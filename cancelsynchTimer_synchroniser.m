function [] = cancelsynchTimer_database(varargin);


handles2 = guidata(gcf);
%uiresume(handles2.hf_w2_welcome);

isrunning = get(handles2.proceedprocess_main, 'String');
if strcmpi(isrunning, 'running');
    set(handles2.proceedprocess_main, 'String', 'initial');
else;
    fh = findobj(0,'type','figure');
    nfh=length(fh); % Total number of open figures, including GUI and figures with visibility 'off'
    % Scan through open figures - GUI figure number is [] (i.e. size is zero)
    for i = 1:nfh;
        % Close all figures with a Number size is greater than zero
        if strcmpi((fh(i).Name), 'Synchronisation') == 1;
    %         figure(fh(i).Number);
            close(fh(i).Number);
        end;
    end;
end;
pause(0.5);

handles = guidata(gcf);
currentYear = year(datetime("today"));
for yearEC = 2018:currentYear;
    filenameDBin = ['s3://sparta2-prod/sparta2-data/SP2viewerDBSP2_' num2str(yearEC) '.mat'];
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        filenameDBout = [MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearEC) '.mat'];
    elseif ismac == 1;
        filenameDBout = ['/Applications/SP2Synchroniser/SP2viewerDBSP2_' num2str(yearEC) '.mat'];
    end;
    command = ['aws s3 cp ' filenameDBin ' ' filenameDBout];
    [status, out] = system(command);
end;
if ispc == 1
    for yearEC = 2018:currentYear;
        fileEC = [MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearEC) '.mat'];
        if isfile(fileEC) == 1;
            load([MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearEC) '.mat']);
        end;
    end;
elseif ismac == 1;
    for yearEC = 2018:currentYear;
        fileEC = ['/Applications/SP2Synchroniser/SP2viewerDBSP2_' num2str(yearEC) '.mat'];
        if isfile(fileEC) == 1;
            load(fileEC);
        end;
    end;
end;

iter = 0;
for yearEC = 2018:currentYear;
    fileEC = ['FullDB_SP2_' num2str(yearEC)];
    if exist(fileEC) == 1;
        if iter == 0;
            eval(['FullDB = FullDB_SP2_' num2str(yearEC) ';']);
            eval(['uidDB = uidDB_SP2_' num2str(yearEC) ';']);
            eval(['FullDB = FullDB_SP2_' num2str(yearEC) ';']);
            eval(['AgeGroup = AgeGroup_SP2_' num2str(yearEC) ';']);
            eval(['LastUpdate = LastUpdate_SP2_' num2str(yearEC) ';']);
            listFieldsExist = fieldnames(AgeGroup);

            iter = 1;
        else;
            rawIni = length(FullDB(:,1)) + 1;
            eval(['rawEnd = rawIni + length(FullDB_SP2_' num2str(yearEC) '(2:end,1)) - 1;']);
            eval(['FullDB(rawIni:rawEnd,:) = FullDB_SP2_' num2str(yearEC) '(2:end,:);']);
        
            rawIni = length(uidDB(:,1)) + 1;
            eval(['rawEnd = rawIni + length(uidDB_SP2_' num2str(yearEC) '(:,1)) - 1;']);
            eval(['uidDB(rawIni:rawEnd,:) = uidDB_SP2_' num2str(yearEC) ';']);

            eval(['listFieldsCheck = fieldnames(AgeGroup_SP2_' num2str(yearEC) ');']);
            for i = 1:length(listFieldsCheck);
                fieldCheck = listFieldsCheck{i};
                index = find(strcmpi(listFieldsExist, fieldCheck) == 1);
                if isempty(index) == 1;
                    eval(['val = AgeGroup_SP2_' num2str(yearEC) '.' fieldCheck ';']);
                    eval(['AgeGroup.' fieldCheck ' = ' '''' val '''' ';']);
                end;
            end;
        end;
    end;
end;


isSP1 = 0;
isGreenEye = 0;
if ismac == 1;
    if exist('/Applications/SP2Synchroniser/SP2viewerDBSP1.mat') == 2;
        load /Applications/SP2Synchroniser/SP2viewerDBSP1.mat;
        isSP1 = 1;
    end;
    if exist('/Applications/SP2Synchroniser/SP2viewerDBGreenEye.mat') == 2;
        load /Applications/SP2Synchroniser/SP2viewerDBGreenEye.mat;
        isGreenEye = 1;
    end;
elseif ispc == 1;
    if exist([MDIR '\SP2Synchroniser\SP2viewerDBSP1.mat']) == 2;
        load([MDIR '\SP2Synchroniser\SP2viewerDBSP1.mat']);
        isSP1 = 1;
    end;
    if exist([MDIR '\SP2Synchroniser\SP2viewerDBGreenEye.mat']) == 2;
        load([MDIR '\SP2Synchroniser\SP2viewerDBGreenEye.mat']);
        isGreenEye = 1;
    end;
end;

if isSP1 == 1;
    
    rawIni = length(FullDB(:,1)) + 1;
    rawEnd = rawIni + length(FullDB_SP1(2:end,1)) - 1;
    FullDB(rawIni:rawEnd,:) = FullDB_SP1(2:end,:);

    rawIni = length(uidDB(:,1)) + 1;
    rawEnd = rawIni + length(uidDB_SP1(:,1)) - 1;
    uidDB(rawIni:rawEnd,:) = uidDB_SP1;

    listFieldsExist = fieldnames(AgeGroup);
    listFieldsCheck = fieldnames(AgeGroup_SP1);
    for i = 1:length(listFieldsCheck);
        fieldCheck = listFieldsCheck{i};
        index = find(strcmpi(listFieldsExist, fieldCheck) == 1);
        if isempty(index) == 1;
            eval(['val = AgeGroup_SP1.' fieldCheck ';']);
            eval(['AgeGroup.' fieldCheck ' = ' '''' val '''' ';']);
        end;
    end;
end;

if isGreenEye == 1;
    rawIni = length(FullDB(:,1)) + 1;
    rawEnd = rawIni + length(FullDB_GreenEye(2:end,1)) - 1;
    FullDB(rawIni:rawEnd,:) = FullDB_GreenEye(2:end,:);

    rawIni = length(uidDB(:,1)) + 1;
    rawEnd = rawIni + length(uidDB_GreenEye(:,1)) - 1;
    uidDB(rawIni:rawEnd,:) = uidDB_GreenEye;

    listFieldsExist = fieldnames(AgeGroup);
    listFieldsCheck = fieldnames(AgeGroup_GreenEye);
    for i = 1:length(listFieldsCheck);
        fieldCheck = listFieldsCheck{i};
        index = find(strcmpi(listFieldsExist, fieldCheck) == 1);
        if isempty(index) == 1;
            eval(['val = AgeGroup_GreenEye.' fieldCheck ';']);
            eval(['AgeGroup.' fieldCheck ' = ' '''' val '''' ';']);
        end;
    end;
end;

handles.AthletesDB = AthletesDB;
handles.ParaDB = ParaDB;
handles.uidDB = uidDB;
handles.FullDB = FullDB;
handles.PBsDB = PBsDB;
handles.PBsDB_SC = PBsDB_SC;
handles.AgeGroup = AgeGroup;
handles.LastUpdate = LastUpdate;
handles.BenchmarkEvents = BenchmarkEvents;

if isempty(handles.uidDB) == 0;
    %Display database
    source = 'Filter';
    Disp_synchroniser;
    
    handles.sortbyPreviousSelection = handles.sortbyCurrentSelection;
end;
drawnow;
guidata(handles.hf_w1_welcome, handles);
