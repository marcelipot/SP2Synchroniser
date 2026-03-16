function [axesgraph1, axescolbar, AllDB, competitionName] = GreenEye_processing(raceEC, count, AllDB, GEDB, raceDataSegmentNew, raceDataMetaNew, colorrange, colorvalue, axesgraph1, axescolbar);




if count == 1;
    axesgraph1 = axes('parent', gcf, 'units', 'pixels', ...
        'Position', [180, 1, 880, 668], 'Visible', 'off');
else;
    cla(axesgraph1,'reset');
    set(axesgraph1, 'Visible', 'off');
end;


uidDB_GreenEye = AllDB.uidDB_GreenEye;
FullDB_GreenEye = AllDB.FullDB_GreenEye;
ParaDB = AllDB.ParaDB; 
AgeGroup = AllDB.AgeGroup;
AthletesDB = AllDB.AthletesDB;
PBsDB = AllDB.PBsDB;
PBsDB_SC = AllDB.PBsDB_SC;
MeetDB = AllDB.MeetDB;
RoundDB = AllDB.RoundDB;

AthleteAMSDB = GEDB.AthleteAMSDB;
AthleteGreenEyeDB = GEDB.AthleteGreenEyeDB;
MeetAMSDB = GEDB.MeetAMSDB;
ParaAMSDB = GEDB.ParaAMSDB;
MeetMissingDB = GEDB.MeetMissingDB;


%------------------------Prepare Data--------------------------
%take race ID and metadata
RaceId = raceDataMetaNew{1,1};
RaceDist = raceDataMetaNew{1,4};
RaceDist = roundn(RaceDist,0);
Course = raceDataMetaNew{1,6};
if strcmpi(lower(Course), 'lcm');
    Course = 50;
else;
    Course = 25;
end;



%--------------------------Metadata----------------------------
AthleteGreenEyeId = raceDataMetaNew{1,2};
GreenEyeIDall = AthleteGreenEyeDB(2:end,1);
AMSIDall1 = AthleteAMSDB(2:end,2);
proceed = 1;
iter = 1;

searchCol = cell2mat(GreenEyeIDall);
indexGreenEyeID = find(searchCol == AthleteGreenEyeId);
if isempty(indexGreenEyeID) == 1;
    AthleteGreenEyeFirstname = [];
    AthleteGreenEyeLastname = [];
else;
    AthleteGreenEyeFirstname = AthleteGreenEyeDB{indexGreenEyeID+1,3};
    AthleteGreenEyeLastname = AthleteGreenEyeDB{indexGreenEyeID+1,2};
end;

searchCol = cell2mat(AMSIDall1);
indexAMSID = find(searchCol == AthleteGreenEyeId);
if isempty(AthleteGreenEyeFirstname) == 0;
    if isempty(indexAMSID) == 0;
        indexName = find(contains(lower(AthleteAMSDB(:,7)),lower(AthleteGreenEyeFirstname)) & ...
            contains(lower(AthleteAMSDB(:,8)),lower(AthleteGreenEyeLastname)));
        if isempty(indexName) == 1;
            %Wrong athlete ... equivalent of doesnt exist ... take info from AthleteGreenEyeD
            sourceMeta = 0;
        else;
            %athlete exist ... take info from AthleteAMSDB
            sourceMeta = 1;
        end;
    else;
        indexName = find(contains(lower(AthleteAMSDB(:,7)),lower(AthleteGreenEyeFirstname)) & ...
            contains(lower(AthleteAMSDB(:,8)),lower(AthleteGreenEyeLastname)));
        if isempty(indexName) == 1;
            %athlete doesnt exist  ... take info from AthleteGreenEyeDB
            sourceMeta = 0;
        else;
            %athlete exist  ... take info from AthleteAMSDB
            sourceMeta = 1;
        end;
    end;
else;
    AMSIDall2 = AthleteAMSDB(2:end,1);
    searchCol = cell2mat(AMSIDall2);
    indexName = find(searchCol == AthleteGreenEyeId);
    indexName = indexName + 1;
    sourceMeta = 1;
end;

Athletename = 'UnknownA';
AthletenameFull = 'UnknownA';
Firstname = 'Athlete';
Lastname = 'Unknown';
Gender = 'MALE';
DOB = '01/01/2000';
Country = 'INTER';

if sourceMeta == 1;
    %AthleteAMSDB
    indexAMSID = AthleteAMSDB{indexName, 1};
    AthleteId = indexAMSID;
    Firstname = AthleteAMSDB{indexName, 7};
    Lastname = AthleteAMSDB{indexName, 8};

    index1 = strfind(Lastname, ' ');
    index2 = strfind(Lastname, '-');
    index3 = strfind(Lastname, '''');
    proceed = 0;
    if isempty(index1) == 0 | isempty(index2) == 0 | isempty(index3) == 0;
        proceed = 1;
    end;
    while proceed == 1;
        if isempty(index1) == 0;
            Lastname = [Lastname(1:index1-1) Lastname(index1+1:end)];
        else;
            if isempty(index2) == 0;
                Lastname = [Lastname(1:index2-1) Lastname(index2+1:end)];
            else;
                if isempty(index3) == 0;
                    Lastname = [Lastname(1:index3-1) Lastname(index3+1:end)];
                end;
            end;
        end;
        index1 = strfind(Lastname, ' ');
        index2 = strfind(Lastname, '-');
        index3 = strfind(Lastname, '''');
        if isempty(index1) == 1 & isempty(index2) == 1 & isempty(index3) == 1;
            proceed = 0;
        end;
    end;
        
    index1 = strfind(Firstname, ' ');
    index2 = strfind(Firstname, '-');
    index3 = strfind(Firstname, '''');
    proceed = 0;
    if isempty(index1) == 0 | isempty(index2) == 0 | isempty(index3) == 0;
        proceed = 1;
    end;
    while proceed == 1;
        if isempty(index1) == 0;
            Firstname = [Firstname(1:index1-1) Firstname(index1+1:end)];
        else;
            if isempty(index2) == 0;
                Firstname = [Firstname(1:index2-1) Firstname(index2+1:end)];
            else;
                if isempty(index3) == 0;
                    Firstname = [Firstname(1:index3-1) Firstname(index3+1:end)];
                end;
            end;
        end;
        index1 = strfind(Firstname, ' ');
        index2 = strfind(Firstname, '-');
        index3 = strfind(Firstname, '''');
        if isempty(index1) == 1 & isempty(index2) == 1 & isempty(index3) == 1;
            proceed = 0;
        end;
    end;

    Athletename = [Lastname Firstname(1)];
    AthletenameFull = [Firstname ' ' Lastname];
    Gender = AthleteAMSDB{indexName, 6};
    if Gender == 1;
        Gender = 'MALE';
    elseif Gender == 2;
        Gender = 'FEMALE';
    end;
    DOB = AthleteAMSDB{indexName, 5};
    if isempty(DOB) == 1;
        DOB = '01/01/2000';
    end;
    if length(DOB) > 10;
        DOB = DOB(1:10);
    elseif length(DOB) < 10;
        index = strfind(DOB, '/');
        dayDOB = DOB(1:index(1)-1);
        if length(dayDOB) == 1;
            dayDOB = ['0' dayDOB];
        end;
        DOB = [dayDOB DOB(2:end)];
    end;
    Country = AthleteAMSDB{indexName, 4};

    li = find(ParaDB.AMSID == indexAMSID);
    if isempty(li) == 1;
        Paralympic = 'Able';
    else;
        Paralympic = 'Para';
    end;

elseif sourceMeta == 0;
    %AthleteGreenEyeDB
    indexAMSID = [];
    AthleteId = AthleteGreenEyeDB{indexGreenEyeID+1, 1};
    Firstname = AthleteGreenEyeDB{indexGreenEyeID+1, 3};
    Lastname = AthleteGreenEyeDB{indexGreenEyeID+1, 2};

    index1 = strfind(Lastname, ' ');
    index2 = strfind(Lastname, '-');
    index3 = strfind(Lastname, '''');
    proceed = 0;
    if isempty(index1) == 0 | isempty(index2) == 0 | isempty(index3) == 0;
        proceed = 1;
    end;
    while proceed == 1;
        if isempty(index1) == 0;
            Lastname = [Lastname(1:index1-1) Lastname(index1+1:end)];
        else;
            if isempty(index2) == 0;
                Lastname = [Lastname(1:index2-1) Lastname(index2+1:end)];
            else;
                if isempty(index3) == 0;
                    Lastname = [Lastname(1:index3-1) Lastname(index3+1:end)];
                end;
            end;
        end;
        index1 = strfind(Lastname, ' ');
        index2 = strfind(Lastname, '-');
        index3 = strfind(Lastname, '''');
        if isempty(index1) == 1 & isempty(index2) == 1 & isempty(index3) == 1;
            proceed = 0;
        end;
    end;
        
    index1 = strfind(Firstname, ' ');
    index2 = strfind(Firstname, '-');
    index3 = strfind(Firstname, '''');
    proceed = 0;
    if isempty(index1) == 0 | isempty(index2) == 0 | isempty(index3) == 0;
        proceed = 1;
    end;
    while proceed == 1;
        if isempty(index1) == 0;
            Firstname = [Firstname(1:index1-1) Firstname(index1+1:end)];
        else;
            if isempty(index2) == 0;
                Firstname = [Firstname(1:index2-1) Firstname(index2+1:end)];
            else;
                if isempty(index3) == 0;
                    Firstname = [Firstname(1:index3-1) Firstname(index3+1:end)];
                end;
            end;
        end;
        index1 = strfind(Firstname, ' ');
        index2 = strfind(Firstname, '-');
        index3 = strfind(Firstname, '''');
        if isempty(index1) == 1 & isempty(index2) == 1 & isempty(index3) == 1;
            proceed = 0;
        end;
    end;

    Athletename = [Lastname Firstname(1)];
    AthletenameFull = [Firstname ' ' Lastname];
    Gender = upper(AthleteGreenEyeDB{indexGreenEyeID+1, 5});
    DOB = AthleteGreenEyeDB{indexGreenEyeID+1, 4};
    if isempty(DOB) == 1;
        DOB = '01/01/2000';
    end;
    if length(DOB) > 10;
        DOB = DOB(1:10);
    elseif length(DOB) < 10;
        index = strfind(DOB, '/');
        dayDOB = DOB(1:index(1)-1);
        if length(dayDOB) == 1;
            dayDOB = ['0' dayDOB];
        end;
        DOB = [dayDOB DOB(2:end)];
    end;
    Country = AthleteGreenEyeDB{indexGreenEyeID+1, 6};
    if isempty(Country) == 1;
        Country = 'INTER';
    end;
    if strcmpi(lower(Country), 'australia');
        Country = 'AUS';
    elseif strcmpi(lower(Country), 'australian');
        Country = 'AUS';
    else;
        Country = 'INTER';
    end;
    Paralympic = 'Able';
end;

StrokeType = raceDataMetaNew{1,5};
if strcmpi(lower(StrokeType), 'individual medley') == 1;
    StrokeType = 'Medley';
end;
MeetName = raceDataMetaNew{1,11};
indexMeetID = find(contains(lower(MeetAMSDB(:,1)), lower(MeetName)));
if isempty(indexMeetID) == 1;
    %cannot be found in the SP1 database
    indexMeetID = find(contains(lower(MeetMissingDB(:,1)), lower(MeetName)));
    if isempty(indexMeetID) == 1;
        %cannot find the meet nowhere
        CompetitionID = 00000;
    else;
        %found the equivalent name in SP1
        MeetName = MeetMissingDB{indexMeetID,2};
        indexMeetID = find(contains(lower(MeetAMSDB(:,1)), lower(MeetName)));
        CompetitionID = MeetAMSDB{indexMeetID,2};
    end;
else;
    %found in the SP1 database
    CompetitionID = MeetAMSDB{indexMeetID,2};
end;
MeetID = CompetitionID;
competitionId = CompetitionID;
li = findstr(MeetName, ' ');
if isempty(li) == 0;
    liop = [];
    for k = 1:length(MeetName);
        lik = find(li == k);
        if isempty(lik) == 1;
            liop = [liop k];
        end;
    end;
    Meet = MeetName(liop);
else;
    Meet = MeetName;
end;

VenueEC = raceDataMetaNew{1,12};

AnalysisDate = 'na';

RaceDate = raceDataMetaNew{1,3};
RaceDate = char(RaceDate);
if isempty(RaceDate) == 1;
    RaceDate = '01/01/2000';
end;

if length(RaceDate) > 10;
    RaceDate = RaceDate(1:10);
elseif length(RaceDate) < 10;
    index = strfind(RaceDate, '/');
    dayRaceDate = RaceDate(1:index(1)-1);
    if length(dayRaceDate) == 1;
        dayRaceDate = ['0' dayRaceDate];
    end;
    RaceDate = [dayRaceDate RaceDate(2:end)];
end;
index = strfind(RaceDate, '/');
dayDate = RaceDate(1:index(1)-1);
monthDate = RaceDate(index(1)+1:index(2)-1);
yearDate = RaceDate(index(2)+1:end);
if length(dayDate) < 2;
    dayDate = ['0' dayDate];
end;
if length(monthDate) < 2;
    monthDate = ['0' monthDate];
end;
RaceDate = [dayDate '-' monthDate '-' yearDate];
RaceDateMod = [yearDate '-' monthDate '-' dayDate];

Stage = raceDataMetaNew{1,8};

isRelay = raceDataMetaNew{1,9};
relayLeg = raceDataMetaNew{1,10};
if strcmpi(isRelay, 'Individual') == 1;
    valRelay = 'Flat';
    detailRelay = 'None';
elseif strcmpi(isRelay, 'Freestyle') == 1;
    if strcmpi(Gender, "MALE") == 1;
        detailRelay = 'MFS';
    else;
        detailRelay = 'WFS';
    end;
    if relayLeg == 1;
        valRelay = 'Flat(L.1)';
    elseif relayLeg == 2;
        valRelay = 'Relay(L.2)';
    elseif relayLeg == 3;
        valRelay = 'Relay(L.3)';
    elseif relayLeg == 4;
        valRelay = 'Relay(L.4)';
    end;

elseif strcmpi(isRelay, 'Medley') == 1;
    if strcmpi(Gender, "MALE") == 1;
        detailRelay = 'MIM';
    else;
        detailRelay = 'WIM';
    end;
    if relayLeg == 1;
        valRelay = 'Flat(L.1)';
    elseif relayLeg == 2;
        valRelay = 'Relay(L.2)';
    elseif relayLeg == 3;
        valRelay = 'Relay(L.3)';
    elseif relayLeg == 4;
        valRelay = 'Relay(L.4)';
    end;
end;

Lane = 'LaneX';
FilenameNew =  [Athletename '_' num2str(RaceDist) StrokeType '_' Stage '_' Lane '_' Meet num2str(yearDate) '_' valRelay '_' detailRelay];

li = strfind(Athletename, ' ');
if isempty(li) == 0;
    AthletenameDisp = [Athletename(1:li(1)-1) '-' Athletename(li(1)+1:end)];
else;
    AthletenameDisp = Athletename;
end;
FilenameDisp =  ['File :  ' AthletenameDisp '_' num2str(RaceDist) StrokeType '_' Stage '_' Lane '_' Meet yearDate];
Year = yearDate;

framerate = 50;
%----------------------------------------------------------



%----------------------------------------------------------
nbLap = roundn(RaceDist./Course,0);
nbSegment = length(raceDataSegmentNew(:,3));
avInterval = RaceDist./nbSegment;

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
SectionSplitTime = [SectionCumTime(1); diff(SectionCumTime)];
SectionVel = raceDataSegmentNew(:,4);

RT = roundn(raceDataMetaNew{1,18},-2);
SplitsAll = [NaN RT roundn((RT.*framerate)+1,0)];
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

SplitsAvSpeed = [];
for lap = 1:nbLap;
    SplitsAvSpeed(lap) = SplitsAll(lap+1,1)./SplitsAll(lap+1,2);
end;
TT = SplitsAll(end,2);
TTtxt = timeSecToStr(TT);
dataTablePacing{6,1} = TTtxt;


BOAll = [];
for lapEC = 1:nbLap;
    refDist = (lapEC-1).*Course;
    flagBO = 0;
    BOECFrame = [];
    BOECTime = [];
    BOECDist = [];
    if lapEC == 1;
        BOECTime = raceDataMetaNew{1,21};
        BOECDist = refDist + raceDataMetaNew{1,22};
        BOECDist = roundn(BOECDist,-2);
        if BOECTime <= 0;
            %no BO on Lap 1... take 15m
            BOECTime = raceDataMetaNew{1,19};
            BOECFrame = roundn((BOECTime.*framerate)+1,0);
            BOECDist = refDist + 15;
            BOECDist = roundn(BOECDist,-2);
            flagBO = 1;
        else;
            BOECFrame = roundn((BOECTime.*framerate)+1,0);
        end;
    else;
        if Course == 25;
            BOECDist = raceDataSegmentNew(lapEC-1,11);
            if BOECDist == 0;
                BOECDist = refDist + 15;
                BOECDist = roundn(BOECDist,-2);
                flagBO = 1;
            else;
                BOECDist = refDist + raceDataSegmentNew(lapEC-1,11);
                BOECDist = roundn(BOECDist,-2);
            end;
            speedRef = SectionVel(lapEC);
            Time25 = SectionCumTime(lapEC-1);
            diffTime = (refDist - BOECDist)./speedRef;
            BOECTime = Time25 - diffTime;
            BOECFrame = roundn((BOECTime.*framerate)+1,0);
        elseif Course == 50;
            if RaceDist == 50;
                BOECDist = [];
                BOECTime = [];
                BOECFrame = [];
            else;
                liIni = (lapEC*2)-1;
                liEnd = (lapEC*2);
                indexTurnBO = find(raceDataSegmentNew(liIni:liEnd,11) ~= 0 & isnan(raceDataSegmentNew(liIni:liEnd,11)) ~= 1);
                if isempty(indexTurnBO);
                    BOECDist = refDist + 15;
                    BOECDist = roundn(BOECDist,-2);
                    flagBO = 1;
                else;
                    if length(indexTurnBO) == 2;
                        %potential error to check?
                        e=e
                    else;
                        liEC = indexTurnBO + liIni - 1;
                    end;
                    if raceDataSegmentNew(liEC,11) == 9999 | raceDataSegmentNew(liEC,11) == 0;
                        BOECDist = refDist + 15;
                        BOECDist = roundn(BOECDist,-2);
                        flagBO = 1;
                    else;
                        BOECDist = refDist + raceDataSegmentNew(liEC,11);
                        BOECDist = roundn(BOECDist,-2);
                    end;
                end;
                speedRef = SectionVel((lapEC*2)-1);
                Time50 = SplitsAll(lapEC,2);
                diffTime = (refDist - BOECDist)./speedRef;
                BOECTime = Time50 - diffTime;
                BOECFrame = roundn((BOECTime.*framerate)+1,0);
            end;
        end;
    end;
    BOAll = [BOAll; [BOECFrame BOECTime BOECDist flagBO]];
end;
%correct interpolated BO for turns
indexInvalid = find(BOAll(2:end,4) == 1);
if isempty(indexInvalid) == 0;
    %some turns are interpolated
    indexInvalid = indexInvalid + 1;

    if length(indexInvalid) == nbLap-1;
        %all turns are missing
        for changeTurn = 2:nbLap;
            avTurns = 12;
            lapEC = changeTurn;
            BOAll(lapEC,3) = ((lapEC-1).*Course) + avTurns;
            refDist = (lapEC-1).*Course;
            if Course == 25;
                speedRef = SectionVel(lapEC);
                Time25 = SectionCumTime(lapEC-1);
                diffTime = (refDist - BOAll(lapEC,3))./speedRef;
                BOECTime = Time25 - diffTime;
                BOECFrame = roundn((BOECTime.*framerate)+1,0);
                BOAll(lapEC,1) = BOECFrame;
                BOAll(lapEC,2) = BOECTime;
            else;
                speedRef = SectionVel((lapEC*2)-1);
                Time50 = SplitsAll(lapEC,2);
                diffTime = (refDist - BOAll(lapEC,3))./speedRef;
                BOECTime = Time50 - diffTime;
                BOECFrame = roundn((BOECTime.*framerate)+1,0);

                BOAll(lapEC,1) = BOECFrame;
                BOAll(lapEC,2) = BOECTime;
            end;
        end;
    else;
        indexValid = find(BOAll(2:end,4) == 0);
        indexValid = indexValid + 1;
        validTurnsAll = [];
        for changeTurn = 1:length(indexValid);
            lapEC = indexValid(changeTurn);
            validTurn = BOAll(lapEC,3);
            refDist = (lapEC-1).*Course;
            validTurnsAll = [validTurnsAll; validTurn-refDist];
        end;
        avTurns = roundn(mean(validTurnsAll),-1);
        
        for changeTurn = 1:length(indexInvalid);
            lapEC = indexInvalid(changeTurn);
            BOAll(lapEC,3) = ((lapEC-1).*Course) + avTurns;

            if Course == 25;
                refDist = (lapEC-1).*Course;
                speedRef = SectionVel(lapEC);
                Time25 = SectionCumTime(lapEC-1);
                diffTime = (refDist - BOAll(lapEC,3))./speedRef;
                BOECTime = Time25 - diffTime;
                BOECFrame = roundn((BOECTime.*framerate)+1,0);
                BOAll(lapEC,1) = BOECFrame;
                BOAll(lapEC,2) = BOECTime;
            else;
                refDist = (lapEC-1).*Course;
                speedRef = SectionVel((lapEC*2)-1);
                Time50 = SplitsAll(lapEC,2);
                diffTime = (refDist - BOAll(lapEC,3))./speedRef;
                BOECTime = Time50 - diffTime;
                BOECFrame = roundn((BOECTime.*framerate)+1,0);
                BOAll(lapEC,1) = BOECFrame;
                BOAll(lapEC,2) = BOECTime;
            end;
        end;
    end;    
end;

turnAll = [];
refTurnIn = raceDataMetaNew{1,16};
refTurnOut = raceDataMetaNew{1,17};
if Course == 25;
    for lapEC = 1:nbLap-1;
        TurnInTime = raceDataSegmentNew(lapEC,8);
        if refTurnIn ~= 5 & refTurnIn ~= 0;
            diffDist = refTurnIn-5;
            speedRef = SectionVel(lapEC,1);
            interpTime = diffDist./speedRef;
            TurnInTime = TurnInTime + interpTime;
        end;
    
        TurnOutTime = raceDataSegmentNew(lapEC,9);
        if refTurnOut ~= 10 & refTurnOut ~= 0;
            diffDist = 10-refTurnOut;
            speedRef = SectionVel(lapEC+1,1);
            interpTime = diffDist./speedRef;
            TurnOutTime = TurnOutTime + interpTime;
        end;
        
        interpTurn = 0;
        if lapEC > 1;
            if TurnInTime <= 2;
                TurnInTime = mean(turnAll(:,1));
                TurnOutTime = mean(turnAll(:,2));
                interpTurn = 1;
            end;
            if TurnOutTime >= 15;
                TurnInTime = mean(turnAll(:,1));
                TurnOutTime = mean(turnAll(:,2));
                interpTurn = 1;
            end;
        end;
        turnAll = [turnAll; [TurnInTime TurnOutTime interpTurn]];

        if nbLap-1 > 1;
            if lapEC == nbLap-1;
                if turnAll(1,1) == 0;
                    turnAll(1,1) = mean(turnAll(:,1));
                    turnAll(1,3) = 1;
                end;
                if turnAll(1,2) == 0;
                    turnAll(1,2) = mean(turnAll(:,2));
                    turnAll(1,3) = 1;
                end;
            end;
        end;
    end;
elseif Course == 50;

    if RaceDist == 50;
        turnAll = [];
    else;
        
        for lapEC = 1:nbLap-1;
            TurnInTime = raceDataSegmentNew(lapEC*2,8);
            if refTurnIn ~= 5;
                diffDist = refTurnIn-5;
                speedRef = SectionVel(lapEC,1);
                interpTime = diffDist./speedRef;
                TurnInTime = TurnInTime + interpTime;
            end;
        
            TurnOutTime = raceDataSegmentNew(lapEC*2,9);
            if refTurnOut ~= 10;
                diffDist = 10-refTurnOut;
                speedRef = SectionVel(lapEC+1,1);
                interpTime = diffDist./speedRef;
                TurnOutTime = TurnOutTime + interpTime;
            end;

            interpTurn = 0;
            if TurnInTime <= 2;
                if isempty(turnAll) == 1;
                    TurnInTime = 3;
                    TurnOutTime = 4;
                else;
                    TurnInTime = mean(turnAll(:,1));
                    TurnOutTime = mean(turnAll(:,2));
                end;
                interpTurn = 1;
            end;
            if TurnOutTime >= 15;
                if isempty(turnAll) == 1;
                    TurnInTime = 3;
                    TurnOutTime = 4;
                else;
                    TurnInTime = mean(turnAll(:,1));
                    TurnOutTime = mean(turnAll(:,2));
                end;
                interpTurn = 1;
            end;

            turnAll = [turnAll; [TurnInTime TurnOutTime interpTurn]];
        end;
    end;
end;

finishTime = raceDataMetaNew{1,20};
if finishTime ~= 0;
    refFinish = raceDataMetaNew{1,15};
    if refFinish ~= 5;
        diffDist = refFinish-5;
        speedRef = SectionVel(end,1);
        interpTime = diffDist./speedRef;
        finishTime = finishTime + interpTime;
    end;
else;
    finishTime = NaN;
end;

startTime = raceDataMetaNew{1,19};

RaceLocation = [0 0 0 1 0];
if avInterval == 25;
    jumpDist = ones(1,nbSegment).*25;
else;
    jumpDist = [15 10 10 10 5];
    if RaceDist == 100;
        jumpDist = [15 10 10 10 5 15 10 10 10 5];
    end;
    if RaceDist > 50;
        nbSegment = nbSegment + 1;
    end;
end;
for splitsEC = 1:nbSegment;
    addDist = jumpDist(splitsEC);
    RaceLocation = [RaceLocation; [0 0 0 roundn((SectionCumTime(splitsEC).*framerate)+1,0) RaceLocation(length(RaceLocation(:,1)),5)+addDist]];
end;

for lapEC = 2:nbLap;
    keydist = (lapEC-1).*Course;
    index = find(RaceLocation(:,5) == keydist);
    frameLap = RaceLocation(index,4);
    frameTurnIn = floor(frameLap - (turnAll(lapEC-1,1).*framerate));
    frameTurnOut = floor(frameLap + (turnAll(lapEC-1,2).*framerate));
    indexCheck = find(RaceLocation(:,5) == keydist+10);
    if isempty(indexCheck) == 1;
        RaceLocation = [RaceLocation; [0 0 0 frameTurnIn keydist-5]; [0 0 0 frameTurnOut keydist+10]];
    end;
end;

index = find(RaceLocation(:,5) == RaceDist);
finishFrame = roundn(RaceLocation(index,4) - (finishTime.*framerate),0);
if isnan(finishFrame) == 1;
    RaceLocation = [RaceLocation; [0 0 0 NaN RaceLocation(index,5)-5]];
else;
    indexCheck = find(RaceLocation(:,5) == RaceLocation(index,5)-5);
    if isempty(indexCheck) == 1;
        RaceLocation = [RaceLocation; [0 0 0 finishFrame RaceLocation(index,5)-5]];
    end;
end;

startFrame = roundn(startTime.*framerate,0);
indexCheck = find(RaceLocation(:,5) == 15);
if isempty(indexCheck) == 1;
    if startTime == 0;
        
        RaceLocation = [RaceLocation; [NaN NaN NaN NaN 15]];
    
        %Check is BO needs to be updated
        if BOAll(1,2) == 0;
            %yes it needs
            index = find(RaceLocation(:,5) == 25);
            Pos25 = RaceLocation(index,5);
            Time25 = RaceLocation(index,4)./framerate;
    
            avSpeed = Pos25./Time25;
            startTime = roundn(Time25 - (10./avSpeed),-2);
            startFrame = roundn(startTime.*framerate,0);
            index = find(RaceLocation(:,5) == 15);
            RaceLocation(index,4) = startFrame;
    
            BOAll(1,1) = startFrame;
            BOAll(1,2) = startTime;
    
        else;
            index = find(RaceLocation(:,5) == 25);
            Pos25 = RaceLocation(index,5);
            Time25 = RaceLocation(index,4)./framerate;
            PosBO = BOAll(1,2);
            TimeBO = BOAll(1,1)./framerate;
    
            avSpeed = (Pos25 - PosBO)./((Time25 - TimeBO));
            startTime = roundn(Time25 - (10./avSpeed),-2);
            startFrame = roundn(startTime.*framerate,0);
            index = find(RaceLocation(:,5) == 15);
            RaceLocation(index,4) = startFrame;
    
        end;
    else;
        RaceLocation = [RaceLocation; [0 0 0 startFrame 15]];
    end;
end;

% for lapEC = 1:nbLap;
%     RaceLocation = [RaceLocation; [0 0 0 BOAll(lapEC,1) BOAll(lapEC,3)]];
% end;
[val, index] = sort(RaceLocation(:,5));
RaceLocation = RaceLocation(index,:);

invalidRace = 0;
checkGE_RaceLocation;
%--------------------------------------------------------




%-----------------Reproduce pacingtableINI-----------------
if Course == 25;
    nbZone = 5;
    SectionVelNew = zeros(nbLap,5);
    SectionVelbisNew = zeros(nbLap,5);
    SectionCumTimeNew = zeros(nbLap,5);
    SectionCumTimebisNew = zeros(nbLap,5);
    SectionSplitTimeNew = zeros(nbLap,5);
    SectionSplitTimebisNew = zeros(nbLap,5);
    isInterpolatedVel = zeros(nbLap,5);
    isInterpolatedSplits = zeros(nbLap,5);
elseif Course == 50;
    SectionVelNew = zeros(nbLap,10);
    SectionVelbisNew = zeros(nbLap,10);
    SectionCumTimeNew = zeros(nbLap,10);
    SectionCumTimebisNew = zeros(nbLap,10);
    SectionSplitTimeNew = zeros(nbLap,10);
    SectionSplitTimebisNew = zeros(nbLap,10);
    isInterpolatedVel = zeros(nbLap,10);
    isInterpolatedSplits = zeros(nbLap,10);
    nbZone = 10;
end;
SectionVelNew(:,:) = NaN;
SectionVelbisNew(:,:) = NaN;
SectionCumTimeNew(:,:) = NaN;
SectionCumTimebisNew(:,:) = NaN;
SectionSplitTimeNew(:,:) = NaN;
SectionSplitTimebisNew(:,:) = NaN;

% if RaceDist < 150;
%Data for 10m segments
lapEC = 1;
if Course == 25;
    distSplitsAll = [15 20 25; ...
    35 45 50; ...
    60 70 75; ...
    85 95 100; ...
    110 120 125; ...
    135 145 150; ...
    160 170 175; ...
    185 195 200; ...
    210 220 225; ...
    235 245 250; ...
    260 270 275; ...
    285 295 300; ...
    310 320 325; ...
    335 345 350; ...
    360 370 375; ...
    385 395 400; ...
    410 420 425; ...
    435 445 450; ...
    460 470 475; ...
    485 495 500; ...
    510 520 525; ...
    535 545 550; ...
    560 570 575; ...
    585 595 600; ...
    610 620 625; ...
    635 645 650; ...
    660 670 675; ...
    685 695 700; ...
    710 720 725; ...
    735 745 750; ...
    760 770 775; ...
    785 795 800; ...
    810 820 825; ...
    835 845 850; ...
    860 870 875; ...
    885 895 900; ...
    910 920 925; ...
    935 945 950; ...
    960 970 975; ...
    985 995 1000; ...
    1010 1020 1025; ...
    1035 1045 1050; ...
    1060 1070 1075; ...
    1085 1095 1100; ...
    1110 1120 1125; ...
    1135 1145 1150; ...
    1160 1170 1175; ...
    1185 1195 1200; ...
    1210 1220 1225; ...
    1235 1245 1250; ...
    1260 1270 1275; ...
    1285 1295 1300; ...
    1310 1320 1325; ...
    1335 1345 1350; ...
    1360 1370 1375; ...
    1385 1395 1400; ...
    1410 1420 1425; ...
    1435 1445 1450; ...
    1460 1470 1475; ...
    1485 1495 1500];
elseif Course == 50;
    distSplitsAll = [15 25 35 45 50; ...
    65 75 85 95 100; ...
    115 125 135 145 150; ...
    165 175 185 195 200; ...
    215 225 235 245 250; ...
    265 275 285 295 300; ...
    315 325 335 345 350; ...
    365 375 385 395 400; ...
    415 425 435 445 450; ...
    465 475 485 495 500; ...
    515 525 535 545 550; ...
    565 575 585 595 600; ...
    615 625 635 645 650; ...
    665 675 685 695 700; ...
    715 725 735 745 750; ...
    765 775 785 795 800; ...
    815 825 835 845 850; ...
    865 875 885 895 900; ...
    915 925 935 945 950; ...
    965 975 985 995 1000; ...
    1015 1025 1035 1045 1050; ...
    1065 1075 1085 1095 1100; ...
    1115 1125 1135 1145 1150; ...
    1265 1275 1285 1295 1200; ...
    1215 1225 1235 1245 1250; ...
    1265 1275 1285 1295 1300; ...
    1315 1325 1335 1345 1350; ...
    1365 1375 1385 1395 1400; ...
    1415 1425 1435 1445 1450; ...
    1465 1475 1485 1495 1500];
end;
distSplitsAll = distSplitsAll(1:nbLap,:);

for dataEC = 1:length(raceDataSegmentNew(:,1));
    if Course == 25;
        if lapEC == 1;
            posVel = 4;
            posSplits = [3 4 5];
            distSplits = distSplitsAll(lapEC,:);
        else;
            posVel = 4;
            posSplits = [2 4 5];
            distSplits = distSplitsAll(lapEC,:);
        end;
    elseif Course == 50;
        if lapEC == 1;
            if avInterval == 25;
                posVel = [5 7 9];
            else;
                posVel = [3 5 7 9];
            end;
            posSplits = [3 5 7 9 10];
            distSplits = distSplitsAll(lapEC,:);
        else;
            posVel = [3 5 7 9];
            posSplits = [3 5 7 9 10];
            distSplits = distSplitsAll(lapEC,:);
        end;
    end;
    
    if Course == 25;
        for segEC = 1:length(posVel);
            VelEC = roundn(raceDataSegmentNew(dataEC,4),-2);
            SectionVelNew(lapEC,posVel(segEC)) = VelEC;
        end;
    elseif Course == 50;
        if avInterval == 25;
            if rem(dataEC,2) == 1;
                %first 25
                limZone = nbZone./2;
                index25seg = find(posVel <= limZone);
            else;
                %second 25
                limZone = nbZone;
                index25seg = find(posVel > nbZone./2 & posVel <= limZone);
            end
            posVelAct = posVel(index25seg);
            for segEC = 1:length(posVelAct);
                if posVelAct(segEC) ~= limZone;
                    isInterpolatedVel(lapEC,posVelAct(segEC)) = 1;
                end;
                VelEC = roundn(raceDataSegmentNew(dataEC,4),-2);
                SectionVelNew(lapEC,posVelAct(segEC)) = VelEC;
            end;
        else;
            if (dataEC./lapEC) <= length(posVel);
                posVelAct = posVel(dataEC./lapEC);
                for segEC = 1:length(posVelAct);
    %                     if posVelAct(segEC) ~= limZone;
    %                         isInterpolatedVel(lapEC,posVelAct(segEC)) = 1;
    %                     end;
                    VelEC = roundn(raceDataSegmentNew(dataEC,4),-2);
                    SectionVelNew(lapEC,posVelAct(segEC)) = VelEC;
                end;
            end;
        end;
    end;
    SectionVelbisNew = SectionVelNew;
    
    if Course == 25;
        for segEC = 1:length(posSplits);
            distSplitsEC = distSplits(segEC);
            posSplitsEC = posSplits(segEC);
            if distSplitsEC == lapEC.*Course;
                if Course == 25;
                    SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
                elseif Course == 50;
                    if posSplits(segEC) <= nbZone./2;
                        %first 25m
                        SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
                    else;
                        %25 to 50
                        SplitEC = roundn(raceDataSegmentNew((dataEC),3),-2);
                    end;
                end;
            else;
                index = find(RaceLocation(:,5) == distSplitsEC);
                if isnan(RaceLocation(index,3)) == 1;
                    isInterpolatedSplits(lapEC,posSplits(segEC)) = 1;
                end;
                SplitEC = RaceLocation(index,4)./framerate;
            end;
            SectionCumTimeNew(lapEC,posSplits(segEC)) = SplitEC;
        end;
    elseif Course == 50;
        if avInterval == 25;
            if rem(dataEC,2) == 1;
                %first 25
                limZone = nbZone./2;
                index25seg = find(posSplits <= limZone);
            else;
                %second 25
                limZone = nbZone;
                index25seg = find(posSplits > nbZone./2 & posSplits <= limZone);
            end
            posSplitsAct = posSplits(index25seg);

            for segEC = 1:length(posSplitsAct);
                distSplitsEC = distSplits(index25seg(segEC));
                posSplitsEC = posSplits(index25seg(segEC));
                if distSplitsEC == lapEC.*Course | distSplitsEC == (lapEC.*Course)./2;
                    if posSplits(segEC) <= nbZone./2;
                        %first 25m
                        SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
                    else;
                        %25 to 50
                        SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
                    end;
                else;
                    index = find(RaceLocation(:,5) == distSplitsEC);
                    if isnan(RaceLocation(index,3)) == 1;
                        isInterpolatedSplits(lapEC,posSplitsAct(segEC)) = 1;
                    end;
                    SplitEC = RaceLocation(index,4)./framerate;
                end;
                SectionCumTimeNew(lapEC,posSplitsAct(segEC)) = SplitEC;
            end;
        else;
            if (dataEC./lapEC) <= length(posSplits);
                posSplitsAct = posSplits(dataEC./lapEC);
                for segEC = 1:length(posSplitsAct);
    %                     if posVelAct(segEC) ~= limZone;
    %                         isInterpolatedVel(lapEC,posVelAct(segEC)) = 1;
    %                     end;
                    index = find(posSplits == posSplitsAct(segEC));
                    distSplitsEC = distSplits(index);
                    if distSplitsEC == lapEC.*Course;
                        SplitEC = roundn(SplitsAll(lapEC+1,2),-2);
                    else;
    %                         index = find(RaceLocation(:,5) == distSplitsEC);
    %                         if isnan(RaceLocation(index,3)) == 1;
    %                             isInterpolatedSplits(lapEC,posSplitsAct(segEC)) = 1;
    %                         end;
                        SplitEC = SectionCumTime(dataEC,1);
                    end;
                    SectionCumTimeNew(lapEC,posSplitsAct(segEC)) = SplitEC;
                end;
            end;
        end;
    end;
    
    if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
        %new Lap
        lapEC = lapEC + 1;
    end;
end;

for lapEC = 1:nbLap;
    splitsListEC = SectionCumTimeNew(lapEC,:);
    indexNaN = find(isnan(splitsListEC) == 0);
    for valEC = 1:length(indexNaN);
        if lapEC == 1;
            if valEC == 1;
                SectionSplitTimeNew(lapEC,indexNaN(valEC)) = SectionCumTimeNew(lapEC,indexNaN(valEC));
            else;
                SectionSplitTimeNew(lapEC,indexNaN(valEC)) = SectionCumTimeNew(lapEC,indexNaN(valEC)) - SectionCumTimeNew(lapEC,indexNaN(valEC-1));
            end; 
        else;
            if valEC == 1;
                SectionSplitTimeNew(lapEC,indexNaN(valEC)) = SectionCumTimeNew(lapEC,indexNaN(valEC)) - valSave;
            else;
                SectionSplitTimeNew(lapEC,indexNaN(valEC)) = SectionCumTimeNew(lapEC,indexNaN(valEC)) - SectionCumTimeNew(lapEC,indexNaN(valEC-1));
            end;
        end;
        if valEC == length(indexNaN);
            valSave = SectionCumTimeNew(lapEC,indexNaN(valEC));
        end;
    end;
end;
SectionVelNew_short = SectionVelNew;
SectionVelbisNew_short = SectionVelbisNew;
SectionCumTimeNew_short = SectionCumTimeNew;
SectionCumTimebisNew_short = SectionCumTimebisNew;
SectionSplitTimeNew_short = SectionSplitTimeNew;
SectionSplitTimebisNew_short = SectionSplitTimebisNew;
isInterpolatedSplits_short = isInterpolatedSplits;
isInterpolatedVel_short = isInterpolatedVel;

% else;

%---Data for 25m segments
if Course == 25;
    nbZone = 5;
    SectionVelNew = zeros(nbLap,5);
    SectionVelbisNew = zeros(nbLap,5);
    SectionCumTimeNew = zeros(nbLap,5);
    SectionCumTimebisNew = zeros(nbLap,5);
    SectionSplitTimeNew = zeros(nbLap,5);
    SectionSplitTimebisNew = zeros(nbLap,5);
    isInterpolatedVel = zeros(nbLap,5);
    isInterpolatedSplits = zeros(nbLap,5);
elseif Course == 50;
    SectionVelNew = zeros(nbLap,10);
    SectionVelbisNew = zeros(nbLap,10);
    SectionCumTimeNew = zeros(nbLap,10);
    SectionCumTimebisNew = zeros(nbLap,10);
    SectionSplitTimeNew = zeros(nbLap,10);
    SectionSplitTimebisNew = zeros(nbLap,10);
    isInterpolatedVel = zeros(nbLap,10);
    isInterpolatedSplits = zeros(nbLap,10);
    nbZone = 10;
end;
SectionVelNew(:,:) = NaN;
SectionVelbisNew(:,:) = NaN;
SectionCumTimeNew(:,:) = NaN;
SectionCumTimebisNew(:,:) = NaN;
SectionSplitTimeNew(:,:) = NaN;
SectionSplitTimebisNew(:,:) = NaN;
if Course == 25;
    lapEC = 1;
    for dataEC = 1:length(raceDataSegmentNew(:,1));
        if lapEC == 1;
            posVel = 4;
            posSplits = 5;
            posSR = 5;
            pos = 5;
            posSC = 5;
            distSplits = 25;                
        else;
            posVel = 4;
            posSplits = 5;
            posSR = 5;
            pos = 5;
            posSC = 5;
            distSplits = 25;
        end;

        for segEC = 1:length(posVel);
            VelEC = roundn(raceDataSegmentNew(dataEC,4),-2);
            SectionVelNew(lapEC,posVel(segEC)) = VelEC;
        end;

        for segEC = 1:length(posSplits);
            distSplitsEC = ((lapEC-1).*Course) + distSplits(segEC);
            posSplitsEC = posSplits(segEC);
            if distSplitsEC == lapEC.*Course;
                if Course == 25;
                    SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
                elseif Course == 50;
                    if posSplits(segEC) <= nbZone./2;
                        %first 25m
                        SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
                    else;
                        %25 to 50
                        SplitEC = roundn(raceDataSegmentNew((dataEC),3),-2);
                    end;
                end;
            else;
                index = find(RaceLocation(:,5) == distSplitsEC);
                if isnan(RaceLocation(index,3)) == 1;
                    isInterpolatedSplits(lapEC,posSplits(segEC)) = 1;
                end;
                SplitEC = RaceLocation(index,4)./framerate;
            end;
            SectionCumTimeNew(lapEC,posSplits(segEC)) = SplitEC;
        end;

        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;
    end;

    pos = 5;
    posSC = 5;
    posVel = 5;
    posSR = 5;
    distSplits = 25;
    lapEC = 1;
    for dataEC = 1:length(raceDataSegmentNew(:,1));
        SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
        VelEC = roundn(raceDataSegmentNew(dataEC,4),-2);
        
        SectionVelbisNew(lapEC,pos) = VelEC;
        SectionCumTimebisNew(lapEC,pos) = SplitEC;
        if dataEC == 1;
            SectionSplitTimebisNew(lapEC,pos) = SplitEC;
        else;
            SectionSplitTimebisNew(lapEC,pos) = SplitEC - SplitECPre;
        end;
        SplitECPre = SplitEC;

        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;
    end;
else;

    lapEC = 1;
    for dataEC = 1:length(raceDataSegmentNew(:,1));
        if lapEC == 1;
            posVel = [5 10];
            posSplits = [5 10];
            distSplits = [25 50];
        else;
            posVel = [5 10];
            posSplits = [5 10];
            kdist = (lapEC-1) .* Course;
            distSplits = [kdist+25 kdist+50];
        end;

        if rem(dataEC,2) == 1;
            %first 25
            limZone = nbZone./2;
            index25seg = find(posVel <= limZone);
        else;
            %second 25
            limZone = nbZone;
            index25seg = find(posVel > nbZone./2 & posVel <= limZone);
        end
        posVelAct = posVel(index25seg);
        for segEC = 1:length(posVelAct);
            VelEC = roundn(raceDataSegmentNew(dataEC,4),-2);
            SectionVelbisNew(lapEC,posVelAct(segEC)) = VelEC;                
        end;

        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;
    end;


    lapEC = 1;
    for dataEC = 1:length(raceDataSegmentNew(:,1));
        if lapEC == 1;
            posVel = [5 10];
            posSplits = [5 10];
            distSplits = [25 50];
        else;
            posVel = [5 10];
            posSplits = [5 10];
            kdist = (lapEC-1) .* Course;
            distSplits = [kdist+25 kdist+50];
        end;

        if rem(dataEC,2) == 1;
            %first 25
            limZone = nbZone./2;
            index25seg = find(posVel <= limZone);
        else;
            %second 25
            limZone = nbZone;
            index25seg = find(posVel > nbZone./2 & posVel <= limZone);
        end
        posVelAct = posVel(index25seg);
        for segEC = 1:length(posVelAct);
            if posVelAct(segEC) ~= limZone;
                isInterpolatedVel(lapEC,posVelAct(segEC)) = 1;
            end;
            VelEC = roundn(raceDataSegmentNew(dataEC,4),-2);
            SectionVelNew(lapEC,posVelAct(segEC)) = VelEC;
        end;

        if rem(dataEC,2) == 1;
            %first 25
            limZone = nbZone./2;
            index25seg = find(posSplits <= limZone);
        else;
            %second 25
            limZone = nbZone;
            index25seg = find(posSplits > nbZone./2 & posSplits <= limZone);
        end
        posSplitsAct = posSplits(index25seg);

        for segEC = 1:length(posSplitsAct);
            distSplitsEC = distSplits(index25seg(segEC));
            posSplitsEC = posSplits(index25seg(segEC));
            if distSplitsEC == lapEC.*Course | distSplitsEC == (lapEC.*Course)./2;
                if posSplits(segEC) <= nbZone./2;
                    %first 25m
                    SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
                else;
                    %25 to 50
                    SplitEC = roundn(raceDataSegmentNew(dataEC,3),-2);
                end;
            else;
                index = find(RaceLocation(:,5) == distSplitsEC);
                if isnan(RaceLocation(index,3)) == 1;
                    isInterpolatedSplits(lapEC,posSplitsAct(segEC)) = 1;
                end;
                SplitEC = RaceLocation(index,4)./framerate;
            end;
            SectionCumTimeNew(lapEC,posSplitsAct(segEC)) = SplitEC;
        end;

        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;
    end;
end;
SectionVelNew_long = SectionVelNew;
SectionVelbisNew_long = SectionVelbisNew;
SectionCumTimeNew_long = SectionCumTimeNew;
SectionCumTimebisNew_long = SectionCumTimebisNew;
SectionSplitTimeNew_long = SectionSplitTimeNew;
SectionSplitTimebisNew_long = SectionSplitTimebisNew;

% end;
if RaceDist <= 100;
    SectionVel = SectionVelNew_short;
    SectionCumTime = SectionCumTimeNew_short;
    SectionSplitTime = SectionSplitTimeNew_short;
    
    SectionVelbis = SectionVelbisNew_short;
    SectionCumTimebis = SectionCumTimebisNew_short;
    SectionSplitTimebis = SectionSplitTimebisNew_short;
    
    SectionCumTimeMat = SectionCumTime;
    SectionSplitTimeMat = SectionSplitTime;
else;
    SectionVel = SectionVelNew_long;
    SectionCumTime = SectionCumTimeNew_long;
    SectionSplitTime = SectionSplitTimeNew_long;
    
    SectionVelbis = SectionVelbisNew_long;
    SectionCumTimebis = SectionCumTimebisNew_long;
    SectionSplitTimebis = SectionSplitTimebisNew_long;
    
    SectionCumTimeMat = SectionCumTime;
    SectionSplitTimeMat = SectionSplitTime;
end;

dataMatSplitsPacing = [];
dataMatCumSplitsPacing = [];
dataMatSplitsPacing(:,1) = reshape(SectionSplitTimeMat', nbZone*nbLap, 1);
dataMatCumSplitsPacing(:,1) = reshape(SectionCumTimeMat', nbZone*nbLap, 1);
dataMatSplitsPacingbis = [];
dataMatCumSplitsPacingbis = [];
if isempty(SectionVelbis) == 0;
    SectionVelbis = roundn(SectionVelbis,-2);
    SectionCumTimebis = roundn(SectionCumTimebis,-2);
    SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
    
    SectionCumTimeMatbis = SectionCumTimebis;
%             SectionCumTimeMatbis(:,end) = SplitsAll(:,2);
    SectionSplitTimeMatbis = SectionSplitTimebis;
%             SectionSplitTimeMatbis(:,end) = SectionCumTimeMatbis(:,end) - SectionCumTimeMatbis(:,end-1);

    dataMatSplitsPacingbis(:,1) = reshape(SectionSplitTimeMatbis', nbZone*nbLap, 1);
    dataMatCumSplitsPacingbis(:,1) = reshape(SectionCumTimeMatbis', nbZone*nbLap, 1);
%             dataMatCumSplitsPacingbis(:,1) = dataMatCumSplitsPacing(:,1);
end;
%----------------------------------------------------------
    
    

%------------------Reproduce stroketableINI----------------
if Course == 25;
    nbZone = 5;
    SectionSR = zeros(nbLap,5);
    SectionSD = zeros(nbLap,5);
    SectionNb = zeros(nbLap,5);
    isInterpolatedSR = zeros(nbLap,5);
    isInterpolatedSD = zeros(nbLap,5);
elseif Course == 50;
    SectionSR = zeros(nbLap,10);
    SectionSD = zeros(nbLap,10);
    SectionNb = zeros(nbLap,10);
    isInterpolatedSR = zeros(nbLap,10);
    isInterpolatedSD = zeros(nbLap,10);
    nbZone = 10;
end;
SectionSR(:,:) = NaN;
SectionSD(:,:) = NaN;
SectionNb(:,:) = NaN;
SectionSRbis = SectionSR;
SectionSDbis = SectionSD;
SectionNbbis = SectionNb;

%Data for 10m segments
% if RaceDist < 150;
lapEC = 1;
if Course == 25;
    if lapEC == 1;
        posDPS = 4;
        posSR = [3 4 5];
        posSC = 5;
        distSplits = [15 20 25];
    else;
        posDPS = 4;
        posSR = [2 4 5];
        posSC = 5;
        distSplits = [10 20 25];
    end;

    for dataEC = 1:length(raceDataSegmentNew(:,1));
        SREC = roundn(raceDataSegmentNew(dataEC,5),-1);
        DPSEC = roundn(raceDataSegmentNew(dataEC,6),-2);
        SCEC = raceDataSegmentNew(dataEC,7);
        
        for segEC = 1:length(posSR);
            %duplicate the same SR for all locations (only 1 available)
            SectionSR(lapEC,posSR(segEC)) = SREC;
        end;
        for segEC = 1:length(posDPS);
            %duplicate the same SR for all locations (only 1 available)
            SectionSD(lapEC,posDPS(segEC)) = DPSEC;
        end;
        for segEC = 1:length(posSC);
            %duplicate the same SR for all locations (only 1 available)
            SectionNb(lapEC,posSC(segEC)) = SCEC;
        end;
        
        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;
    end;

elseif Course == 50;

    if lapEC == 1;
        if avInterval == 25;
            posDPS = [5 7 9];
        else;
            posDPS = [3 5 7 9];
        end;
        posSR = [3 5 7 9 10];
        posSC = 10;
        distSplits = [15 25 35 45 50];
    else;
        posDPS = [3 5 7 9];
        posSR = [3 5 7 9 10];
        posSC = 10;
        distSplits = [65 75 85 95 100];
    end;

    for dataEC = 1:length(raceDataSegmentNew(:,1));
        if avInterval == 25;
            if rem(dataEC,2) == 1;
                %first 25
                limZone = nbZone./2;
                index25seg = find(posDPS <= limZone);
            else;
                %second 25
                limZone = nbZone;
                index25seg = find(posDPS > nbZone./2 & posDPS <= limZone);
            end
            posDPSAct = posDPS(index25seg);
            for segEC = 1:length(posDPSAct);
                if posDPSAct(segEC) ~= limZone;
                    isInterpolatedDPS(lapEC,posDPSAct(segEC)) = 1;
                end;
                DPSEC = roundn(raceDataSegmentNew(dataEC,6),-2);
                SectionSD(lapEC,posDPSAct(segEC)) = DPSEC;
            end;

            if rem(dataEC,2) == 1;
                %first 25
                limZone = nbZone./2;
                index25seg = find(posSR <= limZone);
            else;
                %second 25
                limZone = nbZone;
                index25seg = find(posSR > nbZone./2 & posSR <= limZone);
            end
            posSRAct = posSR(index25seg);
            for segEC = 1:length(posSRAct);
                if posSRAct(segEC) ~= limZone;
                    isInterpolatedSR(lapEC,posSRAct(segEC)) = 1;
                end;
                SREC = roundn(raceDataSegmentNew(dataEC,5),-2);
                SectionSR(lapEC,posSRAct(segEC)) = SREC;
            end;

            if rem(dataEC,2) == 1;
                %first 25
                %nothing
            else;
                SCEC = raceDataSegmentNew(dataEC,7);
                SectionNb(lapEC,posSC) = SCEC;
            end;
        else;
            if (dataEC./lapEC) <= length(posDPS);
                posDPSAct = posDPS(dataEC./lapEC);
                for segEC = 1:length(posDPSAct);
                    DPSEC = roundn(raceDataSegmentNew(dataEC,6),-2);
                    SectionSD(lapEC,posDPSAct(segEC)) = DPSEC;
                end;
            end;

            if (dataEC./lapEC) <= length(posSR);
                posSRAct = posSR(dataEC./lapEC);
                for segEC = 1:length(posSRAct);
                    SREC = roundn(raceDataSegmentNew(dataEC,5),-2);
                    SectionSR(lapEC,posSRAct(segEC)) = SREC;
                end;
            end;

            if RaceDist == 50;
                if dataEC == 4;
                    SCEC = raceDataSegmentNew(dataEC,7);
                    SectionNb(lapEC,posSC) = SCEC;
                end;
            else;
                e=e
            end;
        end;

        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;

    end;
end;
SectionSRbis = SectionSR;
SectionSDbis = SectionSD;
SectionNbbis = SectionNb;

SectionSR_short = SectionSR;
SectionSD_short = SectionSD;
SectionNb_short = SectionNb;
SectionSRbis_short = SectionSRbis;
SectionSDbis_short = SectionSDbis;
SectionNbbis_short = SectionNbbis;
isInterpolatedSR_short = isInterpolatedSR;
isInterpolatedSD_short = isInterpolatedSD;

% else;


%Data for 25m segments
if Course == 25;
    nbZone = 5;
    SectionSR = zeros(nbLap,5);
    SectionSD = zeros(nbLap,5);
    SectionNb = zeros(nbLap,5);
    isInterpolatedSR = zeros(nbLap,5);
    isInterpolatedSD = zeros(nbLap,5);
elseif Course == 50;
    SectionSR = zeros(nbLap,10);
    SectionSD = zeros(nbLap,10);
    SectionNb = zeros(nbLap,10);
    isInterpolatedSR = zeros(nbLap,10);
    isInterpolatedSD = zeros(nbLap,10);
    nbZone = 10;
end;
SectionSR(:,:) = NaN;
SectionSD(:,:) = NaN;
SectionNb(:,:) = NaN;
SectionSRbis = SectionSR;
SectionSDbis = SectionSD;
SectionNbbis = SectionNb;
if Course == 25;
    lapEC = 1;
    for dataEC = 1:length(raceDataSegmentNew(:,1));
        if lapEC == 1;
            posDPS = 5;
            posSR = 5;
            posSC = 5;
            distSplits = 25;
        else;
            posDPS = 5;
            posSR = 5;
            posSC = 5;
            distSplits = 25;
        end;
        
        SREC = roundn(raceDataSegmentNew(dataEC,5),-1);
        DPSEC = roundn(raceDataSegmentNew(dataEC,6),-2);
        SCEC = raceDataSegmentNew(dataEC,7);
        
        for segEC = 1:length(posSR);
            %duplicate the same SR for all locations (only 1 available)
            SectionSR(lapEC,posSR(segEC)) = SREC;
        end;
        for segEC = 1:length(posDPS);
            %duplicate the same SR for all locations (only 1 available)
            SectionSD(lapEC,posDPS(segEC)) = DPSEC;
        end;
        for segEC = 1:length(posSC);
            %duplicate the same SR for all locations (only 1 available)
            SectionNb(lapEC,posSC(segEC)) = SCEC;
        end;
        
        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;
    end;

    pos = 5;
    posSC = 5;
    posDPS = 5;
    posSR = 5;
    distSplits = 25;
    lapEC = 1;
    for dataEC = 1:length(raceDataSegmentNew(:,1));
        SREC = roundn(raceDataSegmentNew(dataEC,5),-1);
        DPSEC = roundn(raceDataSegmentNew(dataEC,6),-2);
        SCEC = raceDataSegmentNew(dataEC,7);
        
        SectionSRbis(lapEC,pos) = SREC;
        SectionSDbis(lapEC,pos) = DPSEC;
        SectionNbbis(lapEC,pos) = SCEC;

        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;
    end;
else;
    
    lapEC = 1;
    if lapEC == 1;
        posDPS = [5 10];
        posSR = [5 10];
        posSC = 10;
        distSplits = [25 50];
    else;
        posDPS = [5 10];
        posSR = [5 10];
        posSC = 10;
        kdist = (lapEC-1).*Course;
        distSplits = [kdist+25 kdist+50];
    end;

    for dataEC = 1:length(raceDataSegmentNew(:,1));
        if rem(dataEC,2) == 1;
            %first 25
            limZone = nbZone./2;
            index25seg = find(posDPS <= limZone);
        else;
            %second 25
            limZone = nbZone;
            index25seg = find(posDPS > nbZone./2 & posDPS <= limZone);
        end
        posDPSAct = posDPS(index25seg);
        for segEC = 1:length(posDPSAct);
            if posDPSAct(segEC) ~= limZone;
                isInterpolatedDPS(lapEC,posDPSAct(segEC)) = 1;
            end;
            DPSEC = roundn(raceDataSegmentNew(dataEC,6),-2);
            SectionSD(lapEC,posDPSAct(segEC)) = DPSEC;
        end;

        if rem(dataEC,2) == 1;
            %first 25
            limZone = nbZone./2;
            index25seg = find(posSR <= limZone);
        else;
            %second 25
            limZone = nbZone;
            index25seg = find(posSR > nbZone./2 & posSR <= limZone);
        end
        posSRAct = posSR(index25seg);
        for segEC = 1:length(posSRAct);
            if posSRAct(segEC) ~= limZone;
                isInterpolatedSR(lapEC,posSRAct(segEC)) = 1;
            end;
            SREC = roundn(raceDataSegmentNew(dataEC,5),-2);
            SectionSR(lapEC,posSRAct(segEC)) = SREC;
        end;

        if rem(dataEC,2) == 1;
            %first 25
            %nothing
        else;
            SCEC = raceDataSegmentNew(dataEC,7);
            SectionNb(lapEC,posSC) = SCEC;
        end;

        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;

    end;

    lapEC = 1;
    if lapEC == 1;
        posDPS = [5 10];
        posSR = [5 10];
        posSC = 10;
        distSplits = [15 25 35 45 50];
    else;
        posDPS = [5 10];
        posSR = [5 10];
        posSC = 10;
        kdist = (lapEC-1).*Course
        distSplits = [kdist+15 kdist+25 kdist+35 kdist+45 kdist+50];
    end;

    for dataEC = 1:length(raceDataSegmentNew(:,1));
        if rem(dataEC,2) == 1;
            %first 25
            limZone = nbZone./2;
            index25seg = find(posDPS <= limZone);
        else;
            %second 25
            limZone = nbZone;
            index25seg = find(posDPS > nbZone./2 & posDPS <= limZone);
        end
        posDPSAct = posDPS(index25seg);
        for segEC = 1:length(posDPSAct);
            if posDPSAct(segEC) ~= limZone;
                isInterpolatedDPS(lapEC,posDPSAct(segEC)) = 1;
            end;
            DPSEC = roundn(raceDataSegmentNew(dataEC,6),-2);
            SectionSDbis(lapEC,posDPSAct(segEC)) = DPSEC;
        end;

        if rem(dataEC,2) == 1;
            %first 25
            limZone = nbZone./2;
            index25seg = find(posSR <= limZone);
        else;
            %second 25
            limZone = nbZone;
            index25seg = find(posSR > nbZone./2 & posSR <= limZone);
        end
        posSRAct = posSR(index25seg);
        for segEC = 1:length(posSRAct);
            if posSRAct(segEC) ~= limZone;
                isInterpolatedSR(lapEC,posSRAct(segEC)) = 1;
            end;
            SREC = roundn(raceDataSegmentNew(dataEC,5),-2);
            SectionSRbis(lapEC,posSRAct(segEC)) = SREC;
        end;

        if rem(dataEC,2) == 1;
            %first 25
            %nothing
        else;
            SCEC = raceDataSegmentNew(dataEC,7);
            SectionNbbis(lapEC,posSC) = SCEC;
        end;

        if roundn(raceDataSegmentNew(dataEC,3),-2) == roundn(SplitsAll(lapEC+1,2),-2);
            %new Lap
            lapEC = lapEC + 1;
        end;

    end;

end;
SectionSR_long = SectionSR;
SectionSD_long = SectionSD;
SectionNb_long = SectionNb;
SectionSRbis_long = SectionSRbis;
SectionSDbis_long = SectionSDbis;
SectionNbbis_long = SectionNbbis;

if RaceDist <= 100;
    SectionSR = SectionSR_short;
    SectionSD = SectionSD_short;
    SectionNb = SectionNb_short;
    SectionSRbis = SectionSRbis_short;
    SectionSDbis = SectionSDbis_short;
    SectionNbbis = SectionNbbis_short;
else;
    SectionSR = SectionSR_long;
    SectionSD = SectionSD_long;
    SectionNb = SectionNb_long;
    SectionSRbis = SectionSRbis_long;
    SectionSDbis = SectionSDbis_long;
    SectionNbbis = SectionNbbis_long;
end;


% end;
%----------------------------------------------------------




%--------------------Build Raw Data------------------------
clear RawTime;
clear RawDistance;
clear RawDistanceINI;
clear RawVelocity;
clear RawVelocityRaw;
clear RawVelocityTrend;
clear RawVelocityINI;
clear RawBreath;
clear RawStroke;
clear RawBreakout;
clear RawKick;
clear NbRows;
% SplitsAll = SplitsAllSave;
        
nbRows = roundn((SplitsAll(nbLap+1,2).*framerate) + 1, 0);
RawTime = zeros(1,nbRows);
RawDistance = zeros(1,nbRows);
RawDistanceINI = zeros(1,nbRows);
RawVelocity = zeros(1,nbRows);
RawVelocityRaw = zeros(1,nbRows);
RawVelocityTrend = zeros(1,nbRows);
RawVelocityINI = zeros(1,nbRows);
RawBreath = zeros(1,nbRows);
RawStroke = zeros(1,nbRows);
RawBreakout = zeros(1,nbRows);
RawKick = zeros(1,nbRows);
        
%---Insert initial values
if Course == 50;
    if RaceDist == 50;
        keyDist = [NaN NaN 15 NaN 25 NaN 35 NaN 45 NaN];
        keySeg = [15 25 35 45 50];
    elseif RaceDist == 100;
        keyDist = [NaN NaN 15 NaN 25 NaN 35 NaN 45 NaN; ...
            NaN NaN 65 NaN 75 NaN 85 NaN 95 NaN];
        keySeg = [15 25 35 45 50; ...
           65 75 85 95 100];
    elseif RaceDist == 150;
        keyDist = [NaN NaN NaN NaN 25 NaN NaN NaN NaN 50; NaN NaN NaN NaN 75 NaN NaN NaN NaN 100; NaN NaN NaN NaN 125 NaN NaN NaN NaN 150];
        keyDistbis = [NaN NaN 15 NaN 25 NaN 35 NaN 45 50; NaN NaN 65 NaN 75 NaN 85 NaN 95 100; NaN NaN 115 NaN 125 NaN 135 NaN 145 150];
        keySeg = [25 50; 75 100; 125 150];
    elseif RaceDist == 200;
        keyDist = [NaN NaN NaN NaN 25 NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75 NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125 NaN NaN NaN NaN 150; ...
            NaN NaN NaN NaN 175 NaN NaN NaN NaN 200];
        keyDistbis = [NaN NaN 15 NaN 25 NaN 35 NaN 45 50; ...
            NaN NaN 65 NaN 75 NaN 85 NaN 95 100; ...
            NaN NaN 115 NaN 125 NaN 135 NaN 145 150; ...
            NaN NaN 165 NaN 175 NaN 185 NaN 195 200];
        keySeg = [25 50; 75 100; 125 150; 175 200];
    elseif RaceDist == 400;
        keyDist = [NaN NaN NaN NaN 25 NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75 NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125 NaN NaN NaN NaN 150; ...
            NaN NaN NaN NaN 175 NaN NaN NaN NaN 200; ...
            NaN NaN NaN NaN 225 NaN NaN NaN NaN 250; ...
            NaN NaN NaN NaN 275 NaN NaN NaN NaN 300; ...
            NaN NaN NaN NaN 325 NaN NaN NaN NaN 350; ...
            NaN NaN NaN NaN 375 NaN NaN NaN NaN 400];
        keyDistbis = [NaN NaN 15 NaN 25 NaN 35 NaN 45 50; ...
            NaN NaN 65 NaN 75 NaN 85 NaN 95 100; ...
            NaN NaN 115 NaN 125 NaN 135 NaN 145 150; ...
            NaN NaN 165 NaN 175 NaN 185 NaN 195 200; ...
            NaN NaN 215 NaN 225 NaN 235 NaN 245 250; ...
            NaN NaN 265 NaN 275 NaN 285 NaN 295 300; ...
            NaN NaN 315 NaN 325 NaN 335 NaN 345 350; ...
            NaN NaN 365 NaN 375 NaN 385 NaN 395 400];
        keySeg = [25 50; 75 100; 125 150; 175 200; ...
            225 250; 275 300; 325 350; 375 400];
    elseif RaceDist == 800;
        keyDist = [NaN NaN NaN NaN 25 NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75 NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125 NaN NaN NaN NaN 150; ...
            NaN NaN NaN NaN 175 NaN NaN NaN NaN 200; ...
            NaN NaN NaN NaN 225 NaN NaN NaN NaN 250; ...
            NaN NaN NaN NaN 275 NaN NaN NaN NaN 300; ...
            NaN NaN NaN NaN 325 NaN NaN NaN NaN 350; ...
            NaN NaN NaN NaN 375 NaN NaN NaN NaN 400; ...
            NaN NaN NaN NaN 425 NaN NaN NaN NaN 450; ...
            NaN NaN NaN NaN 475 NaN NaN NaN NaN 500; ...
            NaN NaN NaN NaN 525 NaN NaN NaN NaN 550; ...
            NaN NaN NaN NaN 575 NaN NaN NaN NaN 600; ...
            NaN NaN NaN NaN 625 NaN NaN NaN NaN 650; ...
            NaN NaN NaN NaN 675 NaN NaN NaN NaN 700; ...
            NaN NaN NaN NaN 725 NaN NaN NaN NaN 750; ...
            NaN NaN NaN NaN 775 NaN NaN NaN NaN 800];
        keyDistbis = [NaN NaN 15 NaN 25 NaN 35 NaN 45 50; ...
            NaN NaN 65 NaN 75 NaN 85 NaN 95 100; ...
            NaN NaN 115 NaN 125 NaN 135 NaN 145 150; ...
            NaN NaN 165 NaN 175 NaN 185 NaN 195 200; ...
            NaN NaN 215 NaN 225 NaN 235 NaN 245 250; ...
            NaN NaN 265 NaN 275 NaN 285 NaN 295 300; ...
            NaN NaN 315 NaN 325 NaN 335 NaN 345 350; ...
            NaN NaN 365 NaN 375 NaN 385 NaN 395 400; ...
            NaN NaN 415 NaN 425 NaN 435 NaN 445 450; ...
            NaN NaN 465 NaN 475 NaN 485 NaN 495 500; ...
            NaN NaN 515 NaN 525 NaN 535 NaN 545 550; ...
            NaN NaN 565 NaN 575 NaN 585 NaN 595 600; ...
            NaN NaN 615 NaN 625 NaN 635 NaN 645 650; ...
            NaN NaN 665 NaN 675 NaN 685 NaN 695 700; ...
            NaN NaN 715 NaN 725 NaN 735 NaN 745 750; ...
            NaN NaN 765 NaN 775 NaN 785 NaN 795 800];
        keySeg = [25 50; 75 100; 125 150; 175 200; ...
            225 250; 275 300; 325 350; 375 400; ...
            425 450; 475 500; 525 550; 575 600; ...
            625 650; 675 700; 725 750; 775 800];
    elseif RaceDist == 1500;
        keyDist = [NaN NaN NaN NaN 25 NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75 NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125 NaN NaN NaN NaN 150; ...
            NaN NaN NaN NaN 175 NaN NaN NaN NaN 200; ...
            NaN NaN NaN NaN 225 NaN NaN NaN NaN 250; ...
            NaN NaN NaN NaN 275 NaN NaN NaN NaN 300; ...
            NaN NaN NaN NaN 325 NaN NaN NaN NaN 350; ...
            NaN NaN NaN NaN 375 NaN NaN NaN NaN 400; ...
            NaN NaN NaN NaN 425 NaN NaN NaN NaN 450; ...
            NaN NaN NaN NaN 475 NaN NaN NaN NaN 500; ...
            NaN NaN NaN NaN 525 NaN NaN NaN NaN 550; ...
            NaN NaN NaN NaN 575 NaN NaN NaN NaN 600; ...
            NaN NaN NaN NaN 625 NaN NaN NaN NaN 650; ...
            NaN NaN NaN NaN 675 NaN NaN NaN NaN 700; ...
            NaN NaN NaN NaN 725 NaN NaN NaN NaN 750; ...
            NaN NaN NaN NaN 775 NaN NaN NaN NaN 800; ...
            NaN NaN NaN NaN 825 NaN NaN NaN NaN 850; ...
            NaN NaN NaN NaN 875 NaN NaN NaN NaN 900; ...
            NaN NaN NaN NaN 925 NaN NaN NaN NaN 950; ...
            NaN NaN NaN NaN 975 NaN NaN NaN NaN 1000; ...
            NaN NaN NaN NaN 1025 NaN NaN NaN NaN 1050; ...
            NaN NaN NaN NaN 1075 NaN NaN NaN NaN 1100; ...
            NaN NaN NaN NaN 1125 NaN NaN NaN NaN 1150; ...
            NaN NaN NaN NaN 1175 NaN NaN NaN NaN 1200; ...
            NaN NaN NaN NaN 1225 NaN NaN NaN NaN 1250; ...
            NaN NaN NaN NaN 1275 NaN NaN NaN NaN 1300; ...
            NaN NaN NaN NaN 1325 NaN NaN NaN NaN 1350; ...
            NaN NaN NaN NaN 1375 NaN NaN NaN NaN 1400; ...
            NaN NaN NaN NaN 1425 NaN NaN NaN NaN 1450; ...
            NaN NaN NaN NaN 1475 NaN NaN NaN NaN 1500];
        keyDistbis = [NaN NaN 15 NaN 25 NaN 35 NaN 45 50; ...
            NaN NaN 65 NaN 75 NaN 85 NaN 95 100; ...
            NaN NaN 115 NaN 125 NaN 135 NaN 145 150; ...
            NaN NaN 165 NaN 175 NaN 185 NaN 195 200; ...
            NaN NaN 215 NaN 225 NaN 235 NaN 245 250; ...
            NaN NaN 265 NaN 275 NaN 285 NaN 295 300; ...
            NaN NaN 315 NaN 325 NaN 335 NaN 345 350; ...
            NaN NaN 365 NaN 375 NaN 385 NaN 395 400; ...
            NaN NaN 415 NaN 425 NaN 435 NaN 445 450; ...
            NaN NaN 465 NaN 475 NaN 485 NaN 495 500; ...
            NaN NaN 515 NaN 525 NaN 535 NaN 545 550; ...
            NaN NaN 565 NaN 575 NaN 585 NaN 595 600; ...
            NaN NaN 615 NaN 625 NaN 635 NaN 645 650; ...
            NaN NaN 665 NaN 675 NaN 685 NaN 695 700; ...
            NaN NaN 715 NaN 725 NaN 735 NaN 745 750; ...
            NaN NaN 765 NaN 775 NaN 785 NaN 795 800; ...
            NaN NaN 815 NaN 825 NaN 835 NaN 845 850; ...
            NaN NaN 865 NaN 875 NaN 885 NaN 895 900; ...
            NaN NaN 915 NaN 925 NaN 935 NaN 945 950; ...
            NaN NaN 965 NaN 975 NaN 985 NaN 995 1000; ...
            NaN NaN 1015 NaN 1025 NaN 1035 NaN 1045 1050; ...
            NaN NaN 1065 NaN 1075 NaN 1085 NaN 1095 1100; ...
            NaN NaN 1115 NaN 1125 NaN 1135 NaN 1145 1150; ...
            NaN NaN 1165 NaN 1175 NaN 1185 NaN 1195 1200; ...
            NaN NaN 1215 NaN 1225 NaN 1235 NaN 1245 1250; ...
            NaN NaN 1265 NaN 1275 NaN 1285 NaN 1295 1300; ...
            NaN NaN 1315 NaN 1325 NaN 1335 NaN 1345 1350; ...
            NaN NaN 1365 NaN 1375 NaN 1385 NaN 1395 1400; ...
            NaN NaN 1415 NaN 1425 NaN 1435 NaN 1445 1450; ...
            NaN NaN 1465 NaN 1475 NaN 1485 NaN 1495 1500];
        keySeg = [25 50; 75 100; 125 150; 175 200; ...
            225 250; 275 300; 325 350; 375 400; ...
            425 450; 475 500; 525 550; 575 600; ...
            625 650; 675 700; 725 750; 775 800; ...
            825 850; 875 900; 925 950; 975 1000; ...
            1025 1050; 1075 1100; 1125 1150; 1175 1200; ...
            1225 1250; 1275 1300; 1325 1350; 1375 1400; ...
            1425 1450; 1475 1500];
    end;
else;
    if RaceDist == 50;
        keyDist = [NaN NaN 15 20 25 35 NaN 45 50];
        keySeg = [15 20 25];
    elseif RaceDist == 100;
        keyDist = [NaN NaN 15 20 25; ...
            NaN 35 NaN 45 50; ...
            NaN 60 NaN 70 75; ...
            NaN 85 NaN 95 100];
        keySeg = [15 20 25; ...
           35 45 50; ...
           60 70 75; ...
           85 95 100];
    elseif RaceDist == 150;
        keyDist = [NaN NaN NaN NaN 25; ...
            NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75; ...
            NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125; ...
            NaN NaN NaN NaN 150];
        keyDistbis = [NaN NaN 15 NaN 25; ...
            NaN 35 NaN 45 50; ...
            NaN NaN 65 NaN 75; ...
            NaN 85 NaN 95 100; ...
            NaN NaN 115 NaN 125; ...
            NaN 135 NaN 145 150];
        keySeg = [25; 50; 75; 100; 125; 150];
    elseif RaceDist == 200;
        keyDist = [NaN NaN NaN NaN 25; ...
            NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75; ...
            NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125; ...
            NaN NaN NaN NaN 150; ...
            NaN NaN NaN NaN 175; ...
            NaN NaN NaN NaN 200];
        keyDistbis = [NaN NaN 15 NaN 25; ...
            NaN 35 NaN 45 50; ...
            NaN 65 NaN 70 75; ...
            NaN 85 NaN 95 100; ...
            NaN 115 NaN 120 125; ...
            NaN 135 NaN 145 150; ...
            NaN 165 NaN 170 175; ...
            NaN 185 NaN 195 200];
        keySeg = [25; 50; 75; 100; 125; 150; 175; 200];
    elseif RaceDist == 400;
        keyDist = [NaN NaN NaN NaN 25; ...
            NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75; ...
            NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125; ...
            NaN NaN NaN NaN 150; ...
            NaN NaN NaN NaN 175; ...
            NaN NaN NaN NaN 200; ...
            NaN NaN NaN NaN 225; ...
            NaN NaN NaN NaN 250; ...
            NaN NaN NaN NaN 275; ...
            NaN NaN NaN NaN 300; ...
            NaN NaN NaN NaN 325; ...
            NaN NaN NaN NaN 350; ...
            NaN NaN NaN NaN 375; ...
            NaN NaN NaN NaN 400];
        keyDistbis = [NaN NaN 15 NaN 25; ...
            NaN 35 NaN 45 50; ...
            NaN 65 NaN 70 75; ...
            NaN 85 NaN 95 100; ...
            NaN 115 NaN 120 125; ...
            NaN 135 NaN 145 150; ...
            NaN 165 NaN 170 175; ...
            NaN 185 NaN 195 200; ...
            NaN 215 NaN 220 225; ...
            NaN 235 NaN 245 250; ...
            NaN 265 NaN 270 275; ...
            NaN 285 NaN 295 300; ...
            NaN 315 NaN 320 325; ...
            NaN 335 NaN 345 350; ...
            NaN 365 NaN 370 375; ...
            NaN 385 NaN 395 400];
        keySeg = [25; 50; 75; 100; 125; 150; 175; 200; ...
            225; 250; 275; 300; 325; 350; 375; 400];
    elseif RaceDist == 800;
        keyDist = [NaN NaN NaN NaN 25; ...
            NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75; ...
            NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125; ...
            NaN NaN NaN NaN 150; ...
            NaN NaN NaN NaN 175; ...
            NaN NaN NaN NaN 200; ...
            NaN NaN NaN NaN 225; ...
            NaN NaN NaN NaN 250; ...
            NaN NaN NaN NaN 275; ...
            NaN NaN NaN NaN 300; ...
            NaN NaN NaN NaN 325; ...
            NaN NaN NaN NaN 350; ...
            NaN NaN NaN NaN 375; ...
            NaN NaN NaN NaN 400; ...
            NaN NaN NaN NaN 425; ...
            NaN NaN NaN NaN 450; ...
            NaN NaN NaN NaN 475; ...
            NaN NaN NaN NaN 500; ...
            NaN NaN NaN NaN 525; ...
            NaN NaN NaN NaN 550; ...
            NaN NaN NaN NaN 575; ...
            NaN NaN NaN NaN 600; ...
            NaN NaN NaN NaN 625; ...
            NaN NaN NaN NaN 650; ...
            NaN NaN NaN NaN 675; ...
            NaN NaN NaN NaN 700; ...
            NaN NaN NaN NaN 725; ...
            NaN NaN NaN NaN 750; ...
            NaN NaN NaN NaN 775; ...
            NaN NaN NaN NaN 800];
        keyDistbis = [NaN NaN 15 NaN 25; ...
            NaN 35 NaN 45 50; ...
            NaN 65 NaN 70 75; ...
            NaN 85 NaN 95 100; ...
            NaN 115 NaN 120 125; ...
            NaN 135 NaN 145 150; ...
            NaN 165 NaN 170 175; ...
            NaN 185 NaN 195 200; ...
            NaN 215 NaN 220 225; ...
            NaN 235 NaN 245 250; ...
            NaN 265 NaN 270 275; ...
            NaN 285 NaN 295 300; ...
            NaN 315 NaN 320 325; ...
            NaN 335 NaN 345 350; ...
            NaN 365 NaN 370 375; ...
            NaN 385 NaN 395 400; ...
            NaN 415 NaN 420 425; ...
            NaN 435 NaN 445 450; ...
            NaN 465 NaN 470 475; ...
            NaN 485 NaN 495 500; ...
            NaN 515 NaN 520 525; ...
            NaN 535 NaN 545 550; ...
            NaN 565 NaN 570 575; ...
            NaN 585 NaN 595 600; ...
            NaN 615 NaN 620 625; ...
            NaN 635 NaN 645 650; ...
            NaN 665 NaN 670 675; ...
            NaN 685 NaN 695 700; ...
            NaN 715 NaN 720 725; ...
            NaN 735 NaN 745 750; ...
            NaN 765 NaN 770 775; ...
            NaN 785 NaN 795 800];
        keySeg = [25; 50; 75; 100; 125; 150; 175; 200; ...
            225; 250; 275; 300; 325; 350; 375; 400; ...
            425; 450; 475; 500; 525; 550; 575; 600; ...
            625; 650; 675; 700; 725; 750; 775; 800];
    elseif RaceDist == 1500;
        keyDist = [NaN NaN NaN NaN 25; ...
            NaN NaN NaN NaN 50; ...
            NaN NaN NaN NaN 75; ...
            NaN NaN NaN NaN 100; ...
            NaN NaN NaN NaN 125; ...
            NaN NaN NaN NaN 150; ...
            NaN NaN NaN NaN 175; ...
            NaN NaN NaN NaN 200; ...
            NaN NaN NaN NaN 225; ...
            NaN NaN NaN NaN 250; ...
            NaN NaN NaN NaN 275; ...
            NaN NaN NaN NaN 300; ...
            NaN NaN NaN NaN 325; ...
            NaN NaN NaN NaN 350; ...
            NaN NaN NaN NaN 375; ...
            NaN NaN NaN NaN 400; ...
            NaN NaN NaN NaN 425; ...
            NaN NaN NaN NaN 450; ...
            NaN NaN NaN NaN 475; ...
            NaN NaN NaN NaN 500; ...
            NaN NaN NaN NaN 525; ...
            NaN NaN NaN NaN 550; ...
            NaN NaN NaN NaN 575; ...
            NaN NaN NaN NaN 600; ...
            NaN NaN NaN NaN 625; ...
            NaN NaN NaN NaN 650; ...
            NaN NaN NaN NaN 675; ...
            NaN NaN NaN NaN 700; ...
            NaN NaN NaN NaN 725; ...
            NaN NaN NaN NaN 750; ...
            NaN NaN NaN NaN 775; ...
            NaN NaN NaN NaN 800; ...
            NaN NaN NaN NaN 825; ...
            NaN NaN NaN NaN 850; ...
            NaN NaN NaN NaN 875; ...
            NaN NaN NaN NaN 900; ...
            NaN NaN NaN NaN 925; ...
            NaN NaN NaN NaN 950; ...
            NaN NaN NaN NaN 975; ...
            NaN NaN NaN NaN 1000; ...
            NaN NaN NaN NaN 1025; ...
            NaN NaN NaN NaN 1050; ...
            NaN NaN NaN NaN 1075; ...
            NaN NaN NaN NaN 1100; ...
            NaN NaN NaN NaN 1125; ...
            NaN NaN NaN NaN 1150; ...
            NaN NaN NaN NaN 1175; ...
            NaN NaN NaN NaN 1200; ...
            NaN NaN NaN NaN 1225; ...
            NaN NaN NaN NaN 1250; ...
            NaN NaN NaN NaN 1275; ...
            NaN NaN NaN NaN 1300; ...
            NaN NaN NaN NaN 1325; ...
            NaN NaN NaN NaN 1350; ...
            NaN NaN NaN NaN 1375; ...
            NaN NaN NaN NaN 1400; ...
            NaN NaN NaN NaN 1425; ...
            NaN NaN NaN NaN 1450; ...
            NaN NaN NaN NaN 1475; ...
            NaN NaN NaN NaN 1500];
        keyDistbis = [NaN NaN 15 NaN 25; ...
            NaN 35 NaN 45 50; ...
            NaN 65 NaN 70 75; ...
            NaN 85 NaN 95 100; ...
            NaN 115 NaN 120 125; ...
            NaN 135 NaN 145 150; ...
            NaN 165 NaN 170 175; ...
            NaN 185 NaN 195 200; ...
            NaN 215 NaN 220 225; ...
            NaN 235 NaN 245 250; ...
            NaN 265 NaN 270 275; ...
            NaN 285 NaN 295 300; ...
            NaN 315 NaN 320 325; ...
            NaN 335 NaN 345 350; ...
            NaN 365 NaN 370 375; ...
            NaN 385 NaN 395 400; ...
            NaN 415 NaN 420 425; ...
            NaN 435 NaN 445 450; ...
            NaN 465 NaN 470 475; ...
            NaN 485 NaN 495 500; ...
            NaN 515 NaN 520 525; ...
            NaN 535 NaN 545 550; ...
            NaN 565 NaN 570 575; ...
            NaN 585 NaN 595 600; ...
            NaN 615 NaN 620 625; ...
            NaN 635 NaN 645 650; ...
            NaN 665 NaN 670 675; ...
            NaN 685 NaN 695 700; ...
            NaN 715 NaN 720 725; ...
            NaN 735 NaN 745 750; ...
            NaN 765 NaN 770 775; ...
            NaN 785 NaN 795 800; ...
            NaN 815 NaN 820 825; ...
            NaN 835 NaN 845 850; ...
            NaN 865 NaN 870 875; ...
            NaN 885 NaN 895 900; ...
            NaN 915 NaN 920 925; ...
            NaN 935 NaN 945 950; ...
            NaN 965 NaN 970 975; ...
            NaN 985 NaN 995 1000; ...
            NaN 1015 NaN 1020 1025; ...
            NaN 1035 NaN 1045 1050; ...
            NaN 1065 NaN 1070 1075; ...
            NaN 1085 NaN 1095 1100; ...
            NaN 1115 NaN 1120 1125; ...
            NaN 1135 NaN 1145 1150; ...
            NaN 1165 NaN 1170 1175; ...
            NaN 1185 NaN 1195 1200; ...
            NaN 1215 NaN 1220 1225; ...
            NaN 1235 NaN 1245 1250; ...
            NaN 1265 NaN 1270 1275; ...
            NaN 1285 NaN 1295 1300; ...
            NaN 1315 NaN 1320 1325; ...
            NaN 1335 NaN 1345 1350; ...
            NaN 1365 NaN 1370 1375; ...
            NaN 1385 NaN 1395 1400; ...
            NaN 1415 NaN 1420 1425; ...
            NaN 1435 NaN 1445 1450; ...
            NaN 1465 NaN 1470 1475; ...
            NaN 1485 NaN 1495 1500];
        keySeg = [25; 50; 75; 100; 125; 150; 175; 200; ...
            225; 250; 275; 300; 325; 350; 375; 400; ...
            425; 450; 475; 500; 525; 550; 575; 600; ...
            625; 650; 675; 700; 725; 750; 775; 800; ...
            825; 850; 875; 900; 925; 950; 975; 1000; ...
            1025; 1050; 1075; 1100; 1125; 1150; 1175; 1200; ...
            1225; 1250; 1275; 1300; 1325; 1350; 1375; 1400; ...
            1425; 1450; 1475; 1500];
    end;
end;

if Course == 50;
    if RaceDist == 50;
        perfectDist = [0 15 25 35 45 50];
    elseif RaceDist == 150;
        perfectDist = [0 15 25 35 45 50 ...
            60 65 75 85 95 100 ...
            110 115 125 135 145 150];
    else;
        perfectDist = [0 15 25 35 45 50 60 65 75 85 95 100];
        if RaceDist > 100;
            for lap100 = 2:((RaceDist./Course)./2);
                kdist = lap100.*Course;
                perfectDist = [perfectDist kdist+10 kdist+15 kdist+25 kdist+35 kdist+45 kdist+50 ...
                    kdist+60 kdist+65 kdist+75 kdist+85 kdist+95 kdist+100];
            end;
        end;
    end;
else;
    if RaceDist == 50;
        perfectDist = [0 15 20 25 35 45 50];
    elseif RaceDist == 150;
        perfectDist = [0 15 20 25 35 45 50 ...
            60 70 75 85 95 100 ...
            110 120 125 135 145 150];
    else;
        perfectDist = [0 15 20 25 35 45 50 60 70 75 85 95 100];
        if RaceDist > 100;
            for lap100 = 2:((RaceDist./Course)./4);
                distRef = perfectDist(end);
                perfectDist = [perfectDist distRef+10 distRef+20 distRef+25 ...
                    distRef+35 distRef+45 distRef+50 ...
                    distRef+60 distRef+70 distRef+75 ...
                    distRef+85 distRef+95 distRef+100];
            end;
        end;
    end;
end;

lap = 1;
lapDist = lap.*Course;
for locationEC = 1:length(RaceLocation(:,1));
    locEC = RaceLocation(locationEC,5);
    if Course == 50;
        iniDist = (lap*6)-5;
        endDist = (lap*6);
    elseif Course == 25;
        if lap == 1;
            iniDist = 1;
            endDist = 4;
        else;
            iniDist = (lap*3)-1;
            endDist = iniDist+2;
        end;
    end;
    lilocECPerfect = find(perfectDist(iniDist:endDist) == locEC);

    if isempty(lilocECPerfect) == 0;
        frameLoc = RaceLocation(locationEC,4);
%         frameLoc = frameLoc - listart + 1;
%         locECconv = (Course*(lap-1)) + locEC;
%         RawDistance(1,frameLoc) = locECconv;
        RawDistance(1,frameLoc) = locEC;

%         liKeyDist = find(keyDist(lap,:) == locECconv);
        liKeyDist = find(keyDist(lap,:) == locEC);
        if isempty(liKeyDist) == 0;
            velEC = SectionVel(lap,liKeyDist);
            if isnan(velEC) == 1;
                if liKeyDist ~= 1;
                    velEC = SectionVel(lap,liKeyDist-1);
                else;
                    if liKeyDist == length(SectionVel(lap,:));
                        velEC = SectionVel(lap,liKeyDist-1);
                    else;
                        velEC = SectionVel(lap,liKeyDist+1);
                    end;
                end;
            end;
            RawVelocity(1,frameLoc) = velEC;
        end;

        if locationEC ~= 1;
            if locEC == lapDist;
                lap = lap + 1;
                lapDist = lap.*Course;
            end;
        end;
    end;
end;

%---insert NaN for underwater parts
for lap = 1:nbLap;
    if lap == 1;
        lapBeg = 1;
    else;
        lapBeg = SplitsAll(lap,3) + 2;
    end;
    BOminus1s = BOAll(lap,1) - framerate;
    RawDistance(lapBeg:BOminus1s) = NaN;
    RawVelocity(lapBeg:BOminus1s) = NaN;

    lapEnd = SplitsAll(lap+1,3);
%     indexStrokeLap = find(RaceStroke(:,4) <= lapEnd);
    lilastStroke = lapEnd - framerate./2; %arbitraty last stroke position (not available on GreenEye dataset)
%     if Course == 25;
%         RawDistance(lilastStroke:lapEnd-1) = NaN; %lapEnd-1 or lapEnd ?????
%         RawVelocity(lilastStroke:lapEnd-1) = NaN;
%     elseif Course == 50;
%         RawDistance(lilastStroke:lapEnd) = NaN; %lapEnd-1 or lapEnd ?????
%         RawVelocity(lilastStroke:lapEnd) = NaN;
%     end;
end;


%---insert position and velocity values based on average vel
[li, co] = size(SectionVelbisNew_short);
SectionVelbisNew_short = reshape(SectionVelbisNew_short', 1, li*co);
SectionVelbisNew_long = reshape(SectionVelbisNew_long', 1, li*co);

if Course == 50;
    if RaceDist == 50;
        validIndex = [5 7 9];
    elseif RaceDist == 100;
        validIndex = [NaN 5 7 9; 13 15 17 19];
    elseif RaceDist == 150;
        validIndex = [5 10; 15 20; 25 30];
    elseif RaceDist == 200;
        validIndex = [5 10; 15 20; 25 30; 35 40];
    elseif RaceDist == 400;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80];
    elseif RaceDist == 800;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80; ...
            85 90; 95 100; 105 110; 115 120; 125 130; 135 140; 145 150; 155 160];
    elseif RaceDist == 1500;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80; ...
            85 90; 95 100; 105 110; 115 120; 125 130; 135 140; 145 150; 155 160; ...
            165 170; 175 180; 185 190; 195 200; 205 210; 215 220; 225 230; 235 240; ...
            245 250; 255 260; 265 270; 275 280; 285 290; 295 300];
    end;

elseif Course == 25;
    if RaceDist == 50;
        validIndex = [4; 9];
    elseif RaceDist == 100;
        validIndex = [4; 9; 14; 19];
    elseif RaceDist == 150;
        validIndex = [4; 9; 14; 19; 24; 29];
    elseif RaceDist == 200;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39];
    elseif RaceDist == 400;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79];
    elseif RaceDist == 800;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79; ...
            84; 89; 94; 99; 104; 109; 114; 119; 124; 129; 134; 139; 144; 149; 154; 159];
    elseif RaceDist == 1500;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79; ...
            84; 89; 94; 99; 104; 109; 114; 119; 124; 129; 134; 139; 144; 149; 154; 159; ...
            164; 169; 174; 179; 184; 189; 194; 199; 204; 209; 214; 219; 224; 229; 234; 239; ...
            244; 249; 254; 259; 264; 269; 274; 279; 284; 289; 294; 299];
    end;
end;
VelLapAll = [];
if RaceDist <= 100;
    SectionVelbisNew_short = SectionVelbisNew_short';
    for lapEC = 1:nbLap;
        validIndexLap = validIndex(lapEC,:);
        indexNaN = find(isnan(validIndexLap) == 1);
        validIndexLap(indexNaN) = [];
        dataVelLap = SectionVelbisNew_short(validIndexLap, :);        
        index = find(isnan(dataVelLap) == 0);
        dataVelLap = dataVelLap(index);
        VelLapAll(lapEC) = mean(dataVelLap);
    end;
else;

    SectionVelbisNew_long = SectionVelbisNew_long';
    for lapEC = 1:nbLap;
        validIndexLap = validIndex(lapEC,:);
        indexNaN = find(isnan(validIndexLap) == 1);
        validIndexLap(indexNaN) = [];
        dataVelLap = SectionVelbisNew_long(validIndexLap, :);
        index = find(isnan(dataVelLap) == 0);
        dataVelLap = dataVelLap(index);
        VelLapAll(lapEC) = mean(dataVelLap);
    end;
end;

indexSplitLapIni = 1;
for lap = 1:nbLap;

    if lap == 1;
        lapBeg = 1;
    else;
        lapBeg = SplitsAll(lap,3) + 2;
    end;
    lapEnd = SplitsAll(lap+1,3);
    distlapEnd = SplitsAll(lap+1,1);
    indexSplitLapEnd = find(RaceLocation(:,4) == lapEnd);

    indexzeros = find(RawDistance(lapBeg:lapEnd) == 0);
    indexzeros = indexzeros + lapBeg - 1;
    if isempty(indexzeros) == 1;
        proceed = 0;
    else;
        proceed = 1;
        indexnan = find(isnan(keyDist(lap,:)) == 0);
        seg = 1;
    end;
            
    while proceed == 1;
        
        if seg == 1;
            valIni = indexzeros(1);
            distIni = RawDistance(1,valIni);
        end;

        if length(keySeg(lap,:)) == 1;
            distEC = lap*Course;
        else;
            if seg == length(keySeg(lap,:));
                %last 5m
                distEC = lap*Course;
            else;
                distEC = keyDist(lap,indexnan(seg));
            end;
        end;
%         distECconv = distEC - ((lap-1)*Course);
%         if rem(lap,2) == 0;
%             %odd
%             distECconv = Course - distECconv;
%         end;
        indexkeyDist = find(RaceLocation(indexSplitLapIni:indexSplitLapEnd,5) == distEC);
        indexkeyDist = indexkeyDist + indexSplitLapIni - 1;
        if length(keySeg(lap,:)) == 1;
            lilastStroke = lapEnd - framerate./2; %arbitraty last stroke position (not available on GreenEye dataset)
            distlastStroke = (lap*Course) - (0.5.*VelLapAll(lap));
            distEnd = [];
        else;
            if seg == length(keySeg(lap,:));
                %last 5m: Last arm entry
    %             indexStrokeLap = find(RaceStroke(:,4) <= lapEnd);
    %             lilastStroke = RaceStroke(indexStrokeLap(end),4) + 1;
    %             lilastStroke = lilastStroke;
                lilastStroke = lapEnd - framerate./2; %arbitraty last stroke position (not available on GreenEye dataset)
                distlastStroke = (lap*Course) - (0.5.*VelLapAll(lap));
                distEnd = [];
            else;
                valEnd = RaceLocation(indexkeyDist,4);
                distEnd = RaceLocation(indexkeyDist,5);
            end;
        end;

        if length(keySeg(lap,:)) == 1;
            %case for SCM, races > 150, when only 1 seg for the lap
            velRef = SectionVel(lap,indexnan(seg));
            PosJump = (1/framerate).*velRef;
        else;
            if seg == length(keySeg(lap,:));
                %include last 5m
                velRef = SectionVel(lap,indexnan(end)-1);
                if isnan(velRef) == 1;
                    %find closest non nan
                    indexNonNan = find(isnan(SectionVel(lap,:)) == 0);
                    diffCol = abs(indexnan(end) - indexNonNan);
                    [valmin, locmin] = min(diffCol);
                    locmin = indexNonNan(locmin(1));
                    velRef = SectionVel(lap, locmin);
                end;
                PosJump = (1/framerate).*velRef;
            else;
                if lap ~= 1 & seg == 1;
                    %first seg of lap 2 and after
                    %vel is calculated from 60 to 65 and is not
                    %representative
                    %reculculate it from BO to 65 just to fill the gap
                    %properly
                    velRef = SectionVel(lap,indexnan(seg));
                    if isnan(velRef) == 1;
                        %find closest non nan
                        indexNonNan = find(isnan(SectionVel(lap,:)) == 0);
                        diffCol = abs(indexnan(seg) - indexNonNan);
                        [valmin, locmin] = min(diffCol);
                        locmin = indexNonNan(locmin(1));
                        velRef = SectionVel(lap, locmin);
                    end;
%                     velRefAdj = (distEC - BOAll(lap,3)) / (SectionCumTime(lap,indexnan(seg)) - BOAll(lap,2));
                    PosJump = (1/framerate).*velRef;
                else;
                    velRef = SectionVel(lap,indexnan(seg));
                    if isnan(velRef) == 1;
                        %find closest non nan
                        indexNonNan = find(isnan(SectionVel(lap,:)) == 0);
                        diffCol = abs(indexnan(seg) - indexNonNan);
                        [valmin, locmin] = min(diffCol);
                        locmin = indexNonNan(locmin(1));
                        velRef = SectionVel(lap, locmin);
                    end;
                    PosJump = (1/framerate).*velRef;
                end;
            end;
        end;

        if length(keySeg(lap,:)) == 1;
            %case for SCM, races > 150, when only 1 seg for the lap
            %put the BO position
            skipsegBO = 0;
            liBOEC = BOAll(lap,1) + 1;
            RawDistance(1,liBOEC) = BOAll(lap,3);
            RawVelocity(1,liBOEC) = velRef;

            %remove ave dist until bo minus 1s
            %always use the velRef for that part
            for colEC = -(liBOEC-1) : -valIni;
                colECcor = abs(colEC);
                if isnan(RawDistance(1,colECcor)) == 1;
                    RawDistance(1,colECcor) = RawDistance(1,colECcor+1) - PosJump;
                else;
                    if RawDistance(1,colECcor) == 0;
                        RawDistance(1,colECcor) = RawDistance(1,colECcor+1) - PosJump;
                    end;
                end;
                if isnan(RawVelocity(1,colECcor)) == 1;
                    RawVelocity(1,colECcor) = velRef;
                else;
                    if RawVelocity(1,colECcor) == 0;
                        RawVelocity(1,colECcor) = velRef;
                    end;
                end;
            end;

            %From BO until artificial last stroke
            PosJump = (distlastStroke-(BOAll(lap,3)+0.01))./(lilastStroke-(liBOEC+1));
            for colEC = liBOEC+1 : lilastStroke;
                if isnan(RawDistance(1,colEC)) == 1;
                    RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                else;
                    if RawDistance(1,colEC) == 0;
                        RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                    end;
                end;
                if isnan(RawVelocity(1,colEC)) == 1;
                    RawVelocity(1,colEC) = velRef;
                else;
                    if RawVelocity(1,colEC) == 0;
                        RawVelocity(1,colEC) = velRef;
                    end;
                end;
            end;
            RawVelocity(1,SplitsAll(lap+1,3)) = NaN;

        else;
            diffliEnd = abs(valEnd - RaceLocation(:,4));
            [minval, minloc] = min(diffliEnd);
            distEnd = RaceLocation(minloc,5);

            if seg == 1;
                skipsegBO = 0;
                liBOEC = BOAll(lap,1) + 1;
                %put the BO position
                if BOAll(lap,3) >= distEnd;
                    %segment fully under water
                    skipsegBO = 1;
                else;
                    liBOEC = BOAll(lap,1) + 1;
                    RawDistance(1,liBOEC) = BOAll(lap,3);
                    RawVelocity(1,liBOEC) = velRef;
    
                    %remove ave dist until bo minus 1s
                    %always use the velRef for that part
                    for colEC = -(liBOEC-1) : -valIni;
                        colECcor = abs(colEC);
                        if isnan(RawDistance(1,colECcor)) == 1;
                            RawDistance(1,colECcor) = RawDistance(1,colECcor+1) - PosJump;
                        else;
                            if RawDistance(1,colECcor) == 0;
                                RawDistance(1,colECcor) = RawDistance(1,colECcor+1) - PosJump;
                            end;
                        end;
                        if isnan(RawDistance(1,colECcor)) == 1;
                            RawVelocity(1,colECcor) = velRef;
                        else;
                            if RawVelocity(1,colECcor) == 0;
                                RawVelocity(1,colECcor) = velRef;
                            end;
                        end;
                    end;
                    %add ave dist until reaching end of seg
                    PosJump = (distEnd-BOAll(lap,3)+0.01)./(valEnd-liBOEC);
                    for colEC = liBOEC-1 : valEnd;
                        if isnan(RawDistance(1,colEC)) == 1;
                            RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                        else;
                            if RawDistance(1,colEC) == 0;
                                RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                            end;
                        end;
                        if isnan(RawVelocity(1,colEC)) == 1;
                            RawVelocity(1,colEC) = velRef;
                        else;
                            if RawVelocity(1,colEC) == 0
                                RawVelocity(1,colEC) = velRef;
                            end;
                        end;
                    end;
                end;
            elseif seg == length(keySeg(lap,:));
                diffliIni = abs(valIni - RaceLocation(:,4));
                [minval, minloc] = min(diffliIni);
                distIni = RaceLocation(minloc,5);

                PosJump = (distlastStroke-distIni)./(lilastStroke-valIni);
                for colEC = valIni : lilastStroke;
                    if isnan(RawDistance(1,colEC)) == 1;
                        RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                    else;
                        if RawDistance(1,colEC) == 0;
                            RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                        end;
                    end;
                    if isnan(RawVelocity(1,colEC)) == 1;
                        RawVelocity(1,colEC) = velRef;
                    else;
                        if RawVelocity(1,colEC) == 0;
                            RawVelocity(1,colEC) = velRef;
                        end;
                    end;
                end;
                RawVelocity(1,SplitsAll(lap+1,3)) = NaN;
            else;
                if skipsegBO == 1;
                    skipsegBO = 0;
                    liBOEC = BOAll(lap,1) + 1;
                    %first seg was fully underwater... BO in Seg 2
                    %This become seg 1... same calculations
                    %put the BO position
                    if BOAll(lap,3) >= distEnd;
                        %segment fully under water
                        skipsegBO = 1;
                    else;
                        liBOEC = BOAll(lap,1) + 1;
                        RawDistance(1,liBOEC) = BOAll(lap,3);
                        RawVelocity(1,liBOEC) = velRef;
        
                        %remove ave dist until bo minus 1s
                        %always use the velRef for that part
                        for colEC = -(liBOEC-1) : -valIni;
                            colECcor = abs(colEC);
                            if isnan(RawDistance(1,colECcor)) == 1;
                                RawDistance(1,colECcor) = RawDistance(1,colECcor+1) - PosJump;
                            else;
                                if RawDistance(1,colECcor) == 0;
                                    RawDistance(1,colECcor) = RawDistance(1,colECcor+1) - PosJump;
                                end;
                            end;
                            if isnan(RawDistance(1,colECcor)) == 1;
                                RawVelocity(1,colECcor) = velRef;
                            else;
                                if RawVelocity(1,colECcor) == 0;
                                    RawVelocity(1,colECcor) = velRef;
                                end;
                            end;
                        end;
                        %add ave dist until reaching end of seg
                        PosJump = (distEnd-BOAll(lap,3)+0.01)./(valEnd-liBOEC);
                        for colEC = liBOEC-1 : valEnd;
                            if isnan(RawDistance(1,colEC)) == 1;
                                RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                            else;
                                if RawDistance(1,colEC) == 0;
                                    RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                                end;
                            end;
                            if isnan(RawVelocity(1,colEC)) == 1;
                                RawVelocity(1,colEC) = velRef;
                            else;
                                if RawVelocity(1,colEC) == 0
                                    RawVelocity(1,colEC) = velRef;
                                end;
                            end;
                        end;
                    end;
                else;
                    diffliIni = abs(valIni - RaceLocation(:,4));
                    [minval, minloc] = min(diffliIni);
                    distIni = RaceLocation(minloc,5);
    
                    PosJump = (distEnd-distIni)./(valEnd-valIni);
                    for colEC = valIni : valEnd;
                        if isnan(RawDistance(1,colEC)) == 1;
                            RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                        else;
                            if RawDistance(1,colEC) == 0;
                                RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                            end;
                        end;
                        if isnan(RawVelocity(1,colEC)) == 1;
                            RawVelocity(1,colEC) = velRef;
                        else;
                            if RawVelocity(1,colEC) == 0;
                                RawVelocity(1,colEC) = velRef;
                            end;
                        end;
                    end;
                end;
            end;
            valIni = valEnd;
        end;
        if skipsegBO == 0;
            if (distEC - RawDistance(1,colEC)) < 0.01;
                RawDistance(1,colEC) = RawDistance(1,colEC) - 0.01;
            end;
        end;

        if seg == length(keySeg(lap,:));
            proceed = 0;
        else;
            seg = seg + 1;
            indexzeros = find(RawDistance(lapBeg:lapEnd) == 0);
            indexzeros = indexzeros + lapBeg - 1;
            if isempty(indexzeros) == 1;
                proceed = 0;
            end;
        end;
    end;
    indexSplitLapIni = indexSplitLapEnd + 1;
end;
index = find(RawDistance(1,2:end) == 0);
RawDistance(1,index+1) = NaN;
index = find(RawVelocity(1,:) == 0);
RawVelocity(1,index) = NaN;

RawDistanceINI = RawDistance;
RawVelocityRaw = RawVelocity;
RawVelocityTrend = RawVelocity;
RawVelocityINI = RawVelocity;

%---insert position and velocity values based on average vel
RaceBreath = [];
if isempty(RaceBreath) == 0;
    for breathEC = 1:length(RaceBreath(:,1));
        libreath = RaceBreath(breathEC,4) - listart + 1;
        RawBreath(1,libreath) = 1;
    end;
end;
RaceKick = [];
if isempty(RaceKick) == 0;
    for kickEC = 1:length(RaceKick(:,1));
        likick = RaceKick(kickEC,4) - listart + 1;   
        RawKick(1,likick) = 1;
    end;
end;

index = find(isnan(SectionNbbis) == 0);
if isempty(index) == 0;
    for lapEC = 1:nbLap;
        for posEC = 1:length(posSC);
            %only 1 zone
            nbStroke = SectionNbbis(lapEC,posSC(posEC));
            liIniLap = BOAll(lapEC,1) + 1;
            liEndLap = SplitsAll(lapEC+1,3) - framerate./2 - 1;
            avStroke = (liEndLap-liIniLap)./nbStroke;

            strokePos = liIniLap;
            for stEC = 1:nbStroke;
                strokePos = roundn(strokePos + avStroke,0);
                RawStroke(1,strokePos) = 1;
            end;
        end;
    end;
end;
if isempty(BOAll) == 0;
    for BOEC = 1:length(BOAll(:,1));
        liBOEC = BOAll(BOEC,1);
        RawBreakout(1,liBOEC) = 1;
    end;
end;
for frameEC = 1:nbRows;
    RawTime(frameEC) = (frameEC-1).*(1./framerate);
end;

%---Adjust BOAll frame index
BOAll = roundn(BOAll,-2);
SplitsAll = roundn(SplitsAll,-2);
SplitsAllSave = roundn(SplitsAll,-2);
%----------------------------------------------------------






%----------------Compute other variables-------------------
Stroke_Number = [];
Stroke_Time = zeros(nbLap,80);
Stroke_SR = zeros(nbLap,80);
Stroke_Distance = zeros(nbLap,80);
Stroke_DistanceINI = zeros(nbLap,80);
Stroke_SI = zeros(nbLap,80);
Stroke_SIINI = zeros(nbLap,80);
Stroke_Frame = zeros(nbLap,80);
Stroke_Velocity = zeros(nbLap,80);
Stroke_VelocityMax = zeros(nbLap,80);
Stroke_VelocityMin = zeros(nbLap,80);
Stroke_VelocityINI = zeros(nbLap,80);
Kick_Frames = zeros(nbLap,30);
Breath_Frames = zeros(nbLap,40);
Dive_Stroke = [];
Turn_Stroke = [];
Finish_Stroke = [];
Turn_Time = [];
Turn_TimeIn = [];
Turn_TimeOut = [];
Turn_TimeINI = [];
Turn_TimeInINI = [];
Turn_TimeOutINI = [];
Turn_BODist = [];
TurnsAv = [];
TurnsAvINI = [];
TurnsAvBODist = [];
TurnsAvBOEff = [];
TurnsAvBOEffCorr = [];
TurnsAvKicks = [];
TurnsAvVelAfterBO = [];
TurnsAvVelBeforeBO = [];
TurnsTotal = [];
TurnsTotalINI = [];
TurnsAvKicks = [];

KicksNb = [];
BreathsNb = [];
ApproachSpeedLastCycleAll = [];
ApproachSpeed2CycleAll = [];
ApproachEff = [];
GlideLastStrokeEC = [];
BOEff = [];
VelAfterBO = [];
VelBeforeBO = [];

VelLapAv = [];
TurnUWVelocity = [];

BOAllINI = BOAll;

VelLapAv = VelLapAv;
for lap = 1:nbLap;
    if lap == 1;
        liSplit = SplitsAll(lap+1,3);
        liSplitPrev = 1;
                
        DiveT15 = raceDataMetaNew{1,19};
        DiveT15INI = DiveT15;
                
        liBreath = find(RawBreath(1:liSplit) == 1);
        BreathsNb = [BreathsNb length(liBreath)];
        Breath_Frames(lap,1:length(liBreath)) = liBreath;

        liKick = find(RawKick(1:liSplit) == 1);
        KicksNb = [KicksNb length(liKick)];
        Kick_Frames(lap,1:length(liKick)) = liKick;

        VelBeforeBO(lap) = NaN;
        VelAfterBO(lap) = NaN;
        BOEff(lap) = NaN;
        BOEffCorr(lap) = NaN;

        liStroke = find(RawStroke(liSplitPrev:liSplit) == 1);
        liStroke = liStroke + liSplitPrev - 1;

    else;
        liSplitPrev = liSplit + 1;
        liSplit = SplitsAll(lap+1,3);

        VelBeforeBO(lap) = NaN;
        VelAfterBO(lap) = NaN;
        BOEff(lap) = NaN;
        BOEffCorr(lap) = NaN;
                
        Turn_Time(lap-1) = turnAll(lap-1,1) + turnAll(lap-1,2);
        Turn_TimeIn(lap-1) = turnAll(lap-1,1);
        Turn_TimeOut(lap-1) = turnAll(lap-1,2);
        Turn_BODist(lap-1) = raceDataSegmentNew(lap-1,11);

        Turn_TimeINI(lap-1) = turnAll(lap-1,1) + turnAll(lap-1,2);
        Turn_TimeInINI(lap-1) = turnAll(lap-1,1);
        Turn_TimeOutINI(lap-1) = turnAll(lap-1,2);
        Turn_BODistINI(lap-1) = raceDataSegmentNew(lap-1,11);

        liBreath = find(RawBreath(liSplitPrev:liSplit) == 1);
        BreathsNb = [BreathsNb length(liBreath)];
        Breath_Frames(lap,1:length(liBreath)) = liBreath + liSplitPrev - 1;;

        liKick = find(RawKick(liSplitPrev:liSplit) == 1);
        KicksNb = [KicksNb length(liKick)];
        Kick_Frames(lap,1:length(liKick)) = liKick + liSplitPrev - 1;;

        liStroke = find(RawStroke(liSplitPrev:liSplit) == 1);
        liStroke = liStroke + liSplitPrev - 1;
    end;

    Stroke_Frame(lap,1:length(liStroke)) = liStroke;
    SpeedLastCycle = NaN;
    Speed2Cycle = NaN;

    ApproachSpeedLastCycleAll(lap) = NaN;
    ApproachSpeed2CycleAll(lap) = NaN;
    ApproachEff(lap) = NaN;
        
    GlideLastStrokeEC(1,lap) = NaN;
    GlideLastStrokeEC(2,lap) = NaN;
    GlideLastStrokeEC(3,lap) = NaN;
    GlideLastStrokeEC(4,lap) = NaN;
        
    Stroke_Number(lap) = length(liStroke);
    timeStroke = diff(liStroke)./framerate;
    Stroke_Time(lap,1:length(timeStroke)) = timeStroke;

    TimeStroke = RawTime(liStroke);
    if lap == 1;
        TimeLimInfSR = 1;
    end;
    segECSR = 1;
    for posEC = 1:length(posSR);
        if posEC == length(posSR);
            TimeLimSupSR = SectionCumTime(lap,end);
        else;
            TimeLimSupSR = SectionCumTime(lap,posSR(posEC));
        end;
        liStrokeTimeSeg = find(TimeStroke > TimeLimInfSR & TimeStroke <= TimeLimSupSR);
        liStrokeSeg = liStroke(liStrokeTimeSeg);

        if isempty(liStrokeSeg) == 0;
            if segECSR == 1;
                colIni = 1;
                colEnd = length(liStrokeSeg);
                segECSR = segECSR + 1;
            else;
                colIni = colEnd + 1;
                colEnd = colIni + length(liStrokeSeg) - 1;
                segECSR = segECSR + 1;
            end;
            TimeLimInfSR = TimeLimSupSR;
            Stroke_SR(lap,colIni:colEnd) = SectionSR(lap, posSR(posEC));
        else;
            TimeLimInfSR = TimeLimSupSR;
        end;
    end;

    if lap == 1;
        TimeLimInfVel = 1;
    end;
    segECVel = 1;


    if Course == 25;
        if RaceDist > 100;
            if lapEC == 1;
                posVel = 4;
                posDPS = 4;
                posSR = 5;
                posSC = 5;
                distSplits = 25;
            else;
                posVel = 4;
                posDPS = 4;
                posSR = 5;
                posSC = 5;
                distSplits = 25;
            end;
        else;
            if lapEC == 1;
                posVel = 4;
                posDPS = 4;
                posSR = [3 4 5];
                posSC = 5;
                distSplits = [15 20 25];
            else;
                posVel = 4;
                posDPS = 4;
                posSR = [2 4 5];
                posSC = 5;
                distSplits = [10 20 25];
            end;
        end;
    else;
        if RaceDist > 100;
            if lapEC == 1;
                posVel = [5 10];
                posDPS = [5 10];
                posSR = [5 10];
                posSC = 10;
                distSplits = [25 50];
            else;
                posVel = [5 10];
                posDPS = [5 10];
                posSR = [5 10];
                posSC = 10;
                kdist = (lapEC-1).*Course;
                distSplits = [kdist+25 kdist+50];
            end;
        else;
            if lapEC == 1;
                if avInterval == 25;
                    posVel = [5 7 9];
                    posDPS = [5 7 9];
                else;
                    posVel = [3 5 7 9];
                    posDPS = [3 5 7 9];
                end;
                posSR = [3 5 7 9 10];
                posSC = 10;
                distSplits = [15 25 35 45 50];
            else;
                posVel = [3 5 7 9];
                posDPS = [3 5 7 9];
                posSR = [3 5 7 9 10];
                posSC = 10;
                distSplits = [65 75 85 95 100];
            end;
        end;
    end;
    for posEC = 1:length(posVel);
        if posEC == length(posVel);
            TimeLimSupVel = SectionCumTime(lap,end);
        else;
            TimeLimSupVel = SectionCumTime(lap,posVel(posEC));
        end;
        liStrokeTimeSeg = find(TimeStroke > TimeLimInfVel & TimeStroke <= TimeLimSupVel);
        liStrokeSeg = liStroke(liStrokeTimeSeg);

        if isempty(liStrokeSeg) == 0;
            if segECVel == 1;
                colIni = 1;
                colEnd = length(liStrokeSeg);
                segECVel = segECVel + 1;
            else;
                colIni = colEnd + 1;
                colEnd = colIni + length(liStrokeSeg) - 1;
                segECVel = segECVel + 1;
            end;
            TimeLimInfVel = TimeLimSupVel;
            %Velocity, DPS and SI have the same location in Section
            Stroke_Velocity(lap,colIni:colEnd) = SectionVel(lap, posVel(posEC));
            Stroke_VelocityMax(lap,colIni:colEnd) = SectionVel(lap, posVel(posEC));
            Stroke_VelocityMin(lap,colIni:colEnd) = SectionVel(lap, posVel(posEC));
            Stroke_Distance(lap,colIni:colEnd) = SectionSD(lap, posDPS(posEC));
            Stroke_SI(lap,colIni:colEnd) = Stroke_Velocity(lap,colIni:colEnd).*Stroke_Distance(lap,colIni:colEnd);
        end;
    end;
end;
% if Course == 25;
% %     if RaceDist <= 100;
%         posVel = 5;
%         posDPS = 5;
% %     end;
% end;



%Check for NaN
[li,col] = find(isnan(Stroke_SI) == 1);
Stroke_SI(li,col) = 0;
Stroke_DistanceINI = Stroke_Distance;
Stroke_VelocityINI = Stroke_Velocity;
Stroke_SIINI = Stroke_SI;

StartUWVelocity = [];
StartEntryDist = [];
StartUWDist = [];
StartUWTime = [];

Last5m = finishTime;
Last5mINI = finishTime;


if RaceDist == 50;
    if Course == 50;
        Turn_BODist = [];
        Turn_Time = [];
        Turn_TimeIn = [];
        Turn_TimeOut = [];
        Turn_TimeINI = [];
        Turn_TimeInINI = [];
        Turn_TimeOutINI = [];
        TurnsAv = [NaN NaN NaN];
        TurnsAvBODist = [];
        TurnsAvBOEff = NaN;
        TurnsAvKicks = NaN;
        TurnsAvVelAfterBO = NaN;
        TurnsAvVelBeforeBO = NaN;
        TurnsTotal = [0 0 0];
        TurnsTotalINI = [0 0 0];
        
        TotalSkillTime = DiveT15 + Last5m;
        TotalSkillTimeINI = DiveT15INI + Last5mINI;
    elseif Course == 25;
        TotalSkillTime = DiveT15 + sum(Turn_Time) + Last5m;
        TotalSkillTimeINI = DiveT15INI + sum(Turn_TimeINI) + Last5mINI;
        TurnsTotal = [sum(Turn_TimeIn) sum(Turn_TimeOut) sum(Turn_Time)];
        TurnsTotalINI = [sum(Turn_TimeIn) sum(Turn_TimeOut) sum(Turn_Time)];
        TurnsAv = [mean(Turn_TimeIn) mean(Turn_TimeOut) mean(Turn_Time)];
        TurnsAvINI = [mean(Turn_TimeInINI) mean(Turn_TimeOutINI) mean(Turn_TimeINI)];
        TurnsAvBODist = BOAll(2:end,3);
        TurnsAvKicks = mean(KicksNb(2:end));
        TurnsAvBOEff = NaN;
        TurnsAvBOEffCorr = NaN;
        TurnsAvVelAfterBO = NaN;
        TurnsAvVelBeforeBO = NaN;
    end;
else;
    TotalSkillTime = DiveT15 + sum(Turn_Time) + Last5m;
    TotalSkillTimeINI = DiveT15INI + sum(Turn_TimeINI) + Last5mINI;
    TurnsTotal = [sum(Turn_TimeIn) sum(Turn_TimeOut) sum(Turn_Time)];
    TurnsTotalINI = [sum(Turn_TimeIn) sum(Turn_TimeOut) sum(Turn_Time)];
    TurnsAv = [mean(Turn_TimeIn) mean(Turn_TimeOut) mean(Turn_Time)];
    TurnsAvINI = [mean(Turn_TimeInINI) mean(Turn_TimeOutINI) mean(Turn_TimeINI)];
    TurnsAvBODist = BOAll(2:end,3);
    TurnsAvKicks = mean(KicksNb(2:end));
    TurnsAvBOEff = NaN;
    TurnsAvBOEffCorr = NaN;
    TurnsAvVelAfterBO = NaN;
    TurnsAvVelBeforeBO = NaN;
end;


if RaceDist == 50;
    if Course == 25;
        SplitMid = SplitsAll((nbLap./2)+1,2);
        SplitEnd = SplitsAll(nbLap+1,2) - SplitMid;
        DropOff = SplitEnd - SplitMid;

        DropOfftxt = num2str(DropOff);
        if DropOff > 0;
            DropOfftxt = ['+' DropOfftxt];
        elseif DropOff < 0;
            DropOfftxt = ['-' DropOfftxt(2:end)];
        else;
            DropOfftxt = ['=' DropOfftxt];
        end;
        TimeDropOff =  DropOfftxt;

        Turn_TimeTXT = dataToStr(mean(Turn_Time),2);
        Turn_TimeTXTINI = dataToStr(mean(Turn_TimeINI),2);
        Turn_BODistTXT = dataToStr(mean(Turn_BODist),2);
        Turn_BODistTXTINI = dataToStr(mean(Turn_BODistINI),2);
    
        if isnan(TurnsAvBOEff) == 1;
            TurnsAvBOEffTXT = 'na';
            TurnsAvBOEffCorrTXT = 'na';
        else;
            val1 = dataToStr(mean(TurnsAvBOEff).*100,2);
            val2 = dataToStr(TurnsAvVelBeforeBO, 2);
            val3 = dataToStr(TurnsAvVelAfterBO, 2);
            TurnsAvBOEffTXT = [val1 ' [' val2 ' / ' val3 ']'];
            TurnsAvBOEffCorrTXT = dataToStr(mean(TurnsAvBOEffCorr).*100,2);
        end;
        
    else;
        DropOff = [];
        TimeDropOff = 'na';
        Turn_Time = [];
        TurnsAvEff = [];

        Turn_TimeTXT = 'na';
        Turn_BODistTXT = 'na';
        Turn_TimeTXTINI = 'na';
        Turn_BODistTXTINI = 'na';
        TurnsAvEffTXT = 'na';
        TurnsAvBOEffTXT = 'na';
        TurnsAvBOEffCorrTXT = 'na';
    end;
else;
    if Course == 50;
        if RaceDist == 150;
            DropOff = 0;
        else;
            SplitMid = SplitsAll((nbLap./2)+1,2);
            SplitEnd = SplitsAll(nbLap+1,2) - SplitMid;
            DropOff = SplitEnd - SplitMid;
        end;
    else;
        SplitMid = SplitsAll((nbLap./2)+1,2);
        SplitEnd = SplitsAll(nbLap+1,2) - SplitMid;
        DropOff = SplitEnd - SplitMid;
    end;
        
    DropOfftxt = num2str(DropOff);
    if DropOff > 0;
        DropOfftxt = ['+' DropOfftxt];
    elseif DropOff < 0;
        DropOfftxt = ['-' DropOfftxt(2:end)];
    else;
        DropOfftxt = ['=' DropOfftxt];
    end;
    TimeDropOff =  DropOfftxt;
    if Course == 50;
        if RaceDist == 150;
            TimeDropOff = 'na';
        end;
    end;
    
    Turn_TimeTXT = dataToStr(mean(Turn_Time),2);
    Turn_TimeTXTINI = [dataToStr(mean(Turn_TimeINI),2) ' [' dataToStr(mean(Turn_TimeInINI),2) ' / ' dataToStr(mean(Turn_TimeOutINI),2) ']'];

    Turn_BODistTXT = dataToStr(mean(Turn_BODist),2);
    Turn_BODistTXTINI = dataToStr(mean(Turn_BODistINI),2);
    
    if isnan(TurnsAvBOEff) == 1;
        TurnsAvBOEffTXT = 'na';
        TurnsAvBOEffCorrTXT = 'na';
    else;
        val1 = dataToStr(mean(TurnsAvBOEff).*100, 2);
        val2 = dataToStr(TurnsAvVelBeforeBO, 2);
        val3 = dataToStr(TurnsAvVelAfterBO, 2);
        TurnsAvBOEffTXT = [val1 ' [' val2 ' / ' val3 ']'];
        TurnsAvBOEffCorrTXT = dataToStr(mean(TurnsAvBOEffCorr).*100,2);
    end;
end;


%Max and means per zone/lap
clear SectionVel2;
clear SectionSR2;
clear SectionSD2;
[li,co] = size(SectionVel);
SectionVel2 = reshape(SectionVel, li*co, 1);
linan = find(isnan(SectionVel2) == 0);
valmax = max(SectionVel2(linan));
MaxVelDouble = roundn(valmax,-2);
MaxVel = dataToStr(MaxVelDouble,2);
[MaxVelLoc_Lap, MaxVelLoc_Seg] = find(SectionVel == valmax);
MaxVel = [MaxVel ' [Lap:' num2str(MaxVelLoc_Lap(1)) '-Seg:' num2str(MaxVelLoc_Seg(1)) ']'];
valmean = mean(SectionVel2(linan));
MeanVel = dataToStr(valmean,2);
MaxVelString = [MeanVel ' / ' MaxVel];

[li,co] = size(SectionSR);
SectionSR2 = reshape(SectionSR, li*co, 1);
linan = find(isnan(SectionSR2) == 0);
valmax = max(SectionSR2(linan));
MaxSRDouble = roundn(valmax,-2);
MaxSR = dataToStr(MaxSRDouble,2);
[MaxSRLoc_Lap, MaxSRLoc_Seg] = find(SectionSR == valmax);
MaxSR = [MaxSR ' [Lap:' num2str(MaxSRLoc_Lap(1)) '-Seg:' num2str(MaxSRLoc_Seg(1)) ']'];
valmean = mean(SectionSR2(linan));
MeanSR = dataToStr(valmean,2);
MaxSR = [MeanSR ' / ' MaxSR];

[li,co] = size(SectionSD);
SectionSD2 = reshape(SectionSD, li*co, 1);
linan = find(isnan(SectionSD2) == 0);
valmax = max(SectionSD2(linan));
MaxSDDouble = roundn(valmax,-2);
MaxSD = dataToStr(MaxSDDouble,2);
[MaxSDLoc_Lap, MaxSDLoc_Seg] = find(SectionSD == valmax);
MaxSD = [MaxSD ' [Lap:' num2str(MaxSDLoc_Lap(1)) '-Seg:' num2str(MaxSDLoc_Seg(1)) ']'];
valmean = mean(SectionSD2(linan));
MeanSD = dataToStr(valmean,2);
MaxSD = [MeanSD ' / ' MaxSD];

VELlapTOT = [];
TimelapTOT = [];
StrokeTimeAll = [];
SpeedDecaySprintRange = [];
SpeedDecaySemiRange = [];
SpeedDecayLongRange = [];
SpeedDecaySprintMid = [];
SpeedDecaySemiMid = [];
SpeedDecayLongMid = [];
SpeedDecayRef = [];
Stroke_TimeDecay = Stroke_Time;
Stroke_VelocityDecay = Stroke_VelocityINI;
if strcmpi(StrokeType, 'Freestyle') | strcmpi(StrokeType, 'Backstroke');
    for lapEC = 1:nbLap;
        index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);

        if length(index) > 2;
            if rem(length(index), 2) == 1;
                %odd count of stroke (remove 3 strokes)
                remStroke = 2;
            else;
                remStroke = 1;
            end;
    
            Stroke_TimeDecay(lapEC, 1:2) = 0;
            Stroke_TimeDecay(lapEC, index(end)-remStroke:index(end)) = 0;
    
            Stroke_VelocityDecay(lapEC, 1:2) = 0;
            Stroke_VelocityDecay(lapEC, index(end)-remStroke:index(end)) = 0;
        end;
    end;

    %calculate value per cycle rather than per stroke
    Cycle_Time = [];
    Cycle_Velocity = [];
    Cycle_TimeTOT = [];
    Cycle_VelocityTOT = [];

    for lapEC = 1:nbLap;
        Stroke_VelocityDecayLap = Stroke_VelocityDecay(lapEC,:);
        index = find(Stroke_VelocityDecayLap == 0);
        Stroke_VelocityDecayLap(index) = [];
        
        Stroke_TimeDecayLap = Stroke_TimeDecay(lapEC,:);
        index = find(Stroke_TimeDecayLap == 0);
        Stroke_TimeDecayLap(index) = [];
%         Cycle_Time(lapEC,1) = Stroke_FrameLap(1);

        if isempty(Stroke_VelocityDecayLap) == 1
            nbStroke = 0;
        else;
            nbStroke = length(Stroke_VelocityDecayLap ~= 0);
        end;
        iter = 1;
        if nbStroke > 1;
            for strokeEC = 1:2:nbStroke;
                if Stroke_VelocityDecayLap(1,strokeEC) ~= 0;
                    if strokeEC+1 >= nbStroke;
                        if strokeEC >= nbStroke;
                            Cycle_Time(lapEC,iter) = Cycle_Time(lapEC,iter-1);
                            Cycle_Velocity(lapEC,iter) = Cycle_Velocity(lapEC,iter-1);
                        else;
                            Cycle_Time(lapEC,iter) = sum(Stroke_TimeDecayLap(1,strokeEC));
                            Cycle_Velocity(lapEC,iter) = mean(Stroke_VelocityDecayLap(1,strokeEC));
                        end;
                    else;
                        Cycle_Time(lapEC,iter) = sum(Stroke_TimeDecayLap(1,strokeEC:strokeEC+1));
                        Cycle_Velocity(lapEC,iter) = mean(Stroke_VelocityDecayLap(1,strokeEC:strokeEC+1));
                    end;
                    iter = iter + 1;
                end;
            end;
        else;
            Cycle_Time(lapEC,1) = NaN;
            Cycle_Velocity(lapEC,1) = NaN;
        end;
        Cycle_TimeTOT = [Cycle_TimeTOT Cycle_Time(lapEC,:)];
        Cycle_VelocityTOT = [Cycle_VelocityTOT Cycle_Velocity(lapEC,:)];
    end;

%     index = find(isnan(Cycle_TimeTOT) == 0);
    index = find(isnan(Cycle_VelocityTOT) == 0);
    Cycle_VelocityTOT= Cycle_VelocityTOT(index);
    Cycle_TimeTOT= Cycle_TimeTOT(index);
    StrokeTimeAll = sum(Cycle_TimeTOT);
    [VELlapTOT, index] = sort(Cycle_VelocityTOT, 'Descend');
    if length(VELlapTOT) >= 4;
        MaxVel = mean(VELlapTOT(1:3));   
        MinVel = mean(VELlapTOT(end-2:end));
    elseif length(VELlapTOT) == 3;
        MaxVel = VELlapTOT(1);   
        MinVel = VELlapTOT(end);
    else;
        MaxVel = [];
        MinVel = [];
    end;

    if isempty(MaxVel) == 1;
        SpeedDecayRef = [];
        SpeedDecaySprintRange = [];
        SpeedDecaySprintMid = [];
        SpeedDecaySemiRange = [];
        SpeedDecaySemiMid = [];
        SpeedDecayLongRange = [];
        SpeedDecayLongMid = [];
    else;
        Cycle_TimeTOT = Cycle_TimeTOT(index);
        rangeVel = MaxVel - MinVel;
        RefVelRange = MaxVel - (rangeVel/2);
        SpeedDecayRef(1) = RefVelRange;

        %find 50% of time
        findlim = 0;

        if isempty(find(VELlapTOT ~= 0)) == 1;
            SpeedDecayRef = [];
            SpeedDecaySprintRange = [];
            SpeedDecaySprintMid = [];
            SpeedDecaySemiRange = [];
            SpeedDecaySemiMid = [];
            SpeedDecayLongRange = [];
            SpeedDecayLongMid = [];
        else;
            for tcheck = 1:length(Cycle_TimeTOT);
                timeTOTEC = sum(Cycle_TimeTOT(1:tcheck))./StrokeTimeAll;
                if timeTOTEC > 0.5 & findlim == 0;
                    findlim = 1;
                    RefVelMid = mean([VELlapTOT(tcheck-1) VELlapTOT(tcheck)]);
                end;
            end;
            SpeedDecayRef(2) = RefVelMid;
    
            for veloption = 1:2;
                zoneVelSprint = [-0.025 -0.05 -0.075 -0.1 -0.125 -0.15; ...
                    0.025 0.05 0.075 0.1 0.125 0.15];
                nbzoneVel = length(zoneVelSprint(1,:));
                iter = 1;
                if veloption == 1;
                    RefVel = RefVelRange;
                else;
                    RefVel = RefVelMid;
                end;
        
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelSprint(1,:))+1;
                        index = find(VELlapTOT <= RefVel+zoneVelSprint(1,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT >= RefVel+zoneVelSprint(1,zoneVelEC) & VELlapTOT < RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelSprint(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelSprint(1,zoneVelEC));
                    end;
                    SpeedDecaySprint(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelSprint(1,:))+1;
                        index = find(VELlapTOT > RefVel+zoneVelSprint(2,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT < RefVel+zoneVelSprint(2,zoneVelEC) & VELlapTOT >= RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelSprint(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelSprint(2,zoneVelEC-1));
                    end;
                    SpeedDecaySprint(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                if veloption == 1;
                    SpeedDecaySprintRange = SpeedDecaySprint;
                else;
                    SpeedDecaySprintMid = SpeedDecaySprint;
                end;
            
                zoneVelSemi = [-0.015 -0.03 -0.045 -0.06 -0.075 -0.09; ...
                    0.015 0.03 0.045 0.05 0.075 0.09];
                nbzoneVel = length(zoneVelSemi(1,:));
                iter = 1;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelSemi(1,:))+1;
                        index = find(VELlapTOT <= RefVel+zoneVelSemi(1,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT >= RefVel+zoneVelSemi(1,zoneVelEC) & VELlapTOT < RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelSemi(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelSemi(1,zoneVelEC));
                    end;
                    SpeedDecaySemi(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelSemi(1,:))+1;
                        index = find(VELlapTOT > RefVel+zoneVelSemi(2,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT < RefVel+zoneVelSemi(2,zoneVelEC) & VELlapTOT >= RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelSemi(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelSemi(2,zoneVelEC-1));
                    end;
                    SpeedDecaySemi(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                if veloption == 1;
                    SpeedDecaySemiRange = SpeedDecaySemi;
                else;
                    SpeedDecaySemiMid = SpeedDecaySemi;
                end;
            
                zoneVelLong = [-0.01 -0.02 -0.03 -0.04 -0.05 -0.06; ...
                    0.01 0.02 0.03 0.04 0.05 0.06];
                nbzoneVel = length(zoneVelLong(1,:));
                iter = 1;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelLong(1,:))+1;
                        index = find(VELlapTOT <= RefVel+zoneVelLong(1,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT >= RefVel+zoneVelLong(1,zoneVelEC) & VELlapTOT < RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelLong(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelLong(1,zoneVelEC));
                    end;
                    SpeedDecayLong(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelLong(1,:))+1;
                        index = find(VELlapTOT > RefVel+zoneVelLong(2,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT < RefVel+zoneVelLong(2,zoneVelEC) & VELlapTOT >= RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelLong(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelLong(2,zoneVelEC-1));
                    end;
                    SpeedDecayLong(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                if veloption == 1;
                    SpeedDecayLongRange = SpeedDecayLong;
                else;
                    SpeedDecayLongMid = SpeedDecayLong;
                end;
            end;
        end;
    end;
   
elseif strcmpi(StrokeType, 'Butterfly') | strcmpi(StrokeType, 'Breaststroke');
    %remove first and last strokes (if more than 2 strokes)
    for lapEC = 1:nbLap;
        index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
        
        if length(index) > 2;
            Stroke_TimeDecay(lapEC, 1) = 0;
            Stroke_TimeDecay(lapEC, index(end)-1:index(end)) = 0;
    
            Stroke_VelocityDecay(lapEC, 1) = 0;
            Stroke_VelocityDecay(lapEC, index(end)-1:index(end)) = 0;
        end;
    end;

    %calculate value per cycle rather than per stroke (just remove the
    %0)
    Cycle_Time = [];
    Cycle_Velocity = [];
    Cycle_TimeTOT = [];
    Cycle_VelocityTOT = [];
    for lapEC = 1:nbLap;
        Stroke_VelocityDecayLap = Stroke_VelocityDecay(lapEC,:);
        index = find(Stroke_VelocityDecayLap == 0);
        Stroke_VelocityDecayLap(index) = [];
        
        Stroke_TimeDecayLap = Stroke_TimeDecay(lapEC,:);
        index = find(Stroke_TimeDecayLap == 0);
        Stroke_TimeDecayLap(index) = [];
%         Cycle_Time(lapEC,1) = Stroke_FrameLap(1);

        if isempty(Stroke_VelocityDecayLap) == 1
            nbStroke = 0;
        else;
            nbStroke = length(Stroke_VelocityDecayLap ~= 0);
        end;
        iter = 1;
        if nbStroke > 1;
            for strokeEC = 1:2:nbStroke;
                if Stroke_VelocityDecayLap(1,strokeEC) ~= 0;
                    if strokeEC > length(Stroke_TimeDecayLap);
                        Cycle_Time(lapEC,iter) = Cycle_Time(lapEC,iter-1);
                    else
                        Cycle_Time(lapEC,iter) = Stroke_TimeDecayLap(1,strokeEC);
                    end;
                    Cycle_Velocity(lapEC,iter) = Stroke_VelocityDecayLap(1,strokeEC);
                    iter = iter + 1;
                end;
            end;
        else;
            Cycle_Time(lapEC,1) = NaN;
            Cycle_Velocity(lapEC,1) = NaN;
        end;

        Cycle_TimeTOT = [Cycle_TimeTOT Cycle_Time(lapEC,:)];
        Cycle_VelocityTOT = [Cycle_VelocityTOT Cycle_Velocity(lapEC,:)];
    end;

    index1 = find(isnan(Cycle_TimeTOT) == 0);
    index2 = find(isnan(Cycle_VelocityTOT) == 0);
    index = [index1 index2];
    if isempty(index) == 0;
        Cycle_TimeTOT = Cycle_TimeTOT(index);
        Cycle_VelocityTOT = Cycle_VelocityTOT(index);
    end;
    StrokeTimeAll = sum(Cycle_TimeTOT);

    [VELlapTOT, index] = sort(Cycle_VelocityTOT, 'Descend');
    if length(VELlapTOT) >= 4;
        MaxVel = mean(VELlapTOT(1:3));   
        MinVel = mean(VELlapTOT(end-2:end));
    elseif length(VELlapTOT) == 3;
        MaxVel = VELlapTOT(1);   
        MinVel = VELlapTOT(end);
    else;
        MaxVel = [];
        MinVel = [];
    end;

    if isempty(MaxVel) == 1;
        SpeedDecayRef = [];
        SpeedDecaySprintRange = [];
        SpeedDecaySprintMid = [];
        SpeedDecaySemiRange = [];
        SpeedDecaySemiMid = [];
        SpeedDecayLongRange = [];
        SpeedDecayLongMid = [];
    else;
        Cycle_TimeTOT = Cycle_TimeTOT(index);
        rangeVel = MaxVel - MinVel;
        RefVelRange = MaxVel - (rangeVel/2);
        SpeedDecayRef(1) = RefVelRange;
    
        %find 50% of time
        findlim = 0;
        for tcheck = 1:length(Cycle_TimeTOT);
            timeTOTEC = sum(Cycle_TimeTOT(1:tcheck))./StrokeTimeAll;
            if timeTOTEC > 0.5 & findlim == 0;
                findlim = 1;
                RefVelMid = mean([VELlapTOT(tcheck-1) VELlapTOT(tcheck)]);
            end;
        end;
        SpeedDecayRef(2) = RefVelMid;
    
        for veloption = 1:2;
            zoneVelSprint = [-0.025 -0.05 -0.075 -0.1 -0.125 -0.15; ...
                0.025 0.05 0.075 0.1 0.125 0.15];
            nbzoneVel = length(zoneVelSprint(1,:));
            iter = 1;
            if veloption == 1;
                RefVel = RefVelRange;
            else;
                RefVel = RefVelMid;
            end;
    
            for zoneVelEC = 1:nbzoneVel+1;
                if zoneVelEC == length(zoneVelSprint(1,:))+1;
                    index = find(VELlapTOT <= RefVel+zoneVelSprint(1,zoneVelEC-1));
                elseif zoneVelEC == 1;
                    index = find(VELlapTOT >= RefVel+zoneVelSprint(1,zoneVelEC) & VELlapTOT < RefVel);
                else;
                    index = find(VELlapTOT < RefVel+zoneVelSprint(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelSprint(1,zoneVelEC));
                end;
                SpeedDecaySprint(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                iter = iter + 1;
            end;
            for zoneVelEC = 1:nbzoneVel+1;
                if zoneVelEC == length(zoneVelSprint(1,:))+1;
                    index = find(VELlapTOT > RefVel+zoneVelSprint(2,zoneVelEC-1));
                elseif zoneVelEC == 1;
                    index = find(VELlapTOT < RefVel+zoneVelSprint(2,zoneVelEC) & VELlapTOT >= RefVel);
                else;
                    index = find(VELlapTOT < RefVel+zoneVelSprint(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelSprint(2,zoneVelEC-1));
                end;
                SpeedDecaySprint(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                iter = iter + 1;
            end;
            if veloption == 1;
                SpeedDecaySprintRange = SpeedDecaySprint;
            else;
                SpeedDecaySprintMid = SpeedDecaySprint;
            end;
        
            zoneVelSemi = [-0.015 -0.03 -0.045 -0.06 -0.075 -0.09; ...
                0.015 0.03 0.045 0.05 0.075 0.09];
            nbzoneVel = length(zoneVelSemi(1,:));
            iter = 1;
            for zoneVelEC = 1:nbzoneVel+1;
                if zoneVelEC == length(zoneVelSemi(1,:))+1;
                    index = find(VELlapTOT <= RefVel+zoneVelSemi(1,zoneVelEC-1));
                elseif zoneVelEC == 1;
                    index = find(VELlapTOT >= RefVel+zoneVelSemi(1,zoneVelEC) & VELlapTOT < RefVel);
                else;
                    index = find(VELlapTOT < RefVel+zoneVelSemi(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelSemi(1,zoneVelEC));
                end;
                SpeedDecaySemi(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                iter = iter + 1;
            end;
            for zoneVelEC = 1:nbzoneVel+1;
                if zoneVelEC == length(zoneVelSemi(1,:))+1;
                    index = find(VELlapTOT > RefVel+zoneVelSemi(2,zoneVelEC-1));
                elseif zoneVelEC == 1;
                    index = find(VELlapTOT < RefVel+zoneVelSemi(2,zoneVelEC) & VELlapTOT >= RefVel);
                else;
                    index = find(VELlapTOT < RefVel+zoneVelSemi(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelSemi(2,zoneVelEC-1));
                end;
                SpeedDecaySemi(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                iter = iter + 1;
            end;
            if veloption == 1;
                SpeedDecaySemiRange = SpeedDecaySemi;
            else;
                SpeedDecaySemiMid = SpeedDecaySemi;
            end;
        
            zoneVelLong = [-0.01 -0.02 -0.03 -0.04 -0.05 -0.06; ...
                0.01 0.02 0.03 0.04 0.05 0.06];
            nbzoneVel = length(zoneVelLong(1,:));
            iter = 1;
            for zoneVelEC = 1:nbzoneVel+1;
                if zoneVelEC == length(zoneVelLong(1,:))+1;
                    index = find(VELlapTOT <= RefVel+zoneVelLong(1,zoneVelEC-1));
                elseif zoneVelEC == 1;
                    index = find(VELlapTOT >= RefVel+zoneVelLong(1,zoneVelEC) & VELlapTOT < RefVel);
                else;
                    index = find(VELlapTOT < RefVel+zoneVelLong(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelLong(1,zoneVelEC));
                end;
                SpeedDecayLong(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                iter = iter + 1;
            end;
            for zoneVelEC = 1:nbzoneVel+1;
                if zoneVelEC == length(zoneVelLong(1,:))+1;
                    index = find(VELlapTOT > RefVel+zoneVelLong(2,zoneVelEC-1));
                elseif zoneVelEC == 1;
                    index = find(VELlapTOT < RefVel+zoneVelLong(2,zoneVelEC) & VELlapTOT >= RefVel);
                else;
                    index = find(VELlapTOT < RefVel+zoneVelLong(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelLong(2,zoneVelEC-1));
                end;
                SpeedDecayLong(iter) = sum(Cycle_TimeTOT(index))./StrokeTimeAll;
                iter = iter + 1;
            end;
            if veloption == 1;
                SpeedDecayLongRange = SpeedDecayLong;
            else;
                SpeedDecayLongMid = SpeedDecayLong;
            end;
        end;
    end;
    
else;
    caseStroke = [];
    for lapEC = 1:nbLap;
        if Course == 50;
            if RaceDist == 150;
                if lapEC == 1 | lapEC == 3;
                    %BF and BR
                    caseStroke(lapEC) = 1;
                elseif lapEC == 2;
                    %BK and FS
                    caseStroke(lapEC) = 2;
                end;
            elseif RaceDist == 200;
                if lapEC == 1 | lapEC == 3;
                    %BF and BR
                    caseStroke(lapEC) = 1;
                elseif lapEC == 2 | lapEC == 4;
                    %BK and FS
                    caseStroke(lapEC) = 2;
                end;
            elseif RaceDist == 400;
                if lapEC == 1 | lapEC == 2 | lapEC == 5 | lapEC == 6;
                    %BF and BR
                    caseStroke(lapEC) = 1;
                elseif lapEC == 3 | lapEC == 4 | lapEC == 7 | lapEC == 8;
                    %BK and FS
                    caseStroke(lapEC) = 2;
                end;
            end;
        elseif Course == 25;
            if RaceDist == 100;
                if lapEC == 1 | lapEC == 3;
                    %BF and BR
                    caseStroke(lapEC) = 1;
                elseif lapEC == 2 | lapEC == 4;
                    %BK and FS
                    caseStroke(lapEC) = 2;
                end;
            elseif RaceDist == 150;
                if lapEC == 1 | lapEC == 2 | lapEC == 5 | lapEC == 6;
                    %BF and BR
                    caseStroke(lapEC) = 1;
                elseif lapEC == 3 | lapEC == 4;
                    %BK and FS
                    caseStroke(lapEC) = 2;
                end;
            elseif RaceDist == 200;
                if lapEC == 1 | lapEC == 2 | lapEC == 5 | lapEC == 6;
                    %BF and BR
                    caseStroke(lapEC) = 1;
                elseif lapEC == 3 | lapEC == 4 | lapEC == 7 | lapEC == 8;
                    %BK and FS
                    caseStroke(lapEC) = 2;
                end;
            elseif RaceDist == 400;
                if lapEC == 1 | lapEC == 2 | lapEC == 3 | lapEC == 4 | lapEC == 9 | lapEC == 10 | lapEC == 11 | lapEC == 12;
                    %BF and BR
                    caseStroke(lapEC) = 1;
                elseif lapEC == 5 | lapEC == 6 | lapEC == 7 | lapEC == 8 | lapEC == 13 | lapEC == 14 | lapEC == 15 | lapEC == 16;
                    %BK and FS
                    caseStroke(lapEC) = 2;
                end;
            end;
        end;
    end;

    for lapEC = 1:nbLap;
        if caseStroke(lapEC) == 1;
            %remove first and last strokes
            index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
    
            if length(index) > 2;
                Stroke_TimeDecay(lapEC, 1) = 0;
                Stroke_TimeDecay(lapEC, index(end):index(end)+1) = 0;
    
                Stroke_VelocityDecay(lapEC, 1) = 0;
                Stroke_VelocityDecay(lapEC, index(end)-1:index(end)) = 0;
            end;
        else;
            %remove first 2 and last 2 strokes
            if length(index) > 2;
                index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
                if rem(length(index), 2) == 1;
                    %odd count of stroke (remove 3 strokes)
                    remStroke = 2;
                else;
                    remStroke = 1;
                end;
    
                Stroke_TimeDecay(lapEC, 1:2) = 0;
                Stroke_TimeDecay(lapEC, index(end)-remStroke+1:index(end)+1) = 0;
    
                Stroke_VelocityDecay(lapEC, 1:2) = 0;
                Stroke_VelocityDecay(lapEC, index(end)-remStroke:index(end)) = 0;
            end;
        end;
    end;

    Cycle_Time = [];
    Cycle_Velocity = [];
    for lapEC = 1:nbLap;
        if caseStroke(lapEC) == 1;
            %calculate value per cycle rather than per stroke (just remove the
            %0)
            Stroke_VelocityDecayLap = Stroke_VelocityDecay(lapEC,:);
            index = find(Stroke_VelocityDecayLap == 0);
            Stroke_VelocityDecayLap(index) = [];
            Stroke_TimeDecayLap = Stroke_TimeDecay(lapEC,:);
            index = find(Stroke_TimeDecayLap == 0);
            Stroke_TimeDecayLap(index) = [];

            if isempty(Stroke_VelocityDecayLap) == 1
                nbStroke = 0;
            else;
                nbStroke = length(Stroke_VelocityDecayLap ~= 0);
            end;
            iter = 1;

            if nbStroke > 1;
                for strokeEC = 1:nbStroke;
                    if Stroke_VelocityDecay(lapEC,strokeEC) ~= 0;
                        if strokeEC > length(Stroke_TimeDecayLap);
                            Cycle_Time(lapEC,iter) = Cycle_Time(lapEC,iter-1);
                        else
                            Cycle_Time(lapEC,iter) = Stroke_TimeDecayLap(1,strokeEC);
                        end;
                        Cycle_Velocity(lapEC,iter) = Stroke_VelocityDecayLap(1,strokeEC);
                        iter = iter + 1;
                    end;
                end;
            else
                Cycle_Time(lapEC,1) = NaN;
                Cycle_Velocity(lapEC,1) = NaN;
            end;
        else;
            %calculate value per cycle rather than per stroke
            Stroke_VelocityDecayLap = Stroke_VelocityDecay(lapEC,:);
            index = find(Stroke_VelocityDecayLap == 0);
            Stroke_VelocityDecayLap(index) = [];
            Stroke_TimeDecayLap = Stroke_TimeDecay(lapEC,:);
            index = find(Stroke_TimeDecayLap == 0);
            Stroke_TimeDecayLap(index) = [];
            
            if isempty(Stroke_VelocityDecayLap) == 1
                nbStroke = 0;
            else;
                nbStroke = length(Stroke_VelocityDecayLap ~= 0);
            end;
            iter = 1;
            if nbStroke > 1;
                for strokeEC = 1:2:nbStroke;
                    if Stroke_VelocityDecayLap(1,strokeEC) ~= 0;
                        if strokeEC+1 >= nbStroke;
                            if strokeEC >= nbStroke;
                                Cycle_Time(lapEC,iter) = Cycle_Time(lapEC,iter-1);
                                Cycle_Velocity(lapEC,iter) = Cycle_Velocity(lapEC,iter-1);
                            else;
                                Cycle_Time(lapEC,iter) = sum(Stroke_TimeDecayLap(1,strokeEC));
                                Cycle_Velocity(lapEC,iter) = mean(Stroke_VelocityDecayLap(1,strokeEC));
                            end;
                        else;
                            Cycle_Time(lapEC,iter) = sum(Stroke_TimeDecayLap(1,strokeEC:strokeEC+1));
                            Cycle_Velocity(lapEC,iter) = mean(Stroke_VelocityDecayLap(1,strokeEC:strokeEC+1));
                        end;
                        iter = iter + 1;
                    end;
                end;
            else;
                Cycle_Time(lapEC,1) = NaN;
                Cycle_Velocity(lapEC,1) = NaN;
            end;
        end;
    end;

    if Course == 25;
        if RaceDist == 100;
            legDeflap = [1; 2; 3; 4];
            legCount = 4;
        elseif RaceDist == 150;
            legDeflap = [1 2; 3 4; 5 6];
            legCount = 3;
        elseif RaceDist == 200;
            legDeflap = [1 2;3 4; 5 6; 7 8];
            legCount = 4;
        elseif RaceDist == 400;
            legDeflap = [1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16];
            legCount = 4;
        end;
    elseif Course == 50;
        if RaceDist == 150;
            legDeflap = [1 ; 2; 3];
            legCount = 3;
        elseif RaceDist == 200;
            legDeflap = [1; 2; 3; 4];
            legCount = 4;
        elseif RaceDist == 400;
            legDeflap = [1 2; 3 4; 5 6; 7 8];
            legCount = 4;
        end;
    end;

    for legEC = 1:legCount;
        Cycle_TimeLeg = [];
        Cycle_VelocityLeg = [];
        for lapEC = 1:length(legDeflap(1,:));
            addTime = Cycle_Time(legDeflap(legEC,lapEC),:);
            index = find(addTime ~= 0);
            Cycle_TimeLeg = [Cycle_TimeLeg addTime(index)];
            addVel = Cycle_Velocity(legDeflap(legEC,lapEC),:);
            Cycle_VelocityLeg = [Cycle_VelocityLeg addVel(index)];
        end;
        Cycle_TimeTOT(legEC,1:length(Cycle_TimeLeg)) = Cycle_TimeLeg;
        Cycle_VelocityTOT(legEC,1:length(Cycle_VelocityLeg)) = Cycle_VelocityLeg;
    end;
    
    for legEC = 1:legCount;
        Cycle_TimeTOTLeg = Cycle_TimeTOT(legEC,:);      
        index = find(isnan(Cycle_TimeTOTLeg) == 0);
        Cycle_TimeTOTLeg= Cycle_TimeTOTLeg(index);
        StrokeTimeAll = sum(Cycle_TimeTOTLeg);
        
        Cycle_VelocityLeg = Cycle_VelocityTOT(legEC,:);
        index = find(Cycle_VelocityLeg ~= 0);
        Cycle_VelocityLeg = Cycle_VelocityLeg(index);
        index = find(isnan(Cycle_VelocityLeg) == 0);
        Cycle_VelocityLeg = Cycle_VelocityLeg(index);
        [VELlapTOT, index] = sort(Cycle_VelocityLeg, 'Descend');
        if length(VELlapTOT) >= 4;
            MaxVel = mean(VELlapTOT(1:3));   
            MinVel = mean(VELlapTOT(end-2:end));
        elseif length(VELlapTOT) == 3;
            MaxVel = VELlapTOT(1);   
            MinVel = VELlapTOT(end);
        else;
            MaxVel = [];
            MinVel = [];
        end;

        if isempty(MaxVel) == 1;
            SpeedDecayRef = [];
            SpeedDecaySprintRange = [];
            SpeedDecaySprintMid = [];
            SpeedDecaySemiRange = [];
            SpeedDecaySemiMid = [];
            SpeedDecayLongRange = [];
            SpeedDecayLongMid = [];
        else;
            Cycle_TimeTOTLeg = Cycle_TimeTOTLeg(index);
            rangeVel = MaxVel - MinVel;
            RefVelRange = MaxVel - (rangeVel/2);
            SpeedDecayRef(legEC, 1) = RefVelRange;
    
            %find 50% of time
            findlim = 0;
            if roundn(std(VELlapTOT),-2) == 0;
                %all speeds are the same
                %the the middle
                midlength = length(VELlapTOT)./2;
                if floor(midlength) == midlength;
                    RefVelMid = mean([VELlapTOT(midlength) VELlapTOT(midlength+1)]);
                else;
                    RefVelMid = mean([VELlapTOT(midlength-0.5) VELlapTOT(midlength+0.5)]);
                end;

            else;
                for tcheck = 1:length(Cycle_TimeTOTLeg);
                    timeTOTEC = sum(Cycle_TimeTOTLeg(1:tcheck))./StrokeTimeAll;
                    if timeTOTEC > 0.5 & findlim == 0;
                        findlim = 1;
                        if tcheck == 1;
                            RefVelMid = mean([VELlapTOT(tcheck) VELlapTOT(tcheck+1)]);
                        else;
                            RefVelMid = mean([VELlapTOT(tcheck-1) VELlapTOT(tcheck)]);
                        end;
                    end;
                end;
            end;
            SpeedDecayRef(legEC, 2) = RefVelMid;
    
            for veloption = 1:2;
                zoneVelSprint = [-0.025 -0.05 -0.075 -0.1 -0.125 -0.15; ...
                    0.025 0.05 0.075 0.1 0.125 0.15];
                nbzoneVel = length(zoneVelSprint(1,:));
                iter = 1;
                if veloption == 1;
                    RefVel = RefVelRange;
                else;
                    RefVel = RefVelMid;
                end;
    
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelSprint(1,:))+1;
                        index = find(VELlapTOT <= RefVel+zoneVelSprint(1,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT >= RefVel+zoneVelSprint(1,zoneVelEC) & VELlapTOT < RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelSprint(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelSprint(1,zoneVelEC));
                    end;
                    SpeedDecaySprint(legEC, iter) = sum(Cycle_TimeTOTLeg(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelSprint(1,:))+1;
                        index = find(VELlapTOT > RefVel+zoneVelSprint(2,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT < RefVel+zoneVelSprint(2,zoneVelEC) & VELlapTOT >= RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelSprint(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelSprint(2,zoneVelEC-1));
                    end;
                    SpeedDecaySprint(legEC, iter) = sum(Cycle_TimeTOTLeg(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                if veloption == 1;
                    SpeedDecaySprintRange = SpeedDecaySprint;
                else;
                    SpeedDecaySprintMid = SpeedDecaySprint;
                end;
            
                zoneVelSemi = [-0.015 -0.03 -0.045 -0.06 -0.075 -0.09; ...
                    0.015 0.03 0.045 0.05 0.075 0.09];
                nbzoneVel = length(zoneVelSemi(1,:));
                iter = 1;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelSemi(1,:))+1;
                        index = find(VELlapTOT <= RefVel+zoneVelSemi(1,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT >= RefVel+zoneVelSemi(1,zoneVelEC) & VELlapTOT < RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelSemi(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelSemi(1,zoneVelEC));
                    end;
                    SpeedDecaySemi(legEC, iter) = sum(Cycle_TimeTOTLeg(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelSemi(1,:))+1;
                        index = find(VELlapTOT > RefVel+zoneVelSemi(2,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT < RefVel+zoneVelSemi(2,zoneVelEC) & VELlapTOT >= RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelSemi(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelSemi(2,zoneVelEC-1));
                    end;
                    SpeedDecaySemi(legEC, iter) = sum(Cycle_TimeTOTLeg(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                if veloption == 1;
                    SpeedDecaySemiRange = SpeedDecaySemi;
                else;
                    SpeedDecaySemiMid = SpeedDecaySemi;
                end;
            
                zoneVelLong = [-0.01 -0.02 -0.03 -0.04 -0.05 -0.06; ...
                    0.01 0.02 0.03 0.04 0.05 0.06];
                nbzoneVel = length(zoneVelLong(1,:));
                iter = 1;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelLong(1,:))+1;
                        index = find(VELlapTOT <= RefVel+zoneVelLong(1,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT >= RefVel+zoneVelLong(1,zoneVelEC) & VELlapTOT < RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelLong(1,zoneVelEC-1) & VELlapTOT > RefVel+zoneVelLong(1,zoneVelEC));
                    end;
                    SpeedDecayLong(legEC, iter) = sum(Cycle_TimeTOTLeg(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                for zoneVelEC = 1:nbzoneVel+1;
                    if zoneVelEC == length(zoneVelLong(1,:))+1;
                        index = find(VELlapTOT > RefVel+zoneVelLong(2,zoneVelEC-1));
                    elseif zoneVelEC == 1;
                        index = find(VELlapTOT < RefVel+zoneVelLong(2,zoneVelEC) & VELlapTOT >= RefVel);
                    else;
                        index = find(VELlapTOT < RefVel+zoneVelLong(2,zoneVelEC) & VELlapTOT >= RefVel+zoneVelLong(2,zoneVelEC-1));
                    end;
                    SpeedDecayLong(legEC, iter) = sum(Cycle_TimeTOTLeg(index))./StrokeTimeAll;
                    iter = iter + 1;
                end;
                if veloption == 1;
                    SpeedDecayLongRange = SpeedDecayLong;
                else;
                    SpeedDecayLongMid = SpeedDecayLong;
                end;
            end;
        end;
    end;
end;
%----------------------------------------------------------




%--------------------------Pacing graph----------------------------
reference_velocitythreshold;
%----Velocity bars / SR (left yaxis)
% ran = max(Velocity);
% min_val = 0;
% max_val = max(Velocity);
ran = thresTopDisp - thresBottomDisp;
min_val = thresBottomDisp;
max_val = thresTopDisp;

colorVel = floor(((RawVelocity-min_val)/ran)*256)+1;
colorVelTrend = floor(((RawVelocityTrend-min_val)/ran)*256)+1;
col = zeros(numel(RawVelocity),3);

if strcmpi(detailRelay, 'None') == 1;
    str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' (GE)'];
else;
    str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (GE)'];
end;

graph1_gtit = title(axesgraph1, str, ...
    'color', [1 1 1], 'Visible', 'on');
tickSpeed = [thresBottomDisp:0.2:thresTopDisp];
tickColor = (tickSpeed-min_val)/ran;
tickSpeedTXT = [];
for i = 1:length(tickSpeed);
    tickSpeedTXT{i} = num2str(tickSpeed(i));
end;
            
yyaxis(axesgraph1, 'left');
maxDistance = 0;
minDistance = 100000;
for lap = 1:nbLap;
    Stroke_Distancelap = Stroke_Distance(lap,:);
    li = find(Stroke_Distancelap ~= 0);
    Stroke_Distancelap = Stroke_Distancelap(li);
    NbStrokeEC = length(Stroke_Distancelap);
    for StrokeEC = 1:NbStrokeEC;
        Distance_EC = Stroke_Distancelap(StrokeEC);
        if maxDistance < Distance_EC;
            maxDistance = Distance_EC;
        end;
        if minDistance > Distance_EC;
            minDistance = Distance_EC;
        end;
    end;
end;

lapEC = 1;
StrokeEC = 1;
Stroke_Distancelap = Stroke_Distance(lapEC,:);
Stroke_Framelap = Stroke_Frame(lapEC,:);
li = find(Stroke_Distancelap ~= 0);
Stroke_Distancelap = Stroke_Distancelap(li);
Stroke_Framelap = Stroke_Framelap(li);
NbStrokeEC = length(Stroke_Distancelap);
            
if RaceDist == 50;
    jump = 3;
    linesize = 1.8;
    linesizeRed = 3;
elseif RaceDist == 100;
    jump = 4;
    linesize = 2.2;
    linesizeRed = 3;
elseif RaceDist == 150;
    if framerate == 25;
        jump = 5;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 7;
        linesize = 2.2;
        linesizeRed = 3;
    end;
elseif RaceDist == 200;
    if framerate == 25;
        jump = 5;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 7;
        linesize = 2.2;
        linesizeRed = 3;
    end;
elseif RaceDist == 400
    if framerate == 25;
        jump = 7;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 9;
        linesize = 2.2;
        linesizeRed = 3;
    end;
elseif RaceDist == 800;
    if framerate == 25;
        jump = 9;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 15;
        linesize = 2.2;
        linesizeRed = 3;
    end;
elseif RaceDist == 1500;
    if framerate == 25;
        jump = 8;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 15;
        linesize = 2.2;
        linesizeRed = 3;
    end;
end;
for i = 1:jump:numel(RawVelocity);
    iter = 1;
    if jump == 1;
        Distance_EC = Stroke_Distancelap(StrokeEC);
        if isnan(Velocity(i)) ~= 1;  
            colraw = colorVel(i);
            colrawTrend = colorVelTrend(i);
            if colraw > 256;
                colraw = 256;
            end;
            if colraw <= 0;
                colraw = 1;
            end;
            if colrawTrend > 256;
                colrawTrend = 256;
            end;
            if colrawTrend <= 0;
                colrawTrend = 1;
            end;
            graph1_lineMain = line([i i], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colraw,:), 'parent', axesgraph1, 'visible', 'off');
            graph1_lineMainTrend = line([i i], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colrawTrend,:), 'parent', axesgraph1, 'visible', 'off');
        end;

        if Stroke_Framelap(StrokeEC) <= i;
            if StrokeEC == NbStrokeEC;
                if lapEC < nbLap;
                    %change lap and stroke 1
                    lapEC = lapEC + 1;
                    StrokeEC = 1;
                    Stroke_Distancelap = Stroke_Distance(lapEC,:);
                    Stroke_Framelap = Stroke_Frame(lapEC,:);
                    li = find(Stroke_Distancelap ~= 0);
                    Stroke_Distancelap = Stroke_Distancelap(li);
                    Stroke_Framelap = Stroke_Framelap(li);
                    NbStrokeEC = length(Stroke_Distancelap);
                end;
            else;
                %change stroke only
                StrokeEC = StrokeEC + 1;
            end;
        end;
    else;
        
        Distance_EC = Stroke_Distancelap(StrokeEC);
        if i+jump-1 > numel(RawVelocity);
            maxi = numel(RawVelocity);
        else;
            maxi = i+jump-1;
        end;
        colraw = colorVel(i:maxi);
        colrawTrend = colorVelTrend(i:maxi);
        linan = find(isnan(colraw) ~= 1);
        
        if length(linan) >= (0.8.*jump);
            colraw = roundn(mean(colraw(linan)), 0);
            if colraw > 256;
                colraw = 256;
            end;
            if colraw <= 0;
                colraw = 1;
            end;
            graph1_lineMain = line([i maxi], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colraw,:), 'parent', axesgraph1, 'visible', 'off');
            
            colrawTrend = roundn(mean(colrawTrend(linan)), 0);
            if colrawTrend > 256;
                colrawTrend = 256;
            end;
            if colrawTrend <= 0;
                colrawTrend = 1;
            end;
            graph1_lineMainTrend = line([i maxi], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colrawTrend,:), 'parent', axesgraph1, 'visible', 'off');
            
            iter = iter + 1;
        end;

        if Stroke_Framelap(StrokeEC) <= i+jump-1;
            if StrokeEC == NbStrokeEC;
                if lapEC < nbLap;
                    %change lap and stroke 1
                    lapEC = lapEC + 1;
                    StrokeEC = 1;
                    Stroke_Distancelap = Stroke_Distance(lapEC,:);
                    Stroke_Framelap = Stroke_Frame(lapEC,:);
                    li = find(Stroke_Distancelap ~= 0);
                    Stroke_Distancelap = Stroke_Distancelap(li);
                    Stroke_Framelap = Stroke_Framelap(li);
                    NbStrokeEC = length(Stroke_Distancelap);
                end;
            else;
                %change stroke only
                StrokeEC = StrokeEC + 1;
            end;
        end;
    end;
    hold on;
end;


keysplit = [];
for i = 1:jump:numel(RawVelocity);
    if jump == 1;
        if isnan(Velocity(i)) == 1;
            li = find(SplitsAll(:,3) == i);
            li2 = find(BOAll(:,1) == i);
            if i == 1;
               graph1_lineMain = line([0 0], [0 maxDistance+0.1], 'linewidth', 4, 'Color', [1 1 1], 'parent', axesgraph1, 'visible', 'off');
               graph1_lineMainTrend = line([0 0], [0 maxDistance+0.1], 'linewidth', 4, 'Color', [1 1 1], 'parent', axesgraph1, 'visible', 'off');
            else;
                if isempty(li) == 1 & isempty(li2) == 1;
                    graph1_lineMain = line([i i], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', axesgraph1, 'visible', 'off');
                    graph1_lineMainTrend = line([i i], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', axesgraph1, 'visible', 'off');
                else;
                    if isempty(li) == 0;
                        keysplit = [keysplit i];
                        graph1_lineMain = line([i i], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', axesgraph1, 'visible', 'off');
                        graph1_lineMainTrend = line([i i], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', axesgraph1, 'visible', 'off');
                    end;
                    if isempty(li2) == 0;
                        graph1_lineMain = line([i i], [0 maxDistance+0.1], 'linewidth', linesizeRed-1, 'Color', [0.8 0 0], 'LineStyle', '--', 'parent', axesgraph1, 'visible', 'off');
                        graph1_lineMainTrend = line([i i], [0 maxDistance+0.1], 'linewidth', linesizeRed-1, 'Color', [0.8 0 0], 'LineStyle', '--', 'parent', axesgraph1, 'visible', 'off');
                    end;
                end;
            end;
        end;
    else;
        if i+jump-1 > numel(RawVelocity);
            maxi = numel(RawVelocity);
        else;
            maxi = i+jump-1;
        end;
        colraw = colorVel(i:maxi);
        linan = find(isnan(colraw) ~= 1);
        if length(linan) < (0.8.*jump);
            proceed = 1;
            iterM = 0;
            findsplit = 0;
            while proceed ==  1;
                li = find(SplitsAll(:,3) == i+iterM);
                if isempty(li) == 0
                    proceed = 0;
                    findsplit = i+iterM;
                else;
                    iterM = iterM + 1;
                end;
                if iterM > maxi;
                    proceed = 0;
                    findsplit = 0;
                end;
            end;
            
            proceed = 1;
            iterM = 0;
            findsplit2 = 0;
            while proceed ==  1;
                li2 = find(BOAll(:,1) == i+iterM);
                if isempty(li2) == 0
                    proceed = 0;
                    findsplit2 = i+iterM;
                else;
                    iterM = iterM + 1;
                end;
                if iterM > maxi;
                    proceed = 0;
                    findsplit2 = 0;
                end;
            end;
            
            if i == 1;
                graph1_lineMain = line([0 0], [0 maxDistance+0.1], 'linewidth', 4, 'Color', [1 1 1], 'parent', axesgraph1, 'visible', 'off');
                graph1_lineMainTrend = line([0 0], [0 maxDistance+0.1], 'linewidth', 4, 'Color', [1 1 1], 'parent', axesgraph1, 'visible', 'off');
            else;
                if isempty(li) == 1 & isempty(li2) == 1;
                    graph1_lineMain = line([i maxi], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', axesgraph1, 'visible', 'off');
                    graph1_lineMainTrend = line([i maxi], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', axesgraph1, 'visible', 'off');
                else;
                    if isempty(li) == 0;
                        keysplit = [keysplit i];
                        graph1_lineMain = line([findsplit findsplit], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', axesgraph1, 'visible', 'off');
                        graph1_lineMainTrend = line([findsplit findsplit], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', axesgraph1, 'visible', 'off');
                    end;
                    if isempty(li2) == 0;
                        graph1_lineMain = line([findsplit2 findsplit2], [0 maxDistance+0.1], 'linewidth', linesizeRed-1, 'Color', [0.8 0 0], 'LineStyle', '--', 'parent', axesgraph1, 'visible', 'off');
                        graph1_lineMainTrend = line([findsplit2 findsplit2], [0 maxDistance+0.1], 'linewidth', linesizeRed-1, 'Color', [0.8 0 0], 'LineStyle', '--', 'parent', axesgraph1, 'visible', 'off');
                    end;
                end;
            end;
            iter = iter + 1;
        end;
    end;
    hold on;
end;
graph1_lineBottom = line([0 numel(RawVelocity)], [0 0], 'Color', [0.5 0.5 0.5], 'LineWidth', 2.5, 'parent', axesgraph1, 'visible', 'off');
hold off;

            
%---DPS graph right axis
yyaxis(axesgraph1, 'right');

maxSR = 0;
minSR = 1000000;
iter = 1;
for lap = 1:nbLap;
    Stroke_SRlap = Stroke_SR(lap,:);
    li = find(Stroke_SRlap ~= 0);
    Stroke_SRlap = Stroke_SRlap(li);
    Stroke_Framelap = Stroke_Frame(lap,li);
    NbStroke = length(Stroke_SRlap);
    for stroke = 1:NbStroke;
        if stroke == 1;
            liini = BOAll(lap,1);
            liend = Stroke_Framelap(stroke);
        else;
            liini = Stroke_Framelap(stroke-1);
            liend = Stroke_Framelap(stroke);
        end;
        graph1_Distance(iter) = line([liini liend], [Stroke_SRlap(stroke) Stroke_SRlap(stroke)], ...
            'color', [1 0 0], 'LineWidth', 2, 'Parent', axesgraph1, 'Visible', 'off');
        iter = iter + 1;
        hold on;
    end;
    if maxSR < max(Stroke_SRlap);
        maxSR = max(Stroke_SRlap);
    end;
    if minSR > min(Stroke_SRlap);
        minSR = min(Stroke_SRlap);
    end;
end;

LimGraphStroke = iter-1;
findbreath = 0;
for lap = 1:nbLap;
    Breath_Framelap = Breath_Frames(lap,:);
    li = find(Breath_Framelap ~= 0);
    if isempty(li) == 0;
        findbreath = 1;
    end;
end;
if findbreath == 0;
    graph1_Breath = [];
    LimGraphBreath = [];
else;
    maxYRightaxis = maxSR;
    minYRightaxis = minSR;
    for lap = 1:nbLap;
        Breath_Framelap = Breath_Frames(lap,:);
        li = find(Breath_Framelap ~= 0);
        if isempty(li) == 0;
            Breath_Framelap = Breath_Frames(lap,li);
            NbBreath = length(Breath_Framelap);
            
            for breath = 1:NbBreath;
                graph1_Distance(iter) = line([Breath_Framelap(breath) Breath_Framelap(breath)], ...
                    [minSR minSR+(maxSR-minSR).*0.01], ...
                    'color', [1 0 0], 'LineWidth', 2, 'Parent', axesgraph1, 'Visible', 'off');
                iter = iter + 1;
            end;
        end;
    end;
    LimGraphBreath = iter-1;
end;

set(axesgraph1, 'Visible', 'off');
set(graph1_lineMain, 'Visible', 'off');
set(graph1_lineMainTrend, 'Visible', 'off');
set(graph1_lineBottom, 'Visible', 'off');
set(graph1_gtit, 'Visible', 'off');
set(graph1_Distance, 'Visible', 'off');


%---Colorbar
offsetLeftXtitle = 185./1280;
offsetBottomColBar = 615./720;
widthXtitle = 855./1280;
if count == 1;
    axescolbar = axes('parent', gcf, 'Position', [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.065], 'units', 'Normalized', ...
        'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
        'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12);
else;
    cla(axescolbar, 'reset');
    set(axescolbar, 'Position', [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.065], 'units', 'Normalized', ...
        'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
        'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12);
end;
colbar = colorbar(axescolbar, 'location', 'northoutside', 'Ticks', tickColor,...
         'TickLabels',tickSpeedTXT, 'color', [1 1 1], 'visible', 'off');
colbar.Label.String = 'Velocity (m/s)';
colbar.Label.FontSize = 12;
colbar.Label.FontWeight = 'bold';
colbar.Label.FontName = 'Antiqua';
colbar.Limits = [0 1];
%----------------------------------------------------------




%-------------------------Interpolation--------------------------------
%Start interpolation
indexDive = find(RaceLocation(:,5) == 15); 
if isnan(RaceLocation(indexDive,3)) == 1;
    isInterpolatedDive = 1;
else;
    isInterpolatedDive = 0;
end;

%Turns interpolation
isInterpolatedTurns = zeros(nbLap-1,3);
for lap = 1:nbLap-1;
    %cumulative distance
    TurinDist = (lap*Course) - 5;
    TurOutDist = (lap*Course) + 10;
    indexIn = find(RaceLocation(:,5) == TurinDist);
    indexOut = find(RaceLocation(:,5) == TurOutDist); 
    if isnan(RaceLocation(indexIn,3)) == 1;
        isInterpolatedTurns(lap,1) = 1;
        isInterpolatedTurns(lap,3) = 1; 
    end;
    if isnan(RaceLocation(indexOut,3)) == 1;
        isInterpolatedTurns(lap,2) = 1;
        isInterpolatedTurns(lap,3) = 1;
    end;
end;

%Finish interpolation
indexFinish = find(RaceLocation(:,5) == RaceDist-5); 
if isnan(RaceLocation(indexFinish,3)) == 1;
    isInterpolatedFinish = 1;
else;
    isInterpolatedFinish = 0;
end;

if isInterpolatedDive == 0 & isempty(find(isInterpolatedTurns) == 1) == 1 & isInterpolatedFinish == 0;
    isInterpolatedSkills = 0;
else;
    isInterpolatedSkills = 1;
end;

isInterpolatedBO = BOAll(:,4);
%----------------------------------------------------------------------




%------------------Create SPARTA/LOCKER REPORT---------------------
RT = SplitsAll(1,2);
if strcmpi(valRelay, 'Flat') == 1;
    if strcmpi(StrokeType, 'Backstroke') == 1;
        if RT < 0.52;
            SplitsAll(1,2) = 0.6;
            SplitsAll(1,3) = roundn(SplitsAll(1,3) + ((0.6-RT)*framerate), 0);
            RT = 0.6;
        end;
    else;
        if RT < 0.58;
            SplitsAll(1,2) = 0.65;
            SplitsAll(1,3) = roundn(SplitsAll(1,3) + ((0.65-RT)*framerate), 0);
            RT = 0.65;
        end;
    end;
end;

RaceLocationEC = RaceLocation;
SectionCumTimeEC = SectionCumTime;
SectionSplitTimeEC = SectionSplitTime;
SectionVelEC = SectionVel;
SectionCumTimePDF = SectionCumTime;
SectionSplitTimePDF = SectionSplitTime;
SectionVelPDF = SectionVel;

Source = 3;
dataTablePacing = [];
% [dataMatCumSplitsPacing, isInterpolatedSplits, SectionVel, isInterpolatedVel, dataTableBreath] = create_pacingtable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, ...
%     StrokeType, Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
%     isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, nbLap, ...
%     RawDistanceINI, RawVelocityINI, RawTime, Breath_Frames, Stroke_Frame, Stroke_Time, BOAllINI, Last5m, RaceLocation, ...
%     SectionCumTime, SectionSplitTime, SectionVel, SectionCumTimePDF, SectionSplitTimePDF, SectionVelPDF);
dataTableBreath = create_pacingtable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, ...
    StrokeType, Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
    isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, nbLap, ...
    RawDistanceINI, RawVelocityINI, RawTime, Breath_Frames, Stroke_Frame, Stroke_Time, BOAllINI, Last5m, RaceLocation, ...
    SectionCumTime, SectionSplitTime, SectionVel, SectionCumTimePDF, SectionSplitTimePDF, SectionVelPDF);

[li,co] = size(isInterpolatedSplits);
lapDist = 5:5:(nbLap.*Course);
lapDist = NaN(1,length(lapDist));
liINI = 1;
liEND = nbZone;
for lapEC = 1:nbLap;
    lapDist(1,liEND) = lapEC.*Course;

    liINI = liEND + 1;
    liEND = liINI + nbZone - 1;
end;

SectionVelbisNew_short = reshape(SectionVelbisNew_short', 1, li*co);
SectionVelbisNew_long = reshape(SectionVelbisNew_long', 1, li*co);
SectionCumTimeNew_short = reshape(SectionCumTimeNew_short', 1, li*co);
SectionCumTimeNew_long = reshape(SectionCumTimeNew_long', 1, li*co);
isInterpolatedSplitsStore = reshape(isInterpolatedSplits_short', 1, li*co);
isInterpolatedVelStore = reshape(isInterpolatedVel_short', 1, li*co);


dataTablePacing(:,2) = SectionCumTimeNew_short';
dataTablePacing(:,3) = SectionCumTimeNew_long';
dataTablePacing(:,4) = isInterpolatedSplitsStore';
dataTablePacing(:,6) = SectionVelbisNew_short';
dataTablePacing(:,7) = SectionVelbisNew_long';
dataTablePacing(:,8) = isInterpolatedVelStore';

%---interpolate speed
dataTablePacing(:,5) = dataTablePacing(:,6);
splitDistAll = 5:5:(nbLap*Course);
lapEC = 1;
for valEC = 1:length(dataTablePacing(:,1));
    distEC = splitDistAll(valEC);
    speedEC = dataTablePacing(valEC,6);
    if isnan(speedEC) == 1 | speedEC == 0;
        %split is missing
        BOEC = BOAllINI(lapEC,3);
        if distEC >= BOEC;
            %missing split is after the BO for the lap
            %interpolate using the next vel available
            proceed = 1;
            refRow = valEC;
            while proceed == 1;
                refVel = dataTablePacing(refRow,6);
                if isnan(refVel) == 1 | refVel == 0;
                    refRow = refRow + 1;
                    if refRow > length(dataTablePacing(:,1));
                        proceed = 0;
                        refVel = lastrefVel;
                    end;
                else;
                    proceed = 0;
                end;
            end;
            lastrefVel = refVel;

            dataTablePacing(valEC,5) = refVel;
            dataTablePacing(valEC,8) = 1;
        end;                    
    end;

    indexLap = find(lapDist == distEC);
end;

%---Check NaN and interpolate splits based on speed
lapEC = 1;

if isnan(dataTablePacing(end,2)) == 1;
    %race time missing
    racetimemissing = SplitsAll(end,2);
    dataTablePacing(end,2) = racetimemissing;
end;
if isnan(dataTablePacing(end,3)) == 1;
    %race time missing
    racetimemissing = SplitsAll(end,2);
    dataTablePacing(end,3) = racetimemissing;
end;
dataTablePacing(:,1) = dataTablePacing(:,2);

for valEC = 1:length(dataTablePacing(:,1));
    distEC = splitDistAll(valEC);
    splitEC = dataTablePacing(valEC,1);

    if isnan(splitEC) == 1 | splitEC == 0;
        %split is missing
        BOEC = (BOAllINI(lapEC,3));

        if distEC >= BOEC;
            %missing split is after the BO for the lap
            %interpolate using the next vel available
            refDist = splitDistAll(valEC+1);
            refSplit = dataTablePacing(valEC+1,1);

            diffDist = refDist - distEC;
            diffSplit = diffDist ./ refVel;
            newSplit = refSplit - diffSplit;

            dataTablePacing(valEC,1) = roundn(newSplit,-2);
            dataTablePacing(valEC,4) = 1;
        end;                    
    end;

    indexLap = find(lapDist == distEC);
    if isempty(indexLap) == 0;
        lapEC = lapEC + 1;

        %Correct artefact
        dataTablePacing(indexLap,4) = 0;
    end;
end;


% [SectionSR, isInterpolatedSR, SectionSD, isInterpolatedSD, SectionNb] = create_stroketable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, StrokeType, ...
%     Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
%     isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, ...
%     nbLap, Stroke_SR, Stroke_DistanceINI, Stroke_Frame, RawDistanceINI, RawVelocityINI, ...
%     RawStroke, RawTime, BOAllINI, ...
%     RaceLocation, SectionSD, SectionSR, SectionNb, SectionSDPDF, SectionSRPDF, SecSectionNbPDF);

[li,co] = size(isInterpolatedSR);
SectionSR_short = reshape(SectionSR_short', 1, li*co);
SectionSR_long = reshape(SectionSR_long', 1, li*co);
isInterpolatedSRStore = reshape(isInterpolatedSR_short', 1, li*co);
SectionSD_short = reshape(SectionSD_short', 1, li*co);
SectionSD_long = reshape(SectionSD_long', 1, li*co);
isInterpolatedSDStore = reshape(isInterpolatedSD_short', 1, li*co);
SectionNbbis_short = reshape(SectionNbbis_short', 1, li*co);
SectionNbbis_long = reshape(SectionNbbis_long', 1, li*co);

dataTableStroke(:,2) = SectionSR_short';
dataTableStroke(:,3) = SectionSR_long';
dataTableStroke(:,4) = isInterpolatedSRStore';
%Create interpolated 5m segment in the 15m column
dataTableStroke(:,1) = dataTableStroke(:,2);
lapEC = 1;
for valEC = 1:length(dataTableStroke(:,1));
    distEC = splitDistAll(valEC);
    SREC = dataTableStroke(valEC,1);
    if isnan(SREC) == 1 | SREC == 0;
        %split is missing
        BOEC = BOAllINI(lapEC,3);
        if distEC >= BOEC;
            %missing split is after the BO for the lap
            %interpolate using the next vel available
            proceed = 1;
            refRow = valEC;
            while proceed == 1;
                refSR = dataTableStroke(refRow,1);
                if isnan(refSR) == 1 | refSR == 0;
                    refRow = refRow + 1;
                    if refRow > length(dataTableStroke(:,1));
                        proceed = 0;
                        refSR = lastrefSR;
                    end;
                else;
                    proceed = 0;
                end;
            end;
            lastrefSR = refSR;
            dataTableStroke(valEC,1) = refSR;
            dataTableStroke(valEC,4) = 1;
        end;                    
    end;

    indexLap = find(lapDist == distEC);
    if isempty(indexLap) == 0;
        lapEC = lapEC + 1;
    
        %Correct artefact
        dataTableStroke(indexLap,4) = 0;
    end;
end;

dataTableStroke(:,6) = SectionSD_short';
dataTableStroke(:,7) = SectionSD_long';
dataTableStroke(:,8) = isInterpolatedSDStore';
%---Check NaN and interpolate DPS taking the next closest value
lapEC = 1;
lastrefDPS = [];
dataTableStroke(:,5) = dataTableStroke(:,6);
%Create interpolated 5m segment in the 15m column
for valEC = 1:length(dataTableStroke(:,1));
    distEC = splitDistAll(valEC);
    DPSEC = dataTableStroke(valEC,6);
    if isnan(DPSEC) == 1 | DPSEC == 0;
        %DPS is missing
        BOEC = (BOAllINI(lapEC,3));
        if distEC >= BOEC;
            %missing DPS is after the BO for the lap
            %interpolate using the next DPS available
            proceed = 1;
            refRow = valEC;
            while proceed == 1;
                refDPS = dataTableStroke(refRow,6);
                if isnan(refDPS) == 1 | refDPS == 0;
                    refRow = refRow + 1;
                    if refRow > length(dataTableStroke(:,6));
                        proceed = 0;
                        refDPS = lastrefDPS;
                    end;
                else;
                    proceed = 0;
                end;
            end;
            lastrefDPS = refDPS;
            dataTableStroke(valEC,5) = refDPS;
            dataTableStroke(valEC,8) = 1;
        end;                    
    end;

    indexLap = find(lapDist == distEC);
    if isempty(indexLap) == 0;
        lapEC = lapEC + 1;

        %Correct artefact
        dataTableStroke(indexLap,8) = 0;
    end;
end;
dataTableStroke(:,9) = SectionNbbis_short';
dataTableStroke(:,10) = SectionNbbis_short';
dataTableStroke(:,11) = SectionNbbis_long';
lapEC = 1;



dataTableSkill = create_skilltable_SP1Report_synchroniser(Athletename, Source, ...
    framerate, RaceDist, StrokeType, Meet, Year, ...
    valRelay, detailRelay, Course, Stage, SplitsAll, nbLap, ...
    RaceLocation, TotalSkillTimeINI, Turn_TimeINI, Turn_TimeInINI, Turn_TimeOutINI, ...
    DiveT15INI, RT, StartUWVelocity, StartEntryDist, StartUWDist, StartUWTime, ...
    KicksNb, BOAllINI, BOEff, VelAfterBO, VelBeforeBO, ...
    ApproachEff, ApproachSpeed2CycleAll, ApproachSpeedLastCycleAll, GlideLastStrokeEC, Last5m);

if Course == 25;
    metaData_PDF{1,1} = [num2str(RaceDist) 'm ' StrokeType ' (SCM)'];
else;
    metaData_PDF{1,1} = [num2str(RaceDist) 'm ' StrokeType ' (LCM)'];
end;
metaData_PDF{2,1} = DOB;
index = strfind(VenueEC, '''');
if isempty(index) == 0;
    VenueEC(index) = [];
end;
eval(['metaData_PDF{3,1} = ' '''' VenueEC '''' ';']);
eval(['metaData_PDF{4,1} = ' '''' AnalysisDate '''' ';']);
metaData_PDF{5,1} = framerate;
metaData_PDF{6,1} = 2; %Source
eval(['metaData_PDF{7,1} = ' '''' RaceDateMod '''' ';']);
%------------------------------------------------------------------



%-----------------------Store data-------------------------
onlinefinename = raceDataMetaNew{1,1};
if onlinefinename < 0;
    onlinefinename = ['m' num2str(abs(onlinefinename))];
else;
    onlinefinename = ['p' num2str(abs(onlinefinename))];
end;
% if isempty(onlinefinename) == 1;
%     onlinefinename = [lower(randseq(20,'alphabet','amino')) '-' num2str(SwimsEC{1,1}) '-' num2str(SwimsEC{1,2}) '-' lower(randseq(20,'alphabet','dna')) ];
% end;
uid = ['A' onlinefinename 'A'];
li = findstr(uid, '-');
uid(li) = '_';

index = strfind(Meet, ' ');
if length(index) == 1;
    competitionName = [Meet(1:index-1) Meet(index+1:end)];

elseif length(index) > 1;
    competitionName = [];
    for i = 1:length(index)+1;
        if i == 1;
            competitionName = [competitionName Meet(1 : index(i)-1)];
        elseif i == length(index)+1;
            competitionName = [competitionName Meet(index(i-1)+1 : end)];
        else;
            competitionName = [competitionName Meet(index(i-1)+1 : index(i)-1)];
        end;
    end;
else;
    competitionName = Meet;
end;
competitionName = [competitionName Year];
filenameDBout = ['s3://sparta2-prod/sparta2-data/' Year '/' competitionName '/' uid '.mat'];

eval([uid '.Source = 3;']);
eval([uid '.RawBreath = RawBreath;']);
eval([uid '.RawDistance = RawDistance;']);
eval([uid '.RawDistanceINI = RawDistanceINI;']);
eval([uid '.RawBreakout = RawBreakout;']);
eval([uid '.RawVelocity = RawVelocity;']);
eval([uid '.RawVelocityRaw = RawVelocityRaw;']);
eval([uid '.RawVelocityTrend = RawVelocityTrend;']);
eval([uid '.RawVelocityINI = RawVelocityINI;']);
eval([uid '.RawKick = RawKick;']);
eval([uid '.RawTime = RawTime;']);
eval([uid '.RawStroke = RawStroke;']);
        
eval([uid '.FilenameNew = FilenameNew;']);
eval([uid '.Athletename = Athletename;']);
eval([uid '.AthletenameFull = AthletenameFull;']);
eval([uid '.DOB = DOB;']);
eval([uid '.Firstname = Firstname;']);
eval([uid '.Country = Country;']);
eval([uid '.Gender = Gender;']);
eval([uid '.StrokeType = StrokeType;']);
eval([uid '.Lane = Lane;']);
eval([uid '.Lastname = Lastname;']);
eval([uid '.Year = Year;']);
eval([uid '.Meet = Meet;']);
eval([uid '.Stage = Stage;']);
eval([uid '.AnalysisDate = AnalysisDate;']);
eval([uid '.RaceDate = RaceDateMod;']);
eval([uid '.Venue = VenueEC;']);
eval([uid '.NbLap = nbLap;']);
eval([uid '.Course = Course;']);
eval([uid '.RaceDist = RaceDist;']);
eval([uid '.FrameRate = framerate;']);
RT = SplitsAll(1,2);
if strcmpi(valRelay, 'Flat') == 1;
    if strcmpi(StrokeType, 'Backstroke') == 1;
        if RT < 0.52;
            SplitsAll(1,2) = 0.6;
            SplitsAll(1,3) = roundn(SplitsAll(1,3) + ((0.6-RT)*framerate), 0);
            RT = 0.6;
        end;
    else;
        if RT < 0.58;
            SplitsAll(1,2) = 0.65;
            SplitsAll(1,3) = roundn(SplitsAll(1,3) + ((0.65-RT)*framerate), 0);
            RT = 0.65;
        end;
    end;
end;
eval([uid '.RT = RT;']);
eval([uid '.SplitsAll = SplitsAll;']);
eval([uid '.valRelay = valRelay;']);
eval([uid '.detailRelay = detailRelay;']);
        
eval([uid '.Kick_Frames = Kick_Frames;']);
eval([uid '.KicksNb = KicksNb;']);
eval([uid '.Breath_Frames = Breath_Frames;']);
eval([uid '.BreathsNb = BreathsNb;']);
eval([uid '.Stroke_Frame = Stroke_Frame;']);
eval([uid '.Stroke_Count = Stroke_Number;']);
eval([uid '.Stroke_SR = Stroke_SR;']);
eval([uid '.Stroke_Time = Stroke_Time;']);
eval([uid '.Stroke_Distance = Stroke_Distance;']);
eval([uid '.Stroke_DistanceINI = Stroke_DistanceINI;']);
eval([uid '.Stroke_SI = Stroke_SI;']);
eval([uid '.Stroke_SIINI = Stroke_SIINI;']);
eval([uid '.Stroke_Velocity = Stroke_Velocity;']);
eval([uid '.Stroke_VelocityMax = Stroke_VelocityMax;']);
eval([uid '.Stroke_VelocityMin = Stroke_VelocityMin;']);
eval([uid '.Stroke_VelocityINI = Stroke_VelocityINI;']);
eval([uid '.VelLapAv = VelLapAv;']);
eval([uid '.LimGraphStroke = LimGraphStroke;']);
eval([uid '.LimGraphBreath = LimGraphBreath;']);
TotalSkillTime = roundn(TotalSkillTime,-2);
eval([uid '.TotalSkillTime = TotalSkillTime;']);
TotalSkillTimeINI = roundn(TotalSkillTimeINI,-2);
eval([uid '.TotalSkillTimeINI = TotalSkillTimeINI;']);
DiveT15 = roundn(DiveT15,-2);
eval([uid '.DiveT15 = DiveT15;']);
Last5m = roundn(Last5m,-2);
eval([uid '.Last5m = Last5m;']);
DiveT15INI = roundn(DiveT15INI,-2);
eval([uid '.DiveT15INI = DiveT15INI;']);
Last5mINI = roundn(Last5mINI,-2);
eval([uid '.Last5mINI = Last5mINI;']);
eval([uid '.ApproachEff = ApproachEff;']);
eval([uid '.ApproachSpeed2CycleAll = ApproachSpeed2CycleAll;']);
eval([uid '.ApproachSpeedLastCycleAll = ApproachSpeedLastCycleAll;']);
eval([uid '.BOAll = BOAll;']);
eval([uid '.BOAllINI = BOAllINI;']);
eval([uid '.BOEff = BOEff;']);
eval([uid '.BOEffCorr = BOEffCorr;']);
eval([uid '.VelAfterBO = VelAfterBO;']);
eval([uid '.VelBeforeBO = VelBeforeBO;']);
eval([uid '.GlideLastStroke = GlideLastStrokeEC;']);
Turn_BODist = roundn(Turn_BODist,-2);
eval([uid '.Turn_BODist = Turn_BODist;']);
Turn_Time = roundn(Turn_Time,-2);
eval([uid '.Turn_Time = Turn_Time;']);
Turn_TimeIn = roundn(Turn_TimeIn,-2);
eval([uid '.Turn_TimeIn = Turn_TimeIn;']);
Turn_TimeOut = roundn(Turn_TimeOut,-2);
eval([uid '.Turn_TimeOut = Turn_TimeOut;']);
Turn_TimeINI = roundn(Turn_TimeINI,-2);
eval([uid '.Turn_TimeINI = Turn_TimeINI;']);
Turn_TimeInINI = roundn(Turn_TimeInINI,-2);
eval([uid '.Turn_TimeInINI = Turn_TimeInINI;']);
Turn_TimeOutINI = roundn(Turn_TimeOutINI,-2);
eval([uid '.Turn_TimeOutINI = Turn_TimeOutINI;']);
TurnsAv = roundn(TurnsAv,-2);
eval([uid '.TurnsAv = TurnsAv;']);
TurnsAvBODist = roundn(TurnsAvBODist,-2);
eval([uid '.TurnsAvBODist = TurnsAvBODist;']);
eval([uid '.TurnsAvBOEff = TurnsAvBOEff;']);
eval([uid '.TurnsAvKicks = TurnsAvKicks;']);
eval([uid '.TurnsAvVelAfterBO = TurnsAvVelAfterBO;']);
eval([uid '.TurnsAvVelBeforeBO = TurnsAvVelBeforeBO;']);
        
eval([uid '.TurnsTotal = TurnsTotal;']);
eval([uid '.TurnsTotalINI = TurnsTotalINI;']);
eval([uid '.TurnsAvKicks = TurnsAvKicks;']);
eval([uid '.StartUWVelocity = StartUWVelocity;']);
eval([uid '.StartEntryDist = StartEntryDist;']);
eval([uid '.StartUWDist = StartUWDist;']);
eval([uid '.StartUWTime = StartUWTime;']);
eval([uid '.SpeedDecaySprintRange = SpeedDecaySprintRange;']);
eval([uid '.SpeedDecaySemiRange = SpeedDecaySemiRange;']);
eval([uid '.SpeedDecayLongRange = SpeedDecayLongRange;']);
eval([uid '.SpeedDecaySprintMid = SpeedDecaySprintMid;']);
eval([uid '.SpeedDecaySemiMid = SpeedDecaySemiMid;']);
eval([uid '.SpeedDecayLongMid = SpeedDecayLongMid;']);
eval([uid '.SpeedDecayRef = SpeedDecayRef;']);
eval([uid '.isInterpolatedVel = isInterpolatedVel;']);
eval([uid '.isInterpolatedSplits = isInterpolatedSplits;']);
eval([uid '.isInterpolatedSR = isInterpolatedSR;']);
eval([uid '.isInterpolatedSD = isInterpolatedSD;']);
eval([uid '.RaceLocation = RaceLocation;']);
eval([uid '.SectionCumTime = SectionCumTime;']);
eval([uid '.SectionSplitTime = SectionSplitTime;']);
eval([uid '.SectionVel = SectionVel;']);
eval([uid '.SectionSR = SectionSR;']);
eval([uid '.SectionSD = SectionSD;']);
eval([uid '.SectionNb = SectionNb;']);

graph1PacingAxes = axesgraph1;
eval([uid '.graph1PacingAxes = axesgraph1;']);
eval([uid '.graph1_lineMain = graph1_lineMain;']);
eval([uid '.graph1_lineMainTrend = graph1_lineMainTrend;']);
eval([uid '.graph1PacingGraphDistance = graph1_Distance;']);
eval([uid '.graph1PacingTitle = graph1_gtit;']);
eval([uid '.graph1Pacingaxescolbar = axescolbar;']);
eval([uid '.graph1Pacingcolbar = colbar;']);
eval([uid '.graph1Pacing_maxYLeft = maxDistance;']);
eval([uid '.graph1Pacing_minYLeft = minDistance;']);
eval([uid '.graph1Pacing_maxYRight = maxSR;']);
eval([uid '.graph1Pacing_minYRight = minSR;']);

format longG;
t = now;
DateString = datestr(datetime(t,'ConvertFrom','datenum'));


lapLim = Course:Course:RaceDist;
dataTableRefDist = [5:5:RaceDist]';
if RaceDist <= 100;
    colInterestVel = 6;
    colInterestSR = 2;
    colInterestDPS = 6;
else;
    colInterestVel = 7;
    colInterestSR = 3;
    colInterestDPS = 7;
end;

avVELlap = [];
avSRlap = [];
avDPSlap = [];
% indexLapIni = 1;
% for lapEC = 1:nbLap;
%     indexLapEnd = find(dataTableRefDist == lapLim(lapEC));
%     
%     dataVel = dataTablePacing(indexLapIni:indexLapEnd, colInterestVel);
%     indexNan = find(isnan(dataVel) == 1);
%     dataVel(indexNan) = [];
%     avVELlap = [avVELlap mean(dataVel)];
% 
%     dataSR = dataTableStroke(indexLapIni:indexLapEnd, colInterestSR);
%     indexNan = find(isnan(dataSR) == 1);
%     dataSR(indexNan) = [];
%     avSRlap = [avSRlap mean(dataSR)];
% 
%     dataDPS = dataTableStroke(indexLapIni:indexLapEnd, colInterestDPS);
%     indexNan = find(isnan(dataDPS) == 1);
%     dataDPS(indexNan) = [];
%     avDPSlap = [avDPSlap mean(dataDPS)];
% 
%     indexLapIni = indexLapEnd;
% end;
if Course == 50;
    if RaceDist == 50;
        validIndex = [5 7 9];
    elseif RaceDist == 100;
        validIndex = [NaN 5 7 9; 13 15 17 19];
    elseif RaceDist == 150;
        validIndex = [5 10; 15 20; 25 30];
    elseif RaceDist == 200;
        validIndex = [5 10; 15 20; 25 30; 35 40];
    elseif RaceDist == 400;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80];
    elseif RaceDist == 800;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80; ...
            85 90; 95 100; 105 110; 115 120; 125 130; 135 140; 145 150; 155 160];
    elseif RaceDist == 1500;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80; ...
            85 90; 95 100; 105 110; 115 120; 125 130; 135 140; 145 150; 155 160; ...
            165 170; 175 180; 185 190; 195 200; 205 210; 215 220; 225 230; 235 240; ...
            245 250; 255 260; 265 270; 275 280; 285 290; 295 300];
    end;

elseif Course == 25;
    if RaceDist == 50;
        validIndex = [4; 9];
    elseif RaceDist == 100;
        validIndex = [4; 9; 14; 19];
    elseif RaceDist == 150;
        validIndex = [4; 9; 14; 19; 24; 29];
    elseif RaceDist == 200;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39];
    elseif RaceDist == 400;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79];
    elseif RaceDist == 800;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79; ...
            84; 89; 94; 99; 104; 109; 114; 119; 124; 129; 134; 139; 144; 149; 154; 159];
    elseif RaceDist == 1500;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79; ...
            84; 89; 94; 99; 104; 109; 114; 119; 124; 129; 134; 139; 144; 149; 154; 159; ...
            164; 169; 174; 179; 184; 189; 194; 199; 204; 209; 214; 219; 224; 229; 234; 239; ...
            244; 249; 254; 259; 264; 269; 274; 279; 284; 289; 294; 299];
    end;
end;
VelLapAll = [];
dataVELAll = [];
if RaceDist <= 100;
    SectionVelbisNew_short = SectionVelbisNew_short';
    for lapEC = 1:nbLap;
        validIndexLap = validIndex(lapEC,:);
        indexNaN = find(isnan(validIndexLap) == 1);
        validIndexLap(indexNaN) = [];
        dataVelLap = SectionVelbisNew_short(validIndexLap, :);        
        index = find(isnan(dataVelLap) == 0);
        dataVelLap = dataVelLap(index);
        dataVELAll = [dataVELAll; dataVelLap];
        VelLapAll(lapEC) = mean(dataVelLap);
    end;
else;
    SectionVelbisNew_long = SectionVelbisNew_long';
    for lapEC = 1:nbLap;
        validIndexLap = validIndex(lapEC,:);
        indexNaN = find(isnan(validIndexLap) == 1);
        validIndexLap(indexNaN) = [];
        dataVelLap = SectionVelbisNew_long(validIndexLap, :);
        index = find(isnan(dataVelLap) == 0);
        dataVelLap = dataVelLap(index);
        dataVELAll = [dataVELAll; dataVelLap];
        VelLapAll(lapEC) = mean(dataVelLap);
    end;
end;


%Average DPS per Lap
DPSLapAll = [];
dataDPSAll = [];
if RaceDist <= 100;
    SectionSD_short = SectionSD_short';
    for lapEC = 1:nbLap;
        validIndexLap = validIndex(lapEC,:);
        indexNaN = find(isnan(validIndexLap) == 1);
        validIndexLap(indexNaN) = [];
        dataDPSLap = SectionSD_short(validIndexLap, :);        
        index = find(isnan(dataDPSLap) == 0);
        dataDPSLap = dataDPSLap(index);
        dataDPSAll = [dataDPSAll; dataDPSLap];
        DPSLapAll(lapEC) = mean(dataDPSLap);
    end;
else;
    SectionSD_long = SectionSD_long';
    for lapEC = 1:nbLap;
        validIndexLap = validIndex(lapEC,:);
        indexNaN = find(isnan(validIndexLap) == 1);
        validIndexLap(indexNaN) = [];
        dataDPSLap = SectionSD_long(validIndexLap, :);        
        index = find(isnan(dataDPSLap) == 0);
        dataDPSLap = dataDPSLap(index);
        dataDPSAll = [dataDPSAll; dataDPSLap];
        DPSLapAll(lapEC) = mean(dataDPSLap);
    end;
end;


%Average SR per Lap
if Course == 50;
    if RaceDist == 50;
        validIndex = [3 5 7 9 10];
    elseif RaceDist == 100;
        validIndex = [3 5 7 9 10; 13 15 17 19 20];
    elseif RaceDist == 150;
        validIndex = [5 10; 15 20; 25 30];
    elseif RaceDist == 200;
        validIndex = [5 10; 15 20; 25 30; 35 40];
    elseif RaceDist == 400;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80];
    elseif RaceDist == 800;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80; ...
            85 90; 95 100; 105 110; 115 120; 125 130; 135 140; 145 150; 155 160];
    elseif RaceDist == 1500;
        validIndex = [5 10; 15 20; 25 30; 35 40; 45 50; 55 60; 65 70; 75 80; ...
            85 90; 95 100; 105 110; 115 120; 125 130; 135 140; 145 150; 155 160; ...
            165 170; 175 180; 185 190; 195 200; 205 210; 215 220; 225 230; 235 240; ...
            245 250; 255 260; 265 270; 275 280; 285 290; 295 300];
    end;

elseif Course == 25;
    if RaceDist == 50;
        validIndex = [4; 9];
    elseif RaceDist == 100;
        validIndex = [4; 9; 14; 19];
    elseif RaceDist == 150;
        validIndex = [4; 9; 14; 19; 24; 29];
    elseif RaceDist == 200;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39];
    elseif RaceDist == 400;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79];
    elseif RaceDist == 800;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79; ...
            84; 89; 94; 99; 104; 109; 114; 119; 124; 129; 134; 139; 144; 149; 154; 159];
    elseif RaceDist == 1500;
        validIndex = [4; 9; 14; 19; 24; 29; 34; 39; 43; 39; 54; 59; 64; 69; 74; 79; ...
            84; 89; 94; 99; 104; 109; 114; 119; 124; 129; 134; 139; 144; 149; 154; 159; ...
            164; 169; 174; 179; 184; 189; 194; 199; 204; 209; 214; 219; 224; 229; 234; 239; ...
            244; 249; 254; 259; 264; 269; 274; 279; 284; 289; 294; 299];
    end;
end;

SRLapAll = [];
dataSRAll = [];
if RaceDist <= 100;
    SectionSR_short = SectionSR_short';
    for lapEC = 1:nbLap;
        dataSRLap = SectionSR_short(validIndex(lapEC,:), :);        
        index = find(isnan(dataSRLap) == 0);
        dataSRLap = dataSRLap(index);
        dataSRAll = [dataSRAll; dataSRLap];
        SRLapAll(lapEC) = mean(dataSRLap);
    end;
else;
    SectionSR_long = SectionSR_long';
    for lapEC = 1:nbLap;
        dataSRLap = SectionSR_long(validIndex(lapEC,:), :);        
        index = find(isnan(dataSRLap) == 0);
        dataSRLap = dataSRLap(index);
        dataSRAll = [dataSRAll; dataSRLap];
        SRLapAll(lapEC) = mean(dataSRLap);
    end;
end;

avVELlap = VelLapAll;
avVEL = mean(dataVELAll);
avSRlap = SRLapAll;
avSR = mean(dataSRAll);
avDPSlap = DPSLapAll;
avDPS = mean(dataDPSAll);

avSIlap = [avVELlap'.*avDPSlap']';
avSI = mean(avSIlap);

if count == 1;
    FullDB_GreenEye{1,1} = 'File';
    FullDB_GreenEye{1,2} = 'Name';
    FullDB_GreenEye{1,3} = 'Distance';
    FullDB_GreenEye{1,4} = 'Stroke';
    FullDB_GreenEye{1,5} = 'Gender';
    FullDB_GreenEye{1,6} = 'Round';
    FullDB_GreenEye{1,7} = 'Meet';
    FullDB_GreenEye{1,8} = 'Year';
    FullDB_GreenEye{1,9} = 'Lane';
    FullDB_GreenEye{1,10} = 'Course';
    FullDB_GreenEye{1,11} = 'Type';
    FullDB_GreenEye{1,12} = 'Category';
    FullDB_GreenEye{1,13} = 'DOB';
    FullDB_GreenEye{1,14} = 'Race Time';
    FullDB_GreenEye{1,15} = 'Skills (s)';
    FullDB_GreenEye{1,16} = 'Free Swim (s)';
    FullDB_GreenEye{1,17} = 'Drop-off (s)';
    FullDB_GreenEye{1,18} = 'Speed (Av./Max.) (m/s)';
    FullDB_GreenEye{1,19} = 'Av. SR (Av./Max.) (str/min)';
    FullDB_GreenEye{1,20} = 'Av. DPS (Av./Max.) (m)';
    FullDB_GreenEye{1,21} = 'Block (s)';
    FullDB_GreenEye{1,22} = 'Start (s)';
    FullDB_GreenEye{1,23} = 'Entry Dist (m)';
    FullDB_GreenEye{1,24} = 'Start UW. Speed (m/s)';
    FullDB_GreenEye{1,25} = 'Start BO. Dist (m) (Kicks)';
    FullDB_GreenEye{1,26} = 'Start BO. Skill (%)';
    FullDB_GreenEye{1,27} = 'Av. Turn (s) [in / out]';
    FullDB_GreenEye{1,28} = 'Turn App. Skill (%)';
    FullDB_GreenEye{1,29} = 'Turn BO. Dist (m) (Av. Kicks)';
    FullDB_GreenEye{1,30} = 'Turn BO. Skill (%)';
    FullDB_GreenEye{1,31} = 'Av. Stroke Index (m2/s/str)';
    FullDB_GreenEye{1,32} = 'Av. Swimming Speed (m/s)';
    FullDB_GreenEye{1,33} = 'Av. Stroke Rate (str/min)';
    FullDB_GreenEye{1,34} = 'Av. DPS (m)';
    FullDB_GreenEye{1,35} = 'Country';
    FullDB_GreenEye{1,36} = 'MeetID';
    FullDB_GreenEye{1,37} = 'AV. Turn In (s)';
    FullDB_GreenEye{1,38} = 'AV. Turn Out (s)';
    FullDB_GreenEye{1,39} = 'AV. Turn Tot (s)';
    FullDB_GreenEye{1,40} = 'AthleteID';
    FullDB_GreenEye{1,41} = 'Finish Time (s)';
    FullDB_GreenEye{1,42} = 'Speed Decay (% of time)';
    FullDB_GreenEye{1,43} = 'Speed Decay Ref (50% Max Speed)';
    FullDB_GreenEye{1,44} = 'Dist App (m)';
    FullDB_GreenEye{1,45} = 'Time App (s)';
    FullDB_GreenEye{1,46} = 'Eff App (%)';
    FullDB_GreenEye{1,47} = 'SI per lap';
    FullDB_GreenEye{1,48} = 'Speed per lap';
    FullDB_GreenEye{1,49} = 'SR per lap';
    FullDB_GreenEye{1,50} = 'DPS per lap';
    FullDB_GreenEye{1,51} = 'Splits per lap';
    FullDB_GreenEye{1,52} = 'All Turns';
    FullDB_GreenEye{1,53} = 'Relay Type';
    FullDB_GreenEye{1,54} = 'All turn UW. Speed (m/s)';
    FullDB_GreenEye{1,55} = 'Av turn UW. Speed (m/s)';
    FullDB_GreenEye{1,56} = 'Analysis Date';
    FullDB_GreenEye{1,57} = 'Race Date';
    FullDB_GreenEye{1,58} = 'Source';
    FullDB_GreenEye{1,59} = 'SpeedDecaySemiRange';
    FullDB_GreenEye{1,60} = 'SpeedDecayLongRange';
    FullDB_GreenEye{1,61} = 'SpeedDecaySprintMid';
    FullDB_GreenEye{1,62} = 'SpeedDecaySemiMid';
    FullDB_GreenEye{1,63} = 'SpeedDecayLongMid';
    FullDB_GreenEye{1,64} = 'Kick Count';
    FullDB_GreenEye{1,65} = 'JSON file';
    FullDB_GreenEye{1,66} = 'Data file';
    FullDB_GreenEye{1,67} = 'Metadata_PDF';
    FullDB_GreenEye{1,68} = 'Data Pacing PDF';
    FullDB_GreenEye{1,69} = 'Data Breath PDF';
    FullDB_GreenEye{1,70} = 'Data Stroke PDF';
    FullDB_GreenEye{1,71} = 'Data Skills PDF';
end;

if count == 1;
    li = 1;
else;
    li = length(uidDB_GreenEye(:,1))+1;
end;            
uidDB_GreenEye{li,1} = onlinefinename;
uidDB_GreenEye{li,2} = FilenameNew;
uidDB_GreenEye{li,3} = Athletename;
uidDB_GreenEye{li,4} = num2str(RaceDist);
uidDB_GreenEye{li,5} = StrokeType;
uidDB_GreenEye{li,6} = Stage;
uidDB_GreenEye{li,7} = Lane;
uidDB_GreenEye{li,8} = Meet;
uidDB_GreenEye{li,9} = Year;
uidDB_GreenEye{li,10} = Gender;
uidDB_GreenEye{li,11} = Course;
uidDB_GreenEye{li,12} = SplitsAll(end,2);
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
uidDB_GreenEye{li,13} = 'na';
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
texterror = '';
uidDB_GreenEye{li,14} = texterror;
uidDB_GreenEye{li,15} = AthleteId;
uidDB_GreenEye{li,16} = CompetitionID;
uidDB_GreenEye{li,17} = BOEffCorr(1);
uidDB_GreenEye{li,18} = TurnsAvBOEffCorr;
uidDB_GreenEye{li,19} = avSI;
uidDB_GreenEye{li,20} = avVEL;
uidDB_GreenEye{li,21} = Country;
uidDB_GreenEye{li,22} = SpeedDecaySprintRange;
uidDB_GreenEye{li,23} = SpeedDecayRef;
uidDB_GreenEye{li,24} = valRelay;
uidDB_GreenEye{li,25} = detailRelay;
uidDB_GreenEye{li,26} = 3; %Source
uidDB_GreenEye{li,27} = SpeedDecaySemiRange;
uidDB_GreenEye{li,28} = SpeedDecayLongRange;
uidDB_GreenEye{li,29} = SpeedDecaySprintMid;
uidDB_GreenEye{li,30} = SpeedDecaySemiMid;
uidDB_GreenEye{li,31} = SpeedDecayLongMid;
uidDB_GreenEye{li,32} = filenameDBout;
uidDB_GreenEye{li,33} = 'None';
uidDB_GreenEye{li,34} = DateString; %always last column

    
if count == 1;
    li = 2;
else;
    li = length(FullDB_GreenEye(:,1))+1;
end;
FullDB_GreenEye{li,1} = onlinefinename;
FullDB_GreenEye{li,2} = AthletenameFull;
FullDB_GreenEye{li,3} = num2str(RaceDist);
FullDB_GreenEye{li,4} = StrokeType;
FullDB_GreenEye{li,5} = Gender;
FullDB_GreenEye{li,6} = Stage;
FullDB_GreenEye{li,7} = Meet;
FullDB_GreenEye{li,8} = Year;
FullDB_GreenEye{li,9} = Lane;
FullDB_GreenEye{li,10} = num2str(Course);
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
FullDB_GreenEye{li,11} = valRelay;
FullDB_GreenEye{li,12} = Paralympic;
FullDB_GreenEye{li,13} = DOB;
FullDB_GreenEye{li,14} = timeSecToStr(SplitsAll(end,2));
%     FullDB_GreenEye{li,15} = timeSecToStr(TotalSkillTime);
if isInterpolatedSkills == 1;
    FullDB_GreenEye{li,15} = [timeSecToStr(TotalSkillTimeINI) ' !'];
else;
    FullDB_GreenEye{li,15} = timeSecToStr(TotalSkillTimeINI);
end;
%     FullDB_GreenEye{li,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTime,-2));
FullDB_GreenEye{li,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2));
FullDB_GreenEye{li,17} = TimeDropOff;
FullDB_GreenEye{li,18} = MaxVelString;
FullDB_GreenEye{li,19} = MaxSR;
FullDB_GreenEye{li,20} = MaxSD;
FullDB_GreenEye{li,21} = dataToStr(RT,2);
%     FullDB_GreenEye{li,22} = dataToStr(DiveT15);

if isInterpolatedDive == 1;
    FullDB_GreenEye{li,22} = [dataToStr(DiveT15INI,2) ' !'];
else;
    FullDB_GreenEye{li,22} = dataToStr(DiveT15INI,2);
end;
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
if isempty(StartEntryDist) == 1;
    FullDB_GreenEye{li,23} = 'na'; %Entry
    FullDB_GreenEye{li,24} = 'na'; %UW Speed
else;
    FullDB_GreenEye{li,23} = dataToStr(StartEntryDist,2); %Entry
    FullDB_GreenEye{li,24} = dataToStr(StartUWVelocity,2); %UW Speed
end;
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%     FullDB_GreenEye{li,25} = dataToStr(roundn(BOAll(1,3),-2));
interpolBO = find(isInterpolatedBO(:,1) == 1);
if isempty(interpolBO) == 0;
    FullDB_GreenEye{li,25} = [dataToStr(BOAllINI(1,3),1) ' !'];
else;
    FullDB_GreenEye{li,25} = dataToStr(BOAllINI(1,3),1);
end;
if isempty(KicksNb) == 0;
    if KicksNb(1) == 0;
        FullDB_GreenEye{li,25} = [dataToStr(BOAllINI(1,3),1) '  (na)'];
    else;
        KickTXT = num2str(KicksNb(1));
        FullDB_GreenEye{li,25} = [dataToStr(BOAllINI(1,3),1) '  (' KickTXT ' kicks)'];
    end;
else;
    FullDB_GreenEye{li,25} = [dataToStr(BOAllINI(1,3),1) '  (na)'];
end;
val1 = dataToStr(BOEff(1).*100,1);
val2 = dataToStr(VelBeforeBO(1),2);
val3 = dataToStr(VelAfterBO(1),2);
val4 = dataToStr(BOEffCorr(1).*100,1);    
FullDB_GreenEye{li,26} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
%     FullDB_GreenEye{li,27} = Turn_TimeTXT;

index = find(isInterpolatedTurns == 1);
if isempty(index) == 0;
    FullDB_GreenEye{li,27} = [Turn_TimeTXTINI ' !'];
else;
    FullDB_GreenEye{li,27} = Turn_TimeTXTINI;
end;

val1 = dataToStr(mean(ApproachEff(1:end)).*100,1);
val2 = dataToStr(mean(ApproachSpeed2CycleAll(1:end)),2);
val3 = dataToStr(mean(ApproachSpeedLastCycleAll(1:end)),2);
FullDB_GreenEye{li,28} = [val1 '  [' val2 ' / ' val3 ']'];
%     FullDB_GreenEye{li,29} = Turn_BODistTXT;
if Course == 50;
    if RaceDist == 50;
        FullDB_GreenEye{li,29} = [Turn_BODistTXTINI '  (na)'];
    else;
        if isempty(KicksNb) == 0
            if roundn(mean(KicksNb(2:end)),0) == 0;
                FullDB_GreenEye{li,29} = [Turn_BODistTXTINI '  (na)'];
            else;
                KickTXT = num2str(roundn(mean(KicksNb(2:end)),0));
                FullDB_GreenEye{li,29} = [Turn_BODistTXTINI '  (' KickTXT ' kicks)'];
            end;
        else;
            FullDB_GreenEye{li,29} = [Turn_BODistTXTINI '  (na)'];
        end;
    end;
else
    if isempty(KicksNb) == 0
        if roundn(mean(KicksNb(2:end)),0) == 0;
            FullDB_GreenEye{li,29} = [Turn_BODistTXTINI '  (na)'];
        else;
            KickTXT = num2str(roundn(mean(KicksNb(2:end)),0));
            FullDB_GreenEye{li,29} = [Turn_BODistTXTINI '  (' KickTXT ' kicks)'];
        end;
    else;
        FullDB_GreenEye{li,29} = [Turn_BODistTXTINI '  (na)'];
    end;
end;
val1 = dataToStr(mean(BOEff(2:end)).*100,1);
val2 = dataToStr(mean(VelBeforeBO(2:end)),2);
val3 = dataToStr(mean(VelAfterBO(2:end)),2);
val4 = dataToStr(mean(BOEffCorr(2:end).*100),1);
FullDB_GreenEye{li,30} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
FullDB_GreenEye{li,31} = dataToStr(avSI,2);
FullDB_GreenEye{li,32} = dataToStr(avVEL,2);
FullDB_GreenEye{li,33} = dataToStr(avSR,1);
FullDB_GreenEye{li,34} = dataToStr(avDPS,2);
FullDB_GreenEye{li,35} = Country;  
FullDB_GreenEye{li,36} = ['A' num2str(competitionId) '_' Year 'A'];
if RaceDist == 50;
    FullDB_GreenEye{li,37} = 'na';
    FullDB_GreenEye{li,38} = 'na';
    FullDB_GreenEye{li,39} = 'na';
else;
    if isempty(turnAll) == 0;
        index = find(turnAll(:,3) == 1);
    else;
        index = 1;
    end;
    if isempty(index) == 0;
        FullDB_GreenEye{li,37} = [dataToStr(TurnsAvINI(1,1),2) ' !'];
        FullDB_GreenEye{li,38} = [dataToStr(TurnsAvINI(1,2),2) ' !'];
        FullDB_GreenEye{li,39} = [dataToStr(TurnsAvINI(1,3),2) ' !'];
    else;
        FullDB_GreenEye{li,37} = dataToStr(TurnsAvINI(1,1),2);
        FullDB_GreenEye{li,38} = dataToStr(TurnsAvINI(1,2),2);
        FullDB_GreenEye{li,39} = dataToStr(TurnsAvINI(1,3),2);
    end;
end;
FullDB_GreenEye{li,40} = AthleteId;
FullDB_GreenEye{li,41} = Last5mINI;
FullDB_GreenEye{li,42} = SpeedDecaySprintRange;
FullDB_GreenEye{li,43} = SpeedDecayRef;
FullDB_GreenEye{li,44} = GlideLastStrokeEC(3,end);
FullDB_GreenEye{li,45} = GlideLastStrokeEC(4,end);
FullDB_GreenEye{li,46} = ApproachEff(1,end);
FullDB_GreenEye{li,47} = avSIlap;
FullDB_GreenEye{li,48} = avVELlap;
FullDB_GreenEye{li,49} = avSRlap;
FullDB_GreenEye{li,50} = avDPSlap;
for lap = 2:length(SplitsAll(:,2));
    if lap == 2;
        SplitsLap(lap) = SplitsAll(lap,2);
    else;
        SplitsLap(lap) = SplitsAll(lap,2) - SplitsAll(lap-1,2);
    end;
end;
SplitsLap = SplitsLap(2:end);
FullDB_GreenEye{li,51} = SplitsLap;
if RaceDist == 50;
    FullDB_GreenEye{li,52} = 'na';
else;
    FullDB_GreenEye{li,52} = Turn_Time;
end;
FullDB_GreenEye{li,53} = detailRelay;
FullDB_GreenEye{li,54} = TurnUWVelocity;
FullDB_GreenEye{li,55} = mean(TurnUWVelocity);
FullDB_GreenEye{li,56} = AnalysisDate;
FullDB_GreenEye{li,57} = RaceDateMod;
FullDB_GreenEye{li,58} = 3; %Source
FullDB_GreenEye{li,59} = SpeedDecaySemiRange;
FullDB_GreenEye{li,60} = SpeedDecayLongRange;
FullDB_GreenEye{li,61} = SpeedDecaySprintMid;
FullDB_GreenEye{li,62} = SpeedDecaySemiMid;
FullDB_GreenEye{li,63} = SpeedDecayLongMid;
FullDB_GreenEye{li,64} = KicksNb;
FullDB_GreenEye{li,65} = filenameDBout;
FullDB_GreenEye{li,66} = 'None';
FullDB_GreenEye{li,67} = metaData_PDF;
FullDB_GreenEye{li,68} = dataTablePacing;
FullDB_GreenEye{li,69} = dataTableBreath;
FullDB_GreenEye{li,70} = dataTableStroke;
FullDB_GreenEye{li,71} = dataTableSkill;

%look for AgeGroup
existmeet = isfield(AgeGroup, ['A' num2str(competitionId) '_' Year 'A']);
if existmeet == 1;
    eval(['check = AgeGroup.A' num2str(competitionId) '_' Year 'A;']);
    index = strfind(check, '-');
    CheckDate = datetime(str2num(check(1:index(1)-1)), str2num(check(index(1)+1:index(2)-1)), str2num(check(index(2)+1:end)));
    index = strfind(RaceDate, '-');
    RaceCheckDate = datetime(str2num(RaceDate(index(2)+1:end)), str2num(RaceDate(index(1)+1:index(2)-1)), str2num(RaceDate(1:index(1)-1)));

    dateDiff(1) = RaceCheckDate;
    dateDiff(2) = CheckDate;
    D = caldiff(dateDiff, 'days');
    D = split(D, 'days');
    if D > 0;
        %the race was earlier
        eval(['AgeGroup.A' num2str(competitionId) '_' Year 'A = ' '''' RaceDateMod '''' ';']);
    end;
else;
    eval(['AgeGroup.A' num2str(competitionId) '_' Year 'A = ' '''' RaceDateMod '''' ';']);
end;


if ispc == 1;
    MDIR = getenv('USERPROFILE');
    filenameDBin = [MDIR '\SP2Synchroniser\RaceDB\' uid '.mat'];
elseif ismac == 1;
    filenameDBin = ['/Applications/SP2Synchroniser/RaceDB/' uid '.mat'];
end;
% try;
        save(filenameDBin, uid, 'graph1PacingAxes', 'graph1_Distance', 'graph1_gtit', 'axescolbar', 'colbar');
    
    %Send data file to the cloud
    command = ['aws s3 cp ' filenameDBin ' ' filenameDBout];
    [status, out] = system(command);
% end;

eval(['clear ' uid]);
clear RawBreakout;
clear RawBreath;
clear RawDistance;
clear RawVelocity;
clear RawVelocityTrend;
clear RawKick;
clear RawTime;
clear RawStroke;
clear dataEC;
clear graph1_lineMain;
clear graph1_lineBottom;
clear graph1_lineTop;
clear graph1_text;
clear graph1_Distance;
clear colorrange;
clear colorvalue;

AllDB.uidDB_GreenEye = uidDB_GreenEye;
AllDB.FullDB_GreenEye = FullDB_GreenEye;
AllDB.AthletesDB = AthletesDB;
AllDB.ParaDB = ParaDB;
AllDB.PBsDB = PBsDB;
AllDB.PBsDB_SC = PBsDB_SC;
AllDB.AgeGroup = AgeGroup;
AllDB.MeetDB = MeetDB;
AllDB.RoundDB = RoundDB;
%----------------------------------------------------------