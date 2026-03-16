function [] = startsynch_database(varargin);



%WHen looses internet
%@FileDatastore\read.m: Line 29
%+datastore\SplittableDatastore.m: line 141
%+splitreader\WholeFileCustomReadSplitReader.m: line 49
%+mixin\RemoteToLocalFile.m: Line 43 then Line 68, then Line 96
%@DsFileReader\DsFileReader.m: Line 579
%+stream\createStream.m: Line 82 (build in)


handles2 = guidata(gcf);
source_user = handles2.source_user;
selectfiles = handles2.selectfiles;
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
        %---check doubles
        fileListAWSUpdate2 = {};
        iter = 1;
        for i = 1:length(fileListAWSUpdate);
            fileEC = fileListAWSUpdate{i};
            lilim = strfind(fileEC, '/');
            lilim = lilim(end);
            fileECname = fileEC(lilim+1:end);

            index = find(contains(fileListAWSUpdate2, fileECname));
            if isempty(index) == 1;
                fileListAWSUpdate2{iter,1} = fileEC;
                iter = iter + 1;
            else;
                liIndex = find(contains(fileListAWSUpdate, fileECname));
                name1 = fileListAWSUpdate{liIndex(1)};
                name2 = fileListAWSUpdate{liIndex(2)};
                li1 = find(contains(name1, 'analyses'));
                li2 = find(contains(name1, 'analyses'));
                
                if isempty(li1) == 1 & isempty(li2) == 1;
                    %both are in swims... take the first one
                    fileListAWSNew2{index,1} = name1;
                elseif isempty(li1) == 0 & isempty(li2) == 0;
                    %both are in analyses... take the first one
                    fileListAWSNew2{index,1} = name1;
                elseif isempty(li1) == 0 & isempty(li2) == 1;
                    %name2 is in analyses... I take name2 
                    fileListAWSNew2{index,1} = name2;
                elseif isempty(li1) == 1 & isempty(li2) == 0;
                    %name1 is in analyses... I take name1 
                    fileListAWSNew2{index,1} = name1;
                end;
            end;
        end;
        fileListAWSUpdate = fileListAWSUpdate2;  
        fileListAWSNew = handles2.fileListAWSNew;
        
        %---check doubles
        fileListAWSNew2 = {};
        iter = 1;
        for i = 1:length(fileListAWSNew);
            fileEC = fileListAWSNew{i};
            lilim = strfind(fileEC, '/');
            lilim = lilim(end);
            fileECname = fileEC(lilim+1:end);

            index = find(contains(fileListAWSNew2, fileECname));
            if isempty(index) == 1;
                fileListAWSNew2{iter,1} = fileEC;
                iter = iter + 1;
            else;
                liIndex = find(contains(fileListAWSNew, fileECname));
                name1 = fileListAWSNew{liIndex(1)};
                name2 = fileListAWSNew{liIndex(2)};
                li1 = find(contains(name1, 'analyses'));
                li2 = find(contains(name1, 'analyses'));
                
                if isempty(li1) == 1 & isempty(li2) == 1;
                    %both are in swims... take the first one
                    fileListAWSNew2{index,1} = name1;
                elseif isempty(li1) == 0 & isempty(li2) == 0;
                    %both are in analyses... take the first one
                    fileListAWSNew2{index,1} = name1;
                elseif isempty(li1) == 0 & isempty(li2) == 1;
                    %name2 is in analyses... I take name2 
                    fileListAWSNew2{index,1} = name2;
                elseif isempty(li1) == 1 & isempty(li2) == 0;
                    %name1 is in analyses... I take name1 
                    fileListAWSNew2{index,1} = name1;
                end;
            end;
        end;
        fileListAWSNew = fileListAWSNew2;
            
        fileListAWS = handles2.fileListAWS;
        %---check doubles
        fileListAWS2 = {};
        iter = 1;
        for i = 1:length(fileListAWS);
            fileEC = fileListAWS{i};
            lilim = strfind(fileEC, '/');
            lilim = lilim(end);
            fileECname = fileEC(lilim+1:end);

            index = find(contains(fileListAWS2, fileECname));
            if isempty(index) == 1;
                fileListAWS2{iter,1} = fileEC;
                iter = iter + 1;
            else;
                liIndex = find(contains(fileListAWS, fileECname));
                name1 = fileListAWS{liIndex(1)};
                name2 = fileListAWS{liIndex(2)};
                li1 = find(contains(name1, 'analyses'));
                li2 = find(contains(name1, 'analyses'));
                
                if isempty(li1) == 1 & isempty(li2) == 1;
                    %both are in swims... take the first one
                    fileListAWSNew2{index,1} = name1;
                elseif isempty(li1) == 0 & isempty(li2) == 0;
                    %both are in analyses... take the first one
                    fileListAWSNew2{index,1} = name1;
                elseif isempty(li1) == 0 & isempty(li2) == 1;
                    %name2 is in analyses... I take name2 
                    fileListAWSNew2{index,1} = name2;
                elseif isempty(li1) == 1 & isempty(li2) == 0;
                    %name1 is in analyses... I take name1 
                    fileListAWSNew2{index,1} = name1;
                end;
            end;
        end;
        fileListAWS = fileListAWS2;
        
        AllDB = handles2.AllDB;
        uidDB = AllDB.uidDB;
        FullDB = AllDB.FullDB;
        AthletesDB = AllDB.AthletesDB;
        ParaDB = AllDB.ParaDB;
        PBsDB = AllDB.PBsDB;
        PBsDB_SC = AllDB.PBsDB_SC;
        AgeGroup = AllDB.AgeGroup;
        BenchmarkEvents = AllDB.BenchmarkEvents;
        isupdate = AllDB.isupdate;
        MeetDB = AllDB.MeetDB;
        RoundDB = AllDB.RoundDB;


        set(handles2.pushStart_main, 'enable', 'off');
        set(handles2.updatedfiles_check_analyser, 'enable', 'off');

        proceed1 = 1;
        proceed2 = 1;
        proceed3 = 1;
        if get(handles2.updatedfiles_check_analyser, 'Value') == 1;
            set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Scanning...');

            [connected,timing] = isnetavl;
            if connected == 1;
%                 AWSdsUpdated = fileDatastore('s3://sparta2-prod/', ...
%                     'FileExtensions', '.json',...
%                     'ReadFcn', @AWSReadRaw,...
%                     'IncludeSubfolders', true);
%                 AWSdsUpdated.Files = fileListAWSUpdate;
                listUpdate = {};
                replaceRaw = [];
                iter = 1;
                iterAdd = 1;
                proceedRunning = 1;
                if isempty(fileListAWSUpdate) == 0;
                    while proceed1 == 1 & proceedRunning == 1;

                        set(handles2.txtUpdated_main, 'String', ['Updating existing races :   Scanning...   ' num2str(iter) ' / ' num2str(length(fileListAWSUpdate(:,1)))]);
                        drawnow;
                                               
                        try;
                            fileECin = fileListAWSUpdate{iter};
                            index = strfind(fileECin, '/');
                            if ispc == 1;
                                MDIR = getenv('USERPROFILE');
                                fileECout = [MDIR '\SP2Synchroniser\' fileECin(index(end)+1:end)];
                            elseif ismac == 1;
                                fileECout = ['/Applications/SP2Synchroniser/' fileECin(index(end)+1:end)];
                            end;
                            command = ['aws s3 cp ' fileECin ' ' fileECout];
                            [status, out] = system(command);
                            dataRaw = jsondecode(fileread(fileECout));

                            if ispc == 1;
                                command = ['del ' fileECout];
                            else;
                                command = ['rm ' fileECout];
                            end;
                            [status, cmdout] = system(command);
%                             dataRaw = AWSdsUpdated.read;
                        catch;
                            proceed1 = 0;
                            proceedRunning = 0;
                            set(handles2.txtUpdated_main, 'String', 'Updating existing races :   No internet connection');
                            set(handles2.txtNew_main, 'String', 'Adding new races :   No internet connection');
                            set(handles2.txtFileName_main, 'String', 'File :');
                            set(handles2.pushStart_main, 'enable', 'on');
                            set(handles2.updatedfiles_check_analyser, 'enable', 'on');
                            set(handles2.proceedprocess_main, 'String', 'initial');
                        end;

                        if proceed1 == 1;
                            li_uid = strfind(dataRaw, '"uid":');
                            li_lim = strfind(dataRaw(li_uid+7:li_uid+100), '"');
                            li_lim = li_lim(1:2)+li_uid+7-1;
                            uid = dataRaw(li_lim(1)+1:li_lim(2)-1);

                            li_update = strfind(dataRaw, '"enteredOn":');
                            li_lim = strfind(dataRaw(li_update+13:li_update+100), '"');
                            li_lim = li_lim(1:2)+li_update+13-1;
                            update = dataRaw(li_lim(1)+1:li_lim(2)-1);
                            li = strfind(update, 'T');
                            date = update(1:li(1)-1);
                            li2 = strfind(update, '.');
                            time = update(li(1)+1:li2(1)-1);
                            racedate = datetime([date ' ' time],'InputFormat','yyyy-MM-dd HH:mm:ss');

                            %race exists
                            lirace = find(strcmpi(uidDB, uid));
                            if isempty(lirace) == 0;
                                DBUpdate = uidDB{lirace,end};
                                li = strfind(DBUpdate, '-');
                                month = DBUpdate(li(1)+1:li(2)-1);
                                if strcmpi(month, 'Jan');
                                    month = '01';
                                elseif strcmpi(month, 'Feb');
                                    month = '02';
                                elseif strcmpi(month, 'Mar');
                                    month = '03';
                                elseif strcmpi(month, 'Apr');
                                    month = '04';
                                elseif strcmpi(month, 'May');
                                    month = '05';
                                elseif strcmpi(month, 'Jun');
                                    month = '06';
                                elseif strcmpi(month, 'Jul');
                                    month = '07';
                                elseif strcmpi(month, 'Aug');
                                    month = '08';
                                elseif strcmpi(month, 'Sep');
                                    month = '09';
                                elseif strcmpi(month, 'Oct');
                                    month = '10';
                                elseif strcmpi(month, 'Nov');
                                    month = '11';
                                elseif strcmpi(month, 'Dec');
                                    month = '12';
                                end;
                                DBUpdate = [DBUpdate(1:li(1)) month DBUpdate(li(2):end)];
                                li = strfind(DBUpdate, '-');
                                li2 = strfind(DBUpdate, ' ');
                                DBUpdate = [DBUpdate(li(2)+1:li(2)+4) DBUpdate(li(1):li(2)) DBUpdate(1:li(1)-1) DBUpdate(li2(1):end)];
                                DBUpdate = datetime(DBUpdate, 'InputFormat','yyyy-MM-dd HH:mm:ss');

                                if racedate > DBUpdate;
                                    %the race was modified after the last update
                                    listUpdate{iterAdd,1} = fileListAWSUpdate{iter,1};
                                    replaceRaw(iterAdd, 1) = iter;
                                    iterAdd = iterAdd + 1;
                                end;
                                iter = iter + 1;
                            else;
                                iter = iter + 1;
                            end;

                            isrunning = get(handles2.proceedprocess_main, 'String');
                            if strcmpi(isrunning, 'running');
                                proceed1 = 1;
                                if iter > length(fileListAWSUpdate);
                                    proceedRunning = 0;
                                end;
                            else;
                                proceed1 = 0;
                                proceedRunning = 0;
                                %only borwsing no modification in the DB yet
                                set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Interrupted');
                                set(handles2.txtNew_main, 'String', 'Adding new races :   Interrupted');
                                set(handles2.txtFileName_main, 'String', 'File :');
                                set(handles2.pushStart_main, 'enable', 'on');
                                set(handles2.updatedfiles_check_analyser, 'enable', 'on');
                                set(handles2.proceedprocess_main, 'String', 'initial');
                            end;
                        end;
                    end;

                    if proceed1 == 1;
                        if isempty(listUpdate) == 1;
                            set(handles2.txtUpdated_main, 'String', 'Updating existing races :   No race to update');
                        else;

                            [connected,timing] = isnetavl;
                            if connected == 1;
%                                 AWSdsUpdated2 = fileDatastore('s3://sparta2-prod/', ...
%                                     'FileExtensions', '.json',...
%                                     'ReadFcn', @AWSReadJson,...
%                                     'IncludeSubfolders', true);
%                                 AWSdsUpdated2.Files = listUpdate;

                                set(handles2.txtUpdated_main, 'String', ['Updating existing races :   1 / ' num2str(length(listUpdate(:,1)))]);
                                drawnow;
                                count = 1;
                                proceedRunning = 1;
                                while proceed2 == 1 & proceedRunning == 1;
                                    try;
                                        fileECin = listUpdate{count};
                                        index = strfind(fileECin, '/');
                                        if ispc == 1;
                                            MDIR = getenv('USERPROFILE');
                                            fileECout = [MDIR '\SP2Synchroniser\' fileECin(index(end)+1:end)];
                                        elseif ismac == 1;
                                            fileECout = ['/Applications/SP2Synchroniser/' fileECin(index(end)+1:end)];
                                        end;
                                        command = ['aws s3 cp ' fileECin ' ' fileECout];
                                        [status, out] = system(command);
                                        dataEC = jsondecode(fileread(fileECout));
        
%                                         dataEC = AWSdsUpdated2.read;
                                    catch;
                                        proceed2 = 0;
                                        proceedRunning = 0;
                                        source = 'internet';
                                        saveDB_processingJSON;
                                        set(handles2.proceedprocess_main, 'String', 'initial');
                                    end;
                                    
                                    if proceed2 == 1;
                                        source = 'Update';
%                                         try;




                                            if count == 1;
                                                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, [], []);
                                            else;
                                                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, axesgraph1, axescolbar);
                                            end;
                                            succeed = 1;



%                                         catch;
%                                             succeed = 0;
%                                         end;
                                        count = count + 1;

                                        if succeed == 1;
                                            if ispc == 1;
                                                index = strfind(fileECout, '\');
                                            elseif ismac == 1;
                                                index = strfind(fileECout, '/');
                                            end;
                                            fnameout = fileECout(index(end)+1:end);
                                            filenameDBout = ['s3://sparta2-prod/sparta2-swims/' competitionName(end-3:end) '/' competitionName '/' fnameout];
                                            command = ['aws s3 cp ' fileECout ' ' filenameDBout];
                                            [status, out] = system(command);
                
                                            if ispc == 1;
                                                command = ['del ' fileECout];
                                            else;
                                                command = ['rm ' fileECout];
                                            end;
                                            [status, cmdout] = system(command);
                
                                            command = ['aws s3 rm s3://sparta2-prod/sparta2-swims/' fnameout];
                                            [status, out] = system(command);
                                            command = ['aws s3 rm s3://sparta2-prod/sparta2-analyses/' fnameout];
                                            [status, out] = system(command);
                                        end;

                                        isrunning = get(handles2.proceedprocess_main, 'String');
                                        if strcmpi(isrunning, 'running');
                                            proceed2 = 1;
                                            if count > length(listUpdate);
                                                proceedRunning = 0;
                                            end;
                                        else;
                                            %interrupted
                                            proceed2 = 0;
                                            proceedRunning = 0;
                                            source = 'cancel';
                                            saveDB_processingJSON;
                                            set(handles2.proceedprocess_main, 'String', 'initial');
                                        end;
                                    end;
                                end;
                                set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Completed');
                                set(handles2.txtFileName_main, 'String', 'File :');
                            else;
                                source = 'internet';
                                saveDB_processingJSON;
                                set(handles2.proceedprocess_main, 'String', 'initial');
                            end;
                        end;
                    end;
                else;
                    set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Completed');
                end;
            else;
                source = 'internet';
                saveDB_processingJSON;
                set(handles2.proceedprocess_main, 'String', 'initial');
            end;
        else;
            set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Completed');
        end;
        drawnow;

        if proceed1 == 1 & proceed2 == 1;
            [connected,timing] = isnetavl;
            proceedRunning = 1;
            if connected == 1;
%                 AWSdsNew = fileDatastore('s3://sparta2-prod/', ...
%                     'FileExtensions', '.json',...
%                     'ReadFcn', @AWSReadJson,...
%                     'IncludeSubfolders', true);
%                 AWSdsNew.Files = fileListAWSNew;

                clear axesgraph1;
                if isempty(fileListAWSNew) == 0;
                    set(handles2.txtNew_main, 'String', ['Adding new races :   1 / ' num2str(length(fileListAWSNew(:,1)))]);
                    drawnow;
                    count = 1;
                    proceed3 = 1;
                    proceedRunning = 1;
                    while proceed3 == 1 & proceedRunning == 1;

%                         try;
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





                            fileECin
                            drawnow;


                            


                            dataEC = jsondecode(fileread(fileECout));

%                         catch;
%                             proceed3 = 0;
%                             proceedRunning = 0;
%                             source = 'internet';
%                             saveDB_processingJSON;
%                             set(handles2.proceedprocess_main, 'String', 'initial');
%                         end;

                        if proceed3 == 1;
                            source = 'New';




                                
%                                 e=e
                      
%                             try;
                                if count == 1;
                                    [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, [], []);
                                else;
                                    [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, axesgraph1, axescolbar);
                                end;
                                 succeed = 1;
%                             catch;
%                                 succeed = 0;
%                             end;






                            count = count + 1;

                            if succeed == 1;
                                if ispc == 1;
                                    index = strfind(fileECout, '\');
                                elseif ismac == 1;
                                    index = strfind(fileECout, '/');
                                end;
                                fnameout = fileECout(index(end)+1:end);
                                filenameDBout = ['s3://sparta2-prod/sparta2-swims/' competitionName(end-3:end) '/' competitionName '/' fnameout];
                                command = ['aws s3 cp ' fileECout ' ' filenameDBout];
                                [status, out] = system(command);

                                if ispc == 1;
                                    command = ['del ' fileECout];
                                else;
                                    command = ['rm ' fileECout];
                                end;
                                [status, cmdout] = system(command);
    
                                command = ['aws s3 rm s3://sparta2-prod/sparta2-swims/' fnameout];
                                [status, out] = system(command);
                                command = ['aws s3 rm s3://sparta2-prod/sparta2-analyses/' fnameout];
                                [status, out] = system(command);
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
                                saveDB_processingJSON;
                                set(handles2.proceedprocess_main, 'String', 'initial');
                            end;
                        end;
                    end;
                end;
            else;
                source = 'internet';
                saveDB_processingJSON;
                set(handles2.proceedprocess_main, 'String', 'initial');
            end;

            if proceed3 == 1  & proceedRunning == 0;
                source = 'completed';
                saveDB_processingJSON;
                set(handles2.proceedprocess_main, 'String', 'initial');
            else;
                set(handles2.txtNew_main, 'String', 'Adding new races :   Completed');
                set(handles2.txtFileName_main, 'String', 'File :');
                set(handles2.pushCancel_main, 'String', 'Close');
                set(handles2.updatedfiles_check_analyser, 'enable', 'on');
                set(handles2.proceedprocess_main, 'String', 'initial');
            end;
        end;

        iterUpdate = 1;
        iterNew = 1;
        fileListAWSNew = {};
        fileListAWSUpdate = {};
        if isempty(uidDB) == 0;
            for file = 1:length(fileListAWS);
                fileECOri = fileListAWS{file};
                li = strfind(fileECOri, '/');
                fileEC = fileECOri(li(end)+1:end);
                li = strfind(fileEC, '_');
                fileEC = fileEC(1:li(end)-1);

                if isempty(find(strcmpi(uidDB(:,13), fileEC))) == 0;
                    fileListAWSUpdate{iterUpdate,1} = fileECOri;
                    iterUpdate = iterUpdate + 1;
                else;
                    fileListAWSNew{iterNew,1} = fileECOri;
                    iterNew = iterNew + 1;
                end;
            end;
        else;
            for file = 1:length(fileListAWS);
                fileECOri = fileListAWS{file};
                li = strfind(fileECOri, '/');
                fileEC = fileECOri(li(end)+1:end);
                li = strfind(fileEC, '_');
                fileEC = fileEC(1:li(end)-1);

                fileListAWSNew{iterNew,1} = fileECOri;
                iterNew = iterNew + 1;
            end;
        end;
        clc;
    
    elseif strcmpi(source_user, 'Select');
        %modify selected files sections
        fileListAWSNew = handles2.fileListAWS;
        
        AllDB = handles2.AllDB;
        uidDB = AllDB.uidDB;
        FullDB = AllDB.FullDB;
        AthletesDB = AllDB.AthletesDB;
        ParaDB = AllDB.ParaDB;
        PBsDB = AllDB.PBsDB;
        PBsDB_SC = AllDB.PBsDB_SC;
        AgeGroup = AllDB.AgeGroup;
        BenchmarkEvents = AllDB.BenchmarkEvents;
        isupdate = AllDB.isupdate;
        RoundDB = AllDB.RoundDB;
        MeetDB = AllDB.MeetDB;

        set(handles2.pushStart_main, 'enable', 'off');
        set(handles2.updatedfiles_check_analyser, 'enable', 'off');

        [connected,timing] = isnetavl;
        if connected == 1;
            
            %---check doubles
            fileListAWSNew2 = {};
            iter = 1;
            
            for i = 1:length(fileListAWSNew);
                fileEC = fileListAWSNew{i};
                lilim = strfind(fileEC, '/');
                lilim = lilim(end);
                fileECname = fileEC(lilim+1:end);
                index = find(contains(fileListAWSNew2, fileECname));
                
                if isempty(index) == 1;
                    fileListAWSNew2{iter,1} = fileEC;
                    iter = iter + 1;
                else;
                    liIndex = find(contains(fileListAWSNew, fileECname));
                    name1 = fileListAWSNew{liIndex(1)};
                    name2 = fileListAWSNew{liIndex(2)};
                    li1 = find(contains(name1, 'analyses'));
                    li2 = find(contains(name1, 'analyses'));
                    
                    if isempty(li1) == 1 & isempty(li2) == 1;
                        %both are in swims... take the first one
                        fileListAWSNew2{index,1} = name1;
                    elseif isempty(li1) == 0 & isempty(li2) == 0;
                        %both are in analyses... take the first one
                        fileListAWSNew2{index,1} = name1;
                    elseif isempty(li1) == 0 & isempty(li2) == 1;
                        %name2 is in analyses... I take name2 
                        fileListAWSNew2{index,1} = name2;
                    elseif isempty(li1) == 1 & isempty(li2) == 0;
                        %name1 is in analyses... I take name1 
                        fileListAWSNew2{index,1} = name1;
                    end;
                end;
            end;
            
            fileListAWSNew = fileListAWSNew2;
%             AWSdsNew.Files = fileListAWSNew;

            clear axesgraph1;
            if isempty(fileListAWSNew) == 0;
                set(handles2.txtNew_main, 'String', ['Replacing selected races:   1 / ' num2str(length(fileListAWSNew(:,1)))]);
                drawnow;
                count = 1;
                proceed = 1;
                proceedRunning = 1;
                while proceed == 1 & proceedRunning == 1;



%                     try;
                    



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
                        dataEC = jsondecode(fileread(fileECout));

                        if ispc == 1;
                            command = ['del ' fileECout];
                        else;
                            command = ['rm ' fileECout];
                        end;
                        [status, cmdout] = system(command);

        %                         dataEC = AWSdsNew.read;
%                     catch;
%                         proceed = 0;
%                         proceedRunning = 0;
%                         source = 'internet';
%                         saveDB_processingJSON;
%                         set(handles2.proceedprocess_main, 'String', 'initial');
%                     end;






                    if proceed == 1;
                        source = 'Update';
                        
%                         try;
                            if count == 1;
                                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, [], []);
                            else;
                                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, axesgraph1, axescolbar);
                            end;
                            succeed = 1;
%                         catch;
%                             succeed = 0;
%                         end;
                        count = count + 1;

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
                            saveDB_processingJSON;
                            set(handles2.proceedprocess_main, 'String', 'initial');
                        end;
                    end;
                end;
            end;
        else;
            source = 'internet';
            saveDB_processingJSON;
            set(handles2.proceedprocess_main, 'String', 'initial');
        end;

        if proceed == 1 & proceedRunning == 0;
            source = 'completed';
            saveDB_processingJSON;
            set(handles2.proceedprocess_main, 'String', 'initial');
        end;
        clc;
        
    elseif strcmpi(source_user, 'All');
        %redownload All
        fileListAWSNew = handles2.fileListAWS;
        
        AllDB.uidDB_SP2 = {};
        AllDB.FullDB_SP2 = {};
        AllDB.AthletesDB = handles.AthletesDB;
        AllDB.ParaDB = handles.ParaDB;
        AllDB.PBsDB = handles.PBsDB;
        AllDB.PBsDB_SC = handles.PBsDB_SC;
        AllDB.AgeGroup_SP2 = {};
        AllDB.BenchmarkEvents = handles.BenchmarkEvents;
        AllDB.isupdate = handles.isupdate;
        AllDB.MeetDB = handles.MeetDB;
        AllDB.RoundDB = handles.RoundDB;

        set(handles2.pushStart_main, 'enable', 'off');
        set(handles2.updatedfiles_check_analyser, 'enable', 'off');

        [connected,timing] = isnetavl;
        if connected == 1;
%             AWSdsNew = fileDatastore('s3://sparta2-prod/', ...
%                 'FileExtensions', '.json',...
%                 'ReadFcn', @AWSReadJson,...
%                 'IncludeSubfolders', true);
            %---check doubles
            fileListAWSNew2 = {};
            iter = 1;

            for i = 1:length(fileListAWSNew);
                fileEC = fileListAWSNew{i};
                lilim = strfind(fileEC, '/');
                lilim = lilim(end);
                fileECname = fileEC(lilim+1:end);
                
                index = find(contains(fileListAWSNew2, fileECname));
                if isempty(index) == 1;
                    fileListAWSNew2{iter,1} = fileEC;
                    iter = iter + 1;
                else;
                    liIndex = find(contains(fileListAWSNew, fileECname));
                    name1 = fileListAWSNew{liIndex(1)};
                    name2 = fileListAWSNew{liIndex(2)};
                    li1 = find(contains(name1, 'analyses'));
                    li2 = find(contains(name1, 'analyses'));
                    
                    if isempty(li1) == 1 & isempty(li2) == 1;
                        %both are in swims... take the first one
                        fileListAWSNew2{index,1} = name1;
                    elseif isempty(li1) == 0 & isempty(li2) == 0;
                        %both are in analyses... take the first one
                        fileListAWSNew2{index,1} = name1;
                    elseif isempty(li1) == 0 & isempty(li2) == 1;
                        %name2 is in analyses... I take name2 
                        fileListAWSNew2{index,1} = name2;
                    elseif isempty(li1) == 1 & isempty(li2) == 0;
                        %name1 is in analyses... I take name1 
                        fileListAWSNew2{index,1} = name1;
                    end;
                end;
            end;

            fileListAWSNew = fileListAWSNew2;
%             AWSdsNew.Files = fileListAWSNew;

            clear axesgraph1;
            if isempty(fileListAWSNew) == 0;
                set(handles2.txtNew_main, 'String', ['Replacing selected races:   1 / ' num2str(length(fileListAWSNew(:,1)))]);
                drawnow;
                count = 1;
                proceed = 1;
                proceedRunning = 1;
                while proceed == 1 & proceedRunning == 1;
%                     try;
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
                        dataEC = jsondecode(fileread(fileECout));

%                         dataEC = AWSdsNew.read;
%                     catch;
%                         proceed = 0;
%                         proceedRunning = 0;
%                         source = 'internet';
%                         saveDB_processingJSON;
%                         set(handles2.proceedprocess_main, 'String', 'initial');
%                     end;

                    if proceed == 1;
                        source = 'New';
                        if count == 1;
                            if ispc == 1;
                                MDIR = getenv('USERPROFILE');
                                load([MDIR '\SP2Synchroniser\SP2viewerDB.mat']);
                            elseif ismac == 1;
                                load('/Applications/SP2Synchroniser/SP2viewerDB.mat');
                            end;
                            AllDB.uidDB_SP2 = [];
                            AllDB.FullDB_SP2 = [];
                            AllDB.AthletesDB = AthletesDB;
                            AllDB.ParaDB = ParaDB;
                            AllDB.PBsDB = struct();
                            AllDB.PBsDB_SC = struct();
                            AllDB.AgeGroup_SP2 = struct();
                            create_BenchmarkEvent;
                            AllDB.BenchmarkEvents = BenchmarkEvents;
                            AllDB.isupdate = isupdate;
                            AllDB.RoundDB = RoundDB;
                            AllDB.MeetDB = MeetDB;
                            
                            command = ['aws s3 rm s3://sparta2-prod/sparta2-data/ --recursive'];
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
                                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, [], []);
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
                                command = ['aws s3 cp ' fileECout ' ' filenameDBout];
                                [status, out] = system(command);
    
                                if ispc == 1;
                                    command = ['del ' fileECout];
                                else;
                                    command = ['rm ' fileECout];
                                end;
                                [status, cmdout] = system(command);
    
                                command = ['aws s3 rm s3://sparta2-prod/sparta2-swims/' fnameout];
                                [status, out] = system(command);
                                command = ['aws s3 rm s3://sparta2-prod/sparta2-analyses/' fnameout];
                                [status, out] = system(command);
                            end;

                        else;
                            try;
                                [axesgraph1, axescolbar, AllDB, competitionName] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, axesgraph1, axescolbar);
                                succeed = 1;
                            catch;
                                succeed = 0;
                            end;

                            if succeed == 1;
                                if ispc == 1;
                                    index = strfind(fileECout, '\');
                                elseif ismac == 1;
                                    index = strfind(fileECout, '/');
                                end;
                                fnameout = fileECout(index(end)+1:end);
                                filenameDBout = ['s3://sparta2-prod/sparta2-swims/' competitionName(end-3:end) '/' competitionName '/' fnameout];
                                command = ['aws s3 cp ' fileECout ' ' filenameDBout];
                                [status, out] = system(command);
    
                                if ispc == 1;
                                    command = ['del ' fileECout];
                                else;
                                    command = ['rm ' fileECout];
                                end;
                                [status, cmdout] = system(command);
    
                                command = ['aws s3 rm s3://sparta2-prod/sparta2-swims/' fnameout];
                                [status, out] = system(command);
                                command = ['aws s3 rm s3://sparta2-prod/sparta2-analyses/' fnameout];
                                [status, out] = system(command);
                            end;
                        end;
                        count = count + 1;

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
                            saveDB_processingJSON;
                            set(handles2.proceedprocess_main, 'String', 'initial');
                        end;
                    end;
                end;
            end;
        else;
            source = 'internet';
            saveDB_processingJSON;
            set(handles2.proceedprocess_main, 'String', 'initial');
        end;

        if proceed == 1;
            source = 'completed';
            saveDB_processingJSON;
            set(handles2.proceedprocess_main, 'String', 'initial');
        end;
        clc;
    end;
    
    AllDB.uidDB = uidDB;
    AllDB.FullDB = FullDB;
    AllDB.AthletesDB = AthletesDB;
    AllDB.ParaDB = ParaDB;
    AllDB.PBsDB = PBsDB;
    AllDB.PBsDB_SC = PBsDB_SC;
    AllDB.AgeGroup = AgeGroup;
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

