
function [AllDB, competitionName] = Sparta1_processingUpdate(raceEC, count, AllDB, SP1DB, colorrange, colorvalue);

%Sparta Codes
% 1 FS
% 2 BK
% 3 BF
% 4 BR
% 5 IM
% 
% 0 No Relay
% 1 Freestyle Relay
% 2 Medley Relay
% 3 Mixed Freestyle Relay
% 4 Mixed Medley Relay
% 
% 
% 0 Leg 1
% 1 Leg 2
% 2 Leg 3
% 3 Leg 4
% 
% 
% 1 Final
% 2 Semi-Final
% 3 Heat
% 4 B Final
% 5 Swim Off
% 6 Time Trial
% 7 Training
% 8 Other 1
% 9 Other 2
% 
% 0 Start
% 1 FeetOff ???
% 2 Stroke
% 3 Breath
% 4 BreakOut
% 5 Location
% 6 Kicks
% 7 End




% if count == 1;
%     axesgraph1 = axes('parent', gcf, 'units', 'pixels', ...
%         'Position', [180, 1, 880, 668], 'Visible', 'off');
% else;
%     cla(axesgraph1,'reset');
%     set(axesgraph1, 'Visible', 'off');
% end;

uidDB = AllDB.uidDB;
FullDB = AllDB.FullDB;
ParaDB = AllDB.ParaDB; 
AgeGroup = AllDB.AgeGroup;
AthletesDB = AllDB.AthletesDB;
PBsDB = AllDB.PBsDB;
PBsDB_SC = AllDB.PBsDB_SC;
RoundDB = AllDB.RoundDB;
MeetDB = AllDB.MeetDB;

Annotations = SP1DB.Annotations;
Athletes = SP1DB.Athletes;
Competitions = SP1DB.Competitions;
Swims = SP1DB.Swims;
Users = SP1DB.Users;
Venue = SP1DB.Venue;

% if count == 1;
%     axesgraph1 = axes('parent', gcf, 'units', 'pixels', ...
%         'Position', [180, 1, 880, 668], 'Visible', 'off');
% end;
% 
% if ispc == 1;
%     MDIR = getenv('USERPROFILE');
% end;
% 
% cla(axesgraph1,'reset');
% set(axesgraph1, 'Visible', 'off');
% 
% uidDB = AllDB.uidDB;
% FullDB = AllDB.FullDB;
% AthletesDB = AllDB.AthletesDB;
% ParaDB = AllDB.ParaDB;
% PBsDB = AllDB.PBsDB;
% PBsDB_SC = AllDB.PBsDB_SC;
% AgeGroup = AllDB.AgeGroup;
% colorrange = handles2.colorrange;
% colorvalue = handles2.colorvalue;
% source_user = handles2.source_user;
% selectfiles = handles2.selectfiles;










% for raceEC = 1:length(Swims(:,1));

    %------------------------Prepare Data--------------------------
    %take race ID and metadata
    RaceId = Swims{raceEC, 1};
    SwimsEC = Swims(raceEC, :);
    RaceDist = SwimsEC{1,14};
    RaceDist = roundn(RaceDist,0);
    Course = SwimsEC{1,16};
    %find all annotations for that race
    indexAnnotations = find(Annotations(:,2) == RaceId);
    AnnotationsEC = Annotations(indexAnnotations,:);
    [~,index] = sort(AnnotationsEC(:,4));
    AnnotationsEC = AnnotationsEC(index,:);
    
%     %check the data (BO, feetoff, stroke and splits)
%     
%     isBO = find(AnnotationsEC(:,3) == 4);
%     isFeetOff = find(AnnotationsEC(:,3) == 1);
%     isLocation = find(AnnotationsEC(:,3) == 5);
%     isStroke = find(AnnotationsEC(:,3) == 2);

    
%     invalidRace = 0;
%     if length(isBO) ~= (RaceDist./Course) | isempty(isBO) == 1 | isempty(isLocation) == 1 | isempty(isStroke) == 1;
%         invalidRace = 1;
%     end;
% 
%     li45 = find(RaceLocation(:,5) == 45);
%     li40 = find(RaceLocation(:,5) == 40);
%     li5 = find(RaceLocation(:,5) == 5);
%     li10 = find(RaceLocation(:,5) == 10);
%     turnCount = (RaceDist./Course) - 1;
%     turnCountOdd = (turnCount+1) ./ 2;
%     turnCountEven = turnCount - turnCountOdd;
%     if length(li45) ~= turnCountOdd | length(li40) ~= turnCountOdd | length(li5)-1 ~= turnCountEven | length(li10) ~= turnCountEven;
%         invalidRace = 1;
%     end;

    %--------------------------------------------------------------

%     if invalidRace == 0;

        
    SplitsAll = [];
    SplitsAllSave = [];
    BOAll = [];
    BOAllINI = [];

    %-------------------------Metadata-------------------------
    AthleteId = SwimsEC{1,8};
    AthletesIdCol = Athletes(:,1);
    isAthlete = cellfun(@(x)isequal(x, AthleteId), AthletesIdCol);
    [row,col] = find(isAthlete);
    if isempty(row) == 1;
        Athletename = 'UnknownA';
        AthletenameFull = 'UnknownA';
        Firstname = 'Athlete';
        Lastname = 'Unknown';
        Gender = 'MALE';
        DOB = '01/01/2000';
        Country = 'INTER';
    else;
        li = find(AthletesDB.AMSID == AthleteId);
        if isempty(li) == 0;
            %take metadata in the SP2 database
            Firstname = AthletesDB.Names{li,1};
            Lastname = AthletesDB.Names{li,2};
            Athletename = [Lastname Firstname(1)];
            AthletenameFull = [Firstname ' ' Lastname];
            DOB = AthletesDB.DOB{li,1};
            Gender = AthletesDB.Gender(li,1);
            if Gender == 1;
                Gender = 'MALE';
            else;
                Gender = 'FEMALE';
            end;
            Country = AthletesDB.Nat{li,1};
        else;
            %take metadata in the SP1 database
            Firstname = Athletes{row, 5};
            Lastname = Athletes{row, 6};
            Athletename = [Lastname Firstname(1)];
            AthletenameFull = [Firstname ' ' Lastname];
            Gender = Athletes{row, 4};
            if Gender == 1;
                Gender = 'MALE';
            elseif Gender == 2;
                Gender = 'FEMALE';
            end;
            DOB = Athletes{row, 3};
            if isempty(DOB) == 1;
                DOB = '01/01/2000';
            end;
            DOB = DOB(1:10);
            Country = Athletes{row, 2};
        end;
    end;
    competitionName = [];
    
    li = find(ParaDB.AMSID == AthleteId);
    if isempty(li) == 1;
        Paralympic = 'Able';
    else;
        Paralympic = 'Para';
    end;

    if SwimsEC{1,13} == 1;
        StrokeType = 'Freestyle';
    elseif SwimsEC{1,13} == 2;
        StrokeType = 'Backstroke';
    elseif SwimsEC{1,13} == 3;
        StrokeType = 'Butterfly';
    elseif SwimsEC{1,13} == 4;
        StrokeType = 'Breaststroke';
    elseif SwimsEC{1,13} == 5;
        StrokeType = 'Medley';
    end;

    MeetId = SwimsEC{1,9};
    competitionId = MeetId;
    CompetitionsIdCol = Competitions(:,2);
    isCompetition = cellfun(@(x)isequal(x, MeetId), CompetitionsIdCol);
    [row,col] = find(isCompetition == 1);
    if isempty(row) == 1;

    else;
        Meet = Competitions{row, 1};
        li = findstr(Meet, ' ');
        if isempty(li) == 0;
            liop = [];
            for k = 1:length(Meet);
                lik = find(li == k);
                if isempty(lik) == 1;
                    liop = [liop k];
                end;
            end;
            Meet = Meet(liop);
        end;
    end;
    
    VenueID = SwimsEC{1,10};
    VenueIdCol = Venue(:,2);
    isVenue = cellfun(@(x)isequal(x, VenueID), VenueIdCol);
    [row,col] = find(isVenue == 1);
    if isempty(row) == 1;

    else;
        VenueEC = Venue{row, 1};
    end;
    index = strfind(VenueEC, ',');
    VenueEC = VenueEC(1:index(1)-1);

    AnalysisDate = SwimsEC{1,3};
    AnalysisDate = AnalysisDate(1:10);
    if strcmpi(AnalysisDate(end), ' ') == 1;
        AnalysisDate = AnalysisDate(1:end-1);
        if strcmpi(AnalysisDate(end), ' ') == 1;
            AnalysisDate = AnalysisDate(1:end-1);
        end;
    end;

    index = strfind(AnalysisDate, '/');
    dayDate = AnalysisDate(1:index(1)-1);
    monthDate = AnalysisDate(index(1)+1:index(2)-1);
    yearDate = AnalysisDate(index(2)+1:end);
    if length(dayDate) < 2;
        dayDate = ['0' dayDate];
    end;
    if length(monthDate) < 2;
        monthDate = ['0' monthDate];
    end;
    AnalysisDate = [dayDate '-' monthDate '-' yearDate];


    RaceDate = SwimsEC{1,11};
    RaceDate = RaceDate(1:10);
    if strcmpi(RaceDate(end), ' ') == 1;
        RaceDate = RaceDate(1:end-1);
        if strcmpi(RaceDate(end), ' ') == 1;
            RaceDate = RaceDate(1:end-1);
        end;
    end;
    indexSep = strfind(RaceDate, '/');
    Year = RaceDate(indexSep(2)+1:indexSep(2)+4);

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


    %CHECK the STAGE NAME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    if SwimsEC{1,12} == 1;
        Stage = 'Final';
    elseif SwimsEC{1,12} == 2;
        Stage = 'SemiFinal';
    elseif SwimsEC{1,12} == 3;
        Stage = 'Heat';
    elseif SwimsEC{1,12} == 4;
        Stage = 'FinalB';
    elseif SwimsEC{1,12} == 5;
        Stage = 'SwimOff';
    elseif SwimsEC{1,12} == 6;
        Stage = 'TimeTrial';
    elseif SwimsEC{1,12} == 7;
        Stage = 'Training';
    elseif SwimsEC{1,12} == 8;
        Stage = 'Other1';
    elseif SwimsEC{1,12} == 9;
        Stage = 'Other2';
    end;
    %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    isRelay = SwimsEC{1,17};
    relayType = SwimsEC{1,18};
    relayLeg = SwimsEC{1,19};
    if strcmpi(isRelay, 'False') == 1;
        valRelay = 'Flat';
        detailRelay = 'None';
    else;
        if relayType == 1;
            if strcmpi(Gender, "MALE") == 1;
                detailRelay = 'MFS';
            else;
                detailRelay = 'WFS';
            end;
        elseif relayType == 2;
            if strcmpi(Gender, "MALE") == 1;
                detailRelay = 'MIM';
            else;
                detailRelay = 'WIM';
            end;
        elseif relayType == 3;
            detailRelay = 'MxFS';
        elseif relayType == 4;
            detailRelay = 'MxIM';
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
    FilenameNew =  [Athletename '_' num2str(RaceDist) StrokeType '_' Stage '_' Lane '_' Meet num2str(Year) '_' valRelay '_' detailRelay];

    li = strfind(Athletename, ' ');
    if isempty(li) == 0;
        AthletenameDisp = [Athletename(1:li(1)-1) '-' Athletename(li(1)+1:end)];
    else;
        AthletenameDisp = Athletename;
    end;
    FilenameDisp =  ['File :  ' AthletenameDisp '_' num2str(RaceDist) StrokeType '_' Stage '_' Lane '_' Meet Year];


    framerate = SwimsEC{1,5};


    %Find the good raw in uidDB
    Index = find(contains(uidDB(:,2),FilenameNew));


    if isempty(Index) == 0;
        Index = Index(1);
        RTCol = 21;
        RTval = str2num(FullDB{Index+1,RTCol});
        updateRT = 1;
        %----------------------------------------------------------




        %-----------------Reproduce pacingtableINI-----------------
        VelLapAll = [];
        SectionVel = [];
        SectionCumTime = [];
        SectionSplitTime = [];
        SectionCumTimeMat = [];
        SectionSplitTimeMat = [];

        SectionVelbis = [];
        SectionCumTimebis = [];
        SectionSplitTimebis = [];
        SectionCumTimeMatbis = [];
        SectionSplitTimeMatbis = [];


        if Course == 25;
            nbzone = 5;
        else;
            nbzone = 10;
        end;
        NbLap = RaceDist./Course;

        indexLocation = find(AnnotationsEC(:,3) == 0 | AnnotationsEC(:,3) == 5 | AnnotationsEC(:,3) == 7);
        RaceLocation = AnnotationsEC(indexLocation,:);
        indexStroke = find(AnnotationsEC(:,3) == 2);
        RaceStroke = AnnotationsEC(indexStroke,:);
        indexBreath = find(AnnotationsEC(:,3) == 3);
        RaceBreath = AnnotationsEC(indexBreath,:);
        indexKick = find(AnnotationsEC(:,3) == 6);
        RaceKick = AnnotationsEC(indexKick,:);
        
        dataMatSplitsPacing = [];
        dataMatCumSplitsPacing = [];

        %Dist, Time, Frame
        listart =  find(AnnotationsEC(:,3) == 0);
        listart = AnnotationsEC(listart,4);
        if updateRT == 1;
            liFeefOff = roundn(listart + (RTval.*framerate),0);
        else;
            liFeefOff = find(AnnotationsEC(:,3) == 1);
            liFeefOff = AnnotationsEC(liFeefOff,4);
        end;
        
        SplitsAll = [];
        SplitsAll = [NaN ((liFeefOff-listart)./framerate) liFeefOff-listart];
        indexSplits0 = find(RaceLocation(:,5) == 0);
        if Course == 25;
            indexSplitsEnd = find(RaceLocation(:,5) == 25);
        else;
            indexSplitsEnd = find(RaceLocation(:,5) == 50);
        end;

        if length(indexSplits0) >= length(indexSplitsEnd);
            limMac = length(indexSplits0);
        else;
            limMac = length(indexSplitsEnd);
        end;

        indexSplitsAll = [];
        iter = 1;
        for rawEC = 1:limMac;
            if rawEC <= length(indexSplits0);
                indexSplitsAll(iter) = indexSplits0(rawEC);
            end;
            iter = iter + 1;
            if rawEC <= length(indexSplitsEnd);
                indexSplitsAll(iter) = indexSplitsEnd(rawEC);
            end;
            iter = iter + 1;
        end;

        for lapEC = 1:(RaceDist./Course);
            ReflapBeg = indexSplitsAll(lapEC);
            ReflapEnd = indexSplitsAll(lapEC+1);

            diffRows = RaceLocation(ReflapEnd,4) - RaceLocation(ReflapBeg,4);
            if lapEC == 1;
                SplitsAll = [SplitsAll; [Course*lapEC diffRows/framerate diffRows]];
            else;
                SplitsAll = [SplitsAll; [Course*lapEC SplitsAll(lapEC,2)+(diffRows/framerate) SplitsAll(lapEC,3)+diffRows]];
            end;

%             if lapEC ~= (RaceDist./Course);
%                 if rem(lapEC,2) == 1;
%                     %odd;
%                     ReflapBeg = indexSplitsEnd(lapEC);
%                     ReflapEnd = indexSplits0(lapEC+1);
%                 else;
%                     %even
%                     ReflapBeg = indexSplits0(lapEC);
%                     ReflapEnd = indexSplitsEnd(lapEC+1);
%                 end;
%             end;
        end;
        SplitsAvSpeed = [];
        for lap = 1:NbLap;
            SplitsAvSpeed(lap) = SplitsAll(lap+1,1)./SplitsAll(lap+1,2);
        end;

        TT = SplitsAll(end,2);
        TTtxt = timeSecToStr(TT);
        dataTablePacing{6,1} = TTtxt;

        %BO: Frame, Time, Dist (cumulative)... Change the frame index at
        %the end of the code, not to mess things up with the SectionVel,
        %...
        BOAll = [];
        indexBO = find(AnnotationsEC(:,3) == 4);

        RaceBO = AnnotationsEC(indexBO,:);
        for lapEC = 1:(RaceDist./Course);
            refDist = (lapEC-1).*Course;
            if rem(lapEC,2) == 1;
                %even Lap
                BOAll = [BOAll; [RaceBO(lapEC,4) (RaceBO(lapEC,4)-listart)/framerate refDist+RaceBO(lapEC,5)]];
            else;
                %odd lap
                BOAll = [BOAll; [RaceBO(lapEC,4) (RaceBO(lapEC,4)-listart)/framerate refDist+(Course-RaceBO(lapEC,5))]];
            end;
        end;
      
        indexStart = find(AnnotationsEC(:,3) == 0);
        RaceStart = AnnotationsEC(indexStart,4);

        %calculate values per 5m-sections
        SplitsAllSave = SplitsAll;
        SplitsAll = SplitsAll(2:end,:);
        for lap = 1:NbLap;
            refDist = (lap-1).*Course;

            if lap == 1;
                liSplitIni = 0;
            else;
                liSplitIni = SplitsAll(lap-1,3);
            end;
            liSplitEnd = SplitsAll(lap,3);
            indexStrokeLap = find(RaceStroke(:,4) > liSplitIni & RaceStroke(:,4) <= liSplitEnd);
            liStrokeLap = RaceStroke(indexStrokeLap, 4);
            indexLocationLap = find(RaceLocation(:,4) >= (liSplitIni+RaceStart) & RaceLocation(:,4) <= (liSplitEnd+RaceStart));
            liDistLap = RaceLocation(indexLocationLap, :);
            if rem(lap,2) == 0;
                %even laps: change direction of distance (rather than 50 to
                %0)
                liDistLap(:,5) = refDist + (Course-liDistLap(:,5));
            else;
                liDistLap(:,5) = ((lap-1)*Course) + liDistLap(:,5);
            end;
            
            if Course == 50;
                RaceDist = NbLap.*Course;
                keydist = (lap-1).*Course;
                if RaceDist <= 100;
                
                    if lap == 1;
                        DistIni = keydist;
                    else;
                        DistIni = keydist + 10;
                    end;
                
                    if lap == 1;
                        SectionVel = zeros(NbLap,10);
                        SectionSplitTime = zeros(NbLap,10);
                        SectionCumTime = zeros(NbLap,10);
    
                        SectionVelbis = zeros(NbLap,10);
                        SectionSplitTimebis = zeros(NbLap,10);
                        SectionCumTimebis = zeros(NbLap,10);  
                    end;
                    pos = [3 5 7 9 10];
                    for zone = 1:5;
                        if zone == 1;
                            if lap == 1;
                                %segment 0-15m after dive
                                DistEnd = DistIni + 15;
                                DistEndSplits = DistEnd;
                            else;
                                %segment 50-65m after turn (from 60 to 65m)
                                DistEnd = DistIni + 5;
                                DistEndSplits = DistEnd;
                            end;
                        elseif zone == 5;
                            DistEnd = DistIni + 5;
                            DistEndSplits = DistEnd;
                        else;
                            DistEnd = DistIni + 10;
                            DistEndSplits = DistEnd;
                        end;

                        indexIni = find(liDistLap(:,5) == DistIni);
                        liIni = liDistLap(indexIni,4);   
                        TimeIni = (liIni - listart)./framerate;

                        indexEnd = find(liDistLap(:,5) == DistEnd);
                        liEnd = liDistLap(indexEnd,4);
                        TimeEnd = (liEnd - listart)./framerate;

                        if BOAll(lap,1) >= liEnd;
                            if lap == 1;
                                %BO beyond 15m after the dive
                                SectionSplitTime(lap,pos(zone)) = TimeEnd;
                                SectionCumTime(lap,pos(zone)) = TimeEnd;
                            else;
                                SectionSplitTime(lap,pos(zone)) = NaN;
                                SectionCumTime(lap,pos(zone)) = NaN;
                            end;
                        else;
                            if BOAll(lap,1) > liIni;
                                liIni = BOAll(lap,1) + 1;
                                DistIni = BOAll(lap,3);
                                TimeIni = (liIni - listart)./framerate;
                            end;
                            SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
                            SectionSplitTime(lap,pos(zone)) = TimeEnd-TimeIni;
                            SectionCumTime(lap,pos(zone)) = TimeEnd;
                        end;     
                        DistIni = DistEnd;
                        DistIniSplits = DistEndSplits;
                    end;
                    SectionVelbis = SectionVel;
                    SectionSplitTimebis = SectionSplitTime;
                    SectionCumTimebis = SectionCumTime;
    
                    liSplitIni = SplitsAll(lap,3) + 1;
    
                else;
                    
                    if lap == 1;
                        DistIni = keydist + 15;
                        DistIniSplits = keydist;
                    else;
                        DistIni = keydist + 10;
                        DistIniSplits = keydist;
                    end;
                    
                    if lap == 1;
                        SectionVel = zeros(NbLap,10);
                        SectionSplitTime = zeros(NbLap,10);
                        SectionCumTime = zeros(NbLap,10);
    
                        SectionVelbis = zeros(NbLap,10);
                        SectionSplitTimebis = zeros(NbLap,10);
                        SectionCumTimebis = zeros(NbLap,10);
                    end;
                    pos = [5 10];
                    for zone = 1:2;
                        if zone == 1;
                            if lap == 1;
                                DistEnd = DistIni + 10;
                                DistEndSplits = DistEnd;
                            else;
                                DistEnd = DistIni + 15;
                                DistEndSplits = DistEnd;
                            end;
                        elseif zone == 2;
                            DistEnd = DistIni + 20;
                            DistEndSplits = DistEnd + 5;
                        end;
                        
                        indexIni = find(liDistLap(:,5) == DistIniSplits);
                        liIniSplits = liDistLap(indexIni,4);   
                        TimeIniSplits = (liIniSplits - listart)./framerate;

                        indexEnd = find(liDistLap(:,5) == DistEndSplits);
                        liEndSplits = liDistLap(indexEnd,4);   
                        TimeEndSplits = (liEndSplits - listart)./framerate;

                        indexIni = find(liDistLap(:,5) == DistIni);
                        liIni = liDistLap(indexIni,4);   
                        TimeIni = (liIni - listart)./framerate;

                        indexEnd = find(liDistLap(:,5) == DistEnd);
                        liEnd = liDistLap(indexEnd,4);
                        TimeEnd = (liEnd - listart)./framerate;
    
                        if BOAll(lap,1) >= liEnd;
                            SectionSplitTime(lap,pos(zone)) = NaN;
                            SectionCumTime(lap,pos(zone)) = NaN;
                        else;
                            if BOAll(lap,1) > liIni;
                                liIni = BOAll(lap,1) + 1;
                                DistIni = BOAll(lap,3);
                                TimeIni = (liIni - listart)./framerate;
                            end;
                            SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
                            SectionSplitTime(lap,pos(zone)) = TimeEndSplits-TimeIniSplits;
                            SectionCumTime(lap,pos(zone)) = TimeEndSplits;
                        end;
                        DistIni = DistEnd;
                    end;
                    liSplitIni = SplitsAll(lap,3) + 1;
    
                    %do the same but with the 100m ranges
                    if lap == 1;
                        DistIni = keydist;
                        DistIniSplits = keydist;
                    else;
                        DistIni = keydist + 10;
                        DistIniSplits = keydist;
                    end;
    
                    pos = [3 5 7 9 10];
                    for zone = 1:5;
                        if zone == 1;
                            if lap == 1;
                                %segment 0-15m after dive
                                DistEnd = DistIni + 15;
                                DistEndSplits = DistEnd;
                            else;
                                %segment 50-65m after turn (from 60 to 65m)
                                DistEnd = DistIni + 5;
                                DistEndSplits = DistEnd;
                            end;
                        elseif zone == 5;
                            DistEnd = DistIni + 5;
                            DistEndSplits = DistEnd;
                        else;
                            DistEnd = DistIni + 10;
                            DistEndSplits = DistEnd;
                        end;
                        
                        indexIni = find(liDistLap(:,5) == DistIniSplits);
                        liIniSplits = liDistLap(indexIni,4);   
                        TimeIniSplits = (liIniSplits - listart)./framerate;

                        indexEnd = find(liDistLap(:,5) == DistEndSplits);
                        liEndSplits = liDistLap(indexEnd,4);   
                        TimeEndSplits = (liEndSplits - listart)./framerate;

                        indexIni = find(liDistLap(:,5) == DistIni);
                        liIni = liDistLap(indexIni,4);   
                        TimeIni = (liIni - listart)./framerate;
    
                        indexEnd = find(liDistLap(:,5) == DistEnd);
                        liEnd = liDistLap(indexEnd,4);
                        TimeEnd = (liEnd - listart)./framerate;

                        if BOAll(lap,1) >= liEnd;
                            SectionSplitTimebis(lap,pos(zone)) = NaN;
                            SectionCumTimebis(lap,pos(zone)) = NaN;
                        else;
                            if BOAll(lap,1) > liIni;
                                liIni = BOAll(lap,1) + 1;
                            end;
                            SectionVelbis(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
                            SectionSplitTimebis(lap,pos(zone)) = TimeEndSplits-TimeIniSplits;
                            SectionCumTimebis(lap,pos(zone)) = TimeEndSplits;
                        end;     
                        DistIni = DistEnd;
                        DistIniSplits = DistEndSplits;
                    end;
                    liSplitIni = SplitsAll(lap,3) + 1;
                end;

                %Average speed lap
                DistINIBO = BOAll(lap,3);
                TimeINIBO = BOAll(lap,2);
                DistENDLap = SplitsAll(lap,1) - 5;
                indexEndLap = find(liDistLap(:,5) == DistENDLap);
                liEndLap = liDistLap(indexEndLap,4);
                TimeEndLap = (liEndLap - listart)./framerate;
                VelLapAll(lap) = (DistENDLap-DistINIBO) / (TimeEndLap-TimeINIBO);

            else;
                
            end;
        end;
        SectionVel = roundn(SectionVel,-2);
        SectionCumTime = roundn(SectionCumTime,-2);
        SectionSplitTime = roundn(SectionSplitTime,-2);
        if isempty(SectionVelbis) == 0;
            SectionVelbis = roundn(SectionVelbis,-2);
            SectionCumTimebis = roundn(SectionCumTimebis,-2);
            SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
        end;

        SectionCumTimeMat = SectionCumTime;
%         SectionCumTimeMat(:,end) = SplitsAll(:,2);
        SectionSplitTimeMat = SectionSplitTime;
        SectionSplitTimeMat(:,end) = SectionSplitTimeMat(:,end) - SectionSplitTimeMat(:,5);

        dataMatSplitsPacing(:,1) = reshape(SectionSplitTimeMat', nbzone*NbLap, 1);
        dataMatCumSplitsPacing(:,1) = reshape(SectionCumTimeMat', nbzone*NbLap, 1);

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
    
            dataMatSplitsPacingbis(:,1) = reshape(SectionSplitTimeMatbis', nbzone*NbLap, 1);
            dataMatCumSplitsPacingbis(:,1) = reshape(SectionCumTimeMatbis', nbzone*NbLap, 1);
%             dataMatCumSplitsPacingbis(:,1) = dataMatCumSplitsPacing(:,1);
        end;
        %----------------------------------------------------------
    
    

        %------------------Reproduce stroketableINI----------------
        if strcmpi(StrokeType, 'Medley');
            if Course == 25;
                if RaceDist == 100;
                    lapBFBR = [1 3];
                elseif RaceDist == 150;
                    lapBFBR = [3 4];
                elseif RaceDist == 200;
                    lapBFBR = [1 2 5 6];
                elseif RaceDist == 400;
                    lapBFBR = [1 2 3 4 9 10 11 12];
                end;
            else;
                if RaceDist == 150;
                    lapBFBR = 2;
                elseif RaceDist == 200;
                    lapBFBR = [1 3];
                elseif RaceDist == 400;
                    lapBFBR = [1 2 5 6];
                end;
            end;
        end;

        for lap = 1:NbLap;
            refDist = (lap-1).*Course;

            if lap == 1;
                liSplitIni = 0;
            else;
                liSplitIni = SplitsAll(lap-1,3);
            end;
            liSplitEnd = SplitsAll(lap,3);
            indexStrokeLap = find(RaceStroke(:,4) > liSplitIni+listart & RaceStroke(:,4) <= liSplitEnd+listart);
            liStrokeLap = RaceStroke(indexStrokeLap, 4);
            indexLocationLap = find(RaceLocation(:,4) >= (liSplitIni+RaceStart) & RaceLocation(:,4) <= (liSplitEnd+RaceStart));
            liDistLap = RaceLocation(indexLocationLap, :);
            if rem(lap,2) == 0;
                %even laps: change direction of distance (rather than 50 to
                %0)
                liDistLap(:,5) = refDist + (Course-liDistLap(:,5));
            else;
                liDistLap(:,5) = ((lap-1)*Course) + liDistLap(:,5);
            end;

            if strcmpi(StrokeType, 'Medley');
                lilap = find(lapBFBR == lap);
            end;
            
            keydist = (lap-1).*Course;
            DistIni = keydist;
            
            if Course == 50;
                if RaceDist <= 100;
                    Sparta1_Processing_C50RD100;
    
                else;
                    %200 and above
                    Sparta1_Processing_C50RD200;
                    
                end;        
            else;
                %Course 25m
            end;
        end;
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
        SplitsAll = SplitsAllSave;
        
        NbRows = roundn((SplitsAll(NbLap+1,2).*framerate) + 1, 0);
        RawTime = zeros(1,NbRows);
        RawDistance = zeros(1,NbRows);
        RawDistanceINI = zeros(1,NbRows);
        RawVelocity = zeros(1,NbRows);
        RawVelocityRaw = zeros(1,NbRows);
        RawVelocityTrend = zeros(1,NbRows);
        RawVelocityINI = zeros(1,NbRows);
        RawBreath = zeros(1,NbRows);
        RawStroke = zeros(1,NbRows);
        RawBreakout = zeros(1,NbRows);
        RawKick = zeros(1,NbRows);
        
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end;

        if Course == 50;
            if RaceDist == 50;
                perfectDist = [0 15 25 35 45 50];
            elseif RaceDist == 150;
                perfectDist = [0 15 25 35 45 50 ...
                    40 35 25 15 5 0 ...
                    10 15 25 35 45 50];
            else;
                perfectDist = [0 15 25 35 45 50 40 35 25 15 5 0];
                if RaceDist > 100;
                    for lap100 = 2:((RaceDist./Course)./2);
                        perfectDist = [perfectDist 10 15 25 35 45 50 40 35 25 15 5 0];
                    end;
                end;
            end;
        else;
            perfectDist = [0 15 25 35 45 50]; %to change for SC races
        end;

        lap = 1;
        for locationEC = 1:length(RaceLocation(:,1));
            locEC = RaceLocation(locationEC,5);
            iniDist = (lap*6)-5;
            endDist = (lap*6);
            lilocECPerfect = find(perfectDist(iniDist:endDist) == locEC);

            if isempty(lilocECPerfect) == 0;
                frameLoc = RaceLocation(locationEC,4);
                frameLoc = frameLoc - listart + 1;
                if rem(lap,2) == 0;
                    %even lap
                    locECconv = (Course*(lap-1)) + (Course-locEC);
                else;
                    locECconv = (Course*(lap-1)) + locEC;
                end;
                RawDistance(1,frameLoc) = locECconv;
    
                liKeyDist = find(keyDist(lap,:) == locECconv);
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
                    if locEC == 0 | locEC == Course;
                        lap = lap + 1;
                    end;
                end;
            end;
        end;
        
        %---insert NaN for underwater parts
        for lap = 1:NbLap;
            if lap == 1;
                lapBeg = 1;
            else;
                lapBeg = SplitsAll(lap,3) + 2;
            end;
            BOminus1s = (BOAll(lap,1)-listart) - framerate;
            RawDistance(lapBeg:BOminus1s) = NaN;
            RawVelocity(lapBeg:BOminus1s) = NaN;

            lapEnd = SplitsAll(lap+1,3);
            indexStrokeLap = find(RaceStroke(:,4) <= lapEnd+listart);
            lilastStroke = RaceStroke(indexStrokeLap(end),4)-listart + 1;
            RawDistance(lilastStroke:lapEnd) = NaN;
            RawVelocity(lilastStroke:lapEnd) = NaN;
        end;

        %---insert position and velocity values based on average vel
        indexSplitLapIni = 1;
        for lap = 1:NbLap;

            if lap == 1;
                lapBeg = 1;
            else;
                lapBeg = SplitsAll(lap,3) + 2;
            end;
            lapEnd = SplitsAll(lap+1,3);
            indexSplitLapEnd = find(RaceLocation(:,4) == lapEnd+listart);

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
                
                valIni = indexzeros(1);
                if seg == length(keySeg(lap,:));
                    %last 5m
                    distEC = Course;
                else;
                    distEC = keyDist(lap,indexnan(seg));
                end;
                distECconv = distEC - ((lap-1)*Course);
                if rem(lap,2) == 0;
                    %odd
                    distECconv = Course - distECconv;
                end;
                indexkeyDist = find(RaceLocation(indexSplitLapIni:indexSplitLapEnd,5) == distECconv);
                indexkeyDist = indexkeyDist + indexSplitLapIni - 1;
                if seg == length(keySeg(lap,:));
                    %last 5m: Last arm entry
                    indexStrokeLap = find(RaceStroke(:,4) <= lapEnd+listart);
                    lilastStroke = RaceStroke(indexStrokeLap(end),4)-listart + 1;
                    lilastStroke = lilastStroke;
                else;
                    valEnd = RaceLocation(indexkeyDist,4)-listart;
                end;

                if seg == length(keySeg(lap,:));
                    %last 5m
                    velRef = SectionVel(lap,indexnan(seg-1));
                    PosJump = (1/framerate).*velRef;
                else;
                    if lap ~= 1 & seg == 1;
                        %first seg of lap 2 and after
                        %vel is calculated from 60 to 65 and is not
                        %representative
                        %reculculate it from BO to 65 just to fill the gap
                        %properly
                        velRef = SectionVel(lap,indexnan(seg));
                        velRefAdj = (distEC - BOAll(lap,3)) / (SectionCumTime(lap,indexnan(seg)) - BOAll(lap,2));
                        PosJump = (1/framerate).*velRefAdj;
                    else;
                        velRef = SectionVel(lap,indexnan(seg));
                        if isnan(velRef) == 1;
                            if seg+1 <= length(indexnan);
                                velRef = SectionVel(lap,indexnan(seg+1));
                            else;
                                velRef = SectionVel(lap,indexnan(seg-1));
                            end;
                        end;
                        PosJump = (1/framerate).*velRef;
                    end;
                end;

                if seg == 1;
                    %put the BO position
                    liBOEC = BOAll(lap,1)-listart + 1;
                    RawDistance(1,liBOEC) = BOAll(lap,3);
                    RawVelocity(1,liBOEC) = velRef;
                    %remove ave dist until bo minus 1s
                    for colEC = -(liBOEC-1) : -valIni;
                        colECcor = abs(colEC);
                        if RawDistance(1,colECcor) == 0;
                            RawDistance(1,colECcor) = RawDistance(1,colECcor+1) - PosJump;
                            RawVelocity(1,colECcor) = velRef;
                        end;
                    end;
                    %add ave dist until reaching end of seg
                    for colEC = liBOEC+1 : valEnd;
                        if RawDistance(1,colEC) == 0;
                            RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                            RawVelocity(1,colEC) = velRef;
                        end;
                    end;
                elseif seg == length(keySeg(lap,:));
                    for colEC = valIni : lilastStroke;
                        if RawDistance(1,colEC) == 0;
                            RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                            RawVelocity(1,colEC) = velRef;
                        end;
                    end;
                else;
                    for colEC = valIni : valEnd;
                        if RawDistance(1,colEC) == 0;
                            RawDistance(1,colEC) = RawDistance(1,colEC-1) + PosJump;
                            RawVelocity(1,colEC) = velRef;
                        end;
                    end;
                end;
                if (distEC - RawDistance(1,colEC)) < 0.01;
                    RawDistance(1,colEC) = RawDistance(1,colEC) - 0.01;
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
        RawDistanceINI = RawDistance;
        RawVelocityRaw = RawVelocity;
        RawVelocityTrend = RawVelocity;
        RawVelocityINI = RawVelocity;

        %---insert position and velocity values based on average vel
        if isempty(RaceBreath) == 0;
            for breathEC = 1:length(RaceBreath(:,1));
                libreath = RaceBreath(breathEC,4) - listart + 1;
                RawBreath(1,libreath) = 1;
            end;
        end;
        if isempty(RaceKick) == 0;
            for kickEC = 1:length(RaceKick(:,1));
                likick = RaceKick(kickEC,4) - listart + 1;   
                RawKick(1,likick) = 1;
            end;
        end;
        if isempty(RaceStroke) == 0;
            for strokeEC = 1:length(RaceStroke(:,1));
                listroke = RaceStroke(strokeEC,4) - listart + 1;
                RawStroke(1,listroke) = 1;
            end;
        end;
        if isempty(RaceBO) == 0;
            for BOEC = 1:length(RaceBO(:,1));
                liBOEC = RaceBO(BOEC,4) - listart + 1;
                RawBreakout(1,liBOEC) = 1;
            end;
        end;
        for frameEC = 1:NbRows;
            RawTime(frameEC) = (frameEC-1).*(1./framerate);
        end;

        %---Adjust BOAll frame index
        BOAll(:,1) = BOAll(:,1)-listart;
        BOAll = roundn(BOAll,-2);
        SplitsAll = roundn(SplitsAll,-2);
        SplitsAllSave = roundn(SplitsAllSave,-2);
        %----------------------------------------------------------
        
        


        %----------------Compute other variables-------------------
        Stroke_Number = [];
        Stroke_Time = zeros(NbLap,80);
        Stroke_SR = zeros(NbLap,80);
        Stroke_Distance = zeros(NbLap,80);
        Stroke_DistanceINI = zeros(NbLap,80);
        Stroke_SI = zeros(NbLap,80);
        Stroke_SIINI = zeros(NbLap,80);
        Stroke_Frame = zeros(NbLap,80);
        Stroke_Velocity = zeros(NbLap,80);
        Stroke_VelocityMax = zeros(NbLap,80);
        Stroke_VelocityMin = zeros(NbLap,80);
        Stroke_VelocityINI = zeros(NbLap,80);
        Kick_Frames = zeros(NbLap,30);
        Breath_Frames = zeros(NbLap,40);
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
        TurnOdd = 1;
        TurnEven = 1;
        li45 = find(RaceLocation(:,5) == 45);
        li40 = find(RaceLocation(:,5) == 40);
        li5 = find(RaceLocation(:,5) == 5);
        li10 = find(RaceLocation(:,5) == 10);

        for lap = 1:NbLap;
            if lap == 1;
                liSplit = SplitsAll(lap+1,3);
                liSplitPrev = 1;
                index = find(isnan(SectionVel(lap,:)) == 0);
                if Course == 50;
                    if RaceDist <= 100;
                        VelLapAv(lap) = mean(SectionVel(lap,index(2:end)));
                    else;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    end;
                else;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end;
                
                if RaceDist <= 100;
                    index = find(keyDist(lap,:) == 15);
                    DiveT15 = SectionCumTime(lap,index);
                    DiveT15INI = SectionCumTime(lap,index);
                else;
                    index = find(keyDistbis(lap,:) == 15);
                    DiveT15 = SectionCumTimebis(lap,index);
                    DiveT15INI = SectionCumTimebis(lap,index);
                end;
                
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

                index = find(isnan(SectionVel(lap,:)) == 0);
                VelLapAv(lap) = mean(SectionVel(lap,index));
%                 if Course == 50;
%                     if RaceDist <= 100;
%                         
%                     else;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     end;
%                 else;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 end;

                VelBeforeBO(lap) = NaN;
                VelAfterBO(lap) = NaN;
                BOEff(lap) = NaN;
                BOEffCorr(lap) = NaN;
                
                if lap ~= 1;
                    if rem(lap-1,2) == 1;
                        %turn 1, 3, 5, 7, ...
                        %take 45m and 40m
                        liTurnIn = li45(TurnOdd);
                        liTurnOut = li40(TurnOdd);
                        TurnOdd = TurnOdd + 1;
                    else;
                        %turn 2, 4, 6, 8, ...
                        %take 5m and 10m
                        liTurnIn = li5(TurnEven);
                        liTurnOut = li10(TurnEven);
                        TurnEven = TurnEven + 1;
                    end;
                end;
                frameTurnIn = RaceLocation(liTurnIn,4)-listart;
                frameTurnOut = RaceLocation(liTurnOut,4)-listart;
                Turn_Time(lap-1) = (frameTurnOut - frameTurnIn)./framerate;
                Turn_TimeIn(lap-1) =  (SplitsAll(lap,3) - frameTurnIn)./framerate;
                Turn_TimeOut(lap-1) = (frameTurnOut - SplitsAll(lap,3))./framerate;
                
                Turn_TimeINI(lap-1) = Turn_Time(lap-1);
                Turn_TimeInINI(lap-1) =  Turn_TimeIn(lap-1);
                Turn_TimeOutINI(lap-1) = Turn_TimeOut(lap-1);
                
                Turn_BODist(lap-1) = BOAll(lap,3) - (Course*(lap-1));
                Turn_BODistINI(lap-1) = BOAll(lap,3) - (Course*(lap-1));
                
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
            if strcmpi(StrokeType, 'Freestyle') | strcmpi(StrokeType, 'Backstroke');
                
                Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                keyDistStroke = RawDistance(liStroke);
                diffDist = diff(keyDistStroke).*2;
                Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                for strEC = 2:length(liStroke);
                    segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                    [maxVal, locmaxVal] = max(segVel);
                    if locmaxVal-2 <= 0;
                        if locmaxVal-1 <= 0;
                            valINImax = 1;
                        else;
                            valINImax = locmaxVal-1;
                        end;
                    else;
                        valINImax = locmaxVal-2;
                    end;
                    if locmaxVal+2 > length(segVel);
                        if locmaxVal+1 > length(segVel);
                            valENDmax = length(segVel);
                        else;
                            valENDmax = locmaxVal+1;
                        end;
                    else;
                        valENDmax = locmaxVal+2;
                    end;
                    Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
        
                    [minVal, locminVal] = min(segVel);
                    if locminVal-2 <= 0;
                        if locminVal-1 <= 0;
                            valINImin = 1;
                        else;
                            valINImin = locminVal-1;
                        end;
                    else;
                        valINImin = locminVal-2;
                    end;
                    if locminVal+2 > length(segVel);
                        if locminVal+1 > length(segVel);
                            valENDmin = length(segVel);
                        else;
                            valENDmin = locminVal+1;
                        end;
                    else;
                        valENDmin = locminVal+2;
                    end;
                    Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                end;
                Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
                
            elseif strcmpi(StrokeType, 'Medley');

                if Course == 50;
                    if RaceDist == 200;
                        if lap == 2 | lap == 4;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist).*2;
                            Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
                            
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI).*2;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
                            
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                
                        else;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist);
                            Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
                            
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI);
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
                            
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        end;
                    elseif RaceDist == 150;
                        if lap == 1 | lap == 3;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist).*2;
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI).*2;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(RawVelocity(Velini:Velend));
%                                 VelRefTrend = mean(RawVelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        else;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist);
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI);
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        end;
                    else;
                        if lap == 3 | lap == 4 | lap == 7 | lap == 8;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist).*2;
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI).*2;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        else;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist);
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI);
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        end;
                    end;
                else;
                    if RaceDist == 100;
                        if lap == 2 | lap == 4;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist).*2;
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI).*2;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        else;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist);
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI);
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        end;
                    elseif RaceDist == 200;
                        if lap == 3 | lap == 4 | lap == 7 | lap == 8;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist).*2;
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI).*2;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        else;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist);
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI).*2;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        end;
                    elseif RaceDist == 150;
                        if lap == 1 | lap == 2 | lap == 5 | lap == 6;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist).*2;
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI).*2;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        else;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist);
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI);
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        end;
                    else;
                        if lap == 5 | lap == 6 | lap == 7 | lap == 8 | lap == 13 | lap == 14 | lap == 15 | lap == 16;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist).*2;
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI).*2;
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        else;
                            Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                            keyDist = RawDistance(liStroke);
                            diffDist = diff(keyDist);
                            Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                            Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                            for strEC = 2:length(liStroke);
                                segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                                [maxVal, locmaxVal] = max(segVel);
                                if locmaxVal-2 <= 0;
                                    if locmaxVal-1 <= 0;
                                        valINImax = 1;
                                    else;
                                        valINImax = locmaxVal-1;
                                    end;
                                else;
                                    valINImax = locmaxVal-2;
                                end;
                                if locmaxVal+2 > length(segVel);
                                    if locmaxVal+1 > length(segVel);
                                        valENDmax = length(segVel);
                                    else;
                                        valENDmax = locmaxVal+1;
                                    end;
                                else;
                                    valENDmax = locmaxVal+2;
                                end;
                                Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                                
                                [minVal, locminVal] = min(segVel);
                                if locminVal-2 <= 0;
                                    if locminVal-1 <= 0;
                                        valINImin = 1;
                                    else;
                                        valINImin = locminVal-1;
                                    end;
                                else;
                                    valINImin = locminVal-2;
                                end;
                                if locminVal+2 > length(segVel);
                                    if locminVal+1 > length(segVel);
                                        valENDmin = length(segVel);
                                    else;
                                        valENDmin = locminVal+1;
                                    end;
                                else;
                                    valENDmin = locminVal+2;
                                end;
                                Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                            end;
                            Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
        
                            keyDistINI = RawDistanceINI(liStroke);
                            diffDistINI = diff(keyDistINI);
                            Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                            Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                            Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
%                             if DPSError == 1;
%                                 Velini = liStroke(liStroke2m(1)-3);
%                                 Velend = liStroke(liStroke2m(1)-1);
%                                 VelRef = mean(Velocity(Velini:Velend));
%                                 VelRefTrend = mean(VelocityTrend(Velini:Velend));
%                                 for str = 1:length(liStroke2m);
%                                     valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
%                                     Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
%                                     Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
%                                     Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
%                                     VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
%                                     for it = 1:length((Velend:liStroke(liStroke2m(end))))
%                                         Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
%                                     end;
%                                 end;
%                             end;
                        end;
                    end;
                end;
        
            else;
                Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                keyDistStroke = RawDistance(liStroke);
                diffDist = diff(keyDistStroke);
                Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                for strEC = 2:length(liStroke);
                    segVel = RawVelocity(liStroke(strEC-1):liStroke(strEC));
                    [maxVal, locmaxVal] = max(segVel);
                    if locmaxVal-2 <= 0;
                        if locmaxVal-1 <= 0;
                            valINImax = 1;
                        else;
                            valINImax = locmaxVal-1;
                        end;
                    else;
                        valINImax = locmaxVal-2;
                    end;
                    if locmaxVal+2 > length(segVel);
                        if locmaxVal+1 > length(segVel);
                            valENDmax = length(segVel);
                        else;
                            valENDmax = locmaxVal+1;
                        end;
                    else;
                        valENDmax = locmaxVal+2;
                    end;
                    Stroke_VelocityMax(lap,strEC-1) = mean(segVel(valINImax:valENDmax));
                    
                    [minVal, locminVal] = min(segVel);
                    if locminVal-2 <= 0;
                        if locminVal-1 <= 0;
                            valINImin = 1;
                        else;
                            valINImin = locminVal-1;
                        end;
                    else;
                        valINImin = locminVal-2;
                    end;
                    if locminVal+2 > length(segVel);
                        if locminVal+1 > length(segVel);
                            valENDmin = length(segVel);
                        else;
                            valENDmin = locminVal+1;
                        end;
                    else;
                        valENDmin = locminVal+2;
                    end;
                    Stroke_VelocityMin(lap,strEC-1) = mean(segVel(valINImin:valENDmin));
                end;
                Stroke_SI(lap,1:length(timeStroke)) = Stroke_Velocity(lap,1:length(timeStroke)).*Stroke_Distance(lap,1:length(timeStroke));
            end;

        end;
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

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        DistENDLap = RaceDist - 5;
        indexEndLap = find(liDistLap(:,5) == DistENDLap);
        liEndLap = liDistLap(indexEndLap,4);
        TimeEndLap = (liEndLap - listart)./framerate;
        Last5m = dataMatCumSplitsPacing(end) - TimeEndLap;
        Last5mINI = dataMatCumSplitsPacing(end) - TimeEndLap;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if RaceDist == 50;
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
                SplitMid = SplitsAll((NbLap./2)+1,2);
                SplitEnd = SplitsAll(NbLap+1,2) - SplitMid;
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
                    SplitMid = SplitsAll((NbLap./2)+1,2);
                    SplitEnd = SplitsAll(NbLap+1,2) - SplitMid;
                    DropOff = SplitEnd - SplitMid;
                end;
            else;
                SplitMid = SplitsAll((NbLap./2)+1,2);
                SplitEnd = SplitsAll(NbLap+1,2) - SplitMid;
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
%         clear SectionVel;
        clear SectionVel2;
%         clear SectionSR;
        clear SectionSR2;
%         clear SectionDPS;
        clear SectionSD2;
%         for lap = 1:NbLap;
%             liSplitEnd = SplitsAll(lap+1,3);
%             keydist = (lap-1).*Course;
%             DistIni = keydist;
%             if Course == 25;
%                 nbzone = 5;
%             else;
%                 nbzone = 10;
%             end;
%             for zone = 1:nbzone;
%                 DistEnd = DistIni + 5;
%                 diffIni = abs(RawDistance - DistIni);
%                 [~, liIni] = min(diffIni);
%                 if zone == nbzone;
%                     linan = find(isnan(RawDistance(liIni:liSplitEnd)) == 0);
%                     
%                     if isempty(linan) == 1;
%                         liEnd = liSplitEnd;
%                     else;
%                         linan = linan + liIni - 1;
%                         liEnd = linan(end);
%                     end;
%                 else;
%                     diffEnd = abs(RawDistance - DistEnd);
%                     [~, liEnd] = min(diffEnd);
%                 end;
%         
%                 if zone == nbzone;
%                     SectionVel(lap,zone) = NaN;
%                     SectionSR(lap,zone) = NaN;
%                     SectionDPS(lap,zone) = NaN;
%                 else;
%                     if liEnd < BOAll(lap,1);
%                         SectionVel(lap,zone) = NaN;
%                         SectionSR(lap,zone) = NaN;
%                         SectionDPS(lap,zone) = NaN;
%                     else;
%                         if liIni < BOAll(lap,1);
%                             %only takes full freeswim segments
%                             SectionVel(lap,zone) = NaN;
%                             SectionSR(lap,zone) = NaN;
%                             SectionDPS(lap,zone) = NaN;
%                         else;
%                             if liEnd > length(RawVelocity);
%                                 liEnd = length(RawVelocity);
%                             end;
%                             SectionVel(lap,zone) = roundn(mean(RawVelocity(liIni:liEnd)),-2);
%         
%                             listrokeseg = find(Stroke_Frame(lap,:) >= liIni & Stroke_Frame(lap,:) <= liEnd);
%                             SectionSR(lap,zone) = mean(Stroke_SR(lap, listrokeseg));
%                             SectionDPS(lap,zone) = mean(Stroke_Distance(lap, listrokeseg));
%                         end;
%                     end;
%                 end;
%                 DistIni = DistEnd;
%             end;
%             liSplitIni = SplitsAll(lap+1,3) + 1;
%         end;
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
            for lapEC = 1:NbLap;
                index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
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

            %calculate value per cycle rather than per stroke
            Cycle_Time = [];
            Cycle_Velocity = [];
            Cycle_TimeTOT = [];
            Cycle_VelocityTOT = [];

            for lapEC = 1:NbLap;
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
                            Cycle_Time(lapEC,iter) = sum(Stroke_TimeDecayLap(1,strokeEC:strokeEC+1));
                            Cycle_Velocity(lapEC,iter) = mean(Stroke_VelocityDecayLap(1,strokeEC:strokeEC+1));
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
                MaxVel = [];
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
           
        elseif strcmpi(StrokeType, 'Butterfly') | strcmpi(StrokeType, 'Breaststroke');
            %remove first and last strokes
            for lapEC = 1:NbLap;
                index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
                
                Stroke_TimeDecay(lapEC, 1) = 0;
                Stroke_TimeDecay(lapEC, index(end)-1:index(end)) = 0;
        
                Stroke_VelocityDecay(lapEC, 1) = 0;
                Stroke_VelocityDecay(lapEC, index(end)-1:index(end)) = 0;
            end;
        
            %calculate value per cycle rather than per stroke (just remove the
            %0)
            Cycle_Time = [];
            Cycle_Velocity = [];
            Cycle_TimeTOT = [];
            Cycle_VelocityTOT = [];
            for lapEC = 1:NbLap;
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
                            Cycle_Time(lapEC,iter) = Stroke_TimeDecayLap(1,strokeEC);
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
                MaxVel = [];
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
            for lapEC = 1:NbLap;
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
        
            for lapEC = 1:NbLap;
                if caseStroke(lapEC) == 1;
                    %remove first and last strokes
                    index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
            
                    Stroke_TimeDecay(lapEC, 1) = 0;
                    Stroke_TimeDecay(lapEC, index(end):index(end)+1) = 0;
        
                    Stroke_VelocityDecay(lapEC, 1) = 0;
                    Stroke_VelocityDecay(lapEC, index(end)-1:index(end)) = 0;
                else;
                    %remove first 2 and last 2 strokes
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
        
            Cycle_Time = [];
            Cycle_Velocity = [];
            for lapEC = 1:NbLap;
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
                                Cycle_Time(lapEC,iter) = Stroke_TimeDecayLap(1,strokeEC);
                                Cycle_Velocity(lapEC,iter) = Stroke_VelocityDecay(lapEC,strokeEC);
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
                                Cycle_Time(lapEC,iter) = sum(Stroke_TimeDecayLap(1, strokeEC:strokeEC+1));
                                Cycle_Velocity(lapEC,iter) = mean(Stroke_VelocityDecayLap(1, strokeEC:strokeEC+1));
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
                StrokeTimeAll = sum(Cycle_TimeTOTLeg);
                Cycle_VelocityLeg = Cycle_VelocityTOT(legEC,:);
                index = find(Cycle_VelocityLeg ~= 0);
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
                    MaxVel = [];
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
                    for tcheck = 1:length(Cycle_TimeTOTLeg);
                        timeTOTEC = sum(Cycle_TimeTOTLeg(1:tcheck))./StrokeTimeAll;
                        if timeTOTEC > 0.5 & findlim == 0;
                            findlim = 1;
                            RefVelMid = mean([VELlapTOT(tcheck-1) VELlapTOT(tcheck)]);
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



%         %--------------------------Pacing graph----------------------------
%         reference_velocitythreshold;
%         %----Velocity bars / SR (left yaxis)
%         % ran = max(Velocity);
%         % min_val = 0;
%         % max_val = max(Velocity);
%         ran = thresTopDisp - thresBottomDisp;
%         min_val = thresBottomDisp;
%         max_val = thresTopDisp;
%         
%         colorVel = floor(((RawVelocity-min_val)/ran)*256)+1;
%         colorVelTrend = floor(((RawVelocityTrend-min_val)/ran)*256)+1;
%         col = zeros(numel(RawVelocity),3);
%         
%         if strcmpi(detailRelay, 'None') == 1;
%             str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' (SP1)'];
%         else;
%             str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (SP1)'];
%         end;
% 
%         graph1_gtit = title(axesgraph1, str, ...
%             'color', [1 1 1], 'Visible', 'on');
%         tickSpeed = [thresBottomDisp:0.2:thresTopDisp];
%         tickColor = (tickSpeed-min_val)/ran;
%         tickSpeedTXT = [];
%         for i = 1:length(tickSpeed);
%             tickSpeedTXT{i} = num2str(tickSpeed(i));
%         end;
%                     
%         yyaxis(axesgraph1, 'left');
%         maxDistance = 0;
%         minDistance = 100000;
%         for lap = 1:NbLap;
%             Stroke_Distancelap = Stroke_Distance(lap,:);
%             li = find(Stroke_Distancelap ~= 0);
%             Stroke_Distancelap = Stroke_Distancelap(li);
%             NbStrokeEC = length(Stroke_Distancelap);
%             for StrokeEC = 1:NbStrokeEC;
%                 Distance_EC = Stroke_Distancelap(StrokeEC);
%                 if maxDistance < Distance_EC;
%                     maxDistance = Distance_EC;
%                 end;
%                 if minDistance > Distance_EC;
%                     minDistance = Distance_EC;
%                 end;
%             end;
%         end;
%         
%         lapEC = 1;
%         StrokeEC = 1;
%         Stroke_Distancelap = Stroke_Distance(lapEC,:);
%         Stroke_Framelap = Stroke_Frame(lapEC,:);
%         li = find(Stroke_Distancelap ~= 0);
%         Stroke_Distancelap = Stroke_Distancelap(li);
%         Stroke_Framelap = Stroke_Framelap(li);
%         NbStrokeEC = length(Stroke_Distancelap);
%                     
%         if RaceDist == 50;
%             jump = 3;
%             linesize = 1.8;
%             linesizeRed = 3;
%         elseif RaceDist == 100;
%             jump = 4;
%             linesize = 2.2;
%             linesizeRed = 3;
%         elseif RaceDist == 150;
%             if framerate == 25;
%                 jump = 5;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             else;
%                 jump = 7;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             end;
%         elseif RaceDist == 200;
%             if framerate == 25;
%                 jump = 5;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             else;
%                 jump = 7;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             end;
%         elseif RaceDist == 400
%             if framerate == 25;
%                 jump = 7;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             else;
%                 jump = 9;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             end;
%         elseif RaceDist == 800;
%             if framerate == 25;
%                 jump = 9;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             else;
%                 jump = 15;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             end;
%         elseif RaceDist == 1500;
%             if framerate == 25;
%                 jump = 8;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             else;
%                 jump = 15;
%                 linesize = 2.2;
%                 linesizeRed = 3;
%             end;
%         end;
%         for i = 1:jump:numel(RawVelocity);
%             iter = 1;
%             if jump == 1;
%                 Distance_EC = Stroke_Distancelap(StrokeEC);
%                 if isnan(Velocity(i)) ~= 1;  
%                     colraw = colorVel(i);
%                     colrawTrend = colorVelTrend(i);
%                     if colraw > 256;
%                         colraw = 256;
%                     end;
%                     if colraw <= 0;
%                         colraw = 1;
%                     end;
%                     if colrawTrend > 256;
%                         colrawTrend = 256;
%                     end;
%                     if colrawTrend <= 0;
%                         colrawTrend = 1;
%                     end;
%                     graph1_lineMain = line([i i], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colraw,:), 'parent', axesgraph1, 'visible', 'off');
%                     graph1_lineMainTrend = line([i i], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colrawTrend,:), 'parent', axesgraph1, 'visible', 'off');
%                 end;
%         
%                 if Stroke_Framelap(StrokeEC) <= i;
%                     if StrokeEC == NbStrokeEC;
%                         if lapEC < NbLap;
%                             %change lap and stroke 1
%                             lapEC = lapEC + 1;
%                             StrokeEC = 1;
%                             Stroke_Distancelap = Stroke_Distance(lapEC,:);
%                             Stroke_Framelap = Stroke_Frame(lapEC,:);
%                             li = find(Stroke_Distancelap ~= 0);
%                             Stroke_Distancelap = Stroke_Distancelap(li);
%                             Stroke_Framelap = Stroke_Framelap(li);
%                             NbStrokeEC = length(Stroke_Distancelap);
%                         end;
%                     else;
%                         %change stroke only
%                         StrokeEC = StrokeEC + 1;
%                     end;
%                 end;
%             else;
%                 
%                 Distance_EC = Stroke_Distancelap(StrokeEC);
%                 if i+jump-1 > numel(RawVelocity);
%                     maxi = numel(RawVelocity);
%                 else;
%                     maxi = i+jump-1;
%                 end;
%                 colraw = colorVel(i:maxi);
%                 colrawTrend = colorVelTrend(i:maxi);
%                 linan = find(isnan(colraw) ~= 1);
%                 
%                 if length(linan) >= (0.8.*jump);
%                     colraw = roundn(mean(colraw(linan)), 0);
%                     if colraw > 256;
%                         colraw = 256;
%                     end;
%                     if colraw <= 0;
%                         colraw = 1;
%                     end;
%                     graph1_lineMain = line([i maxi], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colraw,:), 'parent', axesgraph1, 'visible', 'off');
%                     
%                     colrawTrend = roundn(mean(colrawTrend(linan)), 0);
%                     if colrawTrend > 256;
%                         colrawTrend = 256;
%                     end;
%                     if colrawTrend <= 0;
%                         colrawTrend = 1;
%                     end;
%                     graph1_lineMainTrend = line([i maxi], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colrawTrend,:), 'parent', axesgraph1, 'visible', 'off');
%                     
%                     iter = iter + 1;
%                 end;
%         
%                 if Stroke_Framelap(StrokeEC) <= i+jump-1;
%                     if StrokeEC == NbStrokeEC;
%                         if lapEC < NbLap;
%                             %change lap and stroke 1
%                             lapEC = lapEC + 1;
%                             StrokeEC = 1;
%                             Stroke_Distancelap = Stroke_Distance(lapEC,:);
%                             Stroke_Framelap = Stroke_Frame(lapEC,:);
%                             li = find(Stroke_Distancelap ~= 0);
%                             Stroke_Distancelap = Stroke_Distancelap(li);
%                             Stroke_Framelap = Stroke_Framelap(li);
%                             NbStrokeEC = length(Stroke_Distancelap);
%                         end;
%                     else;
%                         %change stroke only
%                         StrokeEC = StrokeEC + 1;
%                     end;
%                 end;
%             end;
%             hold on;
%         end;
%         
%         
%         keysplit = [];
%         for i = 1:jump:numel(RawVelocity);
%             if jump == 1;
%                 if isnan(Velocity(i)) == 1;
%                     li = find(SplitsAll(:,3) == i);
%                     li2 = find(BOAll(:,1) == i);
%                     if i == 1;
%                        graph1_lineMain = line([0 0], [0 maxDistance+0.1], 'linewidth', 4, 'Color', [1 1 1], 'parent', axesgraph1, 'visible', 'off');
%                        graph1_lineMainTrend = line([0 0], [0 maxDistance+0.1], 'linewidth', 4, 'Color', [1 1 1], 'parent', axesgraph1, 'visible', 'off');
%                     else;
%                         if isempty(li) == 1 & isempty(li2) == 1;
%                             graph1_lineMain = line([i i], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', axesgraph1, 'visible', 'off');
%                             graph1_lineMainTrend = line([i i], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', axesgraph1, 'visible', 'off');
%                         else;
%                             if isempty(li) == 0;
%                                 keysplit = [keysplit i];
%                                 graph1_lineMain = line([i i], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', axesgraph1, 'visible', 'off');
%                                 graph1_lineMainTrend = line([i i], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', axesgraph1, 'visible', 'off');
%                             end;
%                             if isempty(li2) == 0;
%                                 graph1_lineMain = line([i i], [0 maxDistance+0.1], 'linewidth', linesizeRed-1, 'Color', [0.8 0 0], 'LineStyle', '--', 'parent', axesgraph1, 'visible', 'off');
%                                 graph1_lineMainTrend = line([i i], [0 maxDistance+0.1], 'linewidth', linesizeRed-1, 'Color', [0.8 0 0], 'LineStyle', '--', 'parent', axesgraph1, 'visible', 'off');
%                             end;
%                         end;
%                     end;
%                 end;
%             else;
%                 if i+jump-1 > numel(RawVelocity);
%                     maxi = numel(RawVelocity);
%                 else;
%                     maxi = i+jump-1;
%                 end;
%                 colraw = colorVel(i:maxi);
%                 linan = find(isnan(colraw) ~= 1);
%                 if length(linan) < (0.8.*jump);
%                     proceed = 1;
%                     iterM = 0;
%                     findsplit = 0;
%                     while proceed ==  1;
%                         li = find(SplitsAll(:,3) == i+iterM);
%                         if isempty(li) == 0
%                             proceed = 0;
%                             findsplit = i+iterM;
%                         else;
%                             iterM = iterM + 1;
%                         end;
%                         if iterM > maxi;
%                             proceed = 0;
%                             findsplit = 0;
%                         end;
%                     end;
%                     
%                     proceed = 1;
%                     iterM = 0;
%                     findsplit2 = 0;
%                     while proceed ==  1;
%                         li2 = find(BOAll(:,1) == i+iterM);
%                         if isempty(li2) == 0
%                             proceed = 0;
%                             findsplit2 = i+iterM;
%                         else;
%                             iterM = iterM + 1;
%                         end;
%                         if iterM > maxi;
%                             proceed = 0;
%                             findsplit2 = 0;
%                         end;
%                     end;
%                     
%                     if i == 1;
%                         graph1_lineMain = line([0 0], [0 maxDistance+0.1], 'linewidth', 4, 'Color', [1 1 1], 'parent', axesgraph1, 'visible', 'off');
%                         graph1_lineMainTrend = line([0 0], [0 maxDistance+0.1], 'linewidth', 4, 'Color', [1 1 1], 'parent', axesgraph1, 'visible', 'off');
%                     else;
%                         if isempty(li) == 1 & isempty(li2) == 1;
%                             graph1_lineMain = line([i maxi], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', axesgraph1, 'visible', 'off');
%                             graph1_lineMainTrend = line([i maxi], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', axesgraph1, 'visible', 'off');
%                         else;
%                             if isempty(li) == 0;
%                                 keysplit = [keysplit i];
%                                 graph1_lineMain = line([findsplit findsplit], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', axesgraph1, 'visible', 'off');
%                                 graph1_lineMainTrend = line([findsplit findsplit], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', axesgraph1, 'visible', 'off');
%                             end;
%                             if isempty(li2) == 0;
%                                 graph1_lineMain = line([findsplit2 findsplit2], [0 maxDistance+0.1], 'linewidth', linesizeRed-1, 'Color', [0.8 0 0], 'LineStyle', '--', 'parent', axesgraph1, 'visible', 'off');
%                                 graph1_lineMainTrend = line([findsplit2 findsplit2], [0 maxDistance+0.1], 'linewidth', linesizeRed-1, 'Color', [0.8 0 0], 'LineStyle', '--', 'parent', axesgraph1, 'visible', 'off');
%                             end;
%                         end;
%                     end;
%                     iter = iter + 1;
%                 end;
%             end;
%             hold on;
%         end;
%         graph1_lineBottom = line([0 numel(RawVelocity)], [0 0], 'Color', [0.5 0.5 0.5], 'LineWidth', 2.5, 'parent', axesgraph1, 'visible', 'off');
%         hold off;
%         
%                     
%         %---DPS graph right axis
%         yyaxis(axesgraph1, 'right');
%         
%         maxSR = 0;
%         minSR = 1000000;
%         iter = 1;
%         for lap = 1:NbLap;
%             Stroke_SRlap = Stroke_SR(lap,:);
%             li = find(Stroke_SRlap ~= 0);
%             Stroke_SRlap = Stroke_SRlap(li);
%             Stroke_Framelap = Stroke_Frame(lap,li);
%             NbStroke = length(Stroke_SRlap);
%             for stroke = 1:NbStroke;
%                 if stroke == 1;
%                     liini = BOAll(lap,1);
%                     liend = Stroke_Framelap(stroke);
%                 else;
%                     liini = Stroke_Framelap(stroke-1);
%                     liend = Stroke_Framelap(stroke);
%                 end;
%                 graph1_Distance(iter) = line([liini liend], [Stroke_SRlap(stroke) Stroke_SRlap(stroke)], ...
%                     'color', [1 0 0], 'LineWidth', 2, 'Parent', axesgraph1, 'Visible', 'off');
%                 iter = iter + 1;
%                 hold on;
%             end;
%             if maxSR < max(Stroke_SRlap);
%                 maxSR = max(Stroke_SRlap);
%             end;
%             if minSR > min(Stroke_SRlap);
%                 minSR = min(Stroke_SRlap);
%             end;
%         end;
%         
%         LimGraphStroke = iter-1;
%         findbreath = 0;
%         for lap = 1:NbLap;
%             Breath_Framelap = Breath_Frames(lap,:);
%             li = find(Breath_Framelap ~= 0);
%             if isempty(li) == 0;
%                 findbreath = 1;
%             end;
%         end;
%         if findbreath == 0;
%             graph1_Breath = [];
%             LimGraphBreath = [];
%         else;
%             maxYRightaxis = maxSR;
%             minYRightaxis = minSR;
%             for lap = 1:NbLap;
%                 Breath_Framelap = Breath_Frames(lap,:);
%                 li = find(Breath_Framelap ~= 0);
%                 if isempty(li) == 0;
%                     Breath_Framelap = Breath_Frames(lap,li);
%                     NbBreath = length(Breath_Framelap);
%                     
%                     for breath = 1:NbBreath;
%                         graph1_Distance(iter) = line([Breath_Framelap(breath) Breath_Framelap(breath)], ...
%                             [minSR minSR+(maxSR-minSR).*0.01], ...
%                             'color', [1 0 0], 'LineWidth', 2, 'Parent', axesgraph1, 'Visible', 'off');
%                         iter = iter + 1;
%                     end;
%                 end;
%             end;
%             LimGraphBreath = iter-1;
%         end;
%         
%         set(axesgraph1, 'Visible', 'off');
%         set(graph1_lineMain, 'Visible', 'off');
%         set(graph1_lineMainTrend, 'Visible', 'off');
%         set(graph1_lineBottom, 'Visible', 'off');
%         set(graph1_gtit, 'Visible', 'off');
%         set(graph1_Distance, 'Visible', 'off');
%         
%         
%         %---Colorbar
%         offsetLeftXtitle = 185./1280;
%         offsetBottomColBar = 615./720;
%         widthXtitle = 855./1280;
%         if count == 1;
%             axescolbar = axes('parent', gcf, 'Position', [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.065], 'units', 'Normalized', ...
%                 'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
%                 'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12);
%         else;
%             cla(axescolbar, 'reset');
%             set(axescolbar, 'Position', [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.065], 'units', 'Normalized', ...
%                 'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
%                 'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12);
%         end;
% 
%         colbar = colorbar(axescolbar, 'location', 'northoutside', 'Ticks', tickColor,...
%                  'TickLabels',tickSpeedTXT, 'color', [1 1 1], 'visible', 'off');
%         colbar.Label.String = 'Velocity (m/s)';
%         colbar.Label.FontSize = 12;
%         colbar.Label.FontWeight = 'bold';
%         colbar.Label.FontName = 'Antiqua';
%         colbar.Limits = [0 1];
%         %----------------------------------------------------------



        %-----------------------Store data-------------------------
        onlinefinename = SwimsEC{1,4};
        if isempty(onlinefinename) == 1;
            onlinefinename = [lower(randseq(20,'alphabet','amino')) '-' num2str(SwimsEC{1,1}) '-' num2str(SwimsEC{1,2}) '-' lower(randseq(20,'alphabet','dna')) ];
        else;
            onlinefinename = onlinefinename(1:end-4); %remove the .mp4
        end;
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

        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            filenameDBin = [MDIR '\SP2Synchroniser\RaceDB\' uid '.mat'];
        elseif ismac == 1;
            filenameDBin = ['/Applications/SP2Synchroniser/RaceDB/' uid '.mat'];
        end;

        fileexist = 0;
        if isfile(filenameDBin) == 1;
            try;
                load(filenameDBin);
            catch;
                filenameDBout = ['s3://sparta2-prod/sparta2-data/' Year '/' competitionName '/' uid '.mat'];
                command = ['aws s3 cp ' filenameDBout ' ' filenameDBin];
                [status, out] = system(command);
    
                if status == 0;
                    load(filenameDBin);
                    fileexist = 1;
                end;
            end;
            fileexist = 1;
        else;
            filenameDBout = ['s3://sparta2-prod/sparta2-data/' Year '/' competitionName '/' uid '.mat'];
            command = ['aws s3 cp ' filenameDBout ' ' filenameDBin];
            [status, out] = system(command);

            if status == 0;
                load(filenameDBin);
                fileexist = 1;
            end;
        end;

        
        %Update required variables
        RT = SplitsAll(1,2);
        if fileexist == 1;
            eval([uid '.Source = 1;']);
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
            eval([uid '.NbLap = NbLap;']);
            eval([uid '.Course = Course;']);
            eval([uid '.RaceDist = RaceDist;']);
            eval([uid '.FrameRate = framerate;']);
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
%             eval([uid '.LimGraphStroke = LimGraphStroke;']);
%             eval([uid '.LimGraphBreath = LimGraphBreath;']);
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
            
    %         graph1PacingAxes = axesgraph1;
    %         eval([uid '.graph1PacingAxes = axesgraph1;']);
    %         eval([uid '.graph1_lineMain = graph1_lineMain;']);
    %         eval([uid '.graph1_lineMainTrend = graph1_lineMainTrend;']);
    %         eval([uid '.graph1PacingGraphDistance = graph1_Distance;']);
    %         eval([uid '.graph1PacingTitle = graph1_gtit;']);
    %         eval([uid '.graph1Pacingaxescolbar = axescolbar;']);
    %         eval([uid '.graph1Pacingcolbar = colbar;']);
    %         eval([uid '.graph1Pacing_maxYLeft = maxDistance;']);
    %         eval([uid '.graph1Pacing_minYLeft = minDistance;']);
    %         eval([uid '.graph1Pacing_maxYRight = maxSR;']);
    %         eval([uid '.graph1Pacing_minYRight = minSR;']);


            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                filenameDBin = [MDIR '\SP2Synchroniser\RaceDB\' uid '.mat'];
            elseif ismac == 1;
                filenameDBin = ['/Applications/SP2Synchroniser/RaceDB/' uid '.mat'];
            end;
            try;
                eval(['graph1PacingAxes = ' uid '.graph1PacingAxes;']);
                eval(['graph1_Distance = ' uid '.graph1PacingGraphDistance;']);
                eval(['graph1_gtit = ' uid '.graph1PacingTitle;']);
                eval(['axescolbar = ' uid '.graph1Pacingaxescolbar;']);
                eval(['colbar = ' uid '.graph1Pacingcolbar;']);

                save(filenameDBin, uid, 'graph1PacingAxes', 'graph1_Distance', 'graph1_gtit', 'axescolbar', 'colbar');
            catch;
                FilenameNew

                save(filenameDBin, uid);
            end;
        end;
       
        
        filenameDBout = ['s3://sparta2-prod/sparta2-data/' Year '/' competitionName '/' uid '.mat'];
        command = ['aws s3 cp ' filenameDBin ' ' filenameDBout];
        [status, out] = system(command);


        format longG;
        t = now;
        DateString = datestr(datetime(t,'ConvertFrom','datenum'));
%         li = length(uidDB(:,1))+1;
        
        %Update the good raw in uidDB (only the variable of interest if in uidDB)
        %$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        Index = find(contains(uidDB(:,2),FilenameNew));
        Index = Index(1);

        uidDB{Index,1} = onlinefinename;
        uidDB{Index,2} = FilenameNew;
        uidDB{Index,3} = Athletename;
        uidDB{Index,4} = num2str(RaceDist);
        uidDB{Index,5} = StrokeType;
        uidDB{Index,6} = Stage;
        uidDB{Index,7} = Lane;
        uidDB{Index,8} = Meet;
        uidDB{Index,9} = Year;
        uidDB{Index,10} = Gender;
        uidDB{Index,11} = Course;
        uidDB{Index,12} = SplitsAll(end,2);
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
        uidDB{Index,13} = 'na';
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
        texterror = '';
        uidDB{Index,14} = texterror;
        uidDB{Index,15} = AthleteId;
        uidDB{Index,16} = competitionId;
        uidDB{Index,17} = BOEffCorr(1);
        uidDB{Index,18} = TurnsAvBOEffCorr;
        avSI = [];
        for lap = 1:NbLap;
            SIlap = Stroke_SIINI(lap, :);
            index = find(SIlap ~= 0);
            avSI = [avSI mean(SIlap(1,index))];
        end;
        avSI = mean(avSI);
        avVEL = [];
        for lap = 1:NbLap;
            VELlap = Stroke_VelocityINI(lap, :);
            index = find(VELlap ~= 0);
            avVEL = [avSI mean(VELlap(1,index))];
        end;
        avVEL = mean(avVEL);
        uidDB{Index,19} = avSI;
        uidDB{Index,20} = avVEL;
        uidDB{Index,21} = Country;
        uidDB{Index,22} = SpeedDecaySprintRange;
        uidDB{Index,23} = SpeedDecayRef;
        uidDB{Index,24} = valRelay;
        uidDB{Index,25} = detailRelay;
        uidDB{Index,26} = 1; %Source
        uidDB{Index,27} = SpeedDecaySemiRange;
        uidDB{Index,28} = SpeedDecayLongRange;
        uidDB{Index,29} = SpeedDecaySprintMid;
        uidDB{Index,30} = SpeedDecaySemiMid;
        uidDB{Index,31} = SpeedDecayLongMid;
        uidDB{Index,27} = DateString; %always last column



%       %  Update the good raw in uidDB (only the variable of interest if in uidDB)
%         for nind = 1:length(Index);
%             FullDB{Index(nind)+1,64} = KicksNb;
%         end;

        FullDB{Index+1,1} = onlinefinename;
        FullDB{Index+1,2} = AthletenameFull;
        FullDB{Index+1,3} = num2str(RaceDist);
        FullDB{Index+1,4} = StrokeType;
        FullDB{Index+1,5} = Gender;
        FullDB{Index+1,6} = Stage;
        FullDB{Index+1,7} = Meet;
        FullDB{Index+1,8} = Year;
        FullDB{Index+1,9} = Lane;
        FullDB{Index+1,10} = num2str(Course);
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
        FullDB{Index+1,11} = valRelay;
        FullDB{Index+1,12} = Paralympic;
        FullDB{Index+1,13} = DOB;
        FullDB{Index+1,14} = timeSecToStr(SplitsAll(end,2));
    %     FullDB{li,15} = timeSecToStr(TotalSkillTime);
        FullDB{Index+1,15} = timeSecToStr(TotalSkillTimeINI);
    %     FullDB{li,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTime,-2));
        FullDB{Index+1,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2));
        FullDB{Index+1,17} = TimeDropOff;
        FullDB{Index+1,18} = MaxVelString;
        FullDB{Index+1,19} = MaxSR;
        FullDB{Index+1,20} = MaxSD;
        FullDB{Index+1,21} = dataToStr(RT,2);
    %     FullDB{li,22} = dataToStr(DiveT15);
        FullDB{Index+1,22} = dataToStr(DiveT15INI,2);
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
        if isempty(StartEntryDist) == 1;
            FullDB{Index+1,23} = 'na'; %Entry
            FullDB{Index+1,24} = 'na'; %UW Speed
        else;
            FullDB{Index+1,23} = dataToStr(StartEntryDist,2); %Entry
            FullDB{Index+1,24} = dataToStr(StartUWVelocity,2); %UW Speed
        end;
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    %     FullDB{li,25} = dataToStr(roundn(BOAll(1,3),-2));
        FullDB{Index+1,25} = dataToStr(BOAllINI(1,3),1);
        val1 = dataToStr(BOEff(1).*100,1);
        val2 = dataToStr(VelBeforeBO(1),2);
        val3 = dataToStr(VelAfterBO(1),2);
        val4 = dataToStr(BOEffCorr(1).*100,1);    
        FullDB{Index+1,26} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
    %     FullDB{li,27} = Turn_TimeTXT;
        FullDB{Index+1,27} = Turn_TimeTXTINI;
        val1 = dataToStr(mean(ApproachEff(1:end)).*100,1);
        val2 = dataToStr(mean(ApproachSpeed2CycleAll(1:end)),2);
        val3 = dataToStr(mean(ApproachSpeedLastCycleAll(1:end)),2);
        FullDB{Index+1,28} = [val1 '  [' val2 ' / ' val3 ']'];
    %     FullDB{li,29} = Turn_BODistTXT;
        FullDB{Index+1,29} = Turn_BODistTXTINI;
        val1 = dataToStr(mean(BOEff(2:end)).*100,1);
        val2 = dataToStr(mean(VelBeforeBO(2:end)),2);
        val3 = dataToStr(mean(VelAfterBO(2:end)),2);
        val4 = dataToStr(mean(BOEffCorr(2:end).*100),1);
        FullDB{Index+1,30} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
        avSI = [];
        for lap = 1:NbLap;
            SIlap = Stroke_SIINI(lap, :);
            index = find(SIlap ~= 0);
            avSI = [avSI mean(SIlap(1,index))];
        end;
        avSIlap = avSI;
        avSI = mean(avSI);
        avVEL = [];
        for lap = 1:NbLap;
            VELlap = Stroke_VelocityINI(lap, :);
            index = find(VELlap ~= 0);
            VELlap = VELlap(1,index);
            index = find(isnan(VELlap) == 0);
            VELlap = VELlap(1,index);
            avVEL = [avVEL mean(VELlap)];
        end;
        avVELlap = avVEL;
        avVEL = mean(avVEL);
        avSR = [];
        for lap = 1:NbLap;
            SRlap = Stroke_SR(lap, :);
            index = find(SRlap ~= 0);
            SRlap = SRlap(1,index);
            index = find(isnan(SRlap) == 0);
            SRLap = SRlap(1,index);
            avSR = [avSR mean(SRlap)];
        end;
        avSRlap = avSR;
        avSR = mean(avSR);
        avDPS = [];
        for lap = 1:NbLap;
            DPSlap = Stroke_DistanceINI(lap, :);
            index = find(DPSlap ~= 0);
            DPSlap = DPSlap(1,index);
            index = find(isnan(DPSlap) == 0);
            DPSlap = DPSlap(1,index);
            avDPS = [avDPS mean(DPSlap)];
        end;
        avDPSlap = avDPS;
        avDPS = mean(avDPS);
        FullDB{Index+1,31} = dataToStr(avSI,2);
        FullDB{Index+1,32} = dataToStr(mean(VelLapAll),2);
        FullDB{Index+1,33} = dataToStr(avSR,1);
        FullDB{Index+1,34} = dataToStr(avDPS,2);
        FullDB{Index+1,35} = Country;  
        FullDB{Index+1,36} = ['A' num2str(competitionId) '_' Year 'A'];
        if RaceDist == 50;
            FullDB{Index+1,37} = 'na';
            FullDB{Index+1,38} = 'na';
            FullDB{Index+1,39} = 'na';
        else;
            FullDB{Index+1,37} = dataToStr(TurnsAvINI(1,1),2);
            FullDB{Index+1,38} = dataToStr(TurnsAvINI(1,2),2);
            FullDB{Index+1,39} = dataToStr(TurnsAvINI(1,3),2);
        end;
        FullDB{Index+1,40} = AthleteId;
        FullDB{Index+1,41} = Last5mINI;
        FullDB{Index+1,42} = SpeedDecaySprintRange;
        FullDB{Index+1,43} = SpeedDecayRef;
        FullDB{Index+1,44} = GlideLastStrokeEC(3,end);
        FullDB{Index+1,45} = GlideLastStrokeEC(4,end);
        FullDB{Index+1,46} = ApproachEff(1,end);
        FullDB{Index+1,47} = avSIlap;
        FullDB{Index+1,48} = avVELlap;
        FullDB{Index+1,49} = avSRlap;
        FullDB{Index+1,50} = avDPSlap;
        for lap = 2:length(SplitsAll(:,2));
            if lap == 2;
                SplitsLap(lap) = SplitsAll(lap,2);
            else;
                SplitsLap(lap) = SplitsAll(lap,2) - SplitsAll(lap-1,2);
            end;
        end;
        SplitsLap = SplitsLap(2:end);
        FullDB{Index+1,51} = SplitsLap;
        if RaceDist == 50;
            FullDB{Index+1,52} = 'na';
        else;
            FullDB{Index+1,52} = Turn_Time;
        end;
        FullDB{Index+1,53} = detailRelay;
        FullDB{Index+1,54} = TurnUWVelocity;
        FullDB{Index+1,55} = mean(TurnUWVelocity);
        FullDB{Index+1,56} = AnalysisDate;
        FullDB{Index+1,57} = RaceDateMod;
        FullDB{Index+1,58} = 1; %Source
        FullDB{Index+1,59} = SpeedDecaySemiRange;
        FullDB{Index+1,60} = SpeedDecayLongRange;
        FullDB{Index+1,61} = SpeedDecaySprintMid;
        FullDB{Index+1,62} = SpeedDecaySemiMid;
        FullDB{Index+1,63} = SpeedDecayLongMid;
        FullDB{Index+1,64} = KicksNb;


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

        AllDB.uidDB = uidDB;
        AllDB.FullDB = FullDB;
        AllDB.AthletesDB = AthletesDB;
        AllDB.ParaDB = ParaDB;
        AllDB.PBsDB = PBsDB;
        AllDB.PBsDB_SC = PBsDB_SC;
        AllDB.AgeGroup = AgeGroup;
    end;


        %----------------------------------------------------------
%     end;
% end;