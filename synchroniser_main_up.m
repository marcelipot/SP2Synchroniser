% P1 = get(handles.Question_button_sync, 'position');
% P2 = get(handles.Downloaddata_button_sync, 'position');
% P3 = get(handles.Downloadraw_button_sync, 'position');
% P4 = get(handles.Downloadbenchmark_button_sync, 'position');
P5 = get(handles.Downloadall_button_sync, 'position');
P6 = get(handles.Downloadnew_button_sync, 'position');
P7 = get(handles.Downloadselect_button_sync, 'position');
P8 = get(handles.Arrowback_button_sync, 'position');
P9 = get(handles.Validate_button_sync, 'position');
P10 = get(handles.Redcross_button_sync, 'position');
P11 = get(handles.Downloadpeople_button_sync, 'position');
% P12 = get(handles.DownloadAMS_button_sync, 'position');
P13 = get(handles.DownloadSP1_button_sync, 'position');
P14 = get(handles.DownloadGE_button_sync, 'position');
P15 = get(handles.Downloadtimer_button_sync, 'position');
P16 = get(handles.DeleteDB_button_sync, 'position');
P17 = get(handles.DuplicateDB_button_sync, 'position');
P18 = get(handles.OpenJSON_button_sync, 'position');
P19 = get(handles.OpenMAT_button_sync, 'position');

%---Question button down
% if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
%     axes(handles.Question_button_sync); imshow(handles.icones.question_offb);
%     create_glossary;
% end;

%---create download data icone
% if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
%     axes(handles.Downloaddata_button_sync); imshow(handles.icones.downloaddata_offb);
%     
%     if isempty(handles.uidDB) == 1;
%         return;
%     end;
%     
%     selectfiles = find(handles.StatusColDBFull == 1)+1;
%     if isempty(selectfiles) == 1;
%         herror = errordlg('No race selected', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         waitfor(herror);
%         return;
%     end;
%     pathname = uigetdir(handles.lastPath_sync);
%     
%     if isempty(pathname) == 1;
%         return;
%     end;
%     if pathname == 0;
%         return;
%     end;
%     handles.lastPath_sync = pathname;
%     
%     clear_figures;
%     nbRaces = length(selectfiles);
%     RaceUID = [];
%     filenameTOT = {};
%     RaceDistList = {};
%     CourseList = {};
%     
%     part1 = 'aws configure set aws_access_key_id AKIARMARPY3XJ6R7X7OV';
%     part2 = 'aws configure set aws_secret_access_key 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';
%     part3 = 'aws configure set default.region ap-southeast-2';
%     command = [part1 ' & ' part2 ' & ' part3];
%     [status, out] = system(command);
% 
%     nb_waitbar = nbRaces;
%     hexport = waitbar(0, 'Preparing data...  0% ');
%     
%     for raceEC = 1:nbRaces;
%         
%         scoreN = roundn(raceEC/nb_waitbar,-2);
%         scoreT = roundn(raceEC/nb_waitbar*100,0);
%         waitbar(scoreN, hexport, ['Preparing data...  ' num2str(scoreT) '%']);
%         
%         RaceUID{raceEC} = handles.uidDB{selectfiles(raceEC)-1,1};
%         RaceDistList{raceEC} = handles.uidDB{selectfiles(raceEC)-1,4};
%         CourseList{raceEC} = handles.uidDB{selectfiles(raceEC)-1,11};
%         
%         UID = RaceUID{raceEC};
%         li = findstr(UID, '-');
%         UID(li) = '_';
%         UID = ['A' UID 'A'];
%         
%         Meet = handles.uidDB{selectfiles(raceEC)-1,8};
%         Year = handles.uidDB{selectfiles(raceEC)-1,9};
%         loadTrialsAWS;
%         
%         eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
%         if findstr(valRelay, 'L.1');
%             valRelay = 'Leg1';
%         elseif findstr(valRelay, 'L.2');
%             valRelay = 'Leg2';
%         elseif findstr(valRelay, 'L.3');
%             valRelay = 'Leg3';
%         elseif findstr(valRelay, 'L.4');
%             valRelay = 'Leg4';
%         else;
%             valRelay = 'Flat';
%         end;
%         
%         filenameTOT{raceEC} = [handles.uidDB{selectfiles(raceEC)-1,2} '_' valRelay];
%     
%     end;
%     RaceUIDTOT = RaceUID;
%     nbRacesTOT = nbRaces;
%     waitbar(0, hexport, ['Exporting data...  0%']);
%     
%     
%     if ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         jFrame=get(handle(hexport), 'javaframe');
%         jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     for raceExport = 1:nbRacesTOT;
%         nbRaces = 1;
%         RaceUID = RaceUIDTOT(raceExport);
%         
%         if ispc == 1;
%             filenameTable = [filenameTOT{raceExport} '_Tables.xlsx'];
%             if isfile(filenameTable) == 1;
%                 MDIR = getenv('USERPROFILE');
%                 command = ['del /Q /S ' filenameTable];
%                 [status, cmdout] = system(command);
%             end;
%         elseif ismac == 1;
%             filenameTable = [filenameTOT{raceExport} '_Tables.xls'];
%             if isfile(filenameTable) == 1;
%                 command = ['rm -rf ' filenameTable];
%                 [status, cmdout] = system(command);
%             end;
%         end;
%         
%         dataMatSplitsPacing = [];
%         dataMatCumSplitsPacing = [];
%     
%         saveTables_synchroniser;
%         scoreN = roundn(raceExport/nb_waitbar,-2);
%         scoreT = roundn(raceExport/nb_waitbar*100,0);
%         waitbar(scoreN, hexport, ['Exporting data...  ' num2str(scoreT) '%']);
%     end;
%     delete(hexport);
% end;
% 
% %---create download raw icone
% if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
%     axes(handles.Downloadraw_button_sync); imshow(handles.icones.downloadraw_offb);
%     
%     if isempty(handles.uidDB) == 1;
%         return;
%     end;
%     
%     selectfiles = find(handles.StatusColDBFull == 1)+1;
%     if isempty(selectfiles) == 1;
%         herror = errordlg('No race selected', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         waitfor(herror);
%         return;
%     end;
%     pathname = uigetdir(handles.lastPath_sync);
%     if isempty(pathname) == 1;
%         return;
%     end;
%     if pathname == 0;
%         return;
%     end;
%     handles.lastPath_sync = pathname;
%     
%     clear_figures;
%     nbRaces = length(selectfiles);
%     RaceUID = [];
%     filenameTOT = {};
%     RaceDistList = {};
%     CourseList = {};
%    
%     hexport = waitbar(0, 'Preparing data...  0% ');
%     for raceEC = 1:nbRaces;
%         RaceUID{raceEC} = handles.uidDB{selectfiles(raceEC)-1, 1};
%         filenameTOT{raceEC} = handles.uidDB{selectfiles(raceEC)-1, 2};
%         RaceDistList{raceEC} = handles.uidDB{selectfiles(raceEC)-1, 4};
%         CourseList{raceEC} = handles.uidDB{selectfiles(raceEC)-1, 11};
%         
%         UID = RaceUID{raceEC};
%         li = findstr(UID, '-');
%         UID(li) = '_';
%         UID = ['A' UID 'A'];
%         
%         Meet = handles.uidDB{selectfiles(raceEC)-1,8};
%         Year = handles.uidDB{selectfiles(raceEC)-1,9};
%         loadTrialsAWS;
%         
%         scoreN = roundn(raceEC/nbRaces,-2);
%         scoreT = roundn(raceEC/nbRaces*100,0);
%         waitbar(scoreN, hexport, ['Preparing data...  ' num2str(scoreT) '%']);
%     end;
%     downloadRawData_synchroniser;
% end;

%---create download benchmark benchmark icon
% if pt(1,1) >= P4(1,1) & pt(1,1) <= (P4(1,1)+P4(1,3)) & pt(1,2) >= P4(1,2) & pt(1,2) <= (P4(1,2)+P4(1,4));
%     axes(handles.Downloadbenchmark_button_sync); imshow(handles.icones.downloadbenchmark_offb);
% 
%     downloadBenchmark_synchroniser;
% end;

%---create download AMS icon
% if pt(1,1) >= P12(1,1) & pt(1,1) <= (P12(1,1)+P12(1,3)) & pt(1,2) >= P12(1,2) & pt(1,2) <= (P12(1,2)+P12(1,4));
%     axes(handles.DownloadAMS_button_sync); imshow(handles.icones.AMS_offb);
% 
%     if isempty(handles.uidDB) == 1;
%         return;
%     end;
% 
%     selectfiles = find(handles.StatusColDBFull == 1)+1;
%     if isempty(selectfiles) == 1;
%         herror = errordlg('No race selected', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         waitfor(herror);
%         return;
%     end;
% 
%     handles2 = create_AMSExportOption_synchroniser;
%     AMSExportType = handles2.AMSExportType;
%     AMSExportHeader = handles2.AMSExportHeader;
%     AMSExportPath = handles2.AMSExportPath;
%     
%     if isempty(AMSExportPath) == 1;
%         herror = errordlg('No race selected', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame=get(handle(herror), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%         waitfor(herror);
%     end;
% 
%     hexport = waitbar(0, 'Preparing data...  0% ');
%     waitbar(0, hexport, ['Preparing data...  0%'], 'fontsize', 7);
%     if ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         jFrame=get(handle(hexport), 'javaframe');
%         jicon=javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
%         jFrame.setFigureIcon(jicon);
%         clc;
%     end;
%     drawnow;
% 
%     clear_figures;
%     nbRaces = length(selectfiles);
%     RaceUID = [];
%     filenameTOT = {};
%     RaceDistList = {};
%     CourseList = {};
%     downloadAMS_synchroniser;
% 
% %     drawnow;
% end;


%---create download Timer icon
if pt(1,1) >= P15(1,1) & pt(1,1) <= (P15(1,1)+P15(1,3)) & pt(1,2) >= P15(1,2) & pt(1,2) <= (P15(1,2)+P15(1,4));
    axes(handles.Downloadtimer_button_sync); imshow(handles.icones.cloudTimer_offb);
    
    [connected,timing] = isnetavl;
    if connected == 1;

        part1 = 'aws configure set aws_access_key_id AKIARMARPY3XIVQ2AQ2B';
        part2 = 'aws configure set aws_secret_access_key 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';
        part3 = 'aws configure set default.region ap-southeast-2';
        command = [part1 ' & ' part2 ' & ' part3];
        [status, out] = system(command);
        
        Synch_WaitbarTimer;
        
        %Display database
%         source = 'Synch';
%         Disp_synchroniser;
    else;
        errorwindow = errordlg('No Internet Connection', 'Error');
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
    end;

end;


%---create download all
if pt(1,1) >= P5(1,1) & pt(1,1) <= (P5(1,1)+P5(1,3)) & pt(1,2) >= P5(1,2) & pt(1,2) <= (P5(1,2)+P5(1,4));
    axes(handles.Downloadall_button_sync); imshow(handles.icones.cloudall_offb);

    yearSelectionAll = inputdlg('Select a year', 'Select a year');
%     yearSelection = yearSelection{1};
    
%     if isempty(handles.uidDB) == 0;
        [connected,timing] = isnetavl;
        if connected == 1;
%             ID_key = 'AKIARMARPY3XJ6R7X7OV';
%             access_key = 'Q5/GcwXUoPsJP8eiLfSG2yeKfAdPIIMl7IwHH2Ko';
%             region = 'ap-southeast-2';
% 
%             setenv('AWS_ACCESS_KEY_ID', ID_key);
%             setenv('AWS_SECRET_ACCESS_KEY', access_key); 
%             setenv('AWS_REGION', region);

            part1 = 'aws configure set aws_access_key_id AKIARMARPY3XIVQ2AQ2B';
            part2 = 'aws configure set aws_secret_access_key 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';
            part3 = 'aws configure set default.region ap-southeast-2';
            command = [part1 ' & ' part2 ' & ' part3];
            [status, out] = system(command);
            
            command = ['aws s3 ls s3://sparta2-prod/sparta2-swims/' yearSelectionAll{1} ' --recursive'];
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
                        liSPARTA = findstr(strEC, 'sparta2');
                        fileList{iter,1} = ['s3://sparta2-prod/' strEC([liSPARTA:liJSON+4])];
                        liSPACE = findstr(strEC,' ');
                        dateList{iter,1} = [strEC(liSPACE(1)-10:liSPACE(1)+8)];
                        iter = iter + 1;
                    end;
                end;
            else;
                iter = 1;
            end;

            command = ['aws s3 ls s3://sparta2-prod/sparta2-swims/'];
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
                                fileList{likeepFile,1} = ['s3://sparta2-prod/sparta2-swims/' nameEC];
                            else;
                                %delete the current file
                                nameOld = fileList{likeepFile,1};
                                command = ['aws s3 rm s3://sparta2-prod/sparta2-swims/' nameEC];
                                [status2, out2] = system(command);
                            end;
                        else;
                            %new file... add it
                            dateList{iter,1} = dateEC;
                            fileList{iter,1} = ['s3://sparta2-prod/sparta2-swims/' nameEC];
                            iter = iter + 1;
                        end;
                    end;
                end;
            end;

            command = ['aws s3 ls s3://sparta2-prod/sparta2-analyses/'];
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

%             %random folder
%             AWSds = fileDatastore('s3://sparta2-prod/', ...
%                 'FileExtensions', '.json',...
%                 'ReadFcn', @AWSReadJson,...
%                 'IncludeSubfolders', true);
%             AWSds.Files = fileList;

            %launch synchro UI
            source_user = 'All';
            fileListAWS = fileList;
            currentYear = year(datetime("today"));

            Synch_Waitbar;

            %Display database
%             source = 'synch';
%             Disp_synchroniser;
        else;
            errorwindow = errordlg('No Internet Connection', 'Error');
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                jFrame = get(handle(errorwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
                clc;
            end;
        end;
%     end;
end;

%---create download new
if pt(1,1) >= P6(1,1) & pt(1,1) <= (P6(1,1)+P6(1,3)) & pt(1,2) >= P6(1,2) & pt(1,2) <= (P6(1,2)+P6(1,4));
    axes(handles.Downloadnew_button_sync); imshow(handles.icones.cloudnew_offb);

    [connected,timing] = isnetavl;
    if connected == 1;

        part1 = 'aws configure set aws_access_key_id AKIARMARPY3XIVQ2AQ2B';
        part2 = 'aws configure set aws_secret_access_key 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';
        part3 = 'aws configure set default.region ap-southeast-2';
        command = [part1 ' & ' part2 ' & ' part3];
        [status, out] = system(command);
        
%         command = 'aws s3 ls s3://sparta2-prod/sparta2-swims/ --recursive';
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


%         command = 'aws s3 ls s3://sparta2-prod/sparta2-analyses/ --recursive';
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

        %launch synchro UI
        fileListAWS = fileList;
%         fileListAWSUpdate = {};
%         fileListAWSNew = {};
        fileListAWSNew = fileList;
        fileListAWSUpdate = {};
%         iterUpdate = 1;
%         iterNew = 1;
%         if isempty(handles.uidDB) == 0;
%             for file = 1:length(fileListAWS);
%                 fileECOri = fileListAWS{file};
%                 li = strfind(fileECOri, '/');
%                 fileEC = fileECOri(li(end)+1:end);
% %                 li = strfind(fileEC, '_');
% %                 fileEC = fileEC(1:li(end)-1);
% %                 fileEC = fileListAWS{file};
% 
%                 if isempty(find(strcmpi(handles.uidDB(:,13), fileEC))) == 0;
%                     fileListAWSUpdate{iterUpdate,1} = fileECOri;
%                     iterUpdate = iterUpdate + 1;
%                 else;
%                     fileListAWSNew{iterNew,1} = fileECOri;
%                     iterNew = iterNew + 1;
%                 end;
%             end;
%         else;
%             for file = 1:length(fileListAWS);
%                 fileECOri = fileListAWS{file};
%                 li = strfind(fileECOri, '/');
%                 fileEC = fileECOri(li(end)+1:end);
% %                 li = strfind(fileEC, '_');
% %                 fileEC = fileEC(1:li(end)-1);
% %                 fileEC = fileListAWS{file};
%                 fileListAWSNew{iterNew,1} = fileECOri;
%                 iterNew = iterNew + 1;
%             end;
%         end;

        %launch synchro UI
        currentYear = year(datetime("today"));
        source_user = 'Update';
        yearSelectionAll = {};
        Synch_Waitbar;
        
        %Display database
%         source = 'Synch';
%         Disp_synchroniser;
    else;
        errorwindow = errordlg('No Internet Connection', 'Error');
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
    end;
end;

%---create download selected
if pt(1,1) >= P7(1,1) & pt(1,1) <= (P7(1,1)+P7(1,3)) & pt(1,2) >= P7(1,2) & pt(1,2) <= (P7(1,2)+P7(1,4));
    axes(handles.Downloadselect_button_sync); imshow(handles.icones.cloudselect_offb);

    if isempty(handles.uidDB) == 0;
        selectfiles = find(handles.StatusColDBFull == 1)+1;

        if isempty(selectfiles) == 0;
            [connected,timing] = isnetavl;
            if connected == 1;
                part1 = 'aws configure set aws_access_key_id AKIARMARPY3XIVQ2AQ2B';
                part2 = 'aws configure set aws_secret_access_key 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';
                part3 = 'aws configure set default.region ap-southeast-2';
                command = [part1 ' & ' part2 ' & ' part3];
                [status, out] = system(command);

                isSP1 = 0;
                iter = 1;
                fileListAWSNew = {};
                for file = 1:length(selectfiles);
                    SourceSparta = handles.uidDB{selectfiles(file)-1,26};
                    if SourceSparta == 1;
                        %sparta 1
                        isSP1 = 1;
                    else;
                        %sparta 2
                        fileListAWSNew{iter,1} = handles.uidDB{selectfiles(file)-1,33};
                        iter = iter + 1;
                    end;
                end;

                if isSP1 == 1;
                    warningwindow = warndlg('Sparta 1 races cannot be updated', 'Warning');
                    if ispc == 1;
                        MDIR = getenv('USERPROFILE');
                        jFrame = get(handle(warningwindow), 'javaframe');
                        jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
                        jFrame.setFigureIcon(jicon);
                        clc;
                    end;
                    waitfor(warningwindow);
                end;                
                fileList = fileListAWSNew;

                command = 'aws s3 ls s3://sparta2-prod/sparta2-analyses/ --recursive';
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
                                %found an identical ID... take the one from
                                %analyses
                                %delete the old file
                                nameOld = fileList{likeepFile,1};
                                command = ['aws s3 rm ' nameOld];
                                [status2, out2] = system(command);
    
                                %replace the date in the lists
%                                 dateList{likeepFile,1} = dateEC;
                                fileList{likeepFile,1} = ['s3://sparta2-prod/sparta2-analyses/' nameEC];
                                
                            end;
                        end;
                    end;
                end;
                fileListAWS = fileList;
                fileListAWSNew = fileListAWS;
                
                %launch synchro UI
                currentYear = year(datetime("today"));
                source_user= 'Select';
                uidDB_id = handles.uidDB(selectfiles(1:length(selectfiles))-1,1);

                yearSelectionAll = {};
                for file = 1:length(fileListAWS);
                    uidDB_idEC = uidDB_id(file);

                    fileLoc = fileListAWS{file};
                    index = strfind(fileLoc, 'sparta2-analyses');
                    if isempty(index) == 0;
                        %it's in analyses so no year
                        index = strfind(fileLoc, '/');
                        if strcmpi(fileLoc, 'None') == 0;
                            proceedYearCheck = 0;
                            yearEC = 2018;
                            while proceedYearCheck == 0;
                                eval(['Index = find(contains(handles.uidDB_SP2_' num2str(yearEC) '(:,1), uidDB_idEC));']);
                                if isempty(Index) == 0;
                                    %find the year it is
                                    proceedYearCheck = 1;
                                else;
                                    if yearEC+1 > currentYear;
                                        proceedYearCheck = 1;
                                    else;
                                        yearEC = yearEC + 1;
                                    end;
                                end;
                            end;
                            selectfiles(file) = Index(1) + 1;
                            yearSelectionAll{file,1} = num2str(yearEC);
                        end;
                    else;
                        %it's in swims so there should be a year
                        index = strfind(fileLoc, '/');
                        if strcmpi(fileLoc, 'None') == 0;
                            yearEC = fileLoc(index(4)+1:index(4)+4);
                            eval(['Index = find(contains(handles.uidDB_SP2_' yearEC '(:,1), uidDB_idEC));']);
                            if isempty(Index) == 1;
                                e=e
                            end;
                            selectfiles(file) = Index(1) + 1;
                            yearSelectionAll{file,1} = yearEC;
                        end;
                    end;
                end;
                dateList = {};
                [yearSelectionAll, indexSort] = sort(yearSelectionAll);
                selectfiles = selectfiles(indexSort);

                Synch_Waitbar;

                %Display database
%                 source = 'Synch';
%                 Disp_synchroniser;
                
            else;
                errorwindow = errordlg('No Internet Connection', 'Error');
                if ispc == 1;
                    MDIR = getenv('USERPROFILE');
                    jFrame = get(handle(errorwindow), 'javaframe');
                    jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
                    jFrame.setFigureIcon(jicon);
                    clc;
                end;
            end;
        end;
    end;
end;


% %---create download new loop
% if pt(1,1) >= P15(1,1) & pt(1,1) <= (P15(1,1)+P15(1,3)) & pt(1,2) >= P15(1,2) & pt(1,2) <= (P15(1,2)+P15(1,4));
%     axes(handles.Downloadnew_button_sync); imshow(handles.icones.cloudnew_offb);
% 
%     [connected,timing] = isnetavl;
%     if connected == 1;
% 
%         part1 = 'aws configure set aws_access_key_id AKIARMARPY3XJ6R7X7OV';
%         part2 = 'aws configure set aws_secret_access_key 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';
%         part3 = 'aws configure set default.region ap-southeast-2';
%         command = [part1 ' & ' part2 ' & ' part3];
%         [status, out] = system(command);
%         
% %         command = 'aws s3 ls s3://sparta2-prod/sparta2-swims/ --recursive';
%         command = 'aws s3 ls s3://sparta2-prod/sparta2-swims/';
%         [status, out] = system(command);
%         liRETURN = regexp(out,'[\n]');
%         fileList = {};
%         datelist = {};
%         if isempty(liRETURN) == 0;
%             iter = 1;
%             for line = 1:length(liRETURN);
%                 if line == 1;
%                     valECini = 1;
%                     valECend = liRETURN(line);
%                 else;
%                     valECini = liRETURN(line-1);
%                     valECend = liRETURN(line);
%                 end;
% %                 fileList{line,1} = ['s3://sparta2-prod/sparta2-swims/' out([valEC-68:valEC+4])];
% %                 li1 = find(liSP2 - valEC < 0);
% %                 sortSP2 = liSP2(li1(end));
%                 strEC = out([valECini:valECend]);
%                 liJSON = findstr(strEC,'.json');
%                 if isempty(liJSON) == 0;
%                     fileList{iter,1} = ['s3://sparta2-prod/sparta2-swims/' strEC([liJSON-68:liJSON+4])];
%                     liSPACE = findstr(strEC,' ');
%                     datelist{iter,1} = [strEC(liSPACE(1)-10:liSPACE(1)+8)];
%                     iter = iter + 1;
%                 end;
%             end;
%         else;
%             iter = 0;
%         end;
% 
%         command = 'aws s3 ls s3://sparta2-prod/sparta2-analyses/';
%         [status, out] = system(command);
%         liRETURN = regexp(out,'[\n]');
%         if isempty(liRETURN) == 0;
%             for line = 1:length(liRETURN);
%                 if line == 1;
%                     valECini = 1;
%                     valECend = liRETURN(line);
%                 else;
%                     valECini = liRETURN(line-1);
%                     valECend = liRETURN(line);
%                 end;
%                 strEC = out([valECini:valECend]);
%                 liJSON = findstr(strEC,'.json');
%                 if isempty(liJSON) == 0;
%                     nameEC = strEC([liJSON-68:liJSON+4]);
%                     dateEC = [strEC(liSPACE(1)-10:liSPACE(1)+8)];
%                     lisearch = strfind(fileList, nameEC);
%                     likeepFile = find(~cellfun('isempty', lisearch));
%                     if isempty(likeepFile) == 0;
%                         %found an identical ID... compare dates
% 
%                     else;
% 
%                     end;
% 
% 
% 
%                     fileList{lineTOT,1} = ['s3://sparta2-prod/' out([sortSP2:valEC+4])];
%                 end;
%             end;
%         end;
% 
%         %launch synchro UI
%         fileListAWS = fileList;
%         fileListAWSUpdate = {};
%         fileListAWSNew = {};
%         iterUpdate = 1;
%         iterNew = 1;
%         if isempty(handles.uidDB) == 0;
%             for file = 1:length(fileListAWS);
%                 fileECOri = fileListAWS{file};
%                 li = strfind(fileECOri, '/');
%                 fileEC = fileECOri(li(end)+1:end);
% %                 li = strfind(fileEC, '_');
% %                 fileEC = fileEC(1:li(end)-1);
% %                 fileEC = fileListAWS{file};
% 
%                 if isempty(find(strcmpi(handles.uidDB(:,13), fileEC))) == 0;
%                     fileListAWSUpdate{iterUpdate,1} = fileECOri;
%                     iterUpdate = iterUpdate + 1;
%                 else;
%                     fileListAWSNew{iterNew,1} = fileECOri;
%                     iterNew = iterNew + 1;
%                 end;
%             end;
%         else;
%             for file = 1:length(fileListAWS);
%                 fileECOri = fileListAWS{file};
%                 li = strfind(fileECOri, '/');
%                 fileEC = fileECOri(li(end)+1:end);
% %                 li = strfind(fileEC, '_');
% %                 fileEC = fileEC(1:li(end)-1);
% %                 fileEC = fileListAWS{file};
%                 fileListAWSNew{iterNew,1} = fileECOri;
%                 iterNew = iterNew + 1;
%             end;
%         end;
% 
%         %launch synchro UI
%         source_user = 'Update';
%         Synch_Waitbar;
%         
%         %Display database
%         source = 'Synch';
%         Disp_synchroniser;
%     else;
%         errorwindow = errordlg('No Internet Connection', 'Error');
%         if ispc == 1;
%             MDIR = getenv('USERPROFILE');
%             jFrame = get(handle(errorwindow), 'javaframe');
%             jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
%             jFrame.setFigureIcon(jicon);
%             clc;
%         end;
%     end;
% end;


%---create arrow back icone
if pt(1,1) >= P8(1,1) & pt(1,1) <= (P8(1,1)+P8(1,3)) & pt(1,2) >= P8(1,2) & pt(1,2) <= (P8(1,2)+P8(1,4));
    axes(handles.Arrowback_button_sync); imshow(handles.icones.arrow_back_offb);
%     drawnow;
    
    
end;

%---create validate icone
if pt(1,1) >= P9(1,1) & pt(1,1) <= (P9(1,1)+P9(1,3)) & pt(1,2) >= P9(1,2) & pt(1,2) <= (P9(1,2)+P9(1,4));
    axes(handles.Validate_button_sync); imshow(handles.icones.validate_offb);
    
    if isempty(handles.uidDB) == 0;
        %Display database
        handles.sourceFilter = 'Filter';
        source = 'Filter';
        Disp_synchroniser;
        
        handles.sortbyPreviousSelection = handles.sortbyCurrentSelection;
    end;
end;

%---create clear icone
if pt(1,1) >= P10(1,1) & pt(1,1) <= (P10(1,1)+P10(1,3)) & pt(1,2) >= P10(1,2) & pt(1,2) <= (P10(1,2)+P10(1,4));
    axes(handles.Redcross_button_sync); imshow(handles.icones.redcross_offb);

    if isempty(handles.uidDB) == 0;
        %reset search
        handles.jCBModel.checkAll;
        handles.checkedColDisp = ones(length(handles.listDropCol),1);
        
        set(handles.popSort_sync, 'value', 1);
        handles.sortbyCurrentSelection = 1;

        handles.SearchMeet = [];
        handles.SearchYear = [];
        handles.SearchName = [];
        handles.SearchMeet = [];
        handles.SearchGender = [];
        handles.SearchSwimType = [];
        handles.SearchStrokeType = [];
        handles.SearchDistance = [];
        handles.SearchPoolType = [];
        handles.SearchCategory = [];
        handles.SearchRaceType = [];
        handles.SearchAgeGroup = [];
        handles.SearchPB = [];
        
        set(handles.filteredit_meet_sync, 'String', 'Meet');
        set(handles.filteredit_year_sync, 'String', 'Year');
        set(handles.filteredit_name_sync, 'String', 'Name');
        set(handles.filterpop_gender_sync, 'Value', 1);
        set(handles.filterpop_type_sync, 'Value', 1);
        set(handles.filterpop_stroke_sync, 'Value', 1);
        set(handles.filterpop_distance_sync, 'Value', 1);
        set(handles.filterpop_pool_sync, 'Value', 1);
        set(handles.filterpop_category_sync, 'Value', 1);
        set(handles.filterpop_relay_sync, 'Value', 1);
        set(handles.filterpop_group_sync, 'Value', 1);
        set(handles.filterpop_time_sync, 'Value', 1);
        
        handles.sortbyExceptionSelection = 1;
        %Display database
        source = 'Filter';
        Disp_synchroniser;
        
        handles.sortbyPreviousSelection = handles.sortbyCurrentSelection;
    end;
end;

%---create download people icon
if pt(1,1) >= P11(1,1) & pt(1,1) <= (P11(1,1)+P11(1,3)) & pt(1,2) >= P11(1,2) & pt(1,2) <= (P11(1,2)+P11(1,4));
    axes(handles.Downloadpeople_button_sync); imshow(handles.icones.people_offb);
    
    %---Load the internal parameters
    [filename, pathname] = uigetfile({'*.xlsx';'*.*'}, 'Select an athletes database', handles.lastPath_sync);
    if filename == 0;
        return;
    end;
    handles.lastPath_sync = pathname;
    name = [pathname filename];

    if ismac == 1;
        load /Applications/SP2Synchroniser/SP2viewerDBSP2.mat;
    elseif ispc == 1;
        MDIR = getenv('USERPROFILE');
        load([MDIR '\SP2Synchroniser\SP2viewerDBSP2.mat']);
    end;
    clear AthletesDB;
    clear ParaDB;
    
    [tableAll, headerAll] = xlsread(name, 1);
    [tablePara, headerPara] = xlsread(name, 2);
    
    for i = 2:length(headerAll(:,1));
        AthletesDBNames{i-1,1} = headerAll{i,7};
        AthletesDBNames{i-1,2} = headerAll{i,8};
        
        if isempty(headerAll{i,5}) == 1;
            AthletesDBDOB{i-1,1} = '01/01/2000';
        else;
            AthletesDBDOB{i-1,1} = headerAll{i,5};
        end;
        if isempty(headerAll{i,4}) == 1;
            AthletesDBNat{i-1,1} = 'AUS';
        else;
            AthletesDBNat{i-1,1} = headerAll{i,4};
        end;
    end;
    AthletesDBID(:,1) = tableAll(:,1);
    AthletesDBGender(:,1) = tableAll(:,6);

    AthletesDB.Names = AthletesDBNames;
    AthletesDB.AMSID = AthletesDBID;
    AthletesDB.DOB = AthletesDBDOB;
    AthletesDB.Nat = AthletesDBNat;
    AthletesDB.Gender = AthletesDBGender;
    
    for i = 2:length(headerPara(:,1));
        ParaDBNames{i-1,1} = headerPara{i,2};
        ParaDBNames{i-1,2} = headerPara{i,3};
        
        if isempty(headerPara{i,5}) == 1;
            ParaDBDOB{i-1,1} = '01/01/2000';
        else;
            ParaDBDOB{i-1,1} = headerPara{i,5};
        end;
        if isempty(headerPara{i,4}) == 1;
            ParaDBNat{i-1,1} = 'AUS';
        else;
            ParaDBNat{i-1,1} = headerPara{i,4};
        end;
    end;
    ParaDBID(:,1) = tablePara(:,1);
    ParaDB.Names = ParaDBNames;
    ParaDB.AMSID = ParaDBID;
    ParaDB.DOB = ParaDBDOB;
    ParaDB.AMSNat = ParaDBNat;
    
    if ismac == 1;
        DBname = '/Applications/SP2ynchroniser/SP2viewerDBSP2.mat';
    elseif ispc == 1;
        MDIR = getenv('USERPROFILE');
        DBname = [MDIR '\SP2Synchroniser\SP2viewerDBSP2.mat'];
    end;
    save(DBname, 'AthletesDB', 'FullDB_SP2', 'LastUpdate_SP2', 'ParaDB', 'PBsDB', 'PBsDB_SC', 'uidDB_SP2', 'AgeGroup_SP2', 'BenchmarkEvents', 'MeetDB', 'RoundDB');
    
    if ismac == 1;
        load /Applications/SP2Synchroniser/SP2viewerDBSP2.mat;
    elseif ispc == 1;
        MDIR = getenv('USERPROFILE');
        load([MDIR '\SP2Synchroniser\SP2viewerDBSP2.mat']);
    end;

%     command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDBSP1.mat'];
%     [status, out] = system(command);

    handles.AthletesDB = AthletesDB;
    handles.ParaDB = ParaDB;
    handles.uidDB_SP2 = uidDB_SP2;
    handles.FullDB_SP2 = FullDB_SP2;
    handles.PBsDB = PBsDB;
    handles.PBsDB_SC = PBsDB_SC;
    handles.LastUpdate_SP2 = LastUpdate_SP2;    
    handles.BenchmarkEvents = BenchmarkEvents;
    handles.AgeGroup_SP2 = AgeGroup_SP2;
    handles.MeetDB = MeetDB;
    handles.RoundDB = RoundDB;
end;


%---create download SP1 icon
if pt(1,1) >= P13(1,1) & pt(1,1) <= (P13(1,1)+P13(1,3)) & pt(1,2) >= P13(1,2) & pt(1,2) <= (P13(1,2)+P13(1,4));
    axes(handles.DownloadSP1_button_sync); imshow(handles.icones.SP1_offb);
    
    %---Load SP1 database
    [filename, pathname] = uigetfile({'*.mat';'*.*'}, 'Select a SP1 database', handles.lastPath_sync);
    if filename == 0;
        return;
    end;
    handles.lastPath_sync = pathname;
    name = [pathname filename];
    load(name);
    

    answer = questdlg('What would you like to do?', ...
	    'SP1 Options', ...
	    'All','Update','All');
    if isempty(answer) == 1;
        return;
    end;

    if strcmpi(answer, 'All') == 1;
        [connected,timing] = isnetavl;
        if connected == 1;
    
    %         part1 = 'aws configure set aws_access_key_id AKIARMARPY3XJ6R7X7OV';
    %         part2 = 'aws configure set aws_secret_access_key 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';
    %         part3 = 'aws configure set default.region ap-southeast-2';
    %         command = [part1 ' & ' part2 ' & ' part3];
    %         [status, out] = system(command);
    %         
    %         command = 'aws s3 ls s3://sparta2-prod/sparta2-swims/';
    %         [status, out] = system(command);
    %         liSP2 = findstr(out,'sparta2');
    %         liJSON = findstr(out,'.json');
    
            indexfileList = [];
            iter = 1;
            nb_waitbar = length(Swims(:,1));
            hexport = waitbar(0, 'Preparing data...  0% ');
    
            for raceEC = 1:length(Swims(:,1));
                
                scoreN = roundn(raceEC/nb_waitbar,-2);
                scoreT = roundn(raceEC/nb_waitbar*100,0);
                waitbar(scoreN, hexport, ['Preparing data...  ' num2str(scoreT) '%']);
                drawnow; 
    
                %take race ID and metadata
                RaceId = Swims{raceEC, 1};
                SwimsEC = Swims(raceEC, :);
                RaceDist = SwimsEC{1,14};
                Course = SwimsEC{1,16};
            
                %find all annotations for that race
                indexAnnotations = find(Annotations(:,2) == RaceId);
                AnnotationsEC = Annotations(indexAnnotations,:);
                [~,index] = sort(AnnotationsEC(:,4));
                AnnotationsEC = AnnotationsEC(index,:);
                %check the data (BO, feetoff, stroke and splits)
                isBO = find(AnnotationsEC(:,3) == 4);
                isFeetOff = find(AnnotationsEC(:,3) == 1);
                isLocation = find(AnnotationsEC(:,3) == 5);
                isStroke = find(AnnotationsEC(:,3) == 2);

                invalidRace = 0;
                if isempty(isFeetOff) == 1 | isempty(isLocation) == 1 | isempty(isStroke) == 1;
                    invalidRace = 1;
                end;

                if Swims{raceEC,8} <= 1;
                    invalidRace = 1;
                end;

%                 if Course == 25;
%                     invalidRace = 1;
%                 end;

                framerate = SwimsEC{1,5};
                if roundn(framerate, 0) < 25;
                    invalidRace = 1;
                end;                

                indexLocation = find(AnnotationsEC(:,3) == 0 | AnnotationsEC(:,3) == 5 | AnnotationsEC(:,3) == 7);
                RaceLocation = AnnotationsEC(indexLocation,:);
                indexEndofRace = find(RaceLocation(:,3) == 7);
                if isempty(indexEndofRace) == 1;
                    invalidRace = 1;
                else;
                    if length(indexEndofRace) > 1;
                        invalidRace = 1;
                    end;
                end;

                indexBeginofRace = find(RaceLocation(:,3) == 0);
                if isempty(indexBeginofRace) == 1;
                    invalidRace = 1;
                else;
                    if length(indexBeginofRace) > 1;
                        invalidRace = 1;
                    end;
                end;

                if invalidRace == 0;
                    if Course == 50;
                        index25m = find(RaceLocation(:,5) == 25);
                        if length(index25m) ~= (RaceDist./Course);
                            invalidRace = 1;
                        end;
                    end;

                    if Course == 25;

                        index0m = find(RaceLocation(:,5) == 0);
                        index25m = find(RaceLocation(:,5) == 25);
    
                        if RaceDist == 50;
                            if length(index0m) ~= 2;
                                invalidRace = 1;
                            end;
                            if length(index25m) ~= 1;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 100;
                            if length(index0m) ~= 3;
                                invalidRace = 1;
                            end;
                            if length(index25m) ~= 2;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 200;
                            if length(index0m) ~= 5;
                                invalidRace = 1;
                            end;
                            if length(index25m) ~= 4;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 400;
                            if length(index0m) ~= 9;
                                invalidRace = 1;
                            end;
                            if length(index25m) ~= 8;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 800;
                            if length(index0m) ~= 17;
                                invalidRace = 1;
                            end;
                            if length(index25m) ~= 16;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 1500;
                            if length(index0m) ~= 31;
                                invalidRace = 1;
                            end;
                            if length(index25m) ~= 30;
                                invalidRace = 1;
                            end;
                        end;
                    else;
                        index0m = find(RaceLocation(:,5) == 0);
                        index50m = find(RaceLocation(:,5) == 50);
                        if RaceDist == 100;
                            if length(index0m) ~= 2;
                                invalidRace = 1;
                            end;
                            if length(index50m) ~= 1;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 200;
                            if length(index0m) ~= 3;
                                invalidRace = 1;
                            end;
                            if length(index50m) ~= 2;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 400;
                            if length(index0m) ~= 5;
                                invalidRace = 1;
                            end;
                            if length(index50m) ~= 4;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 800;
                            if length(index0m) ~= 9;
                                invalidRace = 1;
                            end;
                            if length(index50m) ~= 8;
                                invalidRace = 1;
                            end;
                        elseif RaceDist == 1500;
                            if length(index0m) ~= 16;
                                invalidRace = 1;
                            end;
                            if length(index50m) ~= 15;
                                invalidRace = 1;
                            end;
                        end;
                    end;
                end;

                if invalidRace == 0;
                    checkSP1_RaceLocation;
                    if isMissingDist == 1;
                        invalidRace = 1;
                    end;
                end;

                if invalidRace == 0;
                    RaceStroke = AnnotationsEC(isStroke,:);
                    indexLap = find(RaceLocation(:,5) == 0 | RaceLocation(:,5) == 50);
                    limLap = [];
                    for lec = 2:length(indexLap);
                        limLap = [limLap; [RaceLocation(indexLap(lec-1),4) RaceLocation(indexLap(lec),4)]];
                    end;
                    for lapEC = 1:length(limLap(:,1));
                        frameBeginning = limLap(lapEC,1);
                        frameEnd = limLap(lapEC,2);
    
                        index = find(RaceStroke(:,4) >= frameBeginning & RaceStroke(:,4) <= frameEnd);
                        if length(index) < 3;
                            invalidRace = 1;
                        end;
                    end;
                end;

                %CheckTimes
                if invalidRace == 0;
                    checkTimeSP1;
                    if FINApoints < 850 | FINApoints > 1200;
                        invalidRace = 1;
                    end;
                end;

%                 isRelay = SwimsEC{1,17};
%                 isrelayType = SwimsEC{1,18};
%                 isrelayLeg = SwimsEC{1,19};
%                 if strcmpi(isRelay, 'True') == 1;
%                     if isrelayType == 0 | isrelayLeg == 0;
%                         invalidRace = 1;
%                     end;
%                 end;
    
%                 if SwimsEC{1,8} == 51134 & RaceDist == 100 & SwimsEC{1,9} == 274758;
%                     if SwimsEC{1,8} == 68070; %SwimsEC{1,8} == 71459;
%                         a1=0
%                         invalidRace
%                     else
%                         invalidRace = 1;
%                     end;
%                 else;
%                     a1=0;
%                     invalidRace = 1;
%                 end;
% %                 if SwimsEC{1,8} == 68074 & RaceDist == 100 % & SwimsEC{1,9} == 274794;
% % %                       Filter for a swimmerID (popovic) and Distance and
% % %                       meet
% %                     b1=raceEC
% % %                         indexfileList(iter) = raceEC;
% % %                         iter = iter + 1;
% %                 end;

                if invalidRace == 0;
                    onlinefinename = SwimsEC{1,4};
                    if isempty(onlinefinename) == 1;
                        onlinefinename = [num2str(SwimsEC{1,1}) '-' num2str(SwimsEC{1,2})];
                    else;
                        onlinefinename = onlinefinename(1:end-4); %remove the .mp4
                    end;
    
%                     Index = find(contains(handles.uidDB(:,1), onlinefinename));
%                     if isempty(Index) == 1;
                        indexfileList(iter) = raceEC;
                        iter = iter + 1;
%                     end;
                end;
            end;
            delete(hexport);

            AllDB.uidDB_SP1 = {};
            AllDB.FullDB_SP1 = {};
            AllDB.AthletesDB = handles.AthletesDB;
            AllDB.ParaDB = handles.ParaDB;
            AllDB.PBsDB = handles.PBsDB;
            AllDB.PBsDB_SC = handles.PBsDB_SC;
            AllDB.AgeGroup_SP1 = {};
            AllDB.BenchmarkEvents = handles.BenchmarkEvents;
            AllDB.isupdate = handles.isupdate;
            AllDB.MeetDB = handles.MeetDB;
            AllDB.RoundDB = handles.RoundDB;

            SP1DB.Annotations = Annotations;
            SP1DB.Athletes = Athletes;
            SP1DB.Competitions = Competitions;
            SP1DB.Swims = Swims;
            SP1DB.Users = Users;
            SP1DB.Venue = Venue;
    
            colorrange = parula(256);
            colorvalue = colormap(colorrange);
    
            hexport2 = waitbar(0, 'Processing data...  0% ');
            for count = 1:length(indexfileList);
    
                [num2str(count) ' / ' num2str(length(indexfileList))]
    
    
                scoreN = roundn(count/length(indexfileList),-2);
                scoreT = roundn(count/length(indexfileList)*100,0);
                waitbar(scoreN, hexport2, ['Processing data...  ' num2str(scoreT) '%']);
                drawnow;
    
                raceEC = indexfileList(count); 
                SwimsEC = Swims(raceEC, :);
                RaceDist = SwimsEC{1,14};
                Course = SwimsEC{1,16};
 
% 

%                 if Course == 25;    
%                     
%                     if RaceDist == 50;
%                         raceEC
%                         ee=ee
%     
    
                        
                        if count == 1;
                            [axesgraph1, axescolbar, AllDB, competitionName] = Sparta1_processing(raceEC, count, AllDB, SP1DB, colorrange, colorvalue, [], []);
                        else;
                            [axesgraph1, axescolbar, AllDB, competitionName] = Sparta1_processing(raceEC, count, AllDB, SP1DB, colorrange, colorvalue, axesgraph1, axescolbar);
                        end;
%                     end;
%                 end;
                
            end;
            delete(hexport2);

            uidDB_SP1 = AllDB.uidDB_SP1;
            FullDB_SP1 = AllDB.FullDB_SP1;
            AthletesDB = AllDB.AthletesDB;
            ParaDB = AllDB.ParaDB;
            PBsDB_SP1 = AllDB.PBsDB;
            PBsDB_SC_SP1 = AllDB.PBsDB_SC;
            BenchmarkEvents_SP1 = AllDB.BenchmarkEvents;
            AgeGroup_SP1 = AllDB.AgeGroup_SP1;
            isupdate = AllDB.isupdate;
            MeetDB = AllDB.MeetDB;
            RoundDB = AllDB.RoundDB;
            
            LastUpdate_SP1 = datestr(today('datetime'));
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDB = [MDIR '\SP2viewer\SP2viewerDB_SP1.mat'];
            elseif ismac == 1;
                filenameDB = '/Applications/SP2Viewer/SP2viewerDB_SP1.mat';
            end;
            save(filenameDB, 'LastUpdate_SP1', 'uidDB_SP1', 'FullDB_SP1', 'AgeGroup_SP1', 'PBsDB_SP1', 'PBsDB_SP1', 'BenchmarkEvents_SP1');
            
            command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDBSP1.mat'];
            [status, out] = system(command);
            
        else;
            errorwindow = errordlg('No Internet Connection', 'Error');
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                jFrame = get(handle(errorwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
                clc;
            end;
        end;

    elseif strcmpi(answer, 'Update');
        
        [connected,timing] = isnetavl;
        if connected == 1;
    
    %         part1 = 'aws configure set aws_access_key_id AKIARMARPY3XJ6R7X7OV';
    %         part2 = 'aws configure set aws_secret_access_key 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';
    %         part3 = 'aws configure set default.region ap-southeast-2';
    %         command = [part1 ' & ' part2 ' & ' part3];
    %         [status, out] = system(command);
    %         
    %         command = 'aws s3 ls s3://sparta2-prod/sparta2-swims/';
    %         [status, out] = system(command);
    %         liSP2 = findstr(out,'sparta2');
    %         liJSON = findstr(out,'.json');
    
            indexfileList = [];
            iter = 1;
            nb_waitbar = length(Swims(:,1));
            hexport = waitbar(0, 'Preparing data...  0% ');
    
            for raceEC = 1:length(Swims(:,1));
                
                scoreN = roundn(raceEC/nb_waitbar,-2);
                scoreT = roundn(raceEC/nb_waitbar*100,0);
                waitbar(scoreN, hexport, ['Preparing data...  ' num2str(scoreT) '%']);
                drawnow; 
    
                %take race ID and metadata
                RaceId = Swims{raceEC, 1};
                SwimsEC = Swims(raceEC, :);
                RaceDist = SwimsEC{1,14};
                Course = SwimsEC{1,16};
            
                %find all annotations for that race
                indexAnnotations = find(Annotations(:,2) == RaceId);
                AnnotationsEC = Annotations(indexAnnotations,:);
                [~,index] = sort(AnnotationsEC(:,4));
                AnnotationsEC = AnnotationsEC(index,:);
                %check the data (BO, feetoff, stroke and splits)
                isBO = find(AnnotationsEC(:,3) == 4);
                isFeetOff = find(AnnotationsEC(:,3) == 1);
                isLocation = find(AnnotationsEC(:,3) == 5);
                isStroke = find(AnnotationsEC(:,3) == 2);

                invalidRace = 0;
                if isempty(isFeetOff) == 1 | isempty(isLocation) == 1 | isempty(isStroke) == 1;
                    invalidRace = 1;
                end;

                if Swims{raceEC,8} <= 1;
                    invalidRace = 1;
                end;

                if Course == 25;
                    invalidRace = 1;
                end;

                framerate = SwimsEC{1,5};
                if roundn(framerate, 0) < 25;
                    invalidRace = 1;
                end;
    
                indexLocation = find(AnnotationsEC(:,3) == 0 | AnnotationsEC(:,3) == 5 | AnnotationsEC(:,3) == 7);
                RaceLocation = AnnotationsEC(indexLocation,:);
                indexEndofRace = find(RaceLocation(:,3) == 7);
                if isempty(indexEndofRace) == 1;
                    invalidRace = 1;
                else;
                    if length(indexEndofRace) > 1;
                        invalidRace = 1;
                    end;
                end;
                indexBeginofRace = find(RaceLocation(:,3) == 0);
                if isempty(indexBeginofRace) == 1;
                    invalidRace = 1;
                else;
                    if length(indexBeginofRace) > 1;
                        invalidRace = 1;
                    end;
                end;

                if invalidRace == 0;
                    index25m = find(RaceLocation(:,5) == 25);
                    if length(index25m) ~= (RaceDist./Course);
                        invalidRace = 1;
                    end;
    
                    index0m = find(RaceLocation(:,5) == 0);
                    index50m = find(RaceLocation(:,5) == 50);
                    if RaceDist == 100;
                        if length(index0m) ~= 2;
                            invalidRace = 1;
                        end;
                        if length(index50m) ~= 1;
                            invalidRace = 1;
                        end;
                    elseif RaceDist == 200;
                        if length(index0m) ~= 3;
                            invalidRace = 1;
                        end;
                        if length(index50m) ~= 2;
                            invalidRace = 1;
                        end;
                    elseif RaceDist == 400;
                        if length(index0m) ~= 5;
                            invalidRace = 1;
                        end;
                        if length(index50m) ~= 4;
                            invalidRace = 1;
                        end;
                    elseif RaceDist == 800;
                        if length(index0m) ~= 9;
                            invalidRace = 1;
                        end;
                        if length(index50m) ~= 8;
                            invalidRace = 1;
                        end;
                    elseif RaceDist == 1500;
                        if length(index0m) ~= 16;
                            invalidRace = 1;
                        end;
                        if length(index50m) ~= 15;
                            invalidRace = 1;
                        end;
                    end;
                end;

                if invalidRace == 0;
                    checkSP1_RaceLocation;
                    if isMissingDist == 1;
                        invalidRace = 1;
                    end;
                end;


                if invalidRace == 0;
                    RaceStroke = AnnotationsEC(isStroke,:);
                    indexLap = find(RaceLocation(:,5) == 0 | RaceLocation(:,5) == 50);
                    limLap = [];
                    for lec = 2:length(indexLap);
                        limLap = [limLap; [RaceLocation(indexLap(lec-1),4) RaceLocation(indexLap(lec),4)]];
                    end;
                    for lapEC = 1:length(limLap(:,1));
                        frameBeginning = limLap(lapEC,1);
                        frameEnd = limLap(lapEC,2);
    
                        index = find(RaceStroke(:,4) >= frameBeginning & RaceStroke(:,4) <= frameEnd);
                        if length(index) < 3;
                            invalidRace = 1;
                        end;
                    end;
                end;

                %CheckTimes
                if invalidRace == 0;
                    checkTimeSP1;
                    if FINApoints < 800 | FINApoints > 1200;
                        invalidRace = 1;
                    end;
                end;

%                 isRelay = SwimsEC{1,17};
%                 isrelayType = SwimsEC{1,18};
%                 isrelayLeg = SwimsEC{1,19};
%                 if strcmpi(isRelay, 'True') == 1;
%                     if isrelayType == 0 | isrelayLeg == 0;
%                         invalidRace = 1;
%                     end;
%                 end;
    
%                 if SwimsEC{1,8} == 51134 & RaceDist == 100 & SwimsEC{1,9} == 274758;
% %                 if SwimsEC{1,8} == 26799;
% %                       Filter for a swimmerID (martinenghi) and Distance and
% %                       meet
%                     a1=raceEC
% %                         indexfileList(iter) = raceEC;
% %                         iter = iter + 1;
%                 else;
%                     invalidRace = 1;
%                 end;
% %                 if SwimsEC{1,8} == 68074 & RaceDist == 100 % & SwimsEC{1,9} == 274794;
% % %                       Filter for a swimmerID (popovic) and Distance and
% % %                       meet
% %                     b1=raceEC
% % %                         indexfileList(iter) = raceEC;
% % %                         iter = iter + 1;
% %                 end;

                if invalidRace == 0;
                    
                    onlinefinename = SwimsEC{1,4};
                    if isempty(onlinefinename) == 1;
                        onlinefinename = [num2str(SwimsEC{1,1}) '-' num2str(SwimsEC{1,2})];
                    else;
                        onlinefinename = onlinefinename(1:end-4); %remove the .mp4
                    end;
    
%                     Index = find(contains(handles.uidDB(:,1), onlinefinename));
%                     if isempty(Index) == 1;
                        indexfileList(iter) = raceEC;
                        iter = iter + 1;
%                     end;
                end;
            end;
            delete(hexport);

            AllDB.uidDB_SP1 = {};
            AllDB.FullDB_SP1 = {};
            AllDB.AthletesDB = handles.AthletesDB;
            AllDB.ParaDB = handles.ParaDB;
            AllDB.PBsDB = handles.PBsDB;
            AllDB.PBsDB_SC = handles.PBsDB_SC;
            AllDB.AgeGroup_SP1 = {};
            AllDB.BenchmarkEvents = handles.BenchmarkEvents;
            AllDB.isupdate = handles.isupdate;
            AllDB.MeetDB = handles.MeetDB;
            AllDB.RoundDB = handles.RoundDB;

            SP1DB.Annotations = Annotations;
            SP1DB.Athletes = Athletes;
            SP1DB.Competitions = Competitions;
            SP1DB.Swims = Swims;
            SP1DB.Users = Users;
            SP1DB.Venue = Venue;
    
            colorrange = parula(256);
            colorvalue = colormap(colorrange);
    
            hexport2 = waitbar(0, 'Processing data...  0% ');
            for count = 1:length(indexfileList);
    
                [num2str(count) ' / ' num2str(length(indexfileList))]
    
    
                scoreN = roundn(count/length(indexfileList),-2);
                scoreT = roundn(count/length(indexfileList)*100,0);
                waitbar(scoreN, hexport2, ['Processing data...  ' num2str(scoreT) '%']);
                drawnow;
    
                raceEC = indexfileList(count); 
    
                
                raceEC
    
    
    
                if count == 1;
                    [axesgraph1, axescolbar, AllDB, competitionName] = Sparta1_processing(raceEC, count, AllDB, SP1DB, colorrange, colorvalue, [], []);
                else;
                    [axesgraph1, axescolbar, AllDB, competitionName] = Sparta1_processing(raceEC, count, AllDB, SP1DB, colorrange, colorvalue, axesgraph1, axescolbar);
                end;
            end;
            delete(hexport2);
    
            uidDB_SP1 = AllDB.uidDB_SP1;
            FullDB_SP1 = AllDB.FullDB_SP1;
            AthletesDB = AllDB.AthletesDB;
            ParaDB = AllDB.ParaDB;
            PBsDB_SP1 = AllDB.PBsDB;
            PBsDB_SC_SP1 = AllDB.PBsDB_SC;
            BenchmarkEvents_SP1 = AllDB.BenchmarkEvents;
            AgeGroup_SP1 = AllDB.AgeGroup_SP1;
            isupdate = AllDB.isupdate;
            MeetDB = AllDB.MeetDB;
            RoundDB = AllDB.RoundDB;
            
            LastUpdate_SP1 = datestr(today('datetime'));
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDB = [MDIR '\SP2viewer\SP2viewerDB_SP1.mat'];
            elseif ismac == 1;
                filenameDB = '/Applications/SP2Viewer/SP2viewerDB_SP1.mat';
            end;
            save(filenameDB, 'LastUpdate_SP1', 'uidDB_SP1', 'FullDB_SP1', 'AgeGroup_SP1', 'PBsDB_SP1', 'PBsDB_SP1', 'BenchmarkEvents_SP1');
            
            command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDBSP1.mat'];
            [status, out] = system(command);
            
        else;
            errorwindow = errordlg('No Internet Connection', 'Error');
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                jFrame = get(handle(errorwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
                clc;
            end;
        end;

        
    end;
end;


%---create download GE icon
if pt(1,1) >= P14(1,1) & pt(1,1) <= (P14(1,1)+P14(1,3)) & pt(1,2) >= P14(1,2) & pt(1,2) <= (P14(1,2)+P14(1,4));
    axes(handles.DownloadGE_button_sync); imshow(handles.icones.GE_offb);

    [filename, pathname] = uigetfile({'*.mat';'*.*'}, 'Select an GreenEye database', handles.lastPath_sync);
    if filename == 0;
        return;
    end;
    handles.lastPath_sync = pathname;
    name = [pathname filename];
    load(name);

    AllDB.uidDB_GreenEye = {};
    AllDB.FullDB_GreenEye = {};
    AllDB.AthletesDB = handles.AthletesDB;
    AllDB.ParaDB = handles.ParaDB;
    AllDB.PBsDB = handles.PBsDB;
    AllDB.PBsDB_SC = handles.PBsDB_SC;
    AllDB.AgeGroup = {};
    AllDB.BenchmarkEvents = handles.BenchmarkEvents;
    AllDB.isupdate = handles.isupdate;
    AllDB.MeetDB = handles.MeetDB;
    AllDB.RoundDB = handles.RoundDB;

    GEDB.AthleteAMSDB = AthleteAMSDB;
    GEDB.AthleteGreenEyeDB = AthleteGreenEyeDB;
    GEDB.MeetAMSDB = MeetAMSDB;
    GEDB.ParaAMSDB = ParaAMSDB;
    GEDB.MeetMissingDB = MeetMissingDB;

    colorrange = parula(256);
    colorvalue = colormap(colorrange);

    hexport2 = waitbar(0, 'Processing data...  0% ');
    SwimSegmentIDAll = SwimSegmentGreenEyeDB(2:end,1);
    SwimSegmentIDAll = [SwimSegmentIDAll{:}];
    nbRaces = length(SwimsGreenEyeDB);
    count = 1;
    for raceEC = 2:nbRaces;

        [num2str(raceEC) ' / ' num2str(nbRaces)]

        scoreN = roundn(raceEC/nbRaces,-2);
        scoreT = roundn(raceEC/nbRaces*100,0);
        waitbar(scoreN, hexport2, ['Processing data...  ' num2str(scoreT) '%']);
        drawnow;

        %Check Race
        isvalid = 1;

        swimID = SwimsGreenEyeDB{raceEC,1};
        index = find(SwimSegmentIDAll == swimID);
        if isempty(index) == 0;
            %found annotation for that race
            raceDataSegment = SwimSegmentGreenEyeDB(index+1,:);
            raceDataSegmentNew = [];
            for col = 1:length(raceDataSegment(1,:));
                for elem = 1:length(raceDataSegment(:,col));
                    raceDataSegmentElem = raceDataSegment{elem,col};
                    if isempty(raceDataSegmentElem) == 1;
                        raceDataSegmentElem = 0;
                    end;
                    raceDataSegmentNew(elem,col) = raceDataSegmentElem;
                end;
            end;
            [val, index] = sort(raceDataSegmentNew(:,2));
            raceDataSegmentNew = raceDataSegmentNew(index,:);
            raceDataMetaNew = SwimsGreenEyeDB(raceEC,:);

            for iter = 1:length(raceDataSegmentNew(:,1));
                index = find(raceDataSegmentNew(iter,:) == 9999);
                if isempty(index) == 0;
                    raceDataSegmentNew(iter,index) = NaN;
                end;
            end;
            index = find(raceDataSegmentNew(:,2) == 0);
            if isempty(index) == 0;
                raceDataSegmentNew(index,:) = [];
            end;

            
            %         if strcmpi(raceDataMetaNew{1,6}, 'LCM');
            if raceDataMetaNew{1,4} == 50;
                if length(raceDataSegmentNew(:,1)) < 5;
                    %1 segment is missing
                    raceDataSegmentNew(5,1) = raceDataSegmentNew(4,1);
                    raceDataSegmentNew(5,2) = 5;
                    raceDataSegmentNew(5,3) = raceDataMetaNew{1,7};
                    raceDataSegmentNew(5,4) = NaN;
                    if raceDataMetaNew{1,23} ~= 0 & raceDataMetaNew{1,23} ~= 9999;
                        raceDataSegmentNew(5,5) = raceDataMetaNew{1,23};
                    else;
                        raceDataSegmentNew(5,5) = NaN;
                    end;
                    raceDataSegmentNew(5,6) = NaN;
%                     raceDataSegmentNew(5,7) = raceDataSegmentNew(4,7);
%                     raceDataSegmentNew(4,7) = 0;
                end;
            else;
%                     a=1
            end;
    %         else;
    %             b=1
    %         end;
        else;
            isvalid = 0;
        end;
        

        if isvalid == 1;
            RaceDist = raceDataMetaNew{1,4};
            Course = raceDataMetaNew{1,6};
            if strcmpi(Course, 'SCM') == 1;
                Course = 25;
            elseif strcmpi(Course, 'LCM') == 1;
                Course = 50;
            end;
            nbLap = RaceDist./Course;
        end;

        %Check splits
        if isvalid == 1;
            nbSegment = length(raceDataSegmentNew(:,3));
            avInterval = RaceDist./nbSegment;
            framerate = 50;

            if avInterval == 25;
                SectionCumTime = raceDataSegmentNew(:,3);
            else
                if RaceDist == 50;
                    SectionCumTime = raceDataSegmentNew(:,3);
                    SectionCumTime = [SectionCumTime; raceDataMetaNew{1,7}];
                else;
                    e=e
                end;
            end;
            if raceDataSegmentNew(end,3) ~= raceDataMetaNew{1,7};
                SectionCumTime(end,end) = raceDataMetaNew{1,7};
            end;

            RT = roundn(raceDataMetaNew{1,18},-2);
            SplitsAll = [NaN RT roundn((RT.*framerate)+1,0)];
            indexNaN = find(isnan(SectionCumTime) == 1);
            indexZeros = find(SectionCumTime == 0);

            if isempty(indexNaN) & isempty(indexZeros) == 1;
                for lapEC = 1:nbLap;
                    if avInterval == 25;
                        if Course == 25;
                            splitEC = SectionCumTime(lapEC,1);
                        else;
                            splitEC = SectionCumTime(lapEC*2,1);
                        end;
                        SplitsAll = [SplitsAll; lapEC*Course roundn(splitEC,-2) roundn((splitEC.*framerate)+1,0)];
                    else;
                        splitEC = SectionCumTime(lapEC*5,1);
                        SplitsAll = [SplitsAll; [lapEC*Course roundn(splitEC,-2) roundn((splitEC.*framerate)+1,0)]];
                    end;
                end;
            
                checkTimes = diff(SplitsAll(2:end,2));
                isCheckTimes = find(checkTimes <= 8.5);
                if isempty(isCheckTimes) == 0;
                    %found a split under 8.5s... Impossible
                    isvalid = 0;
                end;
            else;
                isvalid = 0;
            end;
        end;

        if isvalid == 1;
            %Check Vel
            VelCol = raceDataSegmentNew(:,4);
            if isempty(find(VelCol ~= 9999)) == 1;
                %No Vel
                isvalid = 0;
            elseif isempty(find(isnan(VelCol) ~= 1)) == 1;
                isvalid = 0;
            else;
                index = find(VelCol ~= 0);
                if Course == 25;
                    if length(index) < nbLap;
                        isvalid = 0;
                    end;
                elseif Course == 50;
                    if length(index) < nbLap*2;
                        isvalid = 0;
                    end;
                end;
            end;
            %Check SR
            SRCol = raceDataSegmentNew(:,5);
            if isempty(find(SRCol ~= 9999)) == 1;
                %No SR
                isvalid = 0;
            elseif isempty(find(isnan(SRCol) ~= 1)) == 1;
                isvalid = 0;
            else;
                index = find(SRCol ~= 0);
                if Course == 25;
                    if length(index) < nbLap;
                        isvalid = 0;
                    end;
                elseif Course == 50;
                    if length(index) < nbLap*2;
                        isvalid = 0;
                    end;
                end;
            end;
            %Check DPS
            DPSCol = raceDataSegmentNew(:,6);
            if isempty(find(DPSCol ~= 9999)) == 1;
                %No DPS
                isvalid = 0;
            elseif isempty(find(isnan(DPSCol) ~= 1)) == 1;
                isvalid = 0;
            else;
                index = find(DPSCol ~= 0);
                if isempty(index) == 1;
                    isvalid = 0;
                end;
            end;
            %Check Stroke
            SCCol = raceDataSegmentNew(:,7);
            if isempty(find(SCCol ~= 9999)) == 1;
                %No stroke
                isvalid = 0;
            elseif isempty(find(isnan(DPSCol) ~= 1)) == 1;
                isvalid = 0;
            else;
                index = find(SCCol ~= 0);
                if length(index) ~= nbLap;
                    isvalid = 0;
                end;
            end;
            %Check Turn in
            if RaceDist ~= 50;
                TurnInCol = raceDataSegmentNew(:,8);
                if isempty(find(TurnInCol ~= 9999)) == 1;
                    %No Turn In
                    isvalid = 0;
                else;
                    index = find(DPSCol ~= 0);
                    if isempty(index) == 1;
                        isvalid = 0;
                    end;
                end;
            end;
        end;

        if isvalid == 1;
            if sum(raceDataSegmentNew(:,7)) < 5;
                isvalid = 0;
            end;

            if strcmpi(raceDataMetaNew{1,11}, 'Training') | strcmpi(raceDataMetaNew{1,11}, 'AIS Time Trial') ...
                | strcmpi(raceDataMetaNew{1,11}, 'SA Training Camp') | strcmpi(raceDataMetaNew{1,11}, 'SAL Time Trial Meet') ...
                | strcmpi(raceDataMetaNew{1,11}, 'Time Trial') | strcmpi(raceDataMetaNew{1,11}, 'NSWIS Time Trial');
                isvalid = 0;
            end;
        end;

        
        %CheckTimes
        if isvalid == 1;
            checkTimeGE;
            if FINApoints < 800 | FINApoints > 1200;
                isvalid = 0;
            end;
        end;

        if isvalid == 1
            if count == 1;
                [axesgraph1, axescolbar, AllDB, competitionName] = GreenEye_processing(raceEC, count, AllDB, GEDB, raceDataSegmentNew, raceDataMetaNew, colorrange, colorvalue, [], []);
            else;
                [axesgraph1, axescolbar, AllDB, competitionName] = GreenEye_processing(raceEC, count, AllDB, GEDB, raceDataSegmentNew, raceDataMetaNew, colorrange, colorvalue, axesgraph1, axescolbar);
            end;
            count = count + 1;


            count



        end;
    end;
    delete(hexport2);

    uidDB_GreenEye = AllDB.uidDB_GreenEye;
    FullDB_GreenEye = AllDB.FullDB_GreenEye;
    AthletesDB = AllDB.AthletesDB;
    ParaDB = AllDB.ParaDB;
    PBsDB_GreenEye = AllDB.PBsDB;
    PBsDB_SC_GreenEye = AllDB.PBsDB_SC;
    BenchmarkEvents_GreenEye = AllDB.BenchmarkEvents;
    AgeGroup_GreenEye = AllDB.AgeGroup;
    isupdate = AllDB.isupdate;
    MeetDB = AllDB.MeetDB;
    RoundDB = AllDB.RoundDB;

    
    LastUpdate_GreenEye = datestr(today('datetime'));
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        filenameDB = [MDIR '\SP2viewer\SP2viewerDB_GreenEye.mat'];
    elseif ismac == 1;
        filenameDB = '/Applications/SP2Viewer/SP2viewerDB_GreenEye.mat';
    end;
    save(filenameDB, 'LastUpdate_GreenEye', 'uidDB_GreenEye', 'FullDB_GreenEye', 'AgeGroup_GreenEye', 'PBsDB_GreenEye', 'PBsDB_SC_GreenEye', 'BenchmarkEvents_GreenEye');
    
    command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDBGreenEye.mat'];
    [status, out] = system(command);

    
end;



%---create delete DB icon
if pt(1,1) >= P16(1,1) & pt(1,1) <= (P16(1,1)+P16(1,3)) & pt(1,2) >= P16(1,2) & pt(1,2) <= (P16(1,2)+P16(1,4));
    axes(handles.DeleteDB_button_sync); imshow(handles.icones.deleteDB_offb);

    selectfiles = find(handles.StatusColDBFull == 1)+1;
    if isempty(selectfiles) == 0;
        yearAll = [];
        sourceAll = [];
        commandHistory = {};
        for file = 1:length(selectfiles);
            fileListFullDB(file) = selectfiles(file); %fullDB rows
            fileListuidDB(file) = selectfiles(file)-1; %uidDB rows

            yearAll(file,1) = str2num(handles.uidDB{fileListuidDB(file),9});
            sourceAll(file,1) = handles.uidDB{fileListuidDB(file),26};
            meetEC = handles.uidDB{fileListuidDB(file),8};

            %Create the command to delete the JSON and Mat files
            matID = handles.uidDB{fileListuidDB(file),1};
            index = strfind(matID, '-');
            matID(index) = '_';
            matID = ['A' matID 'A'];
            jsonID = handles.uidDB{fileListuidDB(file),13};

            fileECMAT = ['s3://sparta2-prod/sparta2-data/' num2str(yearAll(file,1)) '/' meetEC num2str(yearAll(file,1)) '/' matID '.mat'];
            command1 = ['aws s3 rm ' fileECMAT];
            if sourceAll(file,1) == 2;
                fileECJSON = ['s3://sparta2-prod/sparta2-swims/' num2str(yearAll(file,1)) '/' meetEC num2str(yearAll(file,1)) '/' jsonID];
                command2 = ['aws s3 rm ' fileECJSON];
                commandHistory{file,1} = [command1 ' & ' command2];
            else;
                commandHistory{file,1} = command1;
            end;
        end;

        indexSP2 = find(sourceAll == 2);
        if isempty(indexSP2) == 0;
            fileListuidDBSP2 = fileListuidDB(indexSP2);
            fileListFullDBSP2 = fileListFullDB(indexSP2);
            yearAllSP2 = yearAll(indexSP2);
            [~, index] = sort(yearAllSP2);
            fileListuidDBSP2 = fileListuidDBSP2(index);
            fileListFullDBSP2 = fileListFullDBSP2(index);
        end;

        indexSP1 = find(sourceAll == 1);
        if isempty(indexSP1) == 0;
            fileListuidDBSP1 = fileListuidDB(indexSP1);
            fileListFullDBSP1 = fileListFullDB(indexSP1);
            yearAllSP1 = yearAll(indexSP1);
        end;

        indexGE = find(sourceAll == 1);
        if isempty(indexGE) == 0;
            fileListuidDBGE = fileListuidDB(indexGE);
            fileListFullDBGE = fileListFullDB(indexGE);
            yearAllGE = yearAll(indexGE);
        end;

        if isempty(indexSP2) == 0;
            %SP2 entries are impacted
            yearCurrent = 0;
            for file = 1:length(fileListFullDBSP2);
                yearEC = yearAllSP2(file);
                if yearEC ~= yearCurrent;
                    if yearCurrent ~= 0;
                        %Save data for the year that was done
                        eval(['FullDB_SP2_' num2str(yearAllSP2(file-1)) ' = FullDBEC;']);
                        eval(['uidDB_SP2_' num2str(yearAllSP2(file-1)) ' = uidDBEC;']);
                        eval(['AgeGroup_SP2_' num2str(yearAllSP2(file-1)) ' = AgeGroupEC;']);
                        
                        if ispc == 1;
                            MDIR = getenv('USERPROFILE');
                            filenameDB = [MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearAllSP2(file-1)) '.mat'];
                        elseif ismac == 1;
                            filenameDB = ['/Applications/SP2Synchroniser/SP2viewerDBSP2_' num2str(yearAllSP2(file-1)) '.mat'];
                        end;
    
                        AthletesDB = handles.AthletesDB;
                        ParaDB = handles.ParaDB;
                        PBsDB = handles.PBsDB;
                        PBsDB_SC = handles.PBsDB_SC;
                        BenchmarkEvents = handles.BenchmarkEvents;
                        isupdate = handles.isupdate;
                        MeetDB = handles.MeetDB;
                        RoundDB = handles.RoundDB;
                        LastUpdate_SP2 = datestr(today('datetime'));
                        eval(['LastUpdate_SP2_' yearAll(file-1) ' = LastUpdate_SP2;']);
                        if ispc == 1;
                            MDIR = getenv('USERPROFILE');
                            filenameDB = [MDIR '\SP2viewer\SP2viewerDBSP2_' yearAll(file-1) '.mat'];
                        elseif ismac == 1;
                            filenameDB = ['/Applications/SP2Viewer/SP2viewerDBSP2_' yearAll(file-1) '.mat'];
                        end;
                        txtuiDB = ['uidDB_SP2_' yearAllSP2(file-1)];
                        txtFullDB = ['FullDB_SP2_' yearAllSP2(file-1)];
                        txtLastUpdate = ['LastUpdate_SP2_' yearAllSP2(file-1)];
                        txtAgeGroup = ['AgeGroup_SP2_' yearAllSP2(file-1)];
                        save(filenameDB, 'AthletesDB', 'ParaDB', ...
                            txtLastUpdate, txtuiDB, txtFullDB, ...
                            'PBsDB', 'PBsDB_SC', txtAgeGroup, 'BenchmarkEvents', ...
                            'isupdate', 'MeetDB', 'RoundDB');
    
                        save(filenameDB, 'LastUpdate_GreenEye', 'uidDB_GreenEye', ...
                            'FullDB_GreenEye', 'AgeGroup_GreenEye', 'MeetDB', ...
                            'AthletesDB', 'ParaDB', 'PBsDB', ...
                            'PBsDB_SC', 'BenchmarkEvents');
                        
                        command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDBSP2_' yearAllSP2(file-1) '.mat'];
                        [status, out] = system(command);
                    end;
    
    
                    %Load new DB matching with the year
                    eval(['FullDBEC = handles.FullDB_SP2_' num2str(yearEC) ';']);
                    eval(['uidDBEC = handles.uidDB_SP2_' num2str(yearEC) ';']);
                    eval(['AgeGroupEC = handles.AgeGroup_SP2_' num2str(yearEC) ';']);
                    eval(['LastUpdateEC = handles.LastUpdate_SP2_' num2str(yearEC) ';']);
                    
                end;
                uidsearch = handles.uidDB{fileListuidDBSP2(file),1};
                liuid = find(strcmpi(uidDBEC, uidsearch) == 1);
                uidDBEC(liuid,:) = [];
                FullDBEC(liuid+1,:) = [];

                yearCurrent = yearEC;
            end;
            %Save data for the last year that was done
            eval(['FullDB_SP2_' num2str(yearAllSP2(file)) ' = FullDBEC;']);
            eval(['uidDB_SP2_' num2str(yearAllSP2(file)) ' = uidDBEC;']);
            eval(['AgeGroup_SP2_' num2str(yearAllSP2(file)) ' = AgeGroupEC;']);
            
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDB = [MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearAllSP2(file)) '.mat'];
            elseif ismac == 1;
                filenameDB = ['/Applications/SP2Synchroniser/SP2viewerDBSP2_' num2str(yearAllSP2(file)) '.mat'];
            end;
    
            AthletesDB = handles.AthletesDB;
            ParaDB = handles.ParaDB;
            PBsDB = handles.PBsDB;
            PBsDB_SC = handles.PBsDB_SC;
            BenchmarkEvents = handles.BenchmarkEvents;
            isupdate = handles.isupdate;
            MeetDB = handles.MeetDB;
            RoundDB = handles.RoundDB;
            LastUpdate_SP2 = datestr(today('datetime'));
            eval(['LastUpdate_SP2_' num2str(yearAllSP2(file)) ' = LastUpdate_SP2;']);
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDB = [MDIR '\SP2viewer\SP2viewerDBSP2_' num2str(yearAllSP2(file)) '.mat'];
            elseif ismac == 1;
                filenameDB = ['/Applications/SP2Viewer/SP2viewerDBSP2_' num2str(yearAllSP2(file)) '.mat'];
            end;
            txtuiDB = ['uidDB_SP2_' num2str(yearAllSP2(file))];
            txtFullDB = ['FullDB_SP2_' num2str(yearAllSP2(file))];
            txtLastUpdate = ['LastUpdate_SP2_' num2str(yearAllSP2(file))];
            txtAgeGroup = ['AgeGroup_SP2_' num2str(yearAllSP2(file))];
            save(filenameDB, 'AthletesDB', 'ParaDB', ...
                txtLastUpdate, txtuiDB, txtFullDB, ...
                'PBsDB', 'PBsDB_SC', txtAgeGroup, 'BenchmarkEvents', ...
                'isupdate', 'MeetDB', 'RoundDB');
            
            command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDBSP2_' num2str(yearAllSP2(file)) '.mat'];
            [status, out] = system(command);
        end;

        if isempty(indexSP1) == 0;
            %SP1 entries are impacted
            for file = 1:length(fileListFullDBSP1);
                if file == 1;
                    %Load new DB matching with the year
                    FullDBEC = handles.FullDB_SP1;
                    uidDBEC = handles.uidDB_SP1;
                    AgeGroupEC = handles.AgeGroup_SP1;
                    LastUpdateEC = handles.LastUpdate_SP1;
                end;
                uidsearch = handles.uidDB{fileListuidDBSP1(file),1};
                liuid = find(strcmpi(uidDBEC, uidsearch) == 1);
                uidDBEC(liuid,:) = [];
                FullDBEC(liuid+1,:) = [];
            end;
            %Save the SP1 data
            FullDB_SP1 = FullDBEC;
            uidDB_SP1 = uidDBEC;
            AgeGroup_SP1 = AgeGroupEC;
            
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDB = [MDIR '\SP2Synchroniser\SP2viewerDBSP1.mat'];
            elseif ismac == 1;
                filenameDB = ['/Applications/SP2Synchroniser/SP2viewerDBSP1.mat'];
            end;
    
            AthletesDB = handles.AthletesDB;
            ParaDB = handles.ParaDB;
            PBsDB = handles.PBsDB;
            PBsDB_SC = handles.PBsDB_SC;
            BenchmarkEvents = handles.BenchmarkEvents;
            isupdate = handles.isupdate;
            MeetDB = handles.MeetDB;
            RoundDB = handles.RoundDB;
            LastUpdate_SP1 = datestr(today('datetime'));
            save(filenameDB, 'AthletesDB', 'ParaDB', ...
                'LastUpdate_SP1', 'uidDB_SP1', 'FullDB_SP1', ...
                'PBsDB', 'PBsDB_SC', 'AgeGroup_SP1', 'BenchmarkEvents', ...
                'isupdate', 'MeetDB', 'RoundDB');
            command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDBSP1.mat'];
            [status, out] = system(command);
        end;

        if isempty(indexGE) == 0;
            %SP1 entries are impacted
            for file = 1:length(fileListFullDBGE);
                if file == 1;
                    %Load new DB matching with the year
                    FullDBEC = handles.FullDB_GreenEye;
                    uidDBEC = handles.uidDB_GreenEye;
                    AgeGroupEC = handles.AgeGroup_GreenEye;
                    LastUpdateEC = handles.LastUpdate_GreenEye;
                end;
                uidsearch = handles.uidDB{fileListuidDBGE(file),1};
                liuid = find(strcmpi(uidDBEC, uidsearch) == 1);
                uidDBEC(liuid,:) = [];
                FullDBEC(liuid+1,:) = [];
            end;
            %Save the GE data
            FullDB_GreenEye = FullDBEC;
            uidDB_GreenEye = uidDBEC;
            AgeGroup_GreenEye = AgeGroupEC;
            
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDB = [MDIR '\SP2Synchroniser\SP2viewerDBGreenEye.mat'];
            elseif ismac == 1;
                filenameDB = ['/Applications/SP2Synchroniser/SP2viewerDBGreenEye.mat'];
            end;
    
            AthletesDB = handles.AthletesDB;
            ParaDB = handles.ParaDB;
            PBsDB = handles.PBsDB;
            PBsDB_SC = handles.PBsDB_SC;
            BenchmarkEvents = handles.BenchmarkEvents;
            isupdate = handles.isupdate;
            MeetDB = handles.MeetDB;
            RoundDB = handles.RoundDB;
            LastUpdate_GreenEye = datestr(today('datetime'));
            save(filenameDB, 'AthletesDB', 'ParaDB', ...
                'LastUpdate_GreenEye', 'uidDB_GreenEye', 'FullDB_GreenEye', ...
                'PBsDB', 'PBsDB_SC', 'AgeGroup_GreenEye', 'BenchmarkEvents', ...
                'isupdate', 'MeetDB', 'RoundDB');
            
            command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDBGreenEye.mat'];
            [status, out] = system(command);
        end;

        answer = questdlg('Do you also want to delete the raw data files (MAT and JSON)?', 'Raw Data', 'Yes', 'No', 'No');
        if strcmpi(answer, 'Yes') == 1;
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
        end;

        %Reload databases
        reload_databases;

        %Display database
        if strcmpi(handles.sourceFilter,'Filter') == 1;
            source = 'Filter';
        else;
            %---re-apply the find duplicates filter
            source = 'FilterDouble';
            classifier = handles.uidDB(:,11);
            classifier = cell2mat(classifier);
            SearchPoolType = handles.filterDoubleCourse;

            likeepPoolType = find(classifier == SearchPoolType); %strcmpi(classifier, SearchPoolType);
            datasetuidDB = handles.uidDB(likeepPoolType,:);
            classifier = datasetuidDB(:,2);
            valALL = 1:length(classifier);
            likeepRaceTOT = [];
            for iter = 1:length(classifier);
                valEC = valALL(iter);
                if valEC ~= 0;
                    %---search filename
                    SearchRace = classifier{iter};
                    lisearch = strcmpi(classifier, SearchRace);
                    likeepRace = find(lisearch == 1);
                    %---Store doubles
                    if length(likeepRace) >= 2;
                        %Found doubles... (current row and at least another one)
                        likeepRaceTOT = [likeepRaceTOT likeepRace'];
                        valALL(likeepRace) = 0;
                    end;
                end;
            end;
        
            if isempty(likeepRaceTOT) == 0;
                %Display database
                handles.sortbyExceptionSelection = 1;
                handles.selectLanesDouble1 = likeepPoolType;
                handles.selectLanesDouble2 = likeepRaceTOT';
                Disp_synchroniser;
                
                handles.sortbyPreviousSelection = handles.sortbyCurrentSelection;
            end;
        end;
        Disp_synchroniser;
    end;
end;

%---create duplicate DB icon
if pt(1,1) >= P17(1,1) & pt(1,1) <= (P17(1,1)+P17(1,3)) & pt(1,2) >= P17(1,2) & pt(1,2) <= (P17(1,2)+P17(1,4));
    axes(handles.DuplicateDB_button_sync); imshow(handles.icones.duplicate_offb);

    answer = questdlg('Long or short course?', ...
    	'Course', 'Long Course', 'Short Course', 'Long Course');

    if isempty(answer) == 1;
        return;
    end;

    %---Filter for course
    likeepPoolType = [];
    classifier = handles.uidDB(:,11);
    classifier = cell2mat(classifier);
    if strcmpi(answer, 'Long Course') == 1;
        SearchPoolType = 50;
        handles.filterDoubleCourse = 50;
    else;
        SearchPoolType = 25;
        handles.filterDoubleCourse = 25;
    end;
    likeepPoolType = find(classifier == SearchPoolType); %strcmpi(classifier, SearchPoolType);
%     likeepPoolType = find(lisearch == 1);
    datasetuidDB = handles.uidDB(likeepPoolType,:);
    classifier = datasetuidDB(:,2);
    valALL = 1:length(classifier);
    likeepRaceTOT = [];
    for iter = 1:length(classifier);
        valEC = valALL(iter);
        if valEC ~= 0;
            %---search filename
            SearchRace = classifier{iter};
            lisearch = strcmpi(classifier, SearchRace);
            likeepRace = find(lisearch == 1);
            %---Store doubles
            if length(likeepRace) >= 2;
                %Found doubles... (current row and at least another one)
                likeepRaceTOT = [likeepRaceTOT likeepRace'];
                valALL(likeepRace) = 0;
            end;
        end;
    end;

    if isempty(likeepRaceTOT) == 0;
        %Display database
        handles.sortbyExceptionSelection = 1;
        source = 'FilterDouble';
        handles.selectLanesDouble1 = likeepPoolType;
        handles.selectLanesDouble2 = likeepRaceTOT';
        Disp_synchroniser;
        
        handles.sortbyPreviousSelection = handles.sortbyCurrentSelection;
    end;
    handles.sourceFilter = 'FilterDouble';
end;


%---create Open JSON icon
if pt(1,1) >= P18(1,1) & pt(1,1) <= (P18(1,1)+P18(1,3)) & pt(1,2) >= P18(1,2) & pt(1,2) <= (P18(1,2)+P18(1,4));
    axes(handles.OpenJSON_button_sync); imshow(handles.icones.OpenJSON_offb);

    isSP1 = 0;
    selectfiles = find(handles.StatusColDBFull == 1)+1;
    if isempty(selectfiles) == 0;
        iter = 1;
        for file = 1:length(selectfiles);
            SourceSparta = handles.uidDB{selectfiles(file)-1,26};
            if SourceSparta == 1 | SourceSparta == 3;
                %sparta 1
                isSP1 = 1;
            else;
                %sparta 2
                fileListAWS{iter,1} = handles.uidDB{selectfiles(file)-1,33};
                iter = iter + 1;
            end;
        end;
        if isSP1 == 1;
            %sparta 1 and greenEye
            errordlg('Error', 'No JSON file available for SP1 and GE Races');
            return;
        end;

        if length(fileListAWS) > 1;
            errordlg('Error', 'Cannot open multiple files');
            return;
        end;

        fileECin = fileListAWS{1};
        [rootFolder, filename, fileext] = fileparts(fileECin);
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            fileECout = [MDIR '\SP2Viewer\Preferences\' filename fileext];
        else;
            fileECout = ['/Applications/SP2Viewer/Preferences/' filename fileext];
        end;
        command = ['aws s3 cp ' fileECin ' ' fileECout];
        [status, out] = system(command);
    
        if status ~= 0;
            errordlg('Error', 'File not downloaded');
            return;
        end;
        system(['notepad ' fileECout]);

        command = ['aws s3 cp ' fileECout ' ' fileECin];
        [status, out] = system(command);

        if status ~= 0;
            errordlg('Error', 'File not uploaded');
            return;
        end;

        if ispc == 1;
            command = ['del /Q ' fileECout];
        else;
            ee=ee
        end;
        [status, out] = system(command);
    end;
end;

%---create Open MAT icon
if pt(1,1) >= P19(1,1) & pt(1,1) <= (P19(1,1)+P19(1,3)) & pt(1,2) >= P19(1,2) & pt(1,2) <= (P19(1,2)+P19(1,4));
    axes(handles.OpenMAT_button_sync); imshow(handles.icones.OpenMAT_offb);

    selectfiles = find(handles.StatusColDBFull == 1)+1;
    if isempty(selectfiles) == 0;        
        iter = 1;
        for file = 1:length(selectfiles);
            fileListAWS{iter,1} = handles.FullDB{selectfiles(file),65};
            iter = iter + 1;
        end;
        if length(fileListAWS) > 1;
            errordlg('Error', 'Cannot open multiple files');
            return;
        end;

        fileECin = fileListAWS{1};
        [rootFolder, filename, fileext] = fileparts(fileECin);
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            fileECout = [MDIR '\SP2Viewer\Preferences\' filename fileext];
        else;
            fileECout = ['/Applications/SP2Viewer/Preferences/' filename fileext];
        end;
        command = ['aws s3 cp ' fileECin ' ' fileECout];
        [status, out] = system(command);
    
        if status ~= 0;
            errordlg('Error', 'File not downloaded');
            return;
        end;
        varAll = load(fileECout);
        assignin('base', 'loadMatFile', varAll);
        eval(['openvar(' '''' 'loadMatFile.' filename '''' ');']);

        if ispc == 1;
            fontEC = 14;
        elseif ismac == 1;
            fontEC = 16;
        end;
        resolution = get(0,'ScreenSize');
        resolution = resolution(1,3:4);
        pos = [(resolution(1)-300)./2 (resolution(2)-100)./2 300 100];
        h = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
            'color', [0 0 0], 'units', 'pixels','position', pos, ...
            'Name', 'Save', 'NumberTitle', 'off');
        h1 = uicontrol('parent', h, 'style', 'text', ...
            'string', 'Save data to cloud ?', 'units', 'pixels', ...
            'position', [1 50 298 30], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], ...
            'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
            'FontWeight', 'Bold', 'Fontsize', fontEC);
        h2 = uicontrol('parent', h, 'style', 'pushbutton', ...
            'string', 'Yes', 'units', 'pixels', ...
            'position', [160 20 60 25], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], ...
            'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
            'FontWeight', 'Bold', 'Fontsize', fontEC-2,...
            'Callback', {@saveDataMatFile, fileECout, fileECin});
        h3 = uicontrol('parent', h, 'style', 'pushbutton', ...
            'string', 'No', 'units', 'pixels', ...
            'position', [80 20 60 25], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], ...
            'FontName', 'Book Antiqua', 'FontAngle', 'Italic', ...
            'FontWeight', 'Bold', 'Fontsize', fontEC-2, ...
            'Callback', {@closeDataMatFile, fileECout, fileECin});
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            jFrame = get(handle(h), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
    end;
end;
