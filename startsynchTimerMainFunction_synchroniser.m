function [] = startsynchTimerMainFunction_synchroniser(varargin);




handles2 = guidata(gcf);

currentYear = year(datetime("today"));
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



%---Check Swim folder
command = 'aws s3 ls s3://sparta2-prod/sparta2-swims/';
[status, out] = system(command);
liRETURN = regexp(out,'[\n]');
fileList = {};
dateList = {};
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
            liSPACE = findstr(strEC,' ');
            fileList{iter,1} = ['s3://sparta2-prod/sparta2-swims/' strEC([liSPACE(end)+1:liJSON+4])];
            
            dateList{iter,1} = [strEC(liSPACE(1)-10:liSPACE(1)+8)];
            iter = iter + 1;
        end;
    end;
else;
    iter = 0;
end;

%---Check Analyses folder
command = 'aws s3 ls s3://sparta2-prod/sparta2-analyses/';
[status, out] = system(command);
liRETURN = regexp(out,'[\n]');
if isempty(liRETURN) == 0;
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
            nameEC = strEC([liJSON-68:liJSON+4]);
            liSPACE = findstr(strEC, ' ');
            dateEC = [strEC(liSPACE(1)-10:liSPACE(1)+8)];
            lisearch = strfind(fileList, nameEC);
            likeepFile = find(~cellfun('isempty', lisearch));
            if isempty(likeepFile) == 0;
                %found an identical ID... compare dates
                dateOld = datetime(dateList{likeepFile,1});
                dateCurrent = datetime(dateEC);
                tf = dateCurrent > dateOld;
                if tf == 1;
                    %the current file is newer;
                    %delete the old file
                    nameOld = fileList{likeepFile,1};
                    command = ['aws s3 rm ' nameOld];
                    [status2, out2] = system(command);

                    %replace the date in the lists
                    dateList{likeepFile,1} = dateEC;
                    fileList{likeepFile,1} = ['s3://sparta2-prod/sparta2-analyses/' nameEC];
                else;
                    %delete the current file
                    nameOld = fileList{likeepFile,1};
                    command = ['aws s3 rm s3://sparta2-prod/sparta2-analyses/' nameEC];
                    [status2, out2] = system(command);
                end;
            else;
                %new file... add it
                dateList{iter,1} = dateEC;
                fileList{iter,1} = ['s3://sparta2-prod/sparta2-analyses/' nameEC];
                iter = iter + 1;
            end;
        end;
    end;
end;
fileListAWS = fileList;

%---Get current year
yearSelectionAll = {};

clear axesgraph1;

if isempty(fileListAWS) == 0;

    %---Initialise
    set(handles2.txtNew_main, 'String', ['Adding new races :   1 / ' num2str(length(fileListAWS(:,1)))]);
    drawnow;
    YearLast = 0;
    MeetLast = 'None';
    commandHistory = {};

    %---Process all detected files
    for count = 1:length(fileListAWS(:,1));

        %---Get the JSON file
        fileECin = fileListAWS{count};
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
            tINI = tic;
        end;
        while proceeddownload == 1;                                
            command = ['aws s3 cp ' fileECin ' ' fileECout];
            [status, out] = system(command);

            if exist(fileECout) == 0;
                tEND = toc;
                if tEND > 7200;
                    %Try for 2h
                    proceeddownload = 0;
                    txt='internetloop'
                end;
            else;
                proceeddownload = 0;
            end;
        end;
        handles2.jsonfile = fileECin;

        %---Load the JSON file
        dataEC = jsondecode(fileread(fileECout));
        uuidEC = dataEC.uid;
        MeetEC = dataEC.competitionName; 
        MeetEC = erase(MeetEC, ' ');
        YearEC = dataEC.date;
        YearEC = str2num(YearEC(1:4));

        %---Update if required the existing race list for that meet/year
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

        %---Check if race already exists
        lisearch = strfind(fileListCheck, nameEC);
        likeepFile = find(~cellfun('isempty', lisearch));

        %---Update or Add the race
        if isempty(likeepFile) == 0;
        
            %---found an identical ID... compare dates
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
                    if count == 1;
                        [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWS, AllDB, fileECout, [], []);
                    else;
                        [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWS, AllDB, fileECout, axesgraph1, axescolbar);
                    end;
                    succeed = 1;
                else;
                    %cound not find it... error in the DB... Add it back as "new"
                    source = 'New';
                    handles2.selectfiles = [];
                    if count == 1;
                        [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWS, AllDB, fileECout, [], []);
                    else;
                        [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWS, AllDB, fileECout, axesgraph1, axescolbar);
                    end;
                    succeed = 1;
                end;
            else;
                %delete the current file and don't process


                ee=ee


                succeed = 0;
                nameOld = fileList{likeepFile,1};
                part1 = ['aws s3 rm ' fileECin];
                part2 = ['aws s3 rm ' fileECout];
                command = [part1 ' & ' part2];
                [status2, out2] = system(command);
            end;
        else;

            %---new file... process it as "new"
            source = 'New';
            handles2.selectfiles = [];
            if count == 1;
                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWS, AllDB, fileECout, [], []);
            else;
                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWS, AllDB, fileECout, axesgraph1, axescolbar);
            end;
            succeed = 1;
        end;

        %---Add command to add or replace the JSON files
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
            commandHistory{count,1} = [command1 ' & ' command2];
            if ispc == 1;
                command = ['del ' fileECout];
            else;
                command = ['rm ' fileECout];
            end;
            [status, cmdout] = system(command);
        end;
    end;

    %---Execute all the command for that loop for
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

    %---Save the Database for every year
    source = 'completed';
    source_user = 'Timer';
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
else;
    set(handles2.txtNew_main, 'String', ['Adding new races :   No new race found']);
    set(handles2.txtFileName_main, 'String', 'File :   ...');
    drawnow;
end;

handles2.AllDB = AllDB;
guidata(handles2.hf_w2_welcome, handles2);


% ####################################
% eval(['uidDB_SP2 = AllDB.uidDB_SP2_' num2str(handles2.yearSelectionAll{1,1}) ';']);
% eval(['FullDB_SP2 = AllDB.FullDB_SP2_' num2str(handles2.yearSelectionAll{1,1}) ';']);
% eval(['AgeGroup_SP2 = AllDB.AgeGroup_SP2_' num2str(handles2.yearSelectionAll{1,1}) ';']);
% AllDB.uidDB_SP2 = uidDB_SP2;
% AllDB.FullDB_SP2 = FullDB_SP2;
% AllDB.AgeGroup_SP2 = AgeGroup_SP2;
% AllDB.AthletesDB = AthletesDB;
% AllDB.ParaDB = ParaDB;
% AllDB.PBsDB = PBsDB;
% AllDB.PBsDB_SC = PBsDB_SC;
% AllDB.BenchmarkEvents = BenchmarkEvents;
% AllDB.isupdate = isupdate;
% AllDB.MeetDB = MeetDB;
% AllDB.RoundDB = RoundDB;
% 
% handles2.AllDB = AllDB;
% if strcmpi(source_user, 'Update');
%     handles2.fileListAWSUpdate = fileListAWSUpdate;
%     handles2.fileListAWSNew = fileListAWSNew;
% elseif strcmpi(source_user, 'Select');  
%     handles2.fileListAWS = fileListAWSNew;
% elseif strcmpi(source_user, 'All');  
%     handles2.fileListAWS = fileListAWSNew;
% end;
% guidata(handles2.hf_w2_welcome, handles2);
% ###################################