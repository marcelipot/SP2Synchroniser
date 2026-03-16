if strcmpi(source, 'FilterDouble') == 1;
    database = FullDB;
else;
    database = handles.FullDB(2:end,:);
end;

%Find raws for 'Meet' (col 7)
likeepMeet = [];

if isempty(handles.SearchMeet) == 0 & isempty(database) == 0;
    classifier = database(:,7);
    
    if iscell(handles.SearchMeet) == 1;
        for i = 1:length(handles.SearchMeet);
            SearchMeet = handles.SearchMeet{i};
            lisearch = strfind(lower(classifier), lower(SearchMeet));
            likeepMeet = [likeepMeet; find(~cellfun('isempty', lisearch))];
        end;
    else;
        SearchMeet = handles.SearchMeet;
        lisearch = strfind(lower(classifier), lower(SearchMeet));
        likeepMeet = [likeepMeet; find(~cellfun('isempty', lisearch))];
    end;
    if isempty(likeepMeet) == 1;
        database = [];
    else;
        database = database(likeepMeet,:);
        uidDB = uidDB(likeepMeet,:);
    end;
end;

%Find raws for 'Year' (col 8)
likeepYear = [];
if isempty(handles.SearchYear) == 0 & isempty(database) == 0;
    classifier = database(:,8);
    
    if length(handles.SearchYear) > 1;
        for i = 1:length(handles.SearchYear);
            handles2.SearchYear{i} = num2str(handles.SearchYear(i));
        end;
        handles.SearchYear = handles.SearchYear2;
    end;
    
    if iscell(handles.SearchYear) == 1;
        for i = 1:length(handles.SearchYear);
            SearchYear = num2str(handles.SearchYear{i});
            lisearch = strfind(lower(classifier), lower(SearchYear));
            likeepYear = [likeepYear; find(~cellfun('isempty', lisearch))];
        end;
    else;
        SearchYear = num2str(handles.SearchYear);
        lisearch = strfind(lower(classifier), lower(SearchYear));
        likeepYear = [likeepYear; find(~cellfun('isempty', lisearch))];
    end;
    if isempty(likeepYear) == 1;
        database = [];
    else;
        database = database(likeepYear,:);
        uidDB = uidDB(likeepYear,:);
    end;
end;

%Find raws for 'Name' (col 2)
likeepName = [];
if isempty(handles.SearchName) == 0 & isempty(database) == 0;
    classifier = database(:,2);
    
    if iscell(handles.SearchName) == 1;
        for i = 1:length(handles.SearchName);
            SearchName = handles.SearchName{i};
            lisearch = strfind(lower(classifier), lower(SearchName));
            likeepName = [likeepName; find(~cellfun('isempty', lisearch))];
        end;
    else;
        SearchName = handles.SearchName;
        lisearch = strfind(lower(classifier), lower(SearchName));
        likeepName = [likeepName; find(~cellfun('isempty', lisearch))];
    end;
    if isempty(likeepName) == 1;
        database = [];
    else;
        database = database(likeepName,:);
        uidDB = uidDB(likeepName,:);
    end;
end;

%Find raws for 'Gender' (col 5)
likeepGender = [];
if isempty(handles.SearchGender) == 0 & isempty(database) == 0;
    classifier = database(:,5);
    SearchGender = handles.listpopGender{handles.SearchGender};
    
    lisearch = strcmpi(lower(classifier), lower(SearchGender));
    likeepGender = find(lisearch == 1);
    if isempty(likeepGender) == 1;
        database = [];
    else;
        database = database(likeepGender,:);
        uidDB = uidDB(likeepGender,:);
    end;
end;

%Find raws for 'SwimType' (col 6)
likeepSwimType = [];
if isempty(handles.SearchSwimType) == 0 & isempty(database) == 0;
    classifier = database(:,6);
    SearchSwimType = handles.listpopType{handles.SearchSwimType};
    
    lisearch = strcmpi(lower(classifier), lower(SearchSwimType));
    likeepSwimType = find(lisearch == 1);
    if isempty(likeepSwimType) == 1;
        database = [];
    else;
        database = database(likeepSwimType,:);
        uidDB = uidDB(likeepSwimType,:);
    end;
end;

%Find raws for 'StrokeType' (col 4)
likeepStrokeType = [];
if isempty(handles.SearchStrokeType) == 0 & isempty(database) == 0;
    classifier = database(:,4);
    SearchStrokeType = handles.listpopStroke{handles.SearchStrokeType};
    
    lisearch = strcmpi(lower(classifier), lower(SearchStrokeType));
    likeepStrokeType = find(lisearch == 1);
    if isempty(likeepStrokeType) == 1;
        database = [];
    else;
        database = database(likeepStrokeType,:);
        uidDB = uidDB(likeepStrokeType,:);
    end;
end;

%Find raws for 'Distance' (col 3)
likeepDistance = [];
if isempty(handles.SearchDistance) == 0 & isempty(database) == 0;
    classifier = database(:,3);
    SearchDistance = handles.listpopDistance{handles.SearchDistance};
    SearchDistance = SearchDistance(1:end-1);
    
    lisearch = strcmpi(lower(classifier), lower(SearchDistance));
    likeepDistance = find(lisearch == 1);
    if isempty(likeepDistance) == 1;
        database = [];
    else;
        database = database(likeepDistance,:);
        uidDB = uidDB(likeepDistance,:);
    end;
end;

%Find raws for 'PoolType' (col 10)
likeepPoolType = [];
if isempty(handles.SearchPoolType) == 0 & isempty(database) == 0;
    classifier = database(:,10);
    SearchPoolType = handles.listpopPool{handles.SearchPoolType};
    if strcmpi(SearchPoolType, 'SCM');
        SearchPoolType = '25';
    else;
        SearchPoolType = '50';
    end;
    
    lisearch = strcmpi(lower(classifier), lower(SearchPoolType));
    likeepPoolType = find(lisearch == 1);
    if isempty(likeepPoolType) == 1;
        database = [];
    else;
        database = database(likeepPoolType,:);
        uidDB = uidDB(likeepPoolType,:);
    end;
end;

%Find raws for 'Category' (col 12)
likeepCategory = [];
if isempty(handles.SearchCategory) == 0 & isempty(database) == 0;
    classifier = database(:,12);
    SearchCategory = handles.listpopGroup{handles.SearchCategory};
    
    lisearch = strcmpi(lower(classifier), lower(SearchCategory));
    likeepCategory = find(lisearch == 1);
    if isempty(likeepCategory) == 1;
        database = [];
    else;
        database = database(likeepCategory,:);
        uidDB = uidDB(likeepCategory,:);
    end;
end;

%Find raws for 'RaceType' (col 11)
likeepRaceType = [];
if isempty(handles.SearchRaceType) == 0 & isempty(database) == 0;
    classifier = database(:,11);
    SearchRaceType = handles.listpopRelay{handles.SearchRaceType};
    
    lisearch = strfind(lower(classifier), lower(SearchRaceType));
    emptyIndex = cellfun('isempty', lisearch);
    lisearch(emptyIndex) = {0};
    lisearch = cell2mat(lisearch);
    likeepRaceType = find(lisearch == 1);
    
    if isempty(likeepRaceType) == 1;
        database = [];
    else;
        database = database(likeepRaceType,:);
        uidDB = uidDB(likeepRaceType,:);
    end;
end;

%Find raws for 'AgeGroup' (col 13)
likeepAgeGroup = [];
if isempty(handles.SearchAgeGroup) == 0 & isempty(database) == 0;
    if handles.SearchAgeGroup > 2;
        classifierMeetID = database(:,36);
        classifierDOB = database(:,13);
        
        for i = 1:length(classifierMeetID);
            MeetID = classifierMeetID{i};
            eval(['MeetBegDate = handles.AgeGroup.' MeetID ';']);
            DOB = classifierDOB{i,1};
            index = strfind(DOB, '/');
            dateDiff(1) = datetime(str2num(DOB(index(2)+1:end)), str2num(DOB(index(1)+1:index(2)-1)), str2num(DOB(1:index(1)-1)));
            index = strfind(MeetBegDate, '-');
            dateDiff(2) = datetime(str2num(MeetBegDate(1:index(1)-1)), str2num(MeetBegDate(index(1)+1:index(2)-1)), str2num(MeetBegDate(index(2)+1:end)));
            D = caldiff(dateDiff, {'years','months','days'});
            [AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});

            if AgeYear(1) < 14 & handles.SearchAgeGroup == 7;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 14 & handles2.SearchAgeGroup == 6;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 15 & handles2.SearchAgeGroup == 5;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 16 & handles2.SearchAgeGroup == 4;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 17 & handles2.SearchAgeGroup == 3;
                likeepAgeGroup = [likeepAgeGroup i];
            elseif AgeYear(1) <= 18 & handles2.SearchAgeGroup == 2;
                likeepAgeGroup = [likeepAgeGroup i];
            end;
        end;
        if isempty(likeepAgeGroup) == 1;
            database = [];
        else;
            database = database(likeepAgeGroup,:);
            uidDB = uidDB(likeepAgeGroup,:);
        end;
    end;
end;

%PBs filter
likeepPBs = [];
if isempty(handles.SearchPoolType) == 1;
    PBsDB = handles.PBsDB;
else;
    if handles.SearchPoolType == 1;
        PBsDB = handles.PBsDB;
    elseif handles.SearchPoolType == 2;
        PBsDB = handles.PBsDB_SC;
    end;
end;
currentNameList = {};
iter = 1;        
if isempty(handles.SearchPB) == 0 & isempty(database) == 0;
    if handles.sortbyCurrentSelection <= 14;
        rankColPB = 1;
    else
        rankColPB = handles.sortbyCurrentSelection - 13;
    end;

    for i = 1:length(database(:,1));
        li = find(strcmpi(handles.uidDB(:,1), database{i,1}));
        athleteUID = handles.uidDB{li,15};
        CurentDist = str2num(handles.uidDB{li,4});
        CurrentStroke = handles.uidDB{li,5};
        
        if strcmpi(CurrentStroke, 'Butterfly');
            if CurentDist == 50;
                target = 1;
            elseif CurentDist == 100;
                target = 2;
            elseif CurentDist == 200;
                target = 3;
            end;
        elseif strcmpi(CurrentStroke, 'Backstroke');
            if CurentDist == 50;
                target = 4;
            elseif CurentDist == 100;
                target = 5;
            elseif CurentDist == 200;
                target = 6;
            end;
        elseif strcmpi(CurrentStroke, 'Breaststroke');
            if CurentDist == 50;
                target = 7;
            elseif CurentDist == 100;
                target = 8;
            elseif CurentDist == 200;
                target = 9;
            end;
        elseif strcmpi(CurrentStroke, 'Freestyle');
            if CurentDist == 50;
                target = 10;
            elseif CurentDist == 100;
                target = 11;
            elseif CurentDist == 200;
                target = 12;
            elseif CurentDist == 400;
                target = 13;
            elseif CurentDist == 800;
                target = 14;
            elseif CurentDist == 1500;
                target = 15;
            end;
        elseif strcmpi(CurrentStroke, 'Medley');
            if CurentDist == 100;
                target = 16;
            elseif CurentDist == 150;
                target = 17;
            elseif CurentDist == 200;
                target = 18;
            elseif CurentDist == 400;
                target = 19;
            end;
        end;

        eval(['PB = PBsDB.A' num2str(athleteUID) 'A(' num2str(target) ',' num2str(rankColPB) ');']);
        
        if handles.sortbyCurrentSelection <= 14;
            %rank by race time
            rankColVAL = 14;
            VAL = database{i,rankColVAL};
            li = strfind(VAL, 's');
            if isempty(li) == 1;
                li2 = strfind(VAL, ':');
                min = str2num(VAL(1:li2-1)).*60;
                sec = str2num(VAL(li2+1:end));
                VAL = min+sec;
            else;
                VAL = str2num(VAL(1:end-1));
            end;
            
        else
            if rankColPB == 2;
                %rank by Skill time
                rankColVAL = 15;
                VAL = database{i,rankColVAL};
                li = strfind(VAL, 's');
                if isempty(li) == 1;
                    li2 = strfind(VAL, ':');
                    min = str2num(VAL(1:li2-1)).*60;
                    sec = str2num(VAL(li2+1:end));
                    VAL = min+sec;
                else;
                    VAL = str2num(VAL(1:end-1));
                end;
                
            elseif rankColPB == 3;
                %rank by swim time
                rankColVAL = 16;
                VAL = database{i,rankColVAL};
                li = strfind(VAL, 's');
                if isempty(li) == 1;
                    li2 = strfind(VAL, ':');
                    min = str2num(VAL(1:li2-1)).*60;
                    sec = str2num(VAL(li2+1:end));
                    VAL = min+sec;
                else;
                    VAL = str2num(VAL(1:end-1));
                end;
            
            elseif rankColPB == 4;
                %rank by DropOff
                rankColVAL = 17;
                VAL = database{i,rankColVAL};
                if strcmpi(VAL(1),'+');
                    VAL = str2num(VAL(2:end));
                else;
                    VAL = str2num(VAL);
                end;
                
            elseif rankColPB == 5;
                %rank by Max Vel
                rankColVAL = 18;
                VAL = database{i,rankColVAL};
                li1 = strfind(VAL, '/');
                li2 = strfind(VAL, '[');
                VAL = str2num(VAL(li1+2:li2-2));
                
            elseif rankColPB == 6;
                %rank by Max SR
                rankColVAL = 19;
                VAL = database{i,rankColVAL};
                li1 = strfind(VAL, '/');
                li2 = strfind(VAL, '[');
                VAL = str2num(VAL(li1+2:li2-2));
                
            elseif rankColPB == 7;
                %rank by Max DPS
                rankColVAL = 20;
                VAL = database{i,rankColVAL};
                li1 = strfind(VAL, '/');
                li2 = strfind(VAL, '[');
                VAL = str2num(VAL(li1+2:li2-2));
                
            elseif rankColPB == 8;
                %rank by RT
                rankColVAL = 21;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            elseif rankColPB == 9;
                %rank by DiveT15
                rankColVAL = 22;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            elseif rankColPB == 10;
                %rank by Entry Dist
                rankColVAL = 23;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            elseif rankColPB == 11;
                %rank by UW speed
                rankColVAL = 24;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            elseif rankColPB == 12;
                %rank by BO Dist Start
                rankColVAL = 25;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            elseif rankColPB == 13;
                %rank by BO Eff Start
                rankColVAL = 26;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            elseif rankColPB == 14;
                %rank by App Eff Turn
                rankColVAL = 27;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            elseif rankColPB == 15;
                %rank by BO Dist Turn
                rankColVAL = 28;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            elseif rankColPB == 16;
                %rank by BO Eff Turn
                rankColVAL = 29;
                VAL = database{i,rankColVAL};
                VAL = str2num(VAL);
                
            end;
        end;    
        
        if roundn(PB,-2) == roundn(VAL,-2);
            
            checkName = database{i,2};
            lisearch = strfind(lower(currentNameList), lower(checkName));
            likeepName = find(~cellfun('isempty', lisearch));
            if isempty(likeepName) == 1; %check for equal PBs
                %I keep the race
                likeepPBs = [likeepPBs i];
                currentNameList{iter,1} = checkName;
                iter = iter + 1;
            end;
        end;
    end;
    if isempty(likeepPBs) == 1;
        database = [];
    else;
        database = database(likeepPBs,:);
        uidDB = uidDB(likeepPBs,:);
    end;
end;
