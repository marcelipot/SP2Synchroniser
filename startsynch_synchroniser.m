function [] = startsynch_synchroniser(varargin);



%WHen looses internet
%@FileDatastore\read.m: Line 29
%+datastore\SplittableDatastore.m: line 141
%+splitreader\WholeFileCustomReadSplitReader.m: line 49
%+mixin\RemoteToLocalFile.m: Line 43 then Line 68, then Line 96
%@DsFileReader\DsFileReader.m: Line 579
%+stream\createStream.m: Line 82 (build in)

currentYear = year(datetime("today"));
handles2 = guidata(gcf);
source_user = handles2.source_user;
selectfiles = handles2.selectfiles;
yearSelectionAll = handles2.yearSelectionAll;

if strcmpi(source_user, 'Select');
    txt1 = 'Updating existing races :   Not available';
    txt2 = 'Replacing selected races :   ...';
elseif strcmpi(source_user, 'Update');
    txt1 = 'Updating existing races :   ...';
    txt2 = 'Adding new races :   ...';
elseif strcmpi(source_user, 'All');
    txt1 = 'Updating existing races :   Not available';
    txt2 = 'Replacing all races :   ...';
end;
set(handles2.txtUpdated_main, 'String', txt1);
set(handles2.txtNew_main, 'String', txt2);
set(handles2.txtFileName_main, 'String', 'File :   ...');
set(handles2.pushCancel_main, 'String', 'Cancel');
drawnow;

isrunning = get(handles2.proceedprocess_main, 'String');
if strcmpi(isrunning, 'initial');
    set(handles2.proceedprocess_main, 'String', 'running');
    if strcmpi(source_user, 'Update');
        %Update section
        fileListAWSUpdate = handles2.fileListAWSUpdate;
        fileListAWSNew = handles2.fileListAWSNew;
        dateList = handles2.dateList;
        
        AllDB = handles2.AllDB;
        for yearEC = 2018:currentYear;
            eval(['uidDB_SP2_' num2str(yearEC) ' = AllDB.uidDB_SP2_' num2str(yearEC) ';']);
            eval(['FullDB_SP2_' num2str(yearEC) ' = AllDB.FullDB_SP2_' num2str(yearEC) ';']);
            eval(['AgeGroup_SP2_' num2str(yearEC) ' = AllDB.AgeGroup_SP2_' num2str(yearEC) ';']);
        end;  
        AthletesDB = AllDB.AthletesDB;
        ParaDB = AllDB.ParaDB;
        PBsDB = AllDB.PBsDB;
        PBsDB_SC = AllDB.PBsDB_SC;
        BenchmarkEvents = AllDB.BenchmarkEvents;
        isupdate = AllDB.isupdate;
        MeetDB = AllDB.MeetDB;
        RoundDB = AllDB.RoundDB;

        set(handles2.pushStart_main, 'enable', 'off');
        set(handles2.updatedfiles_check_analyser, 'enable', 'off');

        proceed1 = 1;
        proceed2 = 1;
        proceed3 = 1;
        if proceed1 == 1 & proceed2 == 1;
            [connected,timing] = isnetavl;
            proceedRunning = 1;
            if connected == 1;
                clear axesgraph1;
                if isempty(fileListAWSNew) == 0;
                    set(handles2.txtNew_main, 'String', ['Adding new races :   1 / ' num2str(length(fileListAWSNew(:,1)))]);
                    drawnow;
                    count = 1;
                    proceed3 = 1;
                    proceedRunning = 1;
                    YearLast = 0;
                    MeetLast = 'None';
                    commandHistory = {};
                    while proceed3 == 1 & proceedRunning == 1;
%                         try;
                            fileECin = fileListAWSNew{count};
                            dateEC = dateList{count};
                            [root, nameEC, ext] = fileparts(fileECin);
                            nameEC = [nameEC ext];
                            index = strfind(fileECin, '/');
                            if ispc == 1;
                                MDIR = getenv('USERPROFILE');
                                fileECout = [MDIR '\SP2Synchroniser\' fileECin(index(end)+1:end)];
                            elseif ismac == 1;
                                fileECout = ['/Applications/SP2Synchroniser/' fileECin(index(end)+1:end)];
                            end;
                            command = ['aws s3 cp ' fileECin ' ' fileECout];
                            [status, out] = system(command);
                            if exist(fileECout) == 0;
                                proceeddownload = 1;
                            else;
                                proceeddownload = 0;
                            end;
                            tINI = tic;
                            while proceeddownload == 1;                                
                                command = ['aws s3 cp ' fileECin ' ' fileECout];
                                [status, out] = system(command);
 
                                if exist(fileECout) == 0;
                                    tEND = toc(tINI);
                                    txt='internetloop'
                                    if tEND > 7200;
                                        %Try for 2h
                                        proceeddownload = 0;
                                    end;
                                else;
                                    proceeddownload = 0;
                                end;
                            end;




                            fileECin




                            
                            handles2.jsonfile = fileECin;

                            dataEC = jsondecode(fileread(fileECout));

%                         catch;
%                             proceed3 = 0;
%                             proceedRunning = 0;
%                             source = 'internet';
%                             saveDB_processingJSON;
%                             set(handles2.proceedprocess_main, 'String', 'initial');
%                         end;

                        if proceed3 == 1;
                            uuidEC = dataEC.uid;
                            MeetEC = dataEC.competitionName; 
                            MeetEC = erase(MeetEC, ' ');
                            YearEC = dataEC.date;
                            YearEC = str2num(YearEC(1:4));
                            if YearEC ~= YearLast | strcmpi(MeetEC, MeetLast) == 0;
                                command = ['aws s3 ls s3://sparta2-prod/sparta2-swims/' num2str(YearEC) '/' MeetEC num2str(YearEC) '/'];
                                [status, out] = system(command);
                                liRETURN = regexp(out,'[\n]');
                                fileListCheck = {};
                                dateListCheck = {};
                                if isempty(liRETURN) == 0;
                                    iter = 1;
                                    for line = 1:length(liRETURN);
                                        if line == 1;
                                            valECini = 1;
                                            valECend = liRETURN(line);
                                        else;
                                            valECini = liRETURN(line-1);
                                            valECend = liRETURN(line);
                                        end;
                                        strEC = out([valECini:valECend]);
                                        liJSON = findstr(strEC,'.json');
                                        if isempty(liJSON) == 0;
                                            liSPACE = findstr(strEC, ' ');
                                            fileListCheck{iter,1} = ['s3://sparta2-prod/sparta2-swims/' num2str(YearEC) '/' MeetEC num2str(YearEC) '/' strEC(liSPACE(end)+1:liJSON+4)];
                                            dateListCheck{iter,1} = [strEC(liSPACE(1)-10:liSPACE(1)+8)];
                                            iter = iter + 1;
                                        end;
                                    end;
                                else;
                                    iter = 0;
                                end;
                            end;
                            YearLast = YearEC;
                            MeetLast = MeetEC;
                            yearSelectionAll{count,1} = num2str(YearEC);
                            handles2.yearSelectionAll = yearSelectionAll;

                            lisearch = strfind(fileListCheck, nameEC);
                            likeepFile = find(~cellfun('isempty', lisearch));

                            if isempty(likeepFile) == 0;

                                %found an identical ID... compare dates
                                dateOld = datetime(dateListCheck{likeepFile,1});
                                dateCurrent = datetime(dateEC);
                                tf = dateCurrent > dateOld;
                                if tf == 1;
                                    %the current file is newer;
                                    %Need to update the old one

                                    eval(['FullDB_SP2_EC = FullDB_SP2_' num2str(YearEC) ';']);
                                    uuidDB = FullDB_SP2_EC(:,1);
                                    liLoc = strfind(uuidDB, uuidEC);
                                    liLocFile = find(~cellfun('isempty', liLoc));
                                    
                                    if isempty(liLocFile) == 0;
                                        %found the file... process it as "selected"
                                        source = 'Update';
                                        selectfiles(count) = liLocFile;
                                        handles2.selectfiles = selectfiles;
%                             try;
                                        if count == 1;
                                            [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, [], []);
                                        else;
                                            [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, axesgraph1, axescolbar);
                                        end;
                                        succeed = 1;
%                             catch;
%                                 succeed = 0;
%                             end;

                                    else;
                                        %cound not find it... error in the DB... Add it back as "new"
                                        source = 'New';
                                        selectfiles = [];
%                             try;
                                        if count == 1;
                                            [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, [], []);
                                        else;
                                            [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, axesgraph1, axescolbar);
                                        end;
                                        succeed = 1;
%                             catch;
%                                 succeed = 0;
%                             end;
                                    end;
                                else;
                                    %delete the current file and don't process
                                    command = ['aws s3 rm ' fileECin];
                                    [status2, out2] = system(command);
                                
                                    if ispc == 1;
                                        command = ['del ' fileECout];
                                    else;
                                        command = ['rm ' fileECout];
                                    end;
                                    [status, cmdout] = system(command);
                                    succeed = 0;
                                end;
                            else;
                                %new file... process it as "new"
                                source = 'New';
                                selectfiles = [];
%                             try;
                                if count == 1;
                                    [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, [], []);
                                else;
                                    [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, axesgraph1, axescolbar);
                                end;
                                 succeed = 1;
%                             catch;
%                                 succeed = 0;
%                             end;
                            end;
                            count = count + 1;

                            if succeed == 1;
                                if ispc == 1;
                                    index = strfind(fileECout, '\');
                                elseif ismac == 1;
                                    index = strfind(fileECout, '/');
                                end;
                                fnameout = fileECout(index(end)+1:end);
                                filenameDBout = ['s3://sparta2-prod/sparta2-swims/' competitionName(end-3:end) '/' competitionName '/' fnameout];
                                command1 = ['aws s3 cp ' fileECin ' ' filenameDBout];
                                command2 = ['aws s3 rm ' fileECin];
%                                 [status, out] = system(command);
                                commandHistory{count-1,1} = [command1 ' & ' command2];

                                if ispc == 1;
                                    command = ['del ' fileECout];
                                else;
                                    command = ['rm ' fileECout];
                                end;
                                [status, cmdout] = system(command);
    
                                
                            end;

                            isrunning = get(handles2.proceedprocess_main, 'String');
                            if strcmpi(isrunning, 'running');
                                proceed3 = 1;
                                if count > length(fileListAWSNew);
                                    proceedRunning = 0;
                                end;
                            else;
                                proceed3 = 0;
                                proceedRunning = 0;
                                source = 'cancel';
                                for yearIter = 1:length(yearSelectionAll(:,1));
                                    if isempty(yearDone) == 1;
                                        yearDone = str2num(yearSelectionAll{yearIter,1});
                                        saveDB_processingJSON;
                                    else;
                                        index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                                        if isempty(index) == 1;
                                            %new year to save
                                            yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                                            saveDB_processingJSON;
                                        else;
                                            %year already saved
                                            %no need of saving
                                        end;
                                    end;
                                end;
                                set(handles2.proceedprocess_main, 'String', 'initial');
                            end;
                        end;
                    end;
                end;
            else;
                if isempty(commandHistory) == 0;
                    commandMain = [];
                    commandJump = 1:20:length(commandHistory);
                    for commandEC = 1:length(commandHistory);
                        if isempty(commandMain) == 1;
                            commandMain = commandHistory{commandEC};
                        else;
                            commandMain = [commandMain ' & ' commandHistory{commandEC}];
                        end;

                        index = find(commandJump == commandEC);
                        if isempty(index) == 0;
                            [status, cmdout] = system(commandMain);
                            commandMain = [];
                        end;
                    end;
                end;
                if isempty(commandMain) == 0;
                    [status, cmdout] = system(commandMain);
                    commandMain = [];
                end;

                source = 'internet';
                for yearIter = 1:length(yearSelectionAll(:,1));
                    if isempty(yearDone) == 1;
                        yearDone = str2num(yearSelectionAll{yearIter,1});
                        saveDB_processingJSON;
                    else;
                        index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                        if isempty(index) == 1;
                            %new year to save
                            yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                            saveDB_processingJSON;
                        else;
                            %year already saved
                            %no need of saving
                        end;
                    end;
                end;
                set(handles2.proceedprocess_main, 'String', 'initial');
            end;

            if proceed3 == 1  & proceedRunning == 0;
                if isempty(commandHistory) == 0;
                    commandMain = [];
                    commandJump = 1:20:length(commandHistory);
                    for commandEC = 1:length(commandHistory);
                        if isempty(commandMain) == 1;
                            commandMain = commandHistory{commandEC};
                        else;
                            commandMain = [commandMain ' & ' commandHistory{commandEC}];
                        end;

                        index = find(commandJump == commandEC);
                        if isempty(index) == 0;
                            [status, cmdout] = system(commandMain);
                            commandMain = [];
                        end;
                    end;
                end;
                if isempty(commandMain) == 0;
                    [status, cmdout] = system(commandMain);
                    commandMain = [];
                end;

                if status ~= 0
                    e=e
                end;

                source = 'completed';
                yearDone = [];
                for yearIter = 1:length(yearSelectionAll(:,1));
                    if isempty(yearDone) == 1;
                        yearDone = str2num(yearSelectionAll{yearIter,1});
                        saveDB_processingJSON;
                    else;
                        index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                        if isempty(index) == 1;
                            %new year to save
                            yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                            saveDB_processingJSON;
                        else;
                            %year already saved
                            %no need of saving
                        end;
                    end;
                end;
                set(handles2.proceedprocess_main, 'String', 'initial');
            else;
                set(handles2.txtNew_main, 'String', 'Adding new races :   Completed');
                set(handles2.txtFileName_main, 'String', 'File :');
                set(handles2.pushCancel_main, 'String', 'Close');
                set(handles2.updatedfiles_check_analyser, 'enable', 'on');
                set(handles2.proceedprocess_main, 'String', 'initial');
            end;
        end;
        clc;
    
    elseif strcmpi(source_user, 'Select');

        %modify selected files sections
        fileListAWSNew = handles2.fileListAWS;
        dateList = handles2.dateList;
        
%         ###########################################################
        AllDB = handles2.AllDB;
        for yearEC = 2018:currentYear;
            eval(['uidDB_SP2_' num2str(yearEC) ' = AllDB.uidDB_SP2_' num2str(yearEC) ';']);
            eval(['FullDB_SP2_' num2str(yearEC) ' = AllDB.FullDB_SP2_' num2str(yearEC) ';']);
            eval(['AgeGroup_SP2_' num2str(yearEC) ' = AllDB.AgeGroup_SP2_' num2str(yearEC) ';']);
        end;  
        AthletesDB = AllDB.AthletesDB;
        ParaDB = AllDB.ParaDB;
        PBsDB = AllDB.PBsDB;
        PBsDB_SC = AllDB.PBsDB_SC;
        BenchmarkEvents = AllDB.BenchmarkEvents;
        isupdate = AllDB.isupdate;
        MeetDB = AllDB.MeetDB;
        RoundDB = AllDB.RoundDB;

        set(handles2.pushStart_main, 'enable', 'off');
        set(handles2.updatedfiles_check_analyser, 'enable', 'off');

        [connected,timing] = isnetavl;
        if connected == 1;
            clear axesgraph1;
            if isempty(fileListAWSNew) == 0;
                set(handles2.txtNew_main, 'String', ['Replacing selected races:   1 / ' num2str(length(fileListAWSNew(:,1)))]);
                drawnow;
                count = 1;
                countCommand = 1;
                proceed = 1;
                proceedRunning = 1;
                YearLast = 0;
                MeetLast = 'None';
                commandHistory = {};
                loopinternet = 0;
                while proceed == 1 & proceedRunning == 1;
%                     try;
                        fileECin = fileListAWSNew{count};
%                         dateEC = dateList{count};
                        [root, nameEC, ext] = fileparts(fileECin);
                        nameEC = [nameEC ext];
                        index = strfind(fileECin, '/');
                        if ispc == 1;
                            MDIR = getenv('USERPROFILE');



                            fileECin


                            fileECout = [MDIR '\SP2Synchroniser\' fileECin(index(end)+1:end)];
                        elseif ismac == 1;
                            fileECout = ['/Applications/SP2Synchroniser/' fileECin(index(end)+1:end)];
                        end;
                        command = ['aws s3 cp ' fileECin ' ' fileECout];
                        [status, out] = system(command);
                        
%                         command = ['aws s3 cp ' fileECin ' ' fileECout];
%                         [status, out] = system(command);
                        if exist(fileECout) == 0;
                            proceeddownload = 1;
                        else;
                            proceeddownload = 0;
                        end;
                        tINI = tic;                        
                        while proceeddownload == 1;                                
                            command = ['aws s3 cp ' fileECin ' ' fileECout];
                            [status, out] = system(command);

                            fileSearch = nameEC;
                            MDIR = getenv('USERPROFILE');

%                             if loopinternet == 0;
%                                 command = 'aws s3 ls s3://sparta2-prod/sparta2-swims/ --recursive';
%                                 [status, out] = system(command);
%                                 liRETURN = regexp(out,'[\n]');
%                                 loopinternet = 1;
%                             end;
% 
%                             if isempty(liRETURN) == 0;
%                                 proceedCheckFile = 1;
%                                 line = 1;
%                                 while proceedCheckFile == 1;
%                                     if line == 1;
%                                         valECini = 1;
%                                         valECend = liRETURN(line);
%                                     else;
%                                         valECini = liRETURN(line-1);
%                                         valECend = liRETURN(line);
%                                     end;
%                                     strEC = out([valECini:valECend]);
%                                     liJSON = findstr(strEC,'.json');
%                                     if isempty(liJSON) == 0;
%                                         nameEC = strEC([liJSON-68:liJSON+4]);
%                                         if strcmpi(fileSearch, nameEC) == 1;
%                                             %found the file
%                                             proceedCheckFile = 0;
%                                         end;
%                                     end;
%                                     line = line + 1;
%                                     if line > length(liRETURN);
%                                         proceedCheckFile = 0;
%                                     end;
%                                 end;
%                             end;
                            
                            if exist(fileECout) == 0;
                                tEND = toc(tINI);
                                txt='internetloop'
                                if tEND > 7200;
                                    %Try for 2h
                                    proceeddownload = 0;
                                end;
                            else;
                                proceeddownload = 0;
                            end;
                        end;
                        handles2.jsonfile = fileECin;
                        dataEC = jsondecode(fileread(fileECout));

                        if ispc == 1;
                            command = ['del ' fileECout];
                        else;
                            command = ['rm ' fileECout];
                        end;
                        [status, cmdout] = system(command);

%                     catch;
%                         proceed = 0;
%                         proceedRunning = 0;
%                         source = 'internet';
%                         saveDB_processingJSON;
%                         set(handles2.proceedprocess_main, 'String', 'initial');
%                     end;

                    if proceed == 1;
%                         uuidEC = dataEC.uid;
%                         MeetEC = dataEC.competitionName; 
%                         MeetEC = erase(MeetEC, ' ');
%                         YearEC = dataEC.date;
%                         YearEC = str2num(YearEC(1:4));

%                         yearSelectionAll{count,1} = num2str(yearEC);
%                         handles2.yearSelectionAll = yearSelectionAll;

%                         try;
                            source = 'Update';
                            if count == 1;
                                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, [], []);
                            else;
                                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, axesgraph1, axescolbar);
                            end;
                            succeed = 1;
%                         catch;
%                             succeed = 0;
%                         end;
                        count = count + 1;

                        if succeed == 1;
                            if ispc == 1;
                                index = strfind(fileECout, '\');
                            elseif ismac == 1;
                                index = strfind(fileECout, '/');
                            end;
                            fnameout = fileECout(index(end)+1:end);
                            filenameDBout = ['s3://sparta2-prod/sparta2-swims/' competitionName(end-3:end) '/' competitionName '/' fnameout];
                            
                            if strcmpi(fileECin, filenameDBout) == 0;
                                command1 = ['aws s3 cp ' fileECin ' ' filenameDBout];
                                
                                command2 = ['aws s3 rm ' fileECin];
                                commandHistory{countCommand,1} = [command1 ' & ' command2];

                                countCommand = countCommand + 1;
                            end;

                            if ispc == 1;
                                command = ['del ' fileECout];
                            else;
                                command = ['rm ' fileECout];
                            end;
                            [status, cmdout] = system(command);
                        end;

                        isrunning = get(handles2.proceedprocess_main, 'String');
                        if strcmpi(isrunning, 'running');
                            proceed = 1;
                            if count > length(fileListAWSNew);
                                proceedRunning = 0;
                            end;
                        else;
                            proceed = 0;
                            proceedRunning = 0;
                            source = 'cancel';
                            for yearIter = 1:length(yearSelectionAll(:,1));
                                if isempty(yearDone) == 1;
                                    yearDone = str2num(yearSelectionAll{yearIter,1});
                                    saveDB_processingJSON;
                                else;
                                    index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                                    if isempty(index) == 1;
                                        %new year to save
                                        yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                                        saveDB_processingJSON;
                                    else;
                                        %year already saved
                                        %no need of saving
                                    end;
                                end;
                            end;
                            set(handles2.proceedprocess_main, 'String', 'initial');
                        end;
                    end;
                end;
            end;
        else;
            if isempty(commandHistory) == 0;
                commandMain = [];
                commandJump = 1:20:length(commandHistory);
                for commandEC = 1:length(commandHistory);
                    if isempty(commandMain) == 1;
                        commandMain = commandHistory{commandEC};
                    else;
                        commandMain = [commandMain ' & ' commandHistory{commandEC}];
                    end;

                    index = find(commandJump == commandEC);
                    if isempty(index) == 0;
                        [status, cmdout] = system(commandMain);
                        commandMain = [];
                    end;
                end;
            end;
            if isempty(commandMain) == 0;
                [status, cmdout] = system(commandMain);
                commandMain = [];
            end;

            source = 'internet';
            for yearIter = 1:length(yearSelectionAll(:,1));
                if isempty(yearDone) == 1;
                    yearDone = str2num(yearSelectionAll{yearIter,1});
                    saveDB_processingJSON;
                else;
                    index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                    if isempty(index) == 1;
                        %new year to save
                        yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                        saveDB_processingJSON;
                    else;
                        %year already saved
                        %no need of saving
                    end;
                end;
            end;
            set(handles2.proceedprocess_main, 'String', 'initial');
        end;

        if proceed == 1 & proceedRunning == 0;
            if isempty(commandHistory) == 0;
                commandMain = [];
                commandJump = 1:20:length(commandHistory);
                for commandEC = 1:length(commandHistory);
                    if isempty(commandMain) == 1;
                        commandMain = commandHistory{commandEC};
                    else;
                        commandMain = [commandMain ' & ' commandHistory{commandEC}];
                    end;

                    index = find(commandJump == commandEC);
                    if isempty(index) == 0;
                        [status, cmdout] = system(commandMain);
                        commandMain = [];
                    end;
                end;
            else;
                commandMain = [];
            end;
            if isempty(commandMain) == 0;
                [status, cmdout] = system(commandMain);
                commandMain = [];
            end;

            if status ~= 0
                e=e
            end;

            source = 'completed';
            yearDone = [];
            for yearIter = 1:length(yearSelectionAll(:,1));
                if isempty(yearDone) == 1;
                    yearDone = str2num(yearSelectionAll{yearIter,1});
                    saveDB_processingJSON;
                else;
                    index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                    if isempty(index) == 1;
                        %new year to save
                        yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                        saveDB_processingJSON;
                    else;
                        %year already saved
                        %no need of saving
                    end;
                end;
            end;
            set(handles2.proceedprocess_main, 'String', 'initial');
        end;
        clc;
        
    elseif strcmpi(source_user, 'All');
        %redownload All
        fileListAWSNew = handles2.fileListAWS;
        
        AllDB = handles2.AllDB;

        
        eval(['AllDB.uidDB_SP2_' num2str(yearSelectionAll{1,1}) ' = {};']);
        eval(['AllDB.FullDB_SP2_' num2str(yearSelectionAll{1,1}) ' = {};']);
        eval(['AllDB.AgeGroup_SP2_' num2str(yearSelectionAll{1,1}) ' = {};']);
        flag_TimeIssue = {};


        set(handles2.pushStart_main, 'enable', 'off');
        set(handles2.updatedfiles_check_analyser, 'enable', 'off');

        [connected,timing] = isnetavl;
        proceed = 1;
        commandHistory = {};
        if connected == 1;
            clear axesgraph1;
            if isempty(fileListAWSNew) == 0;
                set(handles2.txtNew_main, 'String', ['Replacing selected races:   1 / ' num2str(length(fileListAWSNew(:,1)))]);
                drawnow;
                count = 1;
                proceed = 1;
                proceedRunning = 1;
                commandHistory = {};
                
                while proceed == 1 & proceedRunning == 1;
                    fileECin = fileListAWSNew{count};
                    index = strfind(fileECin, '/');
                    if ispc == 1;
                        MDIR = getenv('USERPROFILE');
                        fileECout = [MDIR '\SP2Synchroniser\' fileECin(index(end)+1:end)];
                    elseif ismac == 1;
                        fileECout = ['/Applications/SP2Synchroniser/' fileECin(index(end)+1:end)];
                    end;
                    command = ['aws s3 cp ' fileECin ' ' fileECout];
                    [status, out] = system(command);

                    command = ['aws s3 cp ' fileECin ' ' fileECout];
                    [status, out] = system(command);
                    if exist(fileECout) == 0;
                        proceeddownload = 1;
                    else;
                        proceeddownload = 0;
                    end;
                    tINI = tic;
                    while proceeddownload == 1;                                
                        command = ['aws s3 cp ' fileECin ' ' fileECout];
                        [status, out] = system(command);

                        if exist(fileECout) == 0;
                            tEND = toc(tINI);
                            txt='internetloop'
                            if tEND > 7200;
                                %Try for 2h
                                proceeddownload = 0;
                            end;
                        else;
                            proceeddownload = 0;
                        end;
                    end;

                    handles2.jsonfile = fileECin;
                    dataEC = jsondecode(fileread(fileECout));

                    YearEC = dataEC.date;
                    YearEC = str2num(YearEC(1:4));

                    if YearEC == str2num(yearSelectionAll{1,1});
                        yearSelectionAll{count,1} = num2str(YearEC);
                        handles2.yearSelectionAll = yearSelectionAll;

                        if proceed == 1;
                            source = 'New';
                            if count == 1;
                                if ispc == 1;
                                    MDIR = getenv('USERPROFILE');
                                    load([MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearSelectionAll{1,1}) '.mat']);
                                elseif ismac == 1;
                                    load(['/Applications/SP2Synchroniser/SP2viewerDBSP2_' num2str(yearSelectionAll{1,1}) '.mat']);
                                end;
                                eval(['AllDB.uidDB_SP2_' num2str(yearSelectionAll{1,1}) ' = {};']);
                                eval(['AllDB.FullDB_SP2_' num2str(yearSelectionAll{1,1}) ' = {};']);
                                eval(['AllDB.AgeGroup_SP2_' num2str(yearSelectionAll{1,1}) ' = struct();']);
 
                                AllDB.PBsDB = struct();
                                AllDB.PBsDB_SC = struct();
                                create_BenchmarkEvent;
                                    
                                command = ['aws s3 rm s3://sparta2-prod/sparta2-data/' num2str(yearSelectionAll{1,1}) '/ --recursive'];
                                [status, out] = system(command);
                                    
                                if ispc == 1;
                                    MDIR = getenv('USERPROFILE');
                                    cmd = ['rmdir /Q /S ' [MDIR '\SP2Synchroniser\RaceDB']];
                                    [status, cmdout] = system(cmd);
                                    cmd = ['mkdir ' [MDIR '\SP2Synchroniser\RaceDB']];
                                    [status, cmdout] = system(cmd);
                                    
                                elseif ismac == 1;
                                    MDIR = '/Applications/SP2Synchroniser';
                                    cmd = ['rmdir -r ' [MDIR '/RaceDB']];
                                    [status, cmdout] = system(cmd);
                                    cmd = ['mkdir ' [MDIR '/RaceDB']];
                                    [status, cmdout] = system(cmd);  
                                end;
    
%                             try;
                                [axesgraph1, axescolbar, AllDB, competitionName, flagFR] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, [], []);
                                succeed = 1;
%                             catch;
%                                 succeed = 0;
%                             end;
                                   
                               if succeed == 1;
                                    if ispc == 1;
                                        index = strfind(fileECout, '\');
                                    elseif ismac == 1;
                                        index = strfind(fileECout, '/');
                                    end;
                                    fnameout = fileECout(index(end)+1:end);
                                    filenameDBout = ['s3://sparta2-prod/sparta2-swims/' competitionName(end-3:end) '/' competitionName '/' fnameout];
                                    if strcmpi(fileECin, filenameDBout) == 0;
                                        command1 = ['aws s3 cp ' fileECin ' ' filenameDBout];
                                        command2 = ['aws s3 rm ' fileECin];
                                        commandHistory{count,1} = [command1 ' & ' command2];
                                    else;
                                        commandHistory{count,1} = '';
                                    end;
    
                                    if ispc == 1;
                                        command = ['del ' fileECout];
                                    else;
                                        command = ['rm ' fileECout];
                                    end;
                                    [status, cmdout] = system(command);
                                end;

                            else;
%                             try;
                                [axesgraph1, axescolbar, AllDB, competitionName, flagFR] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, axesgraph1, axescolbar);
                                succeed = 1;
%                             catch;
%                                 succeed = 0;
%                             end;
        
                                if succeed == 1;
                                    if ispc == 1;
                                        index = strfind(fileECout, '\');
                                    elseif ismac == 1;
                                        index = strfind(fileECout, '/');
                                    end;
                                    fnameout = fileECout(index(end)+1:end);
                                    filenameDBout = ['s3://sparta2-prod/sparta2-swims/' competitionName(end-3:end) '/' competitionName '/' fnameout];
                                    if strcmpi(fileECin, filenameDBout) == 0;
                                        command1 = ['aws s3 cp ' fileECin ' ' filenameDBout];
                                        command2 = ['aws s3 rm ' fileECin];
                                        commandHistory{count,1} = [command1 ' & ' command2];
                                    else;
                                        commandHistory{count,1} = '';
                                    end;
     
                                    if ispc == 1;
                                        command = ['del ' fileECout];
                                    else;
                                        command = ['rm ' fileECout];
                                    end;
                                    [status, cmdout] = system(command);
                                end;
                            end;
    
                            flag_TimeIssue{count,1} = '0';
                            flag_TimeIssue{count,2} = flagFR;

                            isrunning = get(handles2.proceedprocess_main, 'String');
                            if strcmpi(isrunning, 'running');
                                proceed = 1;
                                count = count + 1;
                                if count > length(fileListAWSNew);
                                    proceedRunning = 0;
                                end;
                            else;
                                proceed = 0;
                                proceedRunning = 0;
                                source = 'cancel';
                                for yearIter = 1:length(yearSelectionAll(:,1));
                                    if isempty(yearDone) == 1;
                                        yearDone = str2num(yearSelectionAll{yearIter,1});
                                        saveDB_processingJSON;
                                    else;
                                        index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                                        if isempty(index) == 1;
                                            %new year to save
                                            yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                                            saveDB_processingJSON;
                                        else;
                                            %year already saved
                                            %no need of saving
                                        end;
                                    end;
                                end;
                                set(handles2.proceedprocess_main, 'String', 'initial');
                            end;
                        end;
                    else;
                        count = count + 1;
                        if count > length(fileListAWSNew);
                            proceedRunning = 0;
                        end;
                    end;
                end;
            end;
        else;
            source = 'internet';

            if isempty(commandHistory) == 0;
                commandMain = [];
                commandJump = 1:20:length(commandHistory);
                for commandEC = 1:length(commandHistory);
                    if isempty(commandMain) == 1;
                        if isempty(commandHistory{commandEC}) == 0;
                            commandMain = commandHistory{commandEC};
                        end;
                    else;
                        if isempty(commandHistory{commandEC}) == 0;
                            commandMain = [commandMain ' & ' commandHistory{commandEC}];
                        end;
                    end;

                    index = find(commandJump == commandEC);
                    if isempty(index) == 0;
                        [status, cmdout] = system(commandMain);
                        commandMain = [];
                    end;
                end;
            else;
                commandMain = [];
            end;
            if isempty(commandMain) == 0;
                [status, cmdout] = system(commandMain);
                commandMain = [];
            end;

            yearDone = [];
            for yearIter = 1:length(yearSelectionAll(:,1));
                if isempty(yearDone) == 1;
                    yearDone = str2num(yearSelectionAll{yearIter,1});
                    saveDB_processingJSON;
                else;
                    index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                    if isempty(index) == 1;
                        %new year to save
                        yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                        saveDB_processingJSON;
                    else;
                        %year already saved
                        %no need of saving
                    end;
                end;
            end;
            set(handles2.proceedprocess_main, 'String', 'initial');
        end;

        if proceed == 1;
            source = 'completed';
            if isempty(commandHistory) == 0;
                commandMain = [];
                commandJump = 1:20:length(commandHistory);
                for commandEC = 1:length(commandHistory);
                    if isempty(commandMain) == 1;
                        if isempty(commandHistory{commandEC}) == 0;
                            commandMain = commandHistory{commandEC};
                        end;
                    else;
                        if isempty(commandHistory{commandEC}) == 0;
                            commandMain = [commandMain ' & ' commandHistory{commandEC}];
                        end;
                    end;

                    index = find(commandJump == commandEC);
                    if isempty(index) == 0;
                        if isempty(commandMain) == 0
                            [status, cmdout] = system(commandMain);
                            commandMain = [];
                        end;
                    end;
                end;
            else;
                commandMain = [];
            end;
            if isempty(commandMain) == 0;
                [status, cmdout] = system(commandMain);
                commandMain = [];
            end;

            yearDone = [];
            for yearIter = 1:length(yearSelectionAll(:,1));
                if isempty(yearDone) == 1;
                    yearDone = str2num(yearSelectionAll{yearIter,1});
                    saveDB_processingJSON;
                else;
                    index = find(yearDone == str2num(yearSelectionAll{yearIter,1}));
                    if isempty(index) == 1;
                        %new year to save
                        yearDone = [yearDone str2num(yearSelectionAll{yearIter,1})];
                        saveDB_processingJSON;
                    else;
                        %year already saved
                        %no need of saving
                    end;
                end;
            end;
            set(handles2.proceedprocess_main, 'String', 'initial');
        end;
        clc;
    end;


    if isempty(handles2.yearSelectionAll);
        currentYear = year(datetime("today"));
        handles2.yearSelectionAll{1,1} = currentYear;
    end;
    eval(['uidDB_SP2 = AllDB.uidDB_SP2_' num2str(handles2.yearSelectionAll{1,1}) ';']);
    eval(['FullDB_SP2 = AllDB.FullDB_SP2_' num2str(handles2.yearSelectionAll{1,1}) ';']);
    eval(['AgeGroup_SP2 = AllDB.AgeGroup_SP2_' num2str(handles2.yearSelectionAll{1,1}) ';']);
    AllDB.uidDB_SP2 = uidDB_SP2;
    AllDB.FullDB_SP2 = FullDB_SP2;
    AllDB.AgeGroup_SP2 = AgeGroup_SP2;
    AllDB.AthletesDB = AthletesDB;
    AllDB.ParaDB = ParaDB;
    AllDB.PBsDB = PBsDB;
    AllDB.PBsDB_SC = PBsDB_SC;
    AllDB.BenchmarkEvents = BenchmarkEvents;
    AllDB.isupdate = isupdate;
    AllDB.MeetDB = MeetDB;
    AllDB.RoundDB = RoundDB;
    
    handles2.AllDB = AllDB;
    if strcmpi(source_user, 'Update');
        handles2.fileListAWSUpdate = fileListAWSUpdate;
        handles2.fileListAWSNew = fileListAWSNew;
    elseif strcmpi(source_user, 'Select');  
        handles2.fileListAWS = fileListAWSNew;
    elseif strcmpi(source_user, 'All');  
        handles2.fileListAWS = fileListAWSNew;
    end;
    guidata(handles2.hf_w2_welcome, handles2);
end;

