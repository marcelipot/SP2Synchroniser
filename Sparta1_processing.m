function [axesgraph1, axescolbar, AllDB, competitionName] = Sparta1_processing(raceEC, count, AllDB, SP1DB, colorrange, colorvalue, axesgraph1, axescolbar);

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




if count == 1;
    axesgraph1 = axes('parent', gcf, 'units', 'pixels', ...
        'Position', [180, 1, 880, 668], 'Visible', 'off');
else;
    cla(axesgraph1,'reset');
    set(axesgraph1, 'Visible', 'off');
end;

uidDB_SP1 = AllDB.uidDB_SP1;
FullDB_SP1 = AllDB.FullDB_SP1;
ParaDB = AllDB.ParaDB; 
AgeGroup_SP1 = AllDB.AgeGroup_SP1;
AthletesDB = AllDB.AthletesDB;
PBsDB = AllDB.PBsDB;
PBsDB_SC = AllDB.PBsDB_SC;
MeetDB = AllDB.MeetDB;
RoundDB = AllDB.RoundDB;


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
    splitsTimeExactString = SwimsEC{1,end};
    
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
        if isempty(index) == 1;
        else;
            VenueEC = VenueEC(1:index(1)-1);
        end;

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
            else;
                detailRelay = 'None';
            end;

            if relayLeg == 1;
                valRelay = 'Flat(L.1)';
            elseif relayLeg == 2;
                valRelay = 'Relay(L.2)';
            elseif relayLeg == 3;
                valRelay = 'Relay(L.3)';
            elseif relayLeg == 4;
                valRelay = 'Relay(L.4)';
            else;
                %relay leg was not indicated
                valRelay = 'Flat(L.1)';
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



        
        
        
        
        FilenameDisp








        framerate = SwimsEC{1,5};
        %----------------------------------------------------------




        %-----------------Reproduce pacingtableINI-----------------
        VelLapAll = [];
        SectionVel = [];
        SectionCumTime = [];
        SectionSplitTime = [];
        SectionCumTimeMat = [];
        SectionSplitTimeMat = [];
        dataTablePacing = [];

        SectionVelbis = [];
        SectionCumTimebis = [];
        SectionSplitTimebis = [];
        SectionCumTimeMatbis = [];
        SectionSplitTimeMatbis = [];

        isInterpolatedVel = [];
        isInterpolatedSplits = [];
        isInterpolatedVelbis = [];
        isInterpolatedSplitsbis = [];

        if Course == 25;
            nbzone = 5;
        else;
            nbzone = 10;
        end;
        NbLap = RaceDist./Course;

        indexLocation = find(AnnotationsEC(:,3) == 0 | AnnotationsEC(:,3) == 5 | AnnotationsEC(:,3) == 7);
        RaceLocation = AnnotationsEC(indexLocation,:);

        invalidRace = 0;
        isBO = find(AnnotationsEC(:,3) == 4);
        isFeetOff = find(AnnotationsEC(:,3) == 1);
        isLocation = find(AnnotationsEC(:,3) == 5);
        isStroke = find(AnnotationsEC(:,3) == 2);
        checkSP1_RaceLocation;

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
        liFeefOff = find(AnnotationsEC(:,3) == 1);
        liFeefOff = AnnotationsEC(liFeefOff,4);
        
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
            if lap == 1;
                SplitsAvSpeed(lap) = SplitsAll(lap+1,1)./SplitsAll(lap+1,2);
                SplitsAvSpeed(lap) = SplitsAvSpeed(lap) - (0.1*SplitsAvSpeed(lap));
            else;
                SplitsAvSpeed(lap) = SplitsAll(lap+1,1)./SplitsAll(lap+1,2);
                SplitsAvSpeed(lap) = SplitsAvSpeed(lap) - (0.05*SplitsAvSpeed(lap));
            end;
        end;

        TT = SplitsAll(end,2);
        TTtxt = timeSecToStr(TT);
        dataTablePacing{6,1} = TTtxt;

        %BO: Frame, Time, Dist (cumulative)... Change the frame index at
        %the end of the code, not to mess things up with the SectionVel,
        %...
        BOAll = [];
        indexBO = find(AnnotationsEC(:,3) == 4);
        
        if isempty(indexBO) == 1;
            RaceBO = [];
        else;
            RaceBO = AnnotationsEC(indexBO,:);
            RaceBO(:,4) = RaceBO(:,4) - listart;
        end;
       
        rawLapIni = 1;
        for lapEC = 1:(RaceDist./Course);
            rawLapEnd = SplitsAll(lapEC+1,3);
            if isempty(RaceBO) == 1;
                index = [];
            else;
                index = find(RaceBO(:,4) >= rawLapIni & RaceBO(:,4) <= rawLapEnd);
                if length(index) > 1;
                    index = index(1);
                end;
            end;
                    
            flagBO = 0;
            if isempty(index) == 1;
                %no BO
                refDist = (lapEC-1).*Course;

                searchRaw = find(RaceLocation(:,4) >= rawLapIni+listart & RaceLocation(:,4) <= rawLapEnd+listart);
                if Course == 25;
                    if rem(lapEC,2) == 0;
                        %even laps: 2, 4, 6
                        distRef1 = 15;
                        index1 = find(RaceLocation(searchRaw,5) == distRef1);

                        distRef2 = 5;
                        index2 = find(RaceLocation(searchRaw,5) == distRef2);
                    else;
                        %odd laps: 1, 3, 5
                        if lapEC == 1;
                            distRef1 = 15;
                        else;
                            distRef1 = 10;
                        end
                        index1 = find(RaceLocation(searchRaw,5) == distRef1);

                        distRef2 = 20;
                        index2 = find(RaceLocation(searchRaw,5) == distRef2);
                    end
                else;
                    if rem(lapEC,2) == 0;
                        %even laps: 2, 4, 6
                        distRef1 = 40;
                        index1 = find(RaceLocation(searchRaw,5) == distRef1);

                        distRef2 = 25;
                        index2 = find(RaceLocation(searchRaw,5) == distRef2);
                    else;
                        %odd laps: 1, 3, 5
                        if lapEC == 1;
                            distRef1 = 15;
                        else;
                            distRef1 = 10;
                        end
                        index1 = find(RaceLocation(searchRaw,5) == distRef1);

                        distRef2 = 25;
                        index2 = find(RaceLocation(searchRaw,5) == distRef2);
                    end
                end;
                speedRef = abs((distRef2-distRef1) / ...
                    ((RaceLocation(searchRaw(index2),4)./framerate)-(RaceLocation(searchRaw(index1),4)./framerate)));
                
                %find first stroke
                allStrokeIndexLap = find(RaceStroke(:,4) > rawLapIni+listart & RaceStroke(:,4) <= rawLapEnd+listart);
                firstStrokeLap = RaceStroke(allStrokeIndexLap(1), 4);
                %time first stroke
                firstStrokeLap = firstStrokeLap ./ framerate;
                %position first stroke
                if rem(lapEC,2) == 0;
                    %even laps
                    if RaceLocation(searchRaw(index1),4)./framerate > firstStrokeLap;
                        %first anchor is before the first stroke so use
                        %first anchor
                        diffTime = (RaceLocation(searchRaw(index1),4)./framerate) - firstStrokeLap;
                        firstStrokePos = (Course - distRef1) - (diffTime.*speedRef);
                    else;
                        %if not I use the second anchor
                        diffTime = (RaceLocation(searchRaw(index2),4)./framerate) - firstStrokeLap;
                        firstStrokePos = (Course - distRef2) - (diffTime.*speedRef);
                    end;
                else;
                    %odd laps
                    if RaceLocation(searchRaw(index1),4)./framerate > firstStrokeLap;
                        %first anchor is before the first stroke so use
                        %first anchor
                        diffTime = (RaceLocation(searchRaw(index1),4)./framerate) - firstStrokeLap;
                        firstStrokePos = distRef1 - (diffTime.*speedRef);
                    else;
                        %if not I use the second anchor
                        diffTime = (RaceLocation(searchRaw(index2),4)./framerate) - firstStrokeLap;
                        firstStrokePos = distRef2 - (diffTime.*speedRef);
                    end;
                end;
                
                %BODist, BOECTime & BOECFrame (1m before first stroke)
                firstStrokeLap = firstStrokeLap - (listart/framerate);
                BOECDist = (Course.*(lapEC-1)) + (firstStrokePos - 1);
                BOECDist = roundn(BOECDist,-2);

                if BOECDist > (Course.*(lapEC-1)) + 15;
                    if RaceDist >= 400;
                        if rem(lapEC,2) == 0;
                            %even laps
                            BOECDist = 30;
                        else;
                            %odd laps
                            BOECDist = 10;
                        end;
                    else;
                        if rem(lapEC,2) == 0;
                            %even laps
                            BOECDist = 35;
                        else;
                            %odd laps
                            BOECDist = 15;
                        end;
                    end;
                    indexBO = find(RaceLocation(searchRaw,5) == BOECDist);

                    if RaceDist >= 400;
                        BOECDist = (Course.*(lapEC-1)) + 10;
                    else
                        BOECDist = (Course.*(lapEC-1)) + 15;
                    end;

                    if isempty(indexBO) == 0;
                        indexBO = indexBO+searchRaw(1)-1;
                        BOECFrame = RaceLocation(indexBO,4) - listart + 1;
                        BOECTime = BOECFrame./framerate;
                    else;
                        posDiff = ((Course.*(lapEC-1)) + firstStrokePos) - BOECDist;
                        gapTime = posDiff./speedRef;
                        BOECTime = roundn(firstStrokeLap - gapTime, -2);
                        BOECFrame = roundn(BOECTime .*framerate,0);
                    end;
                    BOECDist = roundn(BOECDist,-1);
                else;
                    BOECTime = roundn(firstStrokeLap - (1/speedRef), -2);
                    BOECFrame = roundn(BOECTime .*framerate,0);
                    BOECDist = roundn(BOECDist,-1);
                end;

                flagBO = 1;

                if rem(lapEC,2) == 1;
                    %even Lap
                    BOAll = [BOAll; [BOECFrame BOECTime BOECDist flagBO]];
                else;
                    %odd lap
                    BOAll = [BOAll; [BOECFrame BOECTime BOECDist flagBO]];
                end;
                
                


%                 BOECDist = refDist + 15;
%                 BOECDist = roundn(BOECDist,-2);
%                 flagBO = 1;
% 
%                 indexOut = [];
%                 if lapEC == 1;
%                     lapIni = 1;
%                     lapEnd = find(RaceLocation(:,4) == (SplitsAll(lapEC+1,3)+listart));
%                     indexOut = find(RaceLocation(lapIni:lapEnd,5) == 15);
%                     if isempty(indexOut) == 1;
%                         indexOut = find(RaceLocation(lapIni:lapEnd,5) == 25);
%                     end;
%                 else;
%                     lapIni = find(RaceLocation(:,4) == (SplitsAll(lapEC,3)+listart));
%                     lapEnd = find(RaceLocation(:,4) == (SplitsAll(lapEC+1,3)+listart));
%                     if rem(lapEC,2) == 0;
%                         %even lap
%                         if Course == 25;
%                             indexOut = find(RaceLocation(lapIni:lapEnd,5) == 15);
%                         else;
%                             indexOut = find(RaceLocation(lapIni:lapEnd,5) == 40);
%                         end;
%                     else;
%                         %odd lap
%                         indexOut = find(RaceLocation(lapIni:lapEnd,5) == 10);
%                     end;
%                     if isempty(indexOut) == 1;
%                         indexOut = find(RaceLocation(lapIni:lapEnd,5) == 25);
%                     end;
%                 end;
%                 indexOut = indexOut+lapIni-1;
% 
%                 if isempty(indexOut) == 1;
%                     if Course == 25;
%                         speedRef = SplitsAvSpeed(lapEC);
%                         Time25 = SectionCumTime(lapEC-1);
%                         diffTime = (refDist - BOECDist)./speedRef;
%                         BOECTime = (Time25 - diffTime);
%                         BOECFrame = roundn((BOECTime.*framerate)+1,0);
%                     else;
%                         speedRef = SplitsAvSpeed(lapEC);
%                         Time50 = SplitsAll(lapEC,2);
%                         diffTime = (refDist - BOECDist)./speedRef;
%                         BOECTime = (Time50 - diffTime);
%                         BOECFrame = roundn((BOECTime.*framerate)+1,0);
%                     end;
%                 else;
%                     BOECFrame = RaceLocation(indexOut,4)-listart;
%                     BOECTime = BOECFrame./framerate;
%                 end;

                

            else;
                refDist = (lapEC-1).*Course;
                if rem(lapEC,2) == 1;
                    %even Lap
                    BOAll = [BOAll; [RaceBO(index,4) RaceBO(index,4)/framerate refDist+RaceBO(index,5) flagBO]];
                else;
                    %odd lap
                    BOAll = [BOAll; [RaceBO(index,4) RaceBO(index,4)/framerate refDist+(Course-RaceBO(index,5)) flagBO]];
                end;
            end;
            rawLapIni = rawLapEnd;
        end;
        BOAll(:,1) = roundn(BOAll(:,1), 0);
        BOAll(:,2) = roundn(BOAll(:,2), -2);
        BOAll(:,3) = roundn(BOAll(:,3), -1);

        indexStart = find(AnnotationsEC(:,3) == 0);
        RaceStart = AnnotationsEC(indexStart,4);
        

        % Method to interpolate turns based on the average instead
%                 tryaverage = 0;
%                 if strcmpi(lower(StrokeType), 'freestyle') == 1 | strcmpi(lower(StrokeType), 'backstroke') == 1 | strcmpi(lower(StrokeType), 'breaststroke') == 1;
%                     %not for IM
%                     if lapEC >= 2;
%                         %only for dives (only for turns)
%                         if isempty(BOAll) == 0;
%                             index = find(BOAll(:,4) == 0);
%                             if length(index) >= 3;
%                                 %more than 3 valid turn available... use the
%                                 %average
%                                 tryaverage = 1;
%                             end;
%                         end;
%                     end;
%                 end;
% 
%                 if tryaverage == 1;
%                     BOData = [];
%                     for BOEC = 1:length(index);
%                         if index(BOEC) == 1;
%                             %no need to offset
%                             BOData = [BOData; [BOAll(index(BOEC),2) BOAll(index(BOEC),3)]];
%                         else;
%                             lapoffsetDist = SplitsAll((index(BOEC)),1);
%                             lapoffsetTime = SplitsAll((index(BOEC)),2);
%                             BOData = [BOData; [BOAll(index(BOEC),2)-lapoffsetTime BOAll(index(BOEC),3)-lapoffsetDist]];
%                         end;
%                     end;
%                     averageBOTime = mean(BOData(:,1));
%                     averageBODist = mean(BOData(:,2));
% 
%                     flagBO = 1;
%                     BOAll = [BOAll; [SplitsAll(lapEC,3)+(averageBOTime*framerate) SplitsAll(lapEC,2)+averageBOTime SplitsAll(lapEC,1)+averageBODist flagBO]];
% 
%                 else;
% 
%                 end;
        
        %calculate values per 5m-sections
        SplitsAllSave = SplitsAll;
        SplitsAll = SplitsAll(2:end,:);
        
        if Course == 25;
            nbZone = 5;
            SectionVelNew = zeros(NbLap,5);
            SectionVelbisNew = zeros(NbLap,5);
            SectionCumTimeNew = zeros(NbLap,5);
            SectionCumTimebisNew = zeros(NbLap,5);
            SectionSplitTimeNew = zeros(NbLap,5);
            SectionSplitTimebisNew = zeros(NbLap,5);
            isInterpolatedVel = zeros(NbLap,5);
            isInterpolatedSplits = zeros(NbLap,5);
        elseif Course == 50;
            SectionVelNew = zeros(NbLap,10);
            SectionVelbisNew = zeros(NbLap,10);
            SectionCumTimeNew = zeros(NbLap,10);
            SectionCumTimebisNew = zeros(NbLap,10);
            SectionSplitTimeNew = zeros(NbLap,10);
            SectionSplitTimebisNew = zeros(NbLap,10);
            isInterpolatedVel = zeros(NbLap,10);
            isInterpolatedSplits = zeros(NbLap,10);
            nbZone = 10;
        end;
        SectionVelNew(:,:) = NaN;
        SectionVelbisNew(:,:) = NaN;
        SectionCumTimeNew(:,:) = NaN;
        SectionCumTimebisNew(:,:) = NaN;
        SectionSplitTimeNew(:,:) = NaN;
        SectionSplitTimebisNew(:,:) = NaN;


        %---Short 10m segments
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
        distSplitsAll = distSplitsAll(1:NbLap,:);

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
                %even laps: change direction of distance (rather than 50 to 0)
                liDistLap(:,5) = refDist + (Course-liDistLap(:,5));
            else;
                liDistLap(:,5) = ((lap-1)*Course) + liDistLap(:,5);
            end;
        
            if Course == 50;
                RaceDist = NbLap.*Course;
                keydist = (lap-1).*Course;
        
                if lap == 1;
                    DistIni = keydist;
                else;
                    DistIni = keydist + 10;
                end;
            
                if lap == 1;
                    SectionVel = zeros(NbLap,10);
                    SectionSplitTime = zeros(NbLap,10);
                    SectionCumTime = zeros(NbLap,10);
                    isInterpolatedVel = zeros(NbLap,10);
                    isInterpolatedSplits = zeros(NbLap,10);
                    isInterpolatedVelbis = zeros(NbLap,10);
                    isInterpolatedSplitsbis = zeros(NbLap,10);
        
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
        
                    if BOAll(lap,1)+RaceStart >= liEnd;
                        if lap == 1;
                            %BO beyond 15m after the dive
                            if isnan(liDistLap(indexEnd,3)) == 1;
                                isInterpolatedSplits(lap,pos(zone)) = 1;
                            end;
                            SectionSplitTime(lap,pos(zone)) = TimeEnd;
                            SectionCumTime(lap,pos(zone)) = TimeEnd;
                        else;
                            SectionSplitTime(lap,pos(zone)) = NaN;
                            SectionCumTime(lap,pos(zone)) = NaN;
                        end;
                    else;
                        if BOAll(lap,1)+RaceStart > liIni;
                            liIni = BOAll(lap,1) + 1 + RaceStart;
                            DistIni = BOAll(lap,3);
                            TimeIni = (liIni - listart)./framerate;
                        end;
                        if BOAll(lap,1)+RaceStart > liIni;
                            if BOAll(lap,4) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                                isInterpolatedSplits(lap,pos(zone)) = 1;
                                isInterpolatedVel(lap,pos(zone)) = 1;
                            end;
                        else;
                            if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                                isInterpolatedSplits(lap,pos(zone)) = 1;
                                isInterpolatedVel(lap,pos(zone)) = 1;
                            end;
                        end;
                        SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
                        SectionSplitTime(lap,pos(zone)) = TimeEnd-TimeIni;
                        SectionCumTime(lap,pos(zone)) = TimeEnd;
                    end;     
                    DistIni = DistEnd;
                    DistIniSplits = DistEndSplits;
                end;
%                 SectionVelbis = SectionVel;
%                 SectionSplitTimebis = SectionSplitTime;
%                 SectionCumTimebis = SectionCumTime;
%                 isInterpolatedSplitsbis = isInterpolatedSplits;
%                 isInterpolatedVelbis = isInterpolatedVel;
                liSplitIni = SplitsAll(lap,3) + 1;
        
        
                SectionVel = roundn(SectionVel,-2);
                SectionCumTime = roundn(SectionCumTime,-2);
                SectionSplitTime = roundn(SectionSplitTime,-2);
%                 if isempty(SectionVelbis) == 0;
%                     SectionVelbis = roundn(SectionVelbis,-2);
%                     SectionCumTimebis = roundn(SectionCumTimebis,-2);
%                     SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%                 end;
        
                SectionCumTimeMat = SectionCumTime;
        %         SectionCumTimeMat(:,end) = SplitsAll(:,2);
                SectionSplitTimeMat = SectionSplitTime;
                SectionSplitTimeMat(:,end) = SectionSplitTimeMat(:,end) - SectionSplitTimeMat(:,5);
        
                dataMatSplitsPacing(:,1) = reshape(SectionSplitTimeMat', nbzone*NbLap, 1);
                dataMatCumSplitsPacing(:,1) = reshape(SectionCumTimeMat', nbzone*NbLap, 1);
        
%                 dataMatSplitsPacingbis = [];
%                 dataMatCumSplitsPacingbis = [];
%                 if isempty(SectionVelbis) == 0;
%                     SectionVelbis = roundn(SectionVelbis,-2);
%                     SectionCumTimebis = roundn(SectionCumTimebis,-2);
%                     SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%                     
%                     SectionCumTimeMatbis = SectionCumTimebis;
%         %             SectionCumTimeMatbis(:,end) = SplitsAll(:,2);
%                     SectionSplitTimeMatbis = SectionSplitTimebis;
%         %             SectionSplitTimeMatbis(:,end) = SectionCumTimeMatbis(:,end) - SectionCumTimeMatbis(:,end-1);
%             
%                     dataMatSplitsPacingbis(:,1) = reshape(SectionSplitTimeMatbis', nbzone*NbLap, 1);
%                     dataMatCumSplitsPacingbis(:,1) = reshape(SectionCumTimeMatbis', nbzone*NbLap, 1);
%         %             dataMatCumSplitsPacingbis(:,1) = dataMatCumSplitsPacing(:,1);
%                 end;
                
                %Average speed lap
                DistINIBO = BOAll(lap,3);
                TimeINIBO = BOAll(lap,2);
                DistENDLap = SplitsAll(lap,1) - 5;
                indexEndLap = find(liDistLap(:,5) == DistENDLap);
                liEndLap = liDistLap(indexEndLap,4);
                TimeEndLap = (liEndLap - listart)./framerate;
                VelLapAll(lap) = (DistENDLap-DistINIBO) / (TimeEndLap-TimeINIBO);
        
            else;
                %Short course
                RaceDist = NbLap.*Course;
                keydist = (lap-1).*Course;
        
                if lap == 1;
                    DistIni = keydist;
                else;
                    DistIni = keydist;
                end;
            
                if lap == 1;
                    SectionVel = zeros(NbLap,5);
                    SectionSplitTime = zeros(NbLap,5);
                    SectionCumTime = zeros(NbLap,5);
                    isInterpolatedVel = zeros(NbLap,5);
                    isInterpolatedSplits = zeros(NbLap,5);
                    isInterpolatedVelbis = zeros(NbLap,5);
                    isInterpolatedSplitsbis = zeros(NbLap,5);
        
                    SectionVelbis = zeros(NbLap,5);
                    SectionSplitTimebis = zeros(NbLap,5);
                    SectionCumTimebis = zeros(NbLap,5);  
                end;


                if lap == 1;
                    if RaceDist == 50;
                        pos = [3 5];
                    else;
                        pos = [3 4 5];
                    end;
                else;
                    pos = [2 4 5];
                end;
                for zone = 1:length(pos);
                    if zone == 1;
                        if lap == 1;
                            %segment 0-15m after dive
                            DistEnd = DistIni + 15;
                            DistEndSplits = DistEnd;
                        else;
                            %segment 25-35m after turn
                            DistEnd = DistIni + 10;
                            DistEndSplits = DistEnd;
                        end;
                    elseif zone == length(pos);
                        if RaceDist == 50;
                            if lap == 1;
                                DistEnd = DistIni + 10;
                                DistEndSplits = DistEnd;
                            else
                                DistEnd = DistIni + 5;
                                DistEndSplits = DistEnd;
                            end;
                        else;
                            DistEnd = DistIni + 5;
                            DistEndSplits = DistEnd;
                        end;
                    else;
                        if lap == 1;
                            DistEnd = DistIni + 5;
                            DistEndSplits = DistEnd;
                        else;
                            DistEnd = DistIni + 10;
                            DistEndSplits = DistEnd;
                        end;
                    end;
        
                    indexIni = find(liDistLap(:,5) == DistIni);
                    liIni = liDistLap(indexIni,4);   
                    TimeIni = (liIni - listart)./framerate;
        
                    indexEnd = find(liDistLap(:,5) == DistEnd);
                    liEnd = liDistLap(indexEnd,4);
                    TimeEnd = (liEnd - listart)./framerate;
        
                    if BOAll(lap,1)+RaceStart >= liEnd;
                        if lap == 1;
                            %BO beyond 15m after the dive
                            if isnan(liDistLap(indexEnd,3)) == 1;
                                isInterpolatedSplits(lap,pos(zone)) = 1;
                            end;
                            SectionSplitTime(lap,pos(zone)) = TimeEnd;
                            SectionCumTime(lap,pos(zone)) = TimeEnd;
                        else;
                            SectionSplitTime(lap,pos(zone)) = TimeEnd-TimeIni;;
                            SectionCumTime(lap,pos(zone)) = TimeEnd;
                        end;
                    else;
                        if BOAll(lap,1)+RaceStart > liIni;
                            liIni = BOAll(lap,1) + 1 + RaceStart;
                            DistIni = BOAll(lap,3);
                            TimeIni = (liIni - listart)./framerate;
                        end;
                        if BOAll(lap,1)+RaceStart > liIni;
                            if BOAll(lap,4) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                                isInterpolatedSplits(lap,pos(zone)) = 1;
                                isInterpolatedVel(lap,pos(zone)) = 1;
                            end;
                        else;
                            if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                                isInterpolatedSplits(lap,pos(zone)) = 1;
                                isInterpolatedVel(lap,pos(zone)) = 1;
                            end;
                        end;
                        SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
                        SectionSplitTime(lap,pos(zone)) = TimeEnd-TimeIni;
                        SectionCumTime(lap,pos(zone)) = TimeEnd;
                    end;     
                    DistIni = DistEnd;
                    DistIniSplits = DistEndSplits;
                end;
%                 SectionVelbis = SectionVel;
%                 SectionSplitTimebis = SectionSplitTime;
%                 SectionCumTimebis = SectionCumTime;
%                 isInterpolatedSplitsbis = isInterpolatedSplits;
%                 isInterpolatedVelbis = isInterpolatedVel;
                liSplitIni = SplitsAll(lap,3) + 1;
        
        
                SectionVel = roundn(SectionVel,-2);
                SectionCumTime = roundn(SectionCumTime,-2);
                SectionSplitTime = roundn(SectionSplitTime,-2);
%                 if isempty(SectionVelbis) == 0;
%                     SectionVelbis = roundn(SectionVelbis,-2);
%                     SectionCumTimebis = roundn(SectionCumTimebis,-2);
%                     SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%                 end;
        
                SectionCumTimeMat = SectionCumTime;
        %         SectionCumTimeMat(:,end) = SplitsAll(:,2);
                SectionSplitTimeMat = SectionSplitTime;
                SectionSplitTimeMat(:,end) = SectionSplitTimeMat(:,end) - SectionSplitTimeMat(:,5);
        
                dataMatSplitsPacing(:,1) = reshape(SectionSplitTimeMat', nbzone*NbLap, 1);
                dataMatCumSplitsPacing(:,1) = reshape(SectionCumTimeMat', nbzone*NbLap, 1);
        
%                 dataMatSplitsPacingbis = [];
%                 dataMatCumSplitsPacingbis = [];
%                 if isempty(SectionVelbis) == 0;
%                     SectionVelbis = roundn(SectionVelbis,-2);
%                     SectionCumTimebis = roundn(SectionCumTimebis,-2);
%                     SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%                     
%                     SectionCumTimeMatbis = SectionCumTimebis;
%         %             SectionCumTimeMatbis(:,end) = SplitsAll(:,2);
%                     SectionSplitTimeMatbis = SectionSplitTimebis;
%         %             SectionSplitTimeMatbis(:,end) = SectionCumTimeMatbis(:,end) - SectionCumTimeMatbis(:,end-1);
%             
%                     dataMatSplitsPacingbis(:,1) = reshape(SectionSplitTimeMatbis', nbzone*NbLap, 1);
%                     dataMatCumSplitsPacingbis(:,1) = reshape(SectionCumTimeMatbis', nbzone*NbLap, 1);
%         %             dataMatCumSplitsPacingbis(:,1) = dataMatCumSplitsPacing(:,1);
%                 end;
                
                %Average speed lap
                DistINIBO = BOAll(lap,3);
                TimeINIBO = BOAll(lap,2);
                DistENDLap = SplitsAll(lap,1) - 5;
                indexEndLap = find(liDistLap(:,5) == DistENDLap);
                liEndLap = liDistLap(indexEndLap,4);
                TimeEndLap = (liEndLap - listart)./framerate;
                VelLapAll(lap) = (DistENDLap-DistINIBO) / (TimeEndLap-TimeINIBO);

                
            end;
        end;
        SplitsAvSpeed = VelLapAll;
        
        SectionVel = roundn(SectionVel,-2);
        SectionCumTime = roundn(SectionCumTime,-2);
        SectionSplitTime = roundn(SectionSplitTime,-2);
%         if isempty(SectionVelbis) == 0;
%             SectionVelbis = roundn(SectionVelbis,-2);
%             SectionCumTimebis = roundn(SectionCumTimebis,-2);
%             SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%         end;
        
        SectionCumTimeMat = SectionCumTime;
        SectionSplitTimeMat = SectionSplitTime;
        SectionSplitTimeMat(:,end) = SectionSplitTimeMat(:,end) - SectionSplitTimeMat(:,5);
        
        dataMatSplitsPacing(:,1) = reshape(SectionSplitTimeMat', nbzone*NbLap, 1);
        dataMatCumSplitsPacing(:,1) = reshape(SectionCumTimeMat', nbzone*NbLap, 1);
        
%         dataMatSplitsPacingbis = [];
%         dataMatCumSplitsPacingbis = [];
%         if isempty(SectionVelbis) == 0;
%             SectionVelbis = roundn(SectionVelbis,-2);
%             SectionCumTimebis = roundn(SectionCumTimebis,-2);
%             SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%             
%             SectionCumTimeMatbis = SectionCumTimebis;
%             SectionSplitTimeMatbis = SectionSplitTimebis;
%         
%             dataMatSplitsPacingbis(:,1) = reshape(SectionSplitTimeMatbis', nbzone*NbLap, 1);
%             dataMatCumSplitsPacingbis(:,1) = reshape(SectionCumTimeMatbis', nbzone*NbLap, 1);
%         end;

        SectionVel_short = SectionVel;
        dataMatCumSplitsPacing_short = dataMatCumSplitsPacing;
%         dataMatCumSplitsPacingbis_short = dataMatCumSplitsPacingbis;
        dataMatSplitsPacing_short = dataMatSplitsPacing;
%         dataMatSplitsPacingbis_short = dataMatSplitsPacingbis;
        isInterpolatedSplits_short = isInterpolatedSplits;
        isInterpolatedVel_short = isInterpolatedVel;

                 
        %---Long 25m segments
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
                %even laps: change direction of distance (rather than 50 to 0)
                liDistLap(:,5) = refDist + (Course-liDistLap(:,5));
            else;
                liDistLap(:,5) = ((lap-1)*Course) + liDistLap(:,5);
            end;
        
            if Course == 50;
                RaceDist = NbLap.*Course;
                keydist = (lap-1).*Course;
        
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
        
                    isInterpolatedVel = zeros(NbLap,10);
                    isInterpolatedSplits = zeros(NbLap,10);
                    isInterpolatedVelbis = zeros(NbLap,10);
                    isInterpolatedSplitsbis = zeros(NbLap,10);
        
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
        
                    if BOAll(lap,1)+RaceStart >= liEnd;
                        SectionSplitTime(lap,pos(zone)) = NaN;
                        SectionCumTime(lap,pos(zone)) = NaN;
                    else;
                        if BOAll(lap,1)+RaceStart > liIni;
                            liIni = BOAll(lap,1) + 1 + RaceStart;
                            DistIni = BOAll(lap,3);
                            TimeIni = (liIni - listart)./framerate;
                        end;
                        if BOAll(lap,1)+RaceStart > liIni;
                            if BOAll(lap,4) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                                isInterpolatedSplits(lap,pos(zone)) = 1;
                                isInterpolatedVel(lap,pos(zone)) = 1;
                            end;
                        else;
                            if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                                isInterpolatedSplits(lap,pos(zone)) = 1;
                                isInterpolatedVel(lap,pos(zone)) = 1;
                            end;
                        end;
                        SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
                        SectionSplitTime(lap,pos(zone)) = TimeEndSplits-TimeIniSplits;
                        SectionCumTime(lap,pos(zone)) = TimeEndSplits;
                    end;
                    DistIni = DistEnd;
                end;
                liSplitIni = SplitsAll(lap,3) + 1;        
            
            else;

                %Short Course
                RaceDist = NbLap.*Course;
                keydist = (lap-1).*Course;
        
                if lap == 1;
                    DistIni = keydist;
                    DistIniSplits = keydist;
                else;
                    DistIni = keydist;
                    DistIniSplits = keydist;
                end;
                
                if lap == 1;
                    SectionVel = zeros(NbLap,5);
                    SectionSplitTime = zeros(NbLap,5);
                    SectionCumTime = zeros(NbLap,5);
        
                    isInterpolatedVel = zeros(NbLap,5);
                    isInterpolatedSplits = zeros(NbLap,5);
                    isInterpolatedVelbis = zeros(NbLap,5);
                    isInterpolatedSplitsbis = zeros(NbLap,5);
        
                    SectionVelbis = zeros(NbLap,5);
                    SectionSplitTimebis = zeros(NbLap,5);
                    SectionCumTimebis = zeros(NbLap,5);
                end;
                pos = 5;
                DistEnd = DistIni + 25;
                DistEndSplits = DistEnd;
                    
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
       
                if BOAll(lap,1)+RaceStart >= liEnd;
                    SectionSplitTime(lap,pos) = NaN;
                    SectionCumTime(lap,pos) = NaN;
                else;
%                     if BOAll(lap,1)+RaceStart > liIni;
%                         liIni = BOAll(lap,1) + 1 + RaceStart;
%                         DistIni = BOAll(lap,3);
%                         TimeIni = (liIni - listart)./framerate;
%                     end;
                    if BOAll(lap,1)+RaceStart > liIni;
                        if BOAll(lap,4) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                            isInterpolatedSplits(lap,pos) = 1;
                            isInterpolatedVel(lap,pos) = 1;
                        end;
                    else;
                        if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                            isInterpolatedSplits(lap,pos) = 1;
                            isInterpolatedVel(lap,pos) = 1;
                        end;
                    end;
                    SectionVel(lap,pos) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
                    SectionSplitTime(lap,pos) = TimeEndSplits-TimeIniSplits;
                    SectionCumTime(lap,pos) = TimeEndSplits;
                end;
                DistIni = DistEnd;


                liSplitIni = SplitsAll(lap,3) + 1;
        

            end;
        end;

        SectionVel = roundn(SectionVel,-2);
        SectionCumTime = roundn(SectionCumTime,-2);
        SectionSplitTime = roundn(SectionSplitTime,-2);
%         if isempty(SectionVelbis) == 0;
%             SectionVelbis = roundn(SectionVelbis,-2);
%             SectionCumTimebis = roundn(SectionCumTimebis,-2);
%             SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%         end;
        
        SectionCumTimeMat = SectionCumTime;
        SectionSplitTimeMat = SectionSplitTime;
        SectionSplitTimeMat(:,end) = SectionSplitTimeMat(:,end) - SectionSplitTimeMat(:,5);
        
        dataMatSplitsPacing(:,1) = reshape(SectionSplitTimeMat', nbzone*NbLap, 1);
        dataMatCumSplitsPacing(:,1) = reshape(SectionCumTimeMat', nbzone*NbLap, 1);
        
%         dataMatSplitsPacingbis = [];
%         dataMatCumSplitsPacingbis = [];
%         if isempty(SectionVelbis) == 0;
%             SectionVelbis = roundn(SectionVelbis,-2);
%             SectionCumTimebis = roundn(SectionCumTimebis,-2);
%             SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%             
%             SectionCumTimeMatbis = SectionCumTimebis;
%             SectionSplitTimeMatbis = SectionSplitTimebis;
%         
%             dataMatSplitsPacingbis(:,1) = reshape(SectionSplitTimeMatbis', nbzone*NbLap, 1);
%             dataMatCumSplitsPacingbis(:,1) = reshape(SectionCumTimeMatbis', nbzone*NbLap, 1);
%         end;
        
        SectionVel_long = SectionVel;
        dataMatCumSplitsPacing_long = dataMatCumSplitsPacing;
%         dataMatCumSplitsPacingbis_long = dataMatCumSplitsPacingbis;
        dataMatSplitsPacing_long = dataMatSplitsPacing;
%         dataMatSplitsPacingbis_long = dataMatSplitsPacingbis;
        isInterpolatedSplits_long = isInterpolatedSplits;
        isInterpolatedVel_long = isInterpolatedVel;
        
        
%         if RaceDist <= 100;
            SectionVel = SectionVel_short;
            dataMatCumSplitsPacing = dataMatCumSplitsPacing_short;
            dataMatSplitsPacing = dataMatSplitsPacing_short;
            isInterpolatedSplits = isInterpolatedSplits_short;
            isInterpolatedVel = isInterpolatedVel_short;
%         else;
%             SectionVelNew = SectionVelNew_long;
%             dataMatCumSplitsPacing = dataMatCumSplitsPacing_long;
%             dataMatSplitsPacing = dataMatSplitsPacing_long;
%             isInterpolatedSplits = isInterpolatedSplits_long;
%             isInterpolatedVel = isInterpolatedVel_long;
%         end;
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

%         for lap = 1:NbLap;
%             refDist = (lap-1).*Course;
% 
%             if lap == 1;
%                 liSplitIni = 0;
%             else;
%                 liSplitIni = SplitsAll(lap-1,3);
%             end;
%             liSplitEnd = SplitsAll(lap,3);
%             indexStrokeLap = find(RaceStroke(:,4) > liSplitIni+listart & RaceStroke(:,4) <= liSplitEnd+listart);
%             liStrokeLap = RaceStroke(indexStrokeLap, 4);
%             indexLocationLap = find(RaceLocation(:,4) >= (liSplitIni+RaceStart) & RaceLocation(:,4) <= (liSplitEnd+RaceStart));
%             liDistLap = RaceLocation(indexLocationLap, :);
%             if rem(lap,2) == 0;
%                 %even laps: change direction of distance (rather than 50 to
%                 %0)
%                 liDistLap(:,5) = refDist + (Course-liDistLap(:,5));
%             else;
%                 liDistLap(:,5) = ((lap-1)*Course) + liDistLap(:,5);
%             end;
% 
%             if strcmpi(StrokeType, 'Medley');
%                 lilap = find(lapBFBR == lap);
%             end;
%             
%             keydist = (lap-1).*Course;
%             DistIni = keydist;
%             
%             if Course == 50;
%                 if RaceDist <= 100;
%                     Sparta1_Processing_C50RD100;
%     
%                 else;
%                     %200 and above
%                     Sparta1_Processing_C50RD200;
%                     
%                 end;        
%             else;
%                 %Course 25m
%             end;
%         end;

        %10m segments
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
                Sparta1_Processing_C50RD100;
            else;
%                 ###########################################
                Sparta1_Processing_C25RD100;
            end;
        end;


        %25m segments
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
                Sparta1_Processing_C50RD200;
            else;
                %Course 25m
                Sparta1_Processing_C25RD200;
            end;
        end;

%         if RaceDist <= 100;
            SectionVel = SectionVel_short;
            isInterpolatedVel = isInterpolatedVel_short;
            SectionSplitTime = SectionSplitTime_short;
            SectionCumTime = SectionCumTime_short;
            isInterpolatedSplits = isInterpolatedSplits_short;
            
            SectionSR = SectionSR_short;
            SectionSD = SectionSD_short;
            SectionNb = SectionNb_short;
            isInterpolatedSR = isInterpolatedSR_short;
            isInterpolatedSD = isInterpolatedSD_short;
%         else;
%             SectionVelNew = SectionVelNew_long;
%             dataMatCumSplitsPacing = dataMatCumSplitsPacing_long;
%             dataMatSplitsPacing = dataMatSplitsPacing_long;
%             isInterpolatedSplits = isInterpolatedSplits_long;
%             isInterpolatedVel = isInterpolatedVel_long;
%         end;


        %---Correct splits with exact times (0.01 rounding)
        %get the times
        timeLapExact = [];
        for lapEC = 1:NbLap;
            distECINI = Course*lapEC;
            distECEND = Course*(lapEC+1);
            if lapEC == 1;
                index = strfind(splitsTimeExactString, [num2str(distECINI) ',']);
                if isempty(index) == 1;
                    indexINI = [];
                else;
                    indexINI = index(1)+3;
                end;
            else;
                index = strfind(splitsTimeExactString, ['|' num2str(distECINI) ',']);
                if isempty(index) == 1;
                    indexINI = [];
                else;
                    if distECINI < 1000;
                        indexINI = index(1)+5;
                    else;
                        indexINI = index(1)+6;
                    end;
                end;
            end;

            if lapEC == NbLap;
                indexEND = length(splitsTimeExactString);
            else;
                index = strfind(splitsTimeExactString, ['|' num2str(distECEND) ',']);
                if isempty(index) == 1;
                    indexEND = [];
                else;
                    indexEND = index(1)-1;
                end;
            end;

            if isempty(indexINI) == 1 | isempty(indexEND) == 1;
                timeLapExact(lapEC,1) = NaN;
            else;
                splitsTimeExactLap = splitsTimeExactString(indexINI:indexEND);
                indexTIME = strfind(splitsTimeExactLap, ',');
                splitsTimeExactLap = splitsTimeExactLap(1:indexTIME(1)-1);
                
                if isempty(splitsTimeExactLap) == 0;
                    indexSEP = strfind(splitsTimeExactLap, ':');
                    if isempty(indexSEP) == 0;
                        hoursString = splitsTimeExactLap(1:indexSEP(1)-1);
                        minutesString = splitsTimeExactLap(indexSEP(1)+1:indexSEP(2)-1);
                        secondesString = splitsTimeExactLap(indexSEP(2)+1:end);
            
                        timeLapExact(lapEC,1) = (str2num(hoursString)*3600) + (str2num(minutesString)*60) + str2num(secondesString);
                    else;
                        timeLapExact(lapEC,1) = NaN;
                    end;
                else;
                    timeLapExact(lapEC,1) = NaN;
                end;
            end;
        end;
        
        %Correct the times
        for lapEC = 1:NbLap;
            splitECnew = roundn(timeLapExact(lapEC,1), -2);
            if isnan(splitECnew) == 0;
                splitECold = SectionCumTime(lapEC,end);
    
                diffSplits = roundn(splitECnew - splitECold, -2);
                SectionCumTime(lapEC,end) = splitECnew;
                SectionCumTime_long(lapEC,end) = splitECnew;
                SectionCumTime_short(lapEC,end) = splitECnew;
                SectionCumTimebis(lapEC,end) = splitECnew;
                
                SectionSplitTime(lapEC,end) = SectionSplitTime(lapEC,end) + diffSplits;
                SectionSplitTime_long(lapEC,end) = SectionSplitTime_long(lapEC,end) + diffSplits;
                SectionSplitTime_short(lapEC,end) = SectionSplitTime_short(lapEC,end) + diffSplits;
                SectionSplitTimebis(lapEC,end) = SectionSplitTimebis(lapEC,end) + diffSplits;
    
                SplitsAllSave(lapEC+1,2) = splitECnew;

                dataMatCumSplitsPacing_short(nbZone.*lapEC, 1) = splitECnew;
                dataMatCumSplitsPacing_long(nbZone.*lapEC, 1) = splitECnew;
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
        
        NbRows = SplitsAll(NbLap+1,3);
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

            if RaceDist == 50;
                keyDist = [NaN NaN 15 NaN 25; ...
                    NaN 35 NaN 45 50];
                keyDistbis = [NaN NaN 15 NaN 25; ...
                    NaN 35 NaN 45 50];
                keySeg = [0 15 25; ...
                    35 45 50];
            elseif RaceDist == 100;
                keyDist = [NaN NaN 15 20 25; ...
                    NaN 35 NaN 45 50; ...
                    NaN 60 NaN 70 75; ...
                    NaN 85 NaN 95 100];
                keyDistbis = [NaN NaN 15 20 25; ...
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
                keyDistbis = [NaN NaN 15 20 25; ...
                    NaN 35 NaN 45 50; ...
                    NaN 60 NaN 70 75; ...
                    NaN 85 NaN 95 100; ...
                    NaN 110 NaN 120 125; ...
                    NaN 135 NaN 145 150];
                keySeg = [15 20 25; 35 45 50; ...
                    60 70 75; 85 95 100; ...
                    110 120 125; 135 145 150];
            elseif RaceDist == 200;
                keyDist = [NaN NaN NaN NaN 25; ...
                    NaN NaN NaN NaN 50; ...
                    NaN NaN NaN NaN 75; ...
                    NaN NaN NaN NaN 100; ...
                    NaN NaN NaN NaN 125; ...
                    NaN NaN NaN NaN 150; ...
                    NaN NaN NaN NaN 175; ...
                    NaN NaN NaN NaN 200];
                keyDistbis = [NaN NaN 15 20 25; ...
                    NaN 35 NaN 45 50; ...
                    NaN 60 NaN 70 75; ...
                    NaN 85 NaN 95 100; ...
                    NaN 110 NaN 120 125; ...
                    NaN 135 NaN 145 150; ...
                    NaN 160 NaN 170 175; ...
                    NaN 185 NaN 195 200];
                keySeg = [15 20 25; 35 45 50; ...
                    60 70 75; 85 95 100; ...
                    110 120 125; 135 145 150; ...
                    160 170 175; 185 195 200];
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
                keyDistbis = [NaN NaN 15 20 25; ...
                    NaN 35 NaN 45 50; ...
                    NaN 60 NaN 70 75; ...
                    NaN 85 NaN 95 100; ...
                    NaN 110 NaN 120 125; ...
                    NaN 135 NaN 145 150; ...
                    NaN 160 NaN 170 175; ...
                    NaN 185 NaN 195 200; ...
                    NaN 210 NaN 220 225; ...
                    NaN 235 NaN 245 250; ...
                    NaN 260 NaN 270 275; ...
                    NaN 285 NaN 295 300; ...
                    NaN 310 NaN 320 325; ...
                    NaN 335 NaN 345 350; ...
                    NaN 360 NaN 370 375; ...
                    NaN 385 NaN 395 400];
                keySeg = [15 20 25; 35 45 50; ...
                    60 70 75; 85 95 100; ...
                    110 120 125; 135 145 150; ...
                    160 170 175; 185 195 200; ...
                    210 220 225; 235 245 250; ...
                    260 270 275; 285 295 300; ...
                    310 320 325; 335 345 350; ...
                    360 370 375; 385 395 400];
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
                keyDistbis = [NaN NaN 15 20 25; ...
                    NaN 35 NaN 45 50; ...
                    NaN 60 NaN 70 75; ...
                    NaN 85 NaN 95 100; ...
                    NaN 110 NaN 120 125; ...
                    NaN 135 NaN 145 150; ...
                    NaN 160 NaN 170 175; ...
                    NaN 185 NaN 195 200; ...
                    NaN 210 NaN 220 225; ...
                    NaN 235 NaN 245 250; ...
                    NaN 260 NaN 270 275; ...
                    NaN 285 NaN 295 300; ...
                    NaN 310 NaN 320 325; ...
                    NaN 335 NaN 345 350; ...
                    NaN 360 NaN 370 375; ...
                    NaN 395 NaN 395 400; ...
                    NaN 410 NaN 420 425; ...
                    NaN 435 NaN 445 450; ...
                    NaN 460 NaN 470 475; ...
                    NaN 485 NaN 495 500; ...
                    NaN 510 NaN 520 525; ...
                    NaN 535 NaN 545 550; ...
                    NaN 560 NaN 570 575; ...
                    NaN 585 NaN 595 600; ...
                    NaN 610 NaN 620 625; ...
                    NaN 635 NaN 645 650; ...
                    NaN 660 NaN 670 675; ...
                    NaN 685 NaN 695 700; ...
                    NaN 710 NaN 720 725; ...
                    NaN 735 NaN 745 750; ...
                    NaN 760 NaN 770 775; ...
                    NaN 785 NaN 795 800];
                keySeg = [15 20 25; 35 45 50; ...
                    60 70 75; 85 95 100; ...
                    110 120 125; 135 145 150; ...
                    160 170 175; 185 195 200; ...
                    210 220 225; 235 245 250; ...
                    260 270 275; 285 295 300; ...
                    310 320 325; 335 345 350; ...
                    360 370 375; 385 395 400; ...
                    410 420 425; 435 445 450; ...
                    460 470 475; 485 495 500; ...
                    510 520 525; 535 545 550; ...
                    560 570 575; 585 595 600; ...
                    610 620 625; 635 645 650; ...
                    660 670 675; 685 695 700; ...
                    710 720 725; 735 745 750; ...
                    760 770 775; 785 795 800];
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
                    NaN NaN NaN NaN 525;...
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
                keyDistbis = [NaN NaN 15 20 25; ...
                    NaN 35 NaN 45 50; ...
                    NaN 60 NaN 70 75; ...
                    NaN 85 NaN 95 100; ...
                    NaN 110 NaN 120 125; ...
                    NaN 135 NaN 145 150; ...
                    NaN 160 NaN 170 175; ...
                    NaN 185 NaN 195 200; ...
                    NaN 210 NaN 220 225; ...
                    NaN 235 NaN 245 250; ...
                    NaN 260 NaN 270 275; ...
                    NaN 285 NaN 295 300; ...
                    NaN 310 NaN 320 325; ...
                    NaN 335 NaN 345 350; ...
                    NaN 360 NaN 370 375; ...
                    NaN 385 NaN 395 400; ...
                    NaN 410 NaN 420 425; ...
                    NaN 435 NaN 445 450; ...
                    NaN 460 NaN 470 475; ...
                    NaN 485 NaN 495 500; ...
                    NaN 510 NaN 520 525; ...
                    NaN 535 NaN 545 550; ...
                    NaN 560 NaN 570 575; ...
                    NaN 585 NaN 595 600; ...
                    NaN 610 NaN 620 625; ...
                    NaN 635 NaN 645 650; ...
                    NaN 660 NaN 670 675; ...
                    NaN 685 NaN 695 700; ...
                    NaN 710 NaN 720 725; ...
                    NaN 735 NaN 745 750; ...
                    NaN 760 NaN 770 775; ...
                    NaN 785 NaN 795 800; ...
                    NaN 810 NaN 820 825; ...
                    NaN 835 NaN 845 850; ...
                    NaN 860 NaN 870 875; ...
                    NaN 885 NaN 895 900; ...
                    NaN 910 NaN 920 925; ...
                    NaN 935 NaN 945 950; ...
                    NaN 960 NaN 970 975; ...
                    NaN 985 NaN 995 1000; ...
                    NaN 1010 NaN 1020 1025; ...
                    NaN 1035 NaN 1045 1050; ...
                    NaN 1060 NaN 1070 1075; ...
                    NaN 1085 NaN 1095 1100; ...
                    NaN 1110 NaN 1120 1125; ...
                    NaN 1135 NaN 1145 1150; ...
                    NaN 1160 NaN 1170 1175; ...
                    NaN 1185 NaN 1195 1200; ...
                    NaN 1210 NaN 1220 1225; ...
                    NaN 1235 NaN 1245 1250; ...
                    NaN 1260 NaN 1270 1275; ...
                    NaN 1285 NaN 1295 1300; ...
                    NaN 1310 NaN 1320 1325; ...
                    NaN 1335 NaN 1345 1350; ...
                    NaN 1360 NaN 1370 1375; ...
                    NaN 1385 NaN 1395 1400; ...
                    NaN 1410 NaN 1420 1425; ...
                    NaN 1435 NaN 1445 1450; ...
                    NaN 1460 NaN 1470 1475; ...
                    NaN 1485 NaN 1495 1500];
                keySeg = [15 20 25; 35 45 50; ...
                    60 70 75; 85 95 100; ...
                    110 120 125; 135 145 150; ...
                    160 170 175; 185 195 200; ...
                    210 220 225; 235 245 250; ...
                    260 270 275; 285 295 300; ...
                    310 320 325; 335 345 350; ...
                    360 370 375; 385 395 400; ...
                    410 420 425; 435 445 450; ...
                    460 470 475; 485 495 500; ...
                    510 520 525; 535 545 550; ...
                    560 570 575; 585 595 600; ...
                    610 620 625; 635 645 650; ...
                    660 670 675; 685 695 700; ...
                    710 720 725; 735 745 750; ...
                    760 770 775; 785 795 800; ...
                    810 820 825; 835 845 850; ...
                    860 870 875; 885 895 900; ...
                    910 920 925; 935 945 950; ...
                    960 970 975; 985 995 1000; ...
                    1010 1020 1025; 1035 1045 1050; ...
                    1060 1070 1075; 1085 1095 1100; ...
                    1110 1120 1125; 1135 1145 1150; ...
                    1160 1170 1175; 1185 1195 1200; ...
                    1210 1220 1225; 1235 1245 1250; ...
                    1260 1270 1275; 1285 1295 1300; ...
                    1310 1320 1325; 1335 1345 1350; ...
                    1360 1370 1375; 1385 1395 1400; ...
                    1410 1420 1425; 1435 1445 1450; ...
                    1460 1470 1475; 1485 1495 1500];
            end;

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
            if RaceDist == 50;
                perfectDist = [0 15 20 25 15 5 0];
            elseif RaceDist == 150;
                perfectDist = [0 15 20 25 15 5 0 ...
                    10 15 20 25 15 5 0 ...
                    15 20 25 15 5 0];
            else;
                perfectDist = [0 15 20 25 15 5 0 10 20 25 15 5 0];
                if RaceDist > 100;
                    for lap100 = 2:((RaceDist./Course)./4);
                        perfectDist = [perfectDist 10 20 25 15 5 0 10 20 25 15 5 0];
                    end;
                end;
            end;
        end;

        lap = 1;
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
            BOminus1s = roundn((BOAll(lap,1)-listart) - framerate,0);
            RawDistance(lapBeg:BOminus1s) = NaN;
            RawVelocity(lapBeg:BOminus1s) = NaN;

            lapEnd = SplitsAll(lap+1,3);
            indexStrokeLap = find(RaceStroke(:,4) <= lapEnd+listart);
            lilastStroke = RaceStroke(indexStrokeLap(end),4)-listart + 1;
            RawDistance(lilastStroke+1:lapEnd) = NaN;
            RawVelocity(lilastStroke+1:lapEnd) = NaN;
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
                if Course == 25;
                    indexnan = find(isnan(keyDistbis(lap,:)) == 0);
                else;
                    indexnan = find(isnan(keyDist(lap,:)) == 0);
                end;
                seg = 1;
            end;

            while proceed == 1;
                valIni = indexzeros(1);
                keySegLap = keySeg(lap,:);
                index = (keySegLap == 0);
                if isempty(index) == 0;
                    keySegLap(index) = [];
                end;
                if seg == length(keySegLap);
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
                if seg == length(keySegLap);
                    %last 5m: Last arm entry
                    indexStrokeLap = find(RaceStroke(:,4) <= lapEnd+listart);
                    lilastStroke = RaceStroke(indexStrokeLap(end),4)-listart + 1;
                    lilastStroke = lilastStroke;
                    if Course == 25;
                        valEnd = RaceLocation(indexkeyDist,4)-listart;
                    end;
                else;
                    valEnd = RaceLocation(indexkeyDist,4)-listart;
                end;

                if seg == length(keySegLap);
                    %include last 5m
                    if Course == 50;
                        if length(indexnan) == 1;
                            velRef = SectionVel(lap,indexnan(seg));
                        else;
                            velRef = SectionVel(lap,indexnan(seg-1));
                        end;
                    else;
                        if RaceDist == 50 & lap == 1;
                            velRef = SectionVel(lap,5);
                        else;
                            velRef = SectionVel(lap,4);
                        end;
                    end;

%                     if isnan(velRef) == 1;
%                         velRef = SectionVel(lap,indexnan(seg)-1);
%                         if isnan(velRef) == 1;
%                             velRef = SectionVel(lap,indexnan(seg)-2);
%                         end;
%                     end;
                    PosJump = (1/framerate).*velRef;
                else;
                    if lap ~= 1 & seg == 1;
                        %first seg of lap 2 and after
                        %vel is calculated from 60 to 65 and is not
                        %representative
                        %reculculate it from BO to 65 just to fill the gap
                        %properly
                        if Course == 50;
                            velRef = SectionVel(lap,indexnan(seg));
                            velRefAdj = (distEC - BOAll(lap,3)) / (SectionCumTime(lap,indexnan(seg)) - BOAll(lap,2));
                            PosJump = (1/framerate).*velRefAdj;
                        else;
                            velRef = SectionVel(lap,4);
                            PosJump = (1/framerate).*velRef;
                        end;
                    else;
                        if Course == 50;
                            velRef = SectionVel(lap,indexnan(seg));
                            if isnan(velRef) == 1;
                                if seg+1 <= length(indexnan);
                                    velRef = SectionVel(lap,indexnan(seg+1));
                                else;
                                    velRef = SectionVel(lap,indexnan(seg-1));
                                end;
                            end;
                        else;
                            if RaceDist == 50 & lap == 1;
                                velRef = SectionVel(lap,5);
                            else;
                                velRef = SectionVel(lap,4);
                            end;
                        end;
                        PosJump = (1/framerate).*velRef;
                    end;
                end;

                if seg == 1;
                    %put the BO position
                    liBOEC = BOAll(lap,1);
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
                elseif seg == length(keySegLap);
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

                if seg == length(keySegLap);
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
                liBOEC = RaceBO(BOEC,4);
                RawBreakout(1,liBOEC) = 1;
            end;
        end;
        for frameEC = 1:NbRows;
            RawTime(frameEC) = (frameEC-1).*(1./framerate);
        end;

        %---Adjust BOAll frame index
%         BOAll(:,1) = BOAll(:,1)-listart;
%         BOAll = roundn(BOAll,-2);
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
        turnAll = [];
        
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
        if Course == 25;
            li20 = find(RaceLocation(:,5) == 20);
            li15 = find(RaceLocation(:,5) == 15);
        else;
            li45 = find(RaceLocation(:,5) == 45);
            li40 = find(RaceLocation(:,5) == 40);
        end;
        li5 = find(RaceLocation(:,5) == 5);
        li10 = find(RaceLocation(:,5) == 10);

        for lap = 1:NbLap;
            if lap == 1;
                liSplit = SplitsAll(lap+1,3);
                liSplitPrev = 1;
                index = find(isnan(SectionVel(lap,:)) == 0);
%                 if Course == 50;
%                     if RaceDist <= 100;
                        if length(index) == 1;
                            VelLapAv(lap) = mean(SectionVel(lap,index));
                        else;
                            VelLapAv(lap) = mean(SectionVel(lap,index(2:end)));
                        end;
%                     else;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     end;
%                 else;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 end;
                
                if RaceDist <= 100;
                    index = find(keyDist(lap,:) == 15);
                    DiveT15 = SectionCumTime(lap,index);
                    DiveT15INI = SectionCumTime(lap,index);
                else;
                    index0 = find(RaceLocation(:,5) == 0);
                    index15 = find(RaceLocation(:,5) == 15);
                    DiveT15 = roundn((RaceLocation(index15(1),4) - RaceLocation(index0(1),4))./framerate,-2);
                    DiveT15INI = DiveT15;
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
                
                if rem(lap-1,2) == 1;
                    %turn 1, 3, 5, 7, ...
                    %take 45m and 40m
                    if Course == 25;
                        liTurnIn = li20(TurnOdd);
                        if TurnOdd == 1;
                            index2remove = find(li15 < liTurnIn);
                            if isempty(index2remove) == 0;
                                li15(index2remove) = [];
                            end;
                        end;
                        liTurnOut = li15(TurnOdd);
                    else;
                        liTurnIn = li45(TurnOdd);
                        liTurnOut = li40(TurnOdd);
                    end;
                    TurnOdd = TurnOdd + 1;
                else;
                    %turn 2, 4, 6, 8, ...
                    %take 5m and 10m
                    liTurnIn = li5(TurnEven);
                    liTurnOut = li10(TurnEven);
                    TurnEven = TurnEven + 1;
                end;

                frameTurnIn = RaceLocation(liTurnIn,4)-listart;
                frameTurnOut = RaceLocation(liTurnOut,4)-listart;
                Turn_Time(lap-1) = (frameTurnOut - frameTurnIn)./framerate;
                Turn_TimeIn(lap-1) =  (SplitsAll(lap,3) - frameTurnIn)./framerate;
                Turn_TimeOut(lap-1) = (frameTurnOut - SplitsAll(lap,3))./framerate;
                
                interpTurn = 0;
                turnAll = [Turn_TimeIn(lap-1) Turn_TimeOut(lap-1) interpTurn];

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

        DistENDLap = RaceDist - 5;
        indexEndLap = find(liDistLap(:,5) == DistENDLap);
        liEndLap = liDistLap(indexEndLap,4);
        TimeEndLap = (liEndLap - listart)./framerate;

        Last5m = roundn(dataMatCumSplitsPacing_short(end) - dataMatCumSplitsPacing_short(end-1), -2);
        Last5mINI = roundn(dataMatCumSplitsPacing_short(end) - dataMatCumSplitsPacing_short(end-1), -2);
        
        if RaceDist == Course;
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


        if RaceDist <= 100;
            refSectionVel = SectionVel_short;
            refSectionSR = SectionSR_short;
            refSectionSD = SectionSD_short;
        else;
            refSectionVel = SectionVel_long;
            refSectionSR = SectionSR_long;
            refSectionSD = SectionSD_long;
        end;


        [li,co] = size(refSectionVel);
        SectionVel2 = reshape(refSectionVel, li*co, 1);
        linan = find(isnan(SectionVel2) == 0);
        valmax = max(SectionVel2(linan));
        MaxVelDouble = roundn(valmax,-2);
        MaxVel = dataToStr(MaxVelDouble,2);
        [MaxVelLoc_Lap, MaxVelLoc_Seg] = find(refSectionVel == valmax);
        MaxVel = [MaxVel ' [Lap:' num2str(MaxVelLoc_Lap(1)) '-Seg:' num2str(MaxVelLoc_Seg(1)) ']'];
        valmean = mean(SectionVel2(linan));
        MeanVel = dataToStr(valmean,2);
        MaxVelString = [MeanVel ' / ' MaxVel];
        
        [li,co] = size(refSectionSR);
        SectionSR2 = reshape(refSectionSR, li*co, 1);
        linan = find(isnan(SectionSR2) == 0);
        valmax = max(SectionSR2(linan));
        MaxSRDouble = roundn(valmax,-2);
        MaxSR = dataToStr(MaxSRDouble,1);
        [MaxSRLoc_Lap, MaxSRLoc_Seg] = find(refSectionSR == valmax);
        MaxSR = [MaxSR ' [Lap:' num2str(MaxSRLoc_Lap(1)) '-Seg:' num2str(MaxSRLoc_Seg(1)) ']'];
        valmean = mean(SectionSR2(linan));
        MeanSR = dataToStr(valmean,1);
        MaxSR = [MeanSR ' / ' MaxSR];
        
        [li,co] = size(refSectionSD);
        SectionSD2 = reshape(refSectionSD, li*co, 1);
        linan = find(isnan(SectionSD2) == 0);
        valmax = max(SectionSD2(linan));
        MaxSDDouble = roundn(valmax,-2);
        MaxSD = dataToStr(MaxSDDouble,2);
        [MaxSDLoc_Lap, MaxSDLoc_Seg] = find(refSectionSD == valmax);
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
                indexNan = find(isnan(Stroke_VelocityDecay(lapEC,:)) == 1);
                if isempty(indexNan) == 0;
                    Stroke_VelocityDecay(lapEC,indexNan) = 0;
                end;
                index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
                if rem(length(index), 2) == 1;
                    %odd count of stroke (remove 3 strokes)
                    remStroke = 2;
                else;
                    remStroke = 1;
                end;

                Stroke_TimeDecay(lapEC, index(1):index(2)) = 0;
                Stroke_TimeDecay(lapEC, index(end)-remStroke:index(end)) = 0;
        
                Stroke_VelocityDecay(lapEC, index(1):index(2)) = 0;
                Stroke_VelocityDecay(lapEC, index(end)-remStroke:index(end)) = 0;
            end;

            %calculate value per cycle rather than per stroke
            Cycle_Time = [];
            Cycle_Velocity = [];
            Cycle_TimeTOT = [];
            Cycle_VelocityTOT = [];

            for lapEC = 1:NbLap;
                Stroke_VelocityDecayLap = Stroke_VelocityDecay(lapEC,:);
                indexNan = find(isnan(Stroke_VelocityDecayLap) == 1);
                if isempty(indexNan) == 0;
                    Stroke_VelocityDecay(lapEC,indexNan) = 0;
                end;
                index = find(Stroke_VelocityDecayLap == 0);
                Stroke_VelocityDecayLap(index) = [];
                
                Stroke_TimeDecayLap = Stroke_TimeDecay(lapEC,:);
                indexNan = find(isnan(Stroke_TimeDecayLap) == 1);
                if isempty(indexNan) == 0;
                    Stroke_TimeDecayLap(lapEC,indexNan) = 0;
                end;

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
           
        elseif strcmpi(StrokeType, 'Butterfly') | strcmpi(StrokeType, 'Breaststroke');
            %remove first and last strokes
            for lapEC = 1:NbLap;
                indexNan = find(isnan(Stroke_VelocityDecay(lapEC,:)) == 1);
                if isempty(indexNan) == 0;
                    Stroke_VelocityDecay(lapEC,indexNan) = 0;
                end;
                
                index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
                
                Stroke_TimeDecay(lapEC, index(1)) = 0;
                Stroke_TimeDecay(lapEC, index(end)-1:index(end)) = 0;
        
                Stroke_VelocityDecay(lapEC, index(1):index(2)) = 0;
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
                indexNan = find(isnan(Stroke_VelocityDecayLap) == 1);
                if isempty(indexNan) == 0;
                    Stroke_VelocityDecay(lapEC,indexNan) = 0;
                end;

                index = find(Stroke_VelocityDecayLap == 0);
                Stroke_VelocityDecayLap(index) = [];
                
                Stroke_TimeDecayLap = Stroke_TimeDecay(lapEC,:);
                indexNan = find(isnan(Stroke_TimeDecayLap) == 1);
                if isempty(indexNan) == 0;
                    Stroke_TimeDecayLap(lapEC,indexNan) = 0;
                end;

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
        
            index = find(isnan(Cycle_TimeTOT) == 0);
            Cycle_TimeTOT= Cycle_TimeTOT(index);
            StrokeTimeAll = sum(Cycle_TimeTOT);
            index = find(isnan(Cycle_VelocityTOT) == 0);
            Cycle_VelocityTOT= Cycle_VelocityTOT(index);
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
                indexNan = find(isnan(Stroke_VelocityDecay(lapEC,:)) == 1);
                if isempty(indexNan) == 0;
                    Stroke_VelocityDecay(lapEC,indexNan) = 0;
                end;
                if caseStroke(lapEC) == 1;
                    %remove first and last strokes
                    index = find(Stroke_VelocityDecay(lapEC,:) ~= 0);
            
                    Stroke_TimeDecay(lapEC, index(1)) = 0;
                    Stroke_TimeDecay(lapEC, index(end):index(end)+1) = 0;
        
                    Stroke_VelocityDecay(lapEC, index(1)) = 0;
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
        
                    Stroke_TimeDecay(lapEC, index(1):index(2)) = 0;
                    Stroke_TimeDecay(lapEC, index(end)-remStroke+1:index(end)+1) = 0;
        
                    Stroke_VelocityDecay(lapEC, index(1):index(2)) = 0;
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
                    indexNan = find(isnan(Stroke_VelocityDecayLap) == 1);
                    if isempty(indexNan) == 0;
                        Stroke_VelocityDecayLap(lapEC,indexNan) = 0;
                    end;
                    index = find(Stroke_VelocityDecayLap == 0);
                    Stroke_VelocityDecayLap(index) = [];
                    
                    Stroke_TimeDecayLap = Stroke_TimeDecay(lapEC,:);
                    indexNan = find(isnan(Stroke_TimeDecayLap) == 1);
                    if isempty(indexNan) == 0;
                        Stroke_TimeDecayLap(lapEC,indexNan) = 0;
                    end;

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
                    indexNan = find(isnan(Stroke_VelocityDecayLap) == 1);
                    if isempty(indexNan) == 0;
                        Stroke_VelocityDecayLap(lapEC,indexNan) = 0;
                    end;

                    index = find(Stroke_VelocityDecayLap == 0);
                    Stroke_VelocityDecayLap(index) = [];
                    
                    Stroke_TimeDecayLap = Stroke_TimeDecay(lapEC,:);
                    indexNan = find(isnan(Stroke_TimeDecayLap) == 1);
                    if isempty(indexNan) == 0;
                        Stroke_TimeDecayLap(lapEC,indexNan) = 0;
                    end;

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
            str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' (SP1)'];
        else;
            str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (SP1)'];
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
        for lap = 1:NbLap;
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
                        if lapEC < NbLap;
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
                        if lapEC < NbLap;
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
        for lap = 1:NbLap;
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
        for lap = 1:NbLap;
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
            for lap = 1:NbLap;
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
        isInterpolatedTurns = zeros(NbLap-1,3);
        for lap = 1:NbLap-1;
            %reverse the distance for each lap
            if rem(lap,2) == 1;
                %odd laps
                index50 = find(RaceLocation(:,5) == Course);
                index50 = index50((lap+1)/2);
                TurnLocation = RaceLocation(index50-2:index50+2,:);
                indexIn = find(TurnLocation(:,5) == Course-5);
                indexOut = find(TurnLocation(:,5) == Course-10); 
                if isnan(TurnLocation(indexIn,3)) == 1;
                    isInterpolatedTurns(lap,1) = 1;
                    isInterpolatedTurns(lap,3) = 1; 
                end;
                if isnan(TurnLocation(indexOut,3)) == 1;
                    isInterpolatedTurns(lap,2) = 1;
                    isInterpolatedTurns(lap,3) = 1;
                end;
            else;
                %even laps
                index0 = find(RaceLocation(:,5) == 0);
                index0 = index0((lap/2)+1);
                TurnLocation = RaceLocation(index0-2:index0+2,:);
                indexIn = find(TurnLocation(:,5) == 5);
                indexOut = find(TurnLocation(:,5) == 10); 
                if isnan(TurnLocation(indexIn,3)) == 1;
                    isInterpolatedTurns(lap,1) = 1;
                    isInterpolatedTurns(lap,3) = 1; 
                end;
                if isnan(TurnLocation(indexOut,3)) == 1;
                    isInterpolatedTurns(lap,2) = 1;
                    isInterpolatedTurns(lap,3) = 1;
                end;
            end;
        end;
        
        %Finish interpolation
        if RaceDist == 50 | RaceDist == 150;
            indexFinish = find(RaceLocation(:,5) == Course-5); 
            indexFinish = indexFinish(end);
        else;
            indexFinish = find(RaceLocation(:,5) == 5); 
            indexFinish = indexFinish(end);
        end;
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
        %------------------------------------------------------------------
        


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
        SectionCumTimePDF = [];
        SectionSplitTimePDF = [];
        SectionVelPDF = [];
        Source = 1;
        dataTablePacing = [];
        dataTableBreath = create_pacingtable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, ...
            StrokeType, Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
            isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, NbLap, ...
            RawDistanceINI, RawVelocityINI, RawTime, Breath_Frames, Stroke_Frame, Stroke_Time, BOAllINI, Last5m, RaceLocationEC, ...
            SectionCumTimeEC, SectionSplitTimeEC, SectionVelEC, SectionCumTimePDF, SectionSplitTimePDF, SectionVelPDF);

        [li,co] = size(isInterpolatedSplits);
        lapDist = 5:5:(NbLap.*Course);
        lapDist = NaN(1,length(lapDist));
        liINI = 1;
        liEND = nbzone;
        for lapEC = 1:NbLap;
            lapDist(1,liEND) = lapEC.*Course;
        
            liINI = liEND + 1;
            liEND = liINI + nbzone - 1;
        end;

        SectionVelNew_short = reshape(SectionVel_short', 1, li*co);
        SectionVelNew_long = reshape(SectionVel_long', 1, li*co);
        dataMatCumSplitsPacingNew_short = dataMatCumSplitsPacing_short;
        dataMatCumSplitsPacingNew_long = dataMatCumSplitsPacing_long;
        isInterpolatedSplitsStore = reshape(isInterpolatedSplits_short', 1, li*co);
        isInterpolatedVelStore = reshape(isInterpolatedVel', 1, li*co);
        

        dataTablePacing(:,2) = dataMatCumSplitsPacingNew_short';
        dataTablePacing(:,3) = dataMatCumSplitsPacingNew_long';
        dataTablePacing(:,4) = isInterpolatedSplitsStore';
        dataTablePacing(:,6) = SectionVelNew_short';
        dataTablePacing(:,7) = SectionVelNew_long';
        dataTablePacing(:,8) = isInterpolatedVelStore';

        %---interpolate speed
        dataTablePacing(:,5) = dataTablePacing(:,6);
        splitDistAll = 5:5:(NbLap*Course);
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


%         [SectionSR, isInterpolatedSR, SectionSD, isInterpolatedSD, SectionNb] = create_stroketable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, StrokeType, ...
%             Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
%             isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, ...
%             NbLap, Stroke_SR, Stroke_DistanceINI, Stroke_Frame, RawDistanceINI, RawVelocityINI, ...
%             RawStroke, RawTime, BOAllINI, ...
%             RaceLocation, SectionSD, SectionSR, SectionNb, SectionSDPDF, SectionSRPDF, SecSectionNbPDF);

        [li,co] = size(isInterpolatedSR);
        SectionSR_short = reshape(SectionSR_short', 1, li*co);
        SectionSR_long = reshape(SectionSR_long', 1, li*co);
        isInterpolatedSRStore = reshape(isInterpolatedSR_short', 1, li*co);
        SectionSD_short = reshape(SectionSD_short', 1, li*co);
        SectionSD_long = reshape(SectionSD_long', 1, li*co);
        isInterpolatedSDStore = reshape(isInterpolatedSD_short', 1, li*co);
        SectionNb_short = reshape(SectionNb_short', 1, li*co);
        SectionNb_long = reshape(SectionNb_long', 1, li*co);

        dataTableStroke = [];
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
        dataTableStroke(:,9) = SectionNb_short';
        dataTableStroke(:,10) = SectionNb_short';
        dataTableStroke(:,11) = SectionNb_long';
        lapEC = 1;

        dataTableSkill = create_skilltable_SP1Report_synchroniser(Athletename, Source, ...
            framerate, RaceDist, StrokeType, Meet, Year, ...
            valRelay, detailRelay, Course, Stage, SplitsAll, NbLap, ...
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





        %----------------------------Store data----------------------------
        onlinefinename = SwimsEC{1,4};
        if isempty(onlinefinename) == 1;
            onlinefinename = [lower(Athletename) '-' num2str(SwimsEC{1,1}) '-' num2str(SwimsEC{1,2}) '-' num2str(RaceDist) lower(StrokeType) lower(Stage)];
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
        filenameDBout = ['s3://sparta2-prod/sparta2-data/' Year '/' competitionName '/' uid '.mat'];

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
        eval([uid '.SectionCumTimebis = SectionCumTimebis;']);
        eval([uid '.SectionSplitTimebis = SectionSplitTimebis;']);
        eval([uid '.SectionVelbis = SectionVelbis;']);
        eval([uid '.SectionSRbis = SectionSRbis;']);
        eval([uid '.SectionSDbis = SectionSDbis;']);
        eval([uid '.SectionNbbis = SectionNbbis;']);

        
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
%         indexLapIni = 1;
%         for lapEC = 1:NbLap;
%             indexLapEnd = find(dataTableRefDist == lapLim(lapEC));
%             
%             dataVel = dataTablePacing(indexLapIni:indexLapEnd, colInterestVel);
%             indexNan = find(isnan(dataVel) == 1);
%             dataVel(indexNan) = [];
%             avVELlap = [avVELlap mean(dataVel)];
%         
%             dataSR = dataTableStroke(indexLapIni:indexLapEnd, colInterestSR);
%             indexNan = find(isnan(dataSR) == 1);
%             dataSR(indexNan) = [];
%             avSRlap = [avSRlap mean(dataSR)];
%         
%             dataDPS = dataTableStroke(indexLapIni:indexLapEnd, colInterestDPS);
%             indexNan = find(isnan(dataDPS) == 1);
%             dataDPS(indexNan) = [];
%             avDPSlap = [avDPSlap mean(dataDPS)];
%         
%             indexLapIni = indexLapEnd;
%         end;
        
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
                validIndex = [5; 9];
            elseif RaceDist == 100;
                validIndex = [4; 9; 14; 19];
            elseif RaceDist == 150;
                validIndex = [5; 10; 15; 20; 25; 30];
            elseif RaceDist == 200;
                validIndex = [5; 10; 15; 20; 25; 30; 35; 40];
            elseif RaceDist == 400;
                validIndex = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50; 55; 60; 65; 70; 75; 80];
            elseif RaceDist == 800;
                validIndex = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50; 55; 60; 65; 70; 75; 80; ...
                    85; 90; 95; 100; 105; 110; 115; 120; 125; 130; 135; 140; 145; 150; 155; 160];
            elseif RaceDist == 1500;
                validIndex = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50; 55; 60; 65; 70; 75; 80; ...
                    85; 90; 95; 100; 105; 110; 115; 120; 125; 130; 135; 140; 145; 150; 155; 160; ...
                    165; 170; 175; 180; 185; 190; 195; 200; 205; 210; 215; 220; 225; 230; 235; 240; ...
                    245; 250; 255; 260; 265; 270; 275; 280; 285; 290; 295; 300];
            end;
        end;
        VelLapAll = [];
        dataVELAll = [];
        if RaceDist <= 100;
            SectionVelNew_short = SectionVelNew_short';
            for lapEC = 1:NbLap;
                validIndexLap = validIndex(lapEC,:);
                indexNaN = find(isnan(validIndexLap) == 1);
                validIndexLap(indexNaN) = [];
                dataVelLap = SectionVelNew_short(validIndexLap, :);
                index = find(isnan(dataVelLap) == 0);
                dataVelLap = dataVelLap(index);
                dataVELAll = [dataVELAll; dataVelLap];
                VelLapAll(lapEC) = mean(dataVelLap);
            end;
        else;
            SectionVelNew_long = SectionVelNew_long';
            for lapEC = 1:NbLap;
                validIndexLap = validIndex(lapEC,:);
                indexNaN = find(isnan(validIndexLap) == 1);
                validIndexLap(indexNaN) = [];
                dataVelLap = SectionVelNew_long(validIndexLap, :);
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
            for lapEC = 1:NbLap;
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
            for lapEC = 1:NbLap;
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
                validIndex = [3 NaN 5; 7 9 10];
            elseif RaceDist == 100;
                validIndex = [3 4 5; 7 9 10; 12 14 15; 17 19 20];
            elseif RaceDist == 150;
                validIndex = [4; 9; 14; 19; 24; 29];
            elseif RaceDist == 200;
                validIndex = [5; 10; 15; 20; 25; 30; 35; 40];
            elseif RaceDist == 400;
                validIndex = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50; 55; 60; 65; 70; 75; 80];
            elseif RaceDist == 800;
                validIndex = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50; 55; 60; 65; 70; 75; 80; ...
                    85; 90; 95; 100; 105; 110; 115; 120; 125; 130; 135; 140; 145; 150; 155; 160];
            elseif RaceDist == 1500;
                validIndex = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50; 55; 60; 65; 70; 75; 80; ...
                    85; 90; 95; 100; 105; 110; 115; 120; 125; 130; 135; 140; 145; 150; 155; 160; ...
                    165; 170; 175; 180; 185; 190; 195; 200; 205; 210; 215; 220; 225; 230; 235; 240; ...
                    245; 250; 255; 260; 265; 270; 275; 280; 285; 290; 295; 300];
            end;
        end;
        
        SRLapAll = [];
        dataSRAll = [];
        if RaceDist <= 100;
            SectionSR_short = SectionSR_short';
            for lapEC = 1:NbLap;
                validIndexLap = validIndex(lapEC,:);
                indexNaN = find(isnan(validIndexLap) == 0);
                validIndexLap = validIndexLap(indexNaN);
                dataSRLap = SectionSR_short(validIndexLap, :);        
                index = find(isnan(dataSRLap) == 0);
                dataSRLap = dataSRLap(index);
                dataSRAll = [dataSRAll; dataSRLap];
                SRLapAll(lapEC) = mean(dataSRLap);
            end;
        else;
            SectionSR_long = SectionSR_long';
            for lapEC = 1:NbLap;
                validIndexLap = validIndex(lapEC,:);
                indexNaN = find(isnan(validIndexLap) == 0);
                validIndexLap = validIndexLap(indexNaN);
                dataSRLap = SectionSR_long(validIndexLap, :);        
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
            FullDB_SP1{1,1} = 'File';
            FullDB_SP1{1,2} = 'Name';
            FullDB_SP1{1,3} = 'Distance';
            FullDB_SP1{1,4} = 'Stroke';
            FullDB_SP1{1,5} = 'Gender';
            FullDB_SP1{1,6} = 'Round';
            FullDB_SP1{1,7} = 'Meet';
            FullDB_SP1{1,8} = 'Year';
            FullDB_SP1{1,9} = 'Lane';
            FullDB_SP1{1,10} = 'Course';
            FullDB_SP1{1,11} = 'Type';
            FullDB_SP1{1,12} = 'Category';
            FullDB_SP1{1,13} = 'DOB';
            FullDB_SP1{1,14} = 'Race Time';
            FullDB_SP1{1,15} = 'Skills (s)';
            FullDB_SP1{1,16} = 'Free Swim (s)';
            FullDB_SP1{1,17} = 'Drop-off (s)';
            FullDB_SP1{1,18} = 'Speed (Av./Max.) (m/s)';
            FullDB_SP1{1,19} = 'Av. SR (Av./Max.) (str/min)';
            FullDB_SP1{1,20} = 'Av. DPS (Av./Max.) (m)';
            FullDB_SP1{1,21} = 'Block (s)';
            FullDB_SP1{1,22} = 'Start (s)';
            FullDB_SP1{1,23} = 'Entry Dist (m)';
            FullDB_SP1{1,24} = 'Start UW. Speed (m/s)';
            FullDB_SP1{1,25} = 'Start BO. Dist (m) (Kicks)';
            FullDB_SP1{1,26} = 'Start BO. Skill (%)';
            FullDB_SP1{1,27} = 'Av. Turn (s) [in / out]';
            FullDB_SP1{1,28} = 'Turn App. Skill (%)';
            FullDB_SP1{1,29} = 'Turn BO. Dist (m) (Av. Kicks)';
            FullDB_SP1{1,30} = 'Turn BO. Skill (%)';
            FullDB_SP1{1,31} = 'Av. Stroke Index (m2/s/str)';
            FullDB_SP1{1,32} = 'Av. Swimming Speed (m/s)';
            FullDB_SP1{1,33} = 'Av. Stroke Rate (str/min)';
            FullDB_SP1{1,34} = 'Av. DPS (m)';
            FullDB_SP1{1,35} = 'Country';
            FullDB_SP1{1,36} = 'MeetID';
            FullDB_SP1{1,37} = 'AV. Turn In (s)';
            FullDB_SP1{1,38} = 'AV. Turn Out (s)';
            FullDB_SP1{1,39} = 'AV. Turn Tot (s)';
            FullDB_SP1{1,40} = 'AthleteID';
            FullDB_SP1{1,41} = 'Finish Time (s)';
            FullDB_SP1{1,42} = 'Speed Decay (% of time)';
            FullDB_SP1{1,43} = 'Speed Decay Ref (50% Max Speed)';
            FullDB_SP1{1,44} = 'Dist App (m)';
            FullDB_SP1{1,45} = 'Time App (s)';
            FullDB_SP1{1,46} = 'Eff App (%)';
            FullDB_SP1{1,47} = 'SI per lap';
            FullDB_SP1{1,48} = 'Speed per lap';
            FullDB_SP1{1,49} = 'SR per lap';
            FullDB_SP1{1,50} = 'DPS per lap';
            FullDB_SP1{1,51} = 'Splits per lap';
            FullDB_SP1{1,52} = 'All Turns';
            FullDB_SP1{1,53} = 'Relay Type';
            FullDB_SP1{1,54} = 'All turn UW. Speed (m/s)';
            FullDB_SP1{1,55} = 'Av turn UW. Speed (m/s)';
            FullDB_SP1{1,56} = 'Analysis Date';
            FullDB_SP1{1,57} = 'Race Date';
            FullDB_SP1{1,58} = 'Source';
            FullDB_SP1{1,59} = 'SpeedDecaySemiRange';
            FullDB_SP1{1,60} = 'SpeedDecayLongRange';
            FullDB_SP1{1,61} = 'SpeedDecaySprintMid';
            FullDB_SP1{1,62} = 'SpeedDecaySemiMid';
            FullDB_SP1{1,63} = 'SpeedDecayLongMid';
            FullDB_SP1{1,64} = 'Kick Count';
            FullDB_SP1{1,65} = 'JSON file';
            FullDB_SP1{1,66} = 'Data file';
            FullDB_SP1{1,67} = 'Metadata_PDF';
            FullDB_SP1{1,68} = 'Data Pacing PDF';
            FullDB_SP1{1,69} = 'Data Breath PDF';
            FullDB_SP1{1,70} = 'Data Stroke PDF';
            FullDB_SP1{1,71} = 'Data Skills PDF';
        end;

        if count == 1;
            li = 1;
        else;
            li = length(uidDB_SP1(:,1))+1;
        end;
        uidDB_SP1{li,1} = onlinefinename;
        uidDB_SP1{li,2} = FilenameNew;
        uidDB_SP1{li,3} = Athletename;
        uidDB_SP1{li,4} = num2str(RaceDist);
        uidDB_SP1{li,5} = StrokeType;
        uidDB_SP1{li,6} = Stage;
        uidDB_SP1{li,7} = Lane;
        uidDB_SP1{li,8} = Meet;
        uidDB_SP1{li,9} = Year;
        uidDB_SP1{li,10} = Gender;
        uidDB_SP1{li,11} = Course;
        uidDB_SP1{li,12} = SplitsAll(end,2);
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
        uidDB_SP1{li,13} = 'na';
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
        texterror = '';
        uidDB_SP1{li,14} = texterror;
        uidDB_SP1{li,15} = AthleteId;
        uidDB_SP1{li,16} = competitionId;
        uidDB_SP1{li,17} = BOEffCorr(1);
        uidDB_SP1{li,18} = TurnsAvBOEffCorr;
        uidDB_SP1{li,19} = avSI;
        uidDB_SP1{li,20} = avVEL;
        uidDB_SP1{li,21} = Country;
        uidDB_SP1{li,22} = SpeedDecaySprintRange;
        uidDB_SP1{li,23} = SpeedDecayRef;
        uidDB_SP1{li,24} = valRelay;
        uidDB_SP1{li,25} = detailRelay;
        uidDB_SP1{li,26} = 1; %Source
        uidDB_SP1{li,27} = SpeedDecaySemiRange;
        uidDB_SP1{li,28} = SpeedDecayLongRange;
        uidDB_SP1{li,29} = SpeedDecaySprintMid;
        uidDB_SP1{li,30} = SpeedDecaySemiMid;
        uidDB_SP1{li,31} = SpeedDecayLongMid;
        uidDB_SP1{li,32} = filenameDBout;
        uidDB_SP1{li,33} = 'None';
        uidDB_SP1{li,34} = DateString; %always last column


        if count == 1;
            li = 2;
        else;
            li = length(FullDB_SP1(:,1))+1;
        end;
        FullDB_SP1{li,1} = onlinefinename;
        FullDB_SP1{li,2} = AthletenameFull;
        FullDB_SP1{li,3} = num2str(RaceDist);
        FullDB_SP1{li,4} = StrokeType;
        FullDB_SP1{li,5} = Gender;
        FullDB_SP1{li,6} = Stage;
        FullDB_SP1{li,7} = Meet;
        FullDB_SP1{li,8} = Year;
        FullDB_SP1{li,9} = Lane;
        FullDB_SP1{li,10} = num2str(Course);
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
        FullDB_SP1{li,11} = valRelay;
        FullDB_SP1{li,12} = Paralympic;
        FullDB_SP1{li,13} = DOB;
        FullDB_SP1{li,14} = timeSecToStr(SplitsAll(end,2));
    %     FullDB{li,15} = timeSecToStr(TotalSkillTime);
        if isInterpolatedSkills == 1;
            FullDB_SP1{li,15} = [timeSecToStr(TotalSkillTimeINI) ' !'];
        else;
            FullDB_SP1{li,15} = timeSecToStr(TotalSkillTimeINI);
        end;
    %     FullDB{li,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTime,-2));
        FullDB_SP1{li,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2));
        FullDB_SP1{li,17} = TimeDropOff;
        FullDB_SP1{li,18} = MaxVelString;
        FullDB_SP1{li,19} = MaxSR;
        FullDB_SP1{li,20} = MaxSD;
        FullDB_SP1{li,21} = dataToStr(RT,2);
    %     FullDB{li,22} = dataToStr(DiveT15);
        if isInterpolatedDive == 1;
            FullDB_SP1{li,22} = [dataToStr(DiveT15INI,2) ' !'];
        else;
            FullDB_SP1{li,22} = dataToStr(DiveT15INI,2);
        end;
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
        if isempty(StartEntryDist) == 1;
            FullDB_SP1{li,23} = 'na'; %Entry
            FullDB_SP1{li,24} = 'na'; %UW Speed
        else;
            FullDB_SP1{li,23} = dataToStr(StartEntryDist,2); %Entry
            FullDB_SP1{li,24} = dataToStr(StartUWVelocity,2); %UW Speed
        end;
    %     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    %     FullDB{li,25} = dataToStr(roundn(BOAll(1,3),-2));
        interpolBO = find(isInterpolatedBO(:,1) == 1);
        if isempty(interpolBO) == 0;
            FullDB_SP1{li,25} = [dataToStr(BOAllINI(1,3),1) ' !'];
        else;
            FullDB_SP1{li,25} = dataToStr(BOAllINI(1,3),1);
        end;
        if isempty(KicksNb) == 0;
            if KicksNb(1) == 0;
                FullDB_SP1{li,25} = [dataToStr(BOAllINI(1,3),1) '  (na)'];
            else;
                KickTXT = num2str(KicksNb(1));
                FullDB_SP1{li,25} = [dataToStr(BOAllINI(1,3),1) '  (' KickTXT ' kicks)'];
            end;
        else;
            FullDB_SP1{li,25} = [dataToStr(BOAllINI(1,3),1) '  (na)'];
        end;
        val1 = dataToStr(BOEff(1).*100,1);
        val2 = dataToStr(VelBeforeBO(1),2);
        val3 = dataToStr(VelAfterBO(1),2);
        val4 = dataToStr(BOEffCorr(1).*100,1);    
        FullDB_SP1{li,26} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
    %     FullDB{li,27} = Turn_TimeTXT;
        
        index = find(isInterpolatedTurns == 1);
        if isempty(index) == 0;
            FullDB_SP1{li,27} = [Turn_TimeTXTINI ' !'];
        else;
            FullDB_SP1{li,27} = Turn_TimeTXTINI;
        end;

        val1 = dataToStr(mean(ApproachEff(1:end)).*100,1);
        val2 = dataToStr(mean(ApproachSpeed2CycleAll(1:end)),2);
        val3 = dataToStr(mean(ApproachSpeedLastCycleAll(1:end)),2);
        FullDB_SP1{li,28} = [val1 '  [' val2 ' / ' val3 ']'];
    %     FullDB{li,29} = Turn_BODistTXT;
        if Course == 50;
            if RaceDist == 50;
                FullDB_SP1{li,29} = [Turn_BODistTXTINI '  (na)'];
            else;
                if isempty(KicksNb) == 0
                    if roundn(mean(KicksNb(2:end)),0) == 0;
                        FullDB_SP1{li,29} = [Turn_BODistTXTINI '  (na)'];
                    else;
                        KickTXT = num2str(roundn(mean(KicksNb(2:end)),0));
                        FullDB_SP1{li,29} = [Turn_BODistTXTINI '  (' KickTXT ' kicks)'];
                    end;
                else;
                    FullDB_SP1{li,29} = [Turn_BODistTXTINI '  (na)'];
                end;
            end;
        else
            if isempty(KicksNb) == 0
                if roundn(mean(KicksNb(2:end)),0) == 0;
                    FullDB_SP1{li,29} = [Turn_BODistTXTINI '  (na)'];
                else;
                    KickTXT = num2str(roundn(mean(KicksNb(2:end)),0));
                    FullDB_SP1{li,29} = [Turn_BODistTXTINI '  (' KickTXT ' kicks)'];
                end;
            else;
                FullDB_SP1{li,29} = [Turn_BODistTXTINI '  (na)'];
            end;
        end;
        val1 = dataToStr(mean(BOEff(2:end)).*100,1);
        val2 = dataToStr(mean(VelBeforeBO(2:end)),2);
        val3 = dataToStr(mean(VelAfterBO(2:end)),2);
        val4 = dataToStr(mean(BOEffCorr(2:end).*100),1);
        FullDB_SP1{li,30} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
        FullDB_SP1{li,31} = dataToStr(avSI,2);
        FullDB_SP1{li,32} = dataToStr(avVEL,2);
        FullDB_SP1{li,33} = dataToStr(avSR,1);
        FullDB_SP1{li,34} = dataToStr(avDPS,2);
        FullDB_SP1{li,35} = Country;  
        FullDB_SP1{li,36} = ['A' num2str(competitionId) '_' Year 'A'];
        if RaceDist == 50;
            FullDB_SP1{li,37} = 'na';
            FullDB_SP1{li,38} = 'na';
            FullDB_SP1{li,39} = 'na';
        else;
            if isempty(turnAll) == 0;
                index = find(turnAll(:,3) == 1);
            else;
                index = 1;
            end;
            if isempty(index) == 0;
                FullDB_SP1{li,37} = [dataToStr(TurnsAvINI(1,1),2) ' !'];
                FullDB_SP1{li,38} = [dataToStr(TurnsAvINI(1,2),2) ' !'];
                FullDB_SP1{li,39} = [dataToStr(TurnsAvINI(1,3),2) ' !'];
            else;
                FullDB_SP1{li,37} = dataToStr(TurnsAvINI(1,1),2);
                FullDB_SP1{li,38} = dataToStr(TurnsAvINI(1,2),2);
                FullDB_SP1{li,39} = dataToStr(TurnsAvINI(1,3),2);
            end;
        end;
        FullDB_SP1{li,40} = AthleteId;
        FullDB_SP1{li,41} = Last5mINI;
        FullDB_SP1{li,42} = SpeedDecaySprintRange;
        FullDB_SP1{li,43} = SpeedDecayRef;
        FullDB_SP1{li,44} = GlideLastStrokeEC(3,end);
        FullDB_SP1{li,45} = GlideLastStrokeEC(4,end);
        FullDB_SP1{li,46} = ApproachEff(1,end);
        FullDB_SP1{li,47} = avSIlap;
        FullDB_SP1{li,48} = avVELlap;
        FullDB_SP1{li,49} = avSRlap;
        FullDB_SP1{li,50} = avDPSlap;
        for lap = 2:length(SplitsAll(:,2));
            if lap == 2;
                SplitsLap(lap) = SplitsAll(lap,2);
            else;
                SplitsLap(lap) = SplitsAll(lap,2) - SplitsAll(lap-1,2);
            end;
        end;
        SplitsLap = SplitsLap(2:end);
        FullDB_SP1{li,51} = SplitsLap;
        if RaceDist == 50;
            FullDB_SP1{li,52} = 'na';
        else;
            FullDB_SP1{li,52} = Turn_Time;
        end;
        FullDB_SP1{li,53} = detailRelay;
        FullDB_SP1{li,54} = TurnUWVelocity;
        FullDB_SP1{li,55} = mean(TurnUWVelocity);
        FullDB_SP1{li,56} = AnalysisDate;
        FullDB_SP1{li,57} = RaceDateMod;
        FullDB_SP1{li,58} = 1; %Source
        FullDB_SP1{li,59} = SpeedDecaySemiRange;
        FullDB_SP1{li,60} = SpeedDecayLongRange;
        FullDB_SP1{li,61} = SpeedDecaySprintMid;
        FullDB_SP1{li,62} = SpeedDecaySemiMid;
        FullDB_SP1{li,63} = SpeedDecayLongMid;
        FullDB_SP1{li,64} = KicksNb;
        FullDB_SP1{li,65} = filenameDBout;
        FullDB_SP1{li,66} = 'None';
        FullDB_SP1{li,67} = metaData_PDF;
        FullDB_SP1{li,68} = dataTablePacing;
        FullDB_SP1{li,69} = dataTableBreath;
        FullDB_SP1{li,70} = dataTableStroke;
        FullDB_SP1{li,71} = dataTableSkill;


        %look for AgeGroup_SP1
        existmeet = isfield(AgeGroup_SP1, ['A' num2str(competitionId) '_' Year 'A']);
        if existmeet == 1;
            eval(['check = AgeGroup_SP1.A' num2str(competitionId) '_' Year 'A;']);
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
                eval(['AgeGroup_SP1.A' num2str(competitionId) '_' Year 'A = ' '''' RaceDateMod '''' ';']);
            end;
        else;
            eval(['AgeGroup_SP1.A' num2str(competitionId) '_' Year 'A = ' '''' RaceDateMod '''' ';']);
        end;


        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            filenameDBin = [MDIR '\SP2Synchroniser\RaceDB\' uid '.mat'];
        elseif ismac == 1;
            filenameDBin = ['/Applications/SP2Synchroniser/RaceDB/' uid '.mat'];
        end;
        save(filenameDBin, uid, 'graph1PacingAxes', 'graph1_Distance', 'graph1_gtit', 'axescolbar', 'colbar');

        %upload data file to the cloud
        command = ['aws s3 cp ' filenameDBin ' ' filenameDBout];
        [status, out] = system(command);

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

        AllDB.uidDB_SP1 = uidDB_SP1;
        AllDB.FullDB_SP1 = FullDB_SP1;
        AllDB.AthletesDB = AthletesDB;
        AllDB.ParaDB = ParaDB;
        AllDB.PBsDB = PBsDB;
        AllDB.PBsDB_SC = PBsDB_SC;
        AllDB.AgeGroup_SP1 = AgeGroup_SP1;
        AllDB.MeetDB = MeetDB;
        AllDB.RoundDB = RoundDB;


        %----------------------------------------------------------
%     end;
% end;