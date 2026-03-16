currentYear = year(datetime("today"));
MDIR = getenv('USERPROFILE')
for yearEC = 2018:currentYear;
    fileEC = [MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearEC) '.mat'];
    if isfile(fileEC) == 1;
        load([MDIR '\SP2Synchroniser\SP2viewerDBSP2_' num2str(yearEC) '.mat']);

        if yearEC ~= currentYear;
            clear AthletesDB;
            clear BenchmarkEvents;
            clear MeetDB;
            clear isupdate;
            clear ParaDB;
            clear PBsDB;
            clear PBsDB_SC;
            clear RoundDB;
        end;
    end;
end;
isSP1 = 0;
isGreenEye = 0;
if exist([MDIR '\SP2Synchroniser\SP2viewerDBSP1.mat']) == 2;
    load([MDIR '\SP2Synchroniser\SP2viewerDBSP1.mat']);
    handles.LastUpdate_SP1 = LastUpdate_SP1;
    isSP1 = 1;
end;
if exist([MDIR '\SP2Synchroniser\SP2viewerDBGreenEye.mat']) == 2;
    load([MDIR '\SP2Synchroniser\SP2viewerDBGreenEye.mat']);
    handles.LastUpdate_GreenEye = LastUpdate_GreenEye;
    isGreenEye = 1;
end;


iter = 0;
for yearEC = 2018:currentYear;
    fileEC = ['FullDB_SP2_' num2str(yearEC)];
    if exist(fileEC) == 1;
        if iter == 0;
            eval(['FullDB = FullDB_SP2_' num2str(yearEC) ';']);
            eval(['uidDB = uidDB_SP2_' num2str(yearEC) ';']);
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
            eval(['LastUpdate = LastUpdate_SP2_' num2str(yearEC) ';']);
        end;

        eval(['handles.FullDB_SP2_' num2str(yearEC) ' = FullDB;']);
        eval(['handles.uidDB_SP2_' num2str(yearEC) ' = uidDB;']);
        eval(['handles.AgeGroup_SP2_' num2str(yearEC) ' = AgeGroup;']);
        eval(['handles.LastUpdate_SP2_' num2str(yearEC) ' = LastUpdate;']);

    end;
end;

% FullDB = FullDB_SP2;
% uidDB = uidDB_SP2;
% AgeGroup = AgeGroup_SP2;
% LastUpdate = LastUpdate_SP2;
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



handles.MeetDB = MeetDB;
handles.AthletesDB = AthletesDB;
handles.ParaDB = ParaDB;
handles.uidDB = uidDB;
handles.uidDB_GreenEye = uidDB_GreenEye;
handles.uidDB_SP1 = uidDB_SP1;
for yearEC = 2018:currentYear;
    eval(['fileEC = [' '''' 'uidDB_SP2_' num2str(yearEC) '''' '];']);
    if exist(fileEC) == 1;
        eval(['handles.uidDB_SP2_' num2str(yearEC) ' = uidDB_SP2_' num2str(yearEC) ';']);
    else;
        eval(['handles.uidDB_SP2_' num2str(yearEC) ' = {};']);
    end;
end;
handles.FullDB = FullDB;
handles.FullDB_GreenEye = FullDB_GreenEye;
handles.FullDB_SP1 = FullDB_SP1;
for yearEC = 2018:currentYear;
    eval(['fileEC = [' '''' 'FullDB_SP2_' num2str(yearEC) '''' '];']);
    if exist(fileEC) == 1;
        eval(['handles.FullDB_SP2_' num2str(yearEC) ' = FullDB_SP2_' num2str(yearEC) ';']);
    else;
        eval(['handles.FullDB_SP2_' num2str(yearEC) ' = {};']);
    end;
end;
handles.PBsDB = PBsDB;
handles.PBsDB_SC = PBsDB_SC;
handles.AgeGroup = AgeGroup;
handles.AgeGroup_GreenEye = AgeGroup_GreenEye;
handles.AgeGroup_SP1 = AgeGroup_SP1;
for yearEC = 2018:currentYear;
    eval(['fileEC = [' '''' 'AgeGroup_SP2_' num2str(yearEC) '''' '];']);
    if exist(fileEC) == 1;
        eval(['handles.AgeGroup_SP2_' num2str(yearEC) ' = AgeGroup_SP2_' num2str(yearEC) ';']);
    else;
        eval(['handles.AgeGroup_SP2_' num2str(yearEC) ' = {};']);
    end;
end;
eval(['handles.LastUpdate = LastUpdate_SP2_' num2str(currentYear) ';']);
handles.BenchmarkEvents = BenchmarkEvents;
handles.RoundDB = RoundDB;

handles.isupdate = isupdate;


