% function dataTableStroke = create_stroketable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, StrokeType, ...
%     Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
%     isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, ...
%     NbLap, SREC, SDEC, Stroke_Frame, DistanceEC, VelocityEC, ...
%     StrokeEC, TimeEC, BOAll, ...
%     RaceLocation, SectionSD, SectionSR, SectionNb, SectionSDPDF, SectionSRPDF, SecSectionNbPDF);

function [SectionSR, isInterpolatedSR, SectionSD, isInterpolatedSD, SectionNb] = create_stroketable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, StrokeType, ...
    Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
    isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, ...
    NbLap, SREC, SDEC, Stroke_Frame, DistanceEC, VelocityEC, ...
    StrokeEC, TimeEC, BOAll, ...
    RaceLocation, SectionSD, SectionSR, SectionNb, SectionSDPDF, SectionSRPDF, SecSectionNbPDF);



dataTableStroke = {};
dataTableStroke{1,2} = 'Metadata';
dataTableStroke{8,2} = 'Stroke Management';
dataTableStroke{9,1} = 'SR / SL / Stroke';

SectionSRALL = [];
SectionSDALL = [];
SectionVelALL = [];
SectionSRALLbis = [];
SectionSDALLbis = [];
SectionVelALLbis = [];

%----------------------------------Meta--------------------------------
dataTableStroke{2,3} = Athletename;
RaceDist = roundn(RaceDist,0);
str = [num2str(RaceDist) '-' StrokeType];
dataTableStroke{3,3} = str;
str = [Meet '-' num2str(Year)];
dataTableStroke{4,3} = str;

if strcmpi(detailRelay, 'None') == 1;
    str = Stage;
else;
    str = [Stage ' - ' detailRelay ' ' valRelay];
end;
dataTableStroke{5,3} = str;

TT = SplitsAll(end,2);
TTtxt = timeSecToStr(TT);
dataTableStroke{6,3} = TTtxt;

if Source == 1;
    dataTableStroke{7,3} = 'Sparta 1';
elseif Source == 2;
    dataTableStroke{7,3} = 'Sparta 2';
elseif Source == 3;
    dataTableStroke{7,3} = 'GreenEye';
end;

idx = isstrprop(Meet,'upper');
MeetShort = Meet(idx);
if strcmpi(Stage, 'Semi-Final');
    StageShort = 'SF';
elseif strcmpi(Stage, 'Semi-final');
    StageShort = 'SF';
else;
    StageShort = Stage;
end;
YearShort = Year(3:4);
graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
storeTitle2{1} = graphTitle2;

%---------------------------------Stroke-------------------------------
colorrow(9,:) = [1 0.9 0.70];
lineEC = 10;
for lap = 1:NbLap;
    dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];

    if Course == 25;
        dataTableStroke{lineEC+1,2} = '0m-5m';
        dataTableStroke{lineEC+2,2} = '5m-10m';
        dataTableStroke{lineEC+3,2} = '10m-15m';
        dataTableStroke{lineEC+4,2} = '15m-20m';
        dataTableStroke{lineEC+5,2} = '20m-Last arm entry';

        lineEC = lineEC + 6;
    else;
        dataTableStroke{lineEC+1,2} = '0m-5m';
        dataTableStroke{lineEC+2,2} = '5m-10m';
        dataTableStroke{lineEC+3,2} = '10m-15m';
        dataTableStroke{lineEC+4,2} = '15m-20m';
        dataTableStroke{lineEC+5,2} = '20m-25m';
        dataTableStroke{lineEC+6,2} = '25m-30m';
        dataTableStroke{lineEC+7,2} = '30m-35m';
        dataTableStroke{lineEC+8,2} = '35m-40m';
        dataTableStroke{lineEC+9,2} = '40m-45m';
        dataTableStroke{lineEC+10,2} = '45m-Last arm entry';

        lineEC = lineEC + 11;
    end;
end;

%calculate values per 5m-sections
SplitsAll = SplitsAll(2:end,:);
if Source == 1 | Source == 3;
    isInterpolatedBO = BOAll(:,4);
    BOAll = BOAll(:,1:3);
else;
    isInterpolatedBO = zeros(NbLap,1);
end;

lengthdata = [length(DistanceEC) length(VelocityEC) length(TimeEC)];
if isempty(find(diff(lengthdata) ~= 0)) == 0;
    [minVal, minLoc] = min(lengthdata);
    if minLoc == 1;
        %Adjust Vel and Time
        VelocityEC = VelocityEC(1:length(DistanceEC));
        TimeEC = TimeEC(1:length(DistanceEC));
    elseif minLoc == 2;
        %Adjust Dist and Time
        DistanceEC = DistanceEC(1:length(VelocityEC));
        TimeEC = TimeEC(1:length(VelocityEC));
    elseif minLoc == 3;
        %Adjust Dist and Vel
        DistanceEC = DistanceEC(1:length(TimeEC));
        VelocityEC = VelocityEC(1:length(TimeEC));
    end;
end;

nbZones = Course./5;
if Source == 2;
    %calculate SR per sections
    %find legs if IM
    if strcmpi(lower(StrokeType), 'medley');
        if Course == 25;
            if RaceDist == 100;
                legsIM = [1;2;3;4];
            elseif RaceDist == 150;
                legsIM = [[1 2]; [3 4]; [5 6]];
            elseif RaceDist == 200;
                legsIM = [[1 2]; [3 4]; [5 6]; [7 8]];
            elseif RaceDist == 400;
                legsIM = [[1 2 3 4]; [5 6 7 8]; [9 10 11 12]; [13 14 15 16]];
            end;
        elseif Course == 50;
            if RaceDist == 150;
                legsIM = [1; 2; 3];
            elseif RaceDist == 200;
                legsIM = [1; 2; 3; 4];
            elseif RaceDist == 400;
                legsIM = [[1 2]; [3 4]; [5 6]; [7 8]];
            end;
        end;
    else;
        legsIM = [];
    end;

    %restructure Stroke_Frame
    Stroke_FrameRestruc = [];
    for lapEC = 1:NbLap;
        indexZero = find(Stroke_Frame(lapEC,:) ~= 0);
        Stroke_FrameRestruc = [Stroke_FrameRestruc Stroke_Frame(lapEC, indexZero)];
    end;

    lapLim = Course:Course:RaceDist;
    lapEC = 1;
    updateLap = 0;
    SectionSR = [];
    SectionSD = [];
    SectionNb = [];

    if Course == 25;

    elseif Course == 50;

        dataZone = [];
        totZone = NbLap.*(Course./5);
        distIni = 0;
        jumDist = 5;
        for zEC = 1:totZone;
            dataZone(zEC,:) = [distIni distIni+5];
            distIni = distIni + 5;
        end;
        zoneSR = 1;
        
        for zoneEC = 1:totZone;

            SREC = [];
            searchExtraStroke = [];
            zone_dist_ini = dataZone(zoneEC,1);
            zone_dist_end = dataZone(zoneEC,2);

            indexLap = find(lapLim == zone_dist_ini);
            if zone_dist_ini == 0;
                %zone beginning is 0
                zone_frame_ini = 1;
            
            else;
                if isempty(indexLap) == 0;
                    %Zone beginning is matching with a lap
                    zone_frame_ini = SplitsAll(indexLap,3);
            
                else;
                    %Zone beginning is mid-pool
                    [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
                    zone_frame_ini = minLoc(1);
                end;
            end;

            indexLap = find(lapLim == zone_dist_end);
            if isempty(indexLap) == 0;
                %Last zone for a lap, remove 2m
                updateLap = 1;
            end;

            if zone_dist_end == 0;
                %zone end is 0
                zone_frame_end = 1;
            else;
                if isempty(indexLap) == 0;
                    %Zone end is matching with a lap
                    zone_frame_end = SplitsAll(indexLap,3);

                else;
                    %Zone end is mid-pool
                    [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                    zone_frame_end = minLoc(1);
                end;
            end;
            
            if isempty(indexLap) == 0;
                %last zone of the lap: take the previous zone to look
                %for other strokes
                searchExtraStroke = 'pre';
                updateLap = 1;
            else;
                %other zones: take the next zone to look
                %for other strokes
                searchExtraStroke = 'post';
            end;
            
            if zoneEC == totZone;
                li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc <= zone_frame_end);
            else;
                li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc < zone_frame_end);
            end;
            strokeList = Stroke_FrameRestruc(1,li_stroke);
            strokeCount = length(strokeList);
            SectionNb(lapEC,zoneSR) = strokeCount;

            if strokeCount < 2;
                %no stroke rate if count if 1
                SREC = [];

            else;
                if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                    if rem(strokeCount,2) == 1;
                        %odd stroke count: no need for another stroke
                        
                    else;
                        %even stroke count: add another stroke to get a
                        %full cycle
                        if strcmpi(searchExtraStroke, 'pre');
                            %look for stroke in the 10s leading to the
                            %zone
                            zone_frame_iniExtra = zone_frame_ini - (10*framerate);
                            zone_frame_endExtra = strokeList(1) - 1;
                            
                            %take the last stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            li_strokeExtra = li_strokeExtra(end);

                            strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                            
                        elseif strcmpi(searchExtraStroke, 'post');
                            %look for stroke in the 10s leading to the
                            %zone
                            zone_frame_endExtra = zone_frame_end + (10*framerate);
                            zone_frame_iniExtra = strokeList(end) + 1;

                            %take the first stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            li_strokeExtra = li_strokeExtra(1);

                            strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                        end;
                    end;

                    for strokeEC = 2:length(strokeList);
                        durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                        SREC(strokeEC-1) = 60/durationStroke;
                        SREC(strokeEC-1) = SREC(strokeEC-1)./2;
                    end;
                    SREC = mean(SREC);

                elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
                    for strokeEC = 2:length(strokeList);
                        durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                        SREC(strokeEC-1) = 60/durationStroke;
                    end;
                    SREC = mean(SREC);

                elseif strcmpi(lower(StrokeType), 'medley');
                    [li, co] = find(legsIM == lapEC);
                    if li == 1 | li == 3;
                        %butterfly and breaststroke legs
                        for strokeEC = 2:length(strokeList);
                            durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                            SREC(strokeEC-1) = 60/durationStroke;
                        end;
                        SREC = mean(SREC);
                    else;
                        %backstroke and freestyle legs
                        if rem(strokeCount,2) == 1;
                        %odd stroke count: no need for another stroke
                        
                        else;
                            %even stroke count: add another stroke to get a
                            %full cycle
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 10s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (10*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_stroke(end);

                                strokeList = [strokeList li_strokeExtra];

                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 10s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (10*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;

                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_stroke(1);

                                strokeList = [strokeList li_strokeExtra];
                            end;
                        end;

                        for strokeEC = 2:length(strokeList);
                            durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                            SREC(strokeEC-1) = 60/durationStroke;
                            SREC(strokeEC-1) = SREC(strokeEC-1)./2;
                        end;
                        SREC = mean(SREC);

                    end;
                end;
                SectionSR(lapEC,zoneSR) = SREC;
            end;
            zoneSR = zoneSR + 1;

            if updateLap == 1;
                updateLap = 0;
                lapEC = lapEC + 1;
                zoneSR = 1;
            end;
        end;
    end;


    %calculate DPS per sections
    if Course == 25;

    elseif Course == 50;
        lapEC = 1;
        updateLap = 0;
        SectionSD = [];
        zoneSD = 1;

        for zoneEC = 1:totZone;

            DPSEC = [];
            searchExtraStroke = [];
            zone_dist_ini = dataZone(zoneEC,1);
            zone_dist_end = dataZone(zoneEC,2);

            indexLap = find(lapLim == zone_dist_ini);
            if zone_dist_ini == 0;
                %zone beginning is 0
                zone_frame_ini = 1;
            
            else;
                if isempty(indexLap) == 0;
                    %Zone beginning is matching with a lap
                    zone_frame_ini = SplitsAll(indexLap,3);
            
                else;
                    %Zone beginning is mid-pool
                    [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
                    zone_frame_ini = minLoc(1);
                end;
            end;
            
            indexLap = find(lapLim == zone_dist_end);
            if isempty(indexLap) == 0;
                %Last zone for a lap, remove 2m
                zone_dist_end = zone_dist_end-2;
                updateLap = 1;
            end;
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
            zone_frame_end = minLoc(1);
            
            if isempty(indexLap) == 0;
                %last zone of the lap: take the previous zone to look
                %for other strokes
                searchExtraStroke = 'pre';
                updateLap = 1;
            else;
                %other zones: take the next zone to look
                %for other strokes
                searchExtraStroke = 'post';
            end;
            
            if zoneEC == totZone;
                li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc <= zone_frame_end);
            else;
                li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc < zone_frame_end);
            end;
            strokeList = Stroke_FrameRestruc(1,li_stroke);
            strokeCount = length(strokeList);

            if strokeCount < 2;
                %no stroke rate if count if 1
                DPSEC = [];

            else;
                if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                    if rem(strokeCount,2) == 1;
                        %odd stroke count: no need for another stroke
                        
                    else;
                        %even stroke count: add another stroke to get a
                        %full cycle
                        if strcmpi(searchExtraStroke, 'pre');
                            %look for stroke in the 10s leading to the
                            %zone
                            zone_frame_iniExtra = zone_frame_ini - (10*framerate);
                            zone_frame_endExtra = strokeList(1) - 1;
                            
                            %take the last stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            li_strokeExtra = li_strokeExtra(end);

                            strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                            
                        elseif strcmpi(searchExtraStroke, 'post');
                            %look for stroke in the 10s leading to the
                            %zone
                            zone_frame_endExtra = zone_frame_end + (10*framerate);
                            zone_frame_iniExtra = strokeList(end) + 1;

                            %take the first stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            li_strokeExtra = li_strokeExtra(1);

                            strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                        end;
                    end;

                    for strokeEC = 2:length(strokeList);
                        distanceStroke(strokeEC) = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                        DPSEC(strokeEC-1) = distanceStroke(strokeEC).*2;
                    end;
                    DPSEC = mean(DPSEC);

                elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
                    for strokeEC = 2:length(strokeList);
                        distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                        DPSEC(strokeEC-1) = distanceStroke;
                    end;
                    DPSEC = mean(DPSEC);

                elseif strcmpi(lower(StrokeType), 'medley');
                    [li, co] = find(legsIM == lapEC);
                    if li == 1 | li == 3;
                        %butterfly and breaststroke legs
                        for strokeEC = 2:length(strokeList);
                            distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                            DPSEC(strokeEC-1) = distanceStroke;
                        end;
                        DPSEC = mean(DPSEC);

                    else;
                        %backstroke and freestyle legs
                        if rem(strokeCount,2) == 1;
                            %odd stroke count: no need for another stroke
                            
                        else;
                            %even stroke count: add another stroke to get a
                            %full cycle
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 10s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (10*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_strokeExtra(end);

                                strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 10s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (10*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;

                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                li_strokeExtra = li_strokeExtra(1);

                                strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                            end;
                        end;

                        for strokeEC = 2:length(strokeList);
                            distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                            DPSEC(strokeEC-1) = distanceStroke.*2;
                        end;
                        DPSEC = mean(DPSEC);
                    end;
                end;

                SectionSD(lapEC,zoneSD) = DPSEC;
                
            end;
            zoneSD = zoneSD + 1;

            if updateLap == 1;
                updateLap = 0;
                lapEC = lapEC + 1;
                zoneSD = 1;
            end;
        end;
    end;
    SectionSDbis = SectionSD;
    SectionSRbis = SectionSR;
    SectionNbbis = SectionNb;

else;
    
    if strcmpi(lower(StrokeType), 'medley');
        if Course == 25;
            if RaceDist == 100;
                legsIM = [1;2;3;4];
            elseif RaceDist == 150;
                legsIM = [[1 2]; [3 4]; [5 6]];
            elseif RaceDist == 200;
                legsIM = [[1 2]; [3 4]; [5 6]; [7 8]];
            elseif RaceDist == 400;
                legsIM = [[1 2 3 4]; [5 6 7 8]; [9 10 11 12]; [13 14 15 16]];
            end;
        elseif Course == 50;
            if RaceDist == 150;
                legsIM = [1; 2; 3];
            elseif RaceDist == 200;
                legsIM = [1; 2; 3; 4];
            elseif RaceDist == 400;
                legsIM = [[1 2]; [3 4]; [5 6]; [7 8]];
            end;
        end;
    else;
        legsIM = [];
    end;
    
    %load the Section data
%         eval(['SectionSR = handles.RacesDB.' UID '.SectionSR;']);
%         eval(['SectionSD = handles.RacesDB.' UID '.SectionSD;']);
%         eval(['SectionNb = handles.RacesDB.' UID '.SectionNb;']);

    %fill the gap to get 5m segment
    for lap = 1:NbLap
        index = find(SectionSD(lap,:) == 0);
        SectionSD(lap,index) = NaN;

        index = find(SectionSR(lap,:) == 0);
        SectionSR(lap,index) = NaN;

        index = find(SectionNb(lap,:) == 0);
        SectionNb(lap,index) = NaN;
    end;
    SectionSDbis = SectionSD;
    SectionSRbis = SectionSR;
    SectionNbbis = SectionNb;
end;

SectionSD = roundn(SectionSD,-2);
SectionSR = roundn(SectionSR,-1);
SectionNb = roundn(SectionNb,0);
SectionSDbis = roundn(SectionSDbis,-2);
SectionSRbis = roundn(SectionSRbis,-2);
SectionNbbis = roundn(SectionNbbis,0);

SectionSRALL(:,:,1) = SectionSR;
SectionSDALL(:,:,1) = SectionSD;
%     SectionVelALL(:,:,i-2) = SectionVel;
if isempty(SectionSRbis) == 0;
    SectionSRALLbis(:,:,1) = SectionSRbis;
    SectionSDALLbis(:,:,1) = SectionSDbis;
%         SectionVelALLbis(:,:,i-2) = SectionVelbis;
end;

lineEC = 11;
for lap = 1:NbLap;
    countInterpSR = 0;
    countInterpSD = 0;
    countInterpNb = 0;

    DistZoneEC = 5 + ((lap-1)*Course);
    BODistLap = BOAll(lap,3);

    addline = 0;
    firstLapZone = 1;
    for zoneEC = 1:4;
        interpZone = 0;

        if (SectionSR(lap,zoneEC)) == 0;
            SRtxt = '  -  ';
        else;
            if isnan((SectionSR(lap,zoneEC))) == 1;
                if BODistLap > DistZoneEC;
                    SRtxt = '  -  ';
%                     elseif BODistLap+2 > DistZoneEC
%                         SRtxt = '  -  ';
                else;
                    index = find(isnan(SectionSR(lap,:)) == 0);
                    if isempty(index) == 1;
                        SRtxt = '  -  ';
                    else;
                        indexFirst = find(index >= zoneEC);
                        indexRef = index(indexFirst(1));    
                        refSR = SectionSR(lap,indexRef);
                        SectionSR(lap,zoneEC) = refSR;
                        isInterpolatedSR(lap,zoneEC) = 1;
                        SRtxt = [dataToStr(refSR,1) ' str/min'];
                        interpZone = 1;
                        countInterpSR = countInterpSR + 1;
                    end;
                end;
            else;
                if BODistLap > DistZoneEC;
                    SRtxt = '  -  ';
                elseif BODistLap+2 > DistZoneEC
                    SRtxt = '  -  ';
                else;
                    if Source == 1 | Source == 3;
                        if isInterpolatedSR(lap,zoneEC) == 1;
                            SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                            interpZone = 1;
                        else;
                            SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                        end;
                    else;
                        SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                    end;
                    countInterpSR = 0;
                end;
            end;
        end;

        if (SectionSD(lap,zoneEC)) == 0;
            SDtxt = '  -  ';
        else;
            if isnan((SectionSD(lap,zoneEC))) == 1;
                if BODistLap > DistZoneEC;
                    SDtxt = '  -  ';
                elseif BODistLap+2 > DistZoneEC
                    SDtxt = '  -  ';
                else;
                    index = find(isnan(SectionSD(lap,:)) == 0);
                    if isempty(index) == 1;
                        SDtxt = '  -  ';
                    else;
                        indexFirst = find(index >= zoneEC);
                        indexRef = index(indexFirst(1));    
                        refSD = SectionSD(lap,indexRef);
                        SectionSD(lap,zoneEC) = refSD;
                        isInterpolatedSD(lap,zoneEC) = 1;
                        SDtxt = [dataToStr(refSD,2) ' m'];
                        interpZone = 1;
                        countInterpSD = countInterpSD + 1;
                    end;
                end;
            else;
                if BODistLap > DistZoneEC;
                    SDtxt = '  -  ';
                elseif BODistLap+2 > DistZoneEC
                    SDtxt = '  -  ';
                else;
                    if Source == 1 | Source == 3;
                        if isInterpolatedSD(lap,zoneEC) == 1;
                            SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                            interpZone = 1;
                        else;
                            SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                        end;
                    else;
                        SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                    end;
                    countInterpSD = 0;
                end;
            end;
        end;
        
        if (SectionNb(lap,zoneEC)) == 0;
            Nbtxt = '  -  ';
        else;
            if isnan((SectionNb(lap,zoneEC))) == 1;
                if BODistLap > DistZoneEC;
                    Nbtxt = '  -  ';
                else;
                    index = find(isnan(SectionNb(lap,:)) == 0);
                    if isempty(index) == 1;
                        Nbtxt = '  -  ';
                    else;
                        
                        indexFirst = find(index >= zoneEC);
                        indexRef = index(indexFirst(1));
                        strokeTot = SectionNb(lap,indexRef);
                        
                        proceed = 1;
                        zoneProcess = indexRef;
                        distRef = 5;
                        refStroke = NaN(1,indexRef);
                        diffRounding = 0;
                        while proceed == 1;

                            if zoneProcess == zoneEC;
                                indexNAN = find(isnan(refStroke(1,:)) ~= 1);
                                refStrokebis = refStroke(1,indexNAN);
                                refStroke(1,zoneProcess) = strokeTot - sum(refStrokebis);
                            else;
                                refSD = SectionSD(lap,zoneProcess);
                                proceedSD = 1;
                                iter = 1;
                                iterPlus = 0;
                                iterMinus = 0;
                                while proceedSD == 1;
                                    if zoneProcess-iter > 0;
                                        if isnan(refSD) == 1;
                                            refSD = SectionSD(lap,zoneProcess-iter);
                                        end;
                                    else;
                                        iterMinus = 1;
                                    end;
                                    if zoneProcess+iter <= length(SectionSD(lap,:));
                                        if isnan(refSD) == 1;
                                            refSD = SectionSD(lap,zoneProcess+iter);
                                        end;
                                    else;
                                        iterPlus = 1;
                                    end;

                                    if isnan(refSD) == 0;
                                        proceedSD = 0;
                                    else;
                                        if iterMinus == 1 & iterPlus == 1;
                                            proceedSD = 0;
                                            indexNaNSD = find(isnan(SectionSD(lap,:)) == 0);
                                            refSD = mean(SectionSD(lap,indexNaNSD));
                                        end;
                                    end;
                                    iter = iter + 1;
                                end;

                                if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                                    refSD = refSD./2;
                                elseif strcmpi(lower(StrokeType), 'Butterfly') | strcmpi(lower(StrokeType), 'breaststroke');
                                    %no changes
                                else;
                                    [legLapIM, colLapIM] = find(legsIM == lap);
                                    if legLapIM == 1 | legLapIM == 3;
                                        refSD = refSD./2;
                                    else;
                                        %no changes
                                    end;
                                end;
                                remSD = mod(refSD,1);
                                refSD = floor(refSD) + ceil(remSD.*10)./10;
                                
                                if zoneProcess == nbZones;
                                    valStroke = (distRef-1.5)./refSD;
                                    %remove 1.5m off the last zone
                                else;
                                    valStroke = distRef./refSD;
                                end;
                                
                                if diffRounding >= 0.9;
                                    valStrokeRound = ceil(valStroke);
                                elseif diffRounding <= -0.9;
                                    valStrokeRound = floor(valStroke);
                                else;
                                    valStrokeRound = roundn(valStroke,0);
                                end;                                    
                                refStroke(1,zoneProcess) = valStrokeRound;
                                diffRounding = diffRounding + (valStroke-valStrokeRound);
                            end;
                            zoneProcess = zoneProcess - 1;
                            if zoneProcess < zoneEC;
                                proceed = 0;
                            end;
                        end;

                        indexNAN = find(isnan(refStroke(1,:)) ~= 1);
                        refStroke = refStroke(1,indexNAN);
                        SectionNb(lap,zoneEC:indexRef) = refStroke;
                        refNb = SectionNb(lap,zoneEC);
                        Nbtxt = [dataToStr(refNb,0) ' str'];

                        countInterpNb = countInterpNb + 1;
                    end;
                end;
            else;
                if BODistLap > DistZoneEC;
                    Nbtxt = '  -  ';
                else;
%                         Nbtxt = timeSecToStr(SectionNb(lap,zoneEC));
                    refNb = SectionNb(lap,zoneEC)./(countInterpNb+1);
                    refNb = roundn(refNb,0);
                    Nbtxt = [dataToStr(refNb,0) ' str'];
                    countInterpNb = 0;
                end;
            end;
        end;

        if interpZone == 1;
            data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt ' !'];
        else;
            if Source == 3;
                if isempty(strfind(SRtxt, '-')) == 0 & isempty(strfind(SDtxt, '-')) == 0 & isempty(strfind(Nbtxt, '-')) == 1;
                    data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt ' !'];
                else;
                    data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
                end;
            else;
                data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
            end;
        end;

        eval(['dataTableStroke{' num2str(lineEC+addline) ',3} = data;']);
        DistZoneEC = DistZoneEC + 5;
        addline = addline + 1;
    end;

    if Course == 50;
        for zoneEC = 5:9;
            interpZone = 0;

            if (SectionSR(lap,zoneEC)) == 0;
                SRtxt = '  -  ';
            else;
                if isnan((SectionSR(lap,zoneEC))) == 1;
                    if BODistLap > DistZoneEC;
                        SRtxt = '  -  ';
%                     elseif BODistLap+2 > DistZoneEC
%                         SRtxt = '  -  ';
                    else;
                        index = find(isnan(SectionSR(lap,:)) == 0);
                        if isempty(index) == 1;
                            SRtxt = '  -  ';
                        else;
                            indexFirst = find(index >= zoneEC);
                            indexRef = index(indexFirst(1));    
                            refSR = SectionSR(lap,indexRef);
                            SectionSR(lap,zoneEC) = refSR;
                            isInterpolatedSR(lap,zoneEC) = 1;
                            SRtxt = [dataToStr(refSR,1) ' str/min'];
                            interpZone = 1;
                            countInterpSR = countInterpSR + 1;
                        end;
                    end;
                else;
                    if BODistLap > DistZoneEC;
                        SRtxt = '  -  ';
                    elseif BODistLap+2 > DistZoneEC
                        SRtxt = '  -  ';
                    else;
                        if Source == 1 | Source == 3;
                            if isInterpolatedSR(lap,zoneEC) == 1;
                                SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                                interpZone = 1;
                            else;
                                SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                            end;
                        else;
                            SRtxt = [dataToStr(SectionSR(lap,zoneEC),1) ' str/min'];
                        end;
                        countInterpSR = 0;
                    end;
                end;
            end;

            if (SectionSD(lap,zoneEC)) == 0;
                SDtxt = '  -  ';
            else;
                if isnan((SectionSD(lap,zoneEC))) == 1;
                    if BODistLap > DistZoneEC;
                        SDtxt = '  -  ';
                    elseif BODistLap+2 > DistZoneEC
                        SDtxt = '  -  ';
                    else;
                        index = find(isnan(SectionSD(lap,:)) == 0);
                        if isempty(index) == 1;
                            SDtxt = '  -  ';
                        else;
                            indexFirst = find(index >= zoneEC);
                            indexRef = index(indexFirst(1));    
                            refSD = SectionSD(lap,indexRef);
                            SectionSD(lap,zoneEC) = refSD;
                            isInterpolatedSD(lap,zoneEC) = 1;
                            SDtxt = [dataToStr(refSD,2) ' m'];
                            interpZone = 1;
                            countInterpSD = countInterpSD + 1;
                        end;
                    end;
                else;
                    if BODistLap > DistZoneEC;
                        SDtxt = '  -  ';
                    elseif BODistLap+2 > DistZoneEC
                        SDtxt = '  -  ';
                    else;
                        if Source == 1 | Source == 3;
                            if isInterpolatedSD(lap,zoneEC) == 1;
                                SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                                interpZone = 1;
                            else;
                                SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                            end;
                        else;
                            SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
                        end;
                        countInterpSD = 0;
                    end;
                end;
            end;
            
            if (SectionNb(lap,zoneEC)) == 0;
                Nbtxt = '  -  ';
            else;
                if isnan((SectionNb(lap,zoneEC))) == 1;
                    if BODistLap > DistZoneEC;
                        Nbtxt = '  -  ';
                    else;
                        index = find(isnan(SectionNb(lap,:)) == 0);
                        if isempty(index) == 1;
                            Nbtxt = '  -  ';
                        else;
                            
                            indexFirst = find(index >= zoneEC);
                            indexRef = index(indexFirst(1));
                            strokeTot = SectionNb(lap,indexRef);
                            
                            proceed = 1;
                            zoneProcess = indexRef;
                            distRef = 5;
                            refStroke = NaN(1,indexRef);
                            diffRounding = 0;
                            while proceed == 1;

                                if zoneProcess == zoneEC;
                                    indexNAN = find(isnan(refStroke(1,:)) ~= 1);
                                    refStrokebis = refStroke(1,indexNAN);
                                    refStroke(1,zoneProcess) = strokeTot - sum(refStrokebis);
                                else;
                                    refSD = SectionSD(lap,zoneProcess);
                                    proceedSD = 1;
                                    iter = 1;
                                    iterPlus = 0;
                                    iterMinus = 0;
                                    while proceedSD == 1;
                                        if zoneProcess-iter > 0;
                                            if isnan(refSD) == 1;
                                                refSD = SectionSD(lap,zoneProcess-iter);
                                            end;
                                        else;
                                            iterMinus = 1;
                                        end;
                                        if zoneProcess+iter <= length(SectionSD(lap,:));
                                            if isnan(refSD) == 1;
                                                refSD = SectionSD(lap,zoneProcess+iter);
                                            end;
                                        else;
                                            iterPlus = 1;
                                        end;

                                        if isnan(refSD) == 0;
                                            proceedSD = 0;
                                        else;
                                            if iterMinus == 1 & iterPlus == 1;
                                                proceedSD = 0;
                                                indexNaNSD = find(isnan(SectionSD(lap,:)) == 0);
                                                refSD = mean(SectionSD(lap,indexNaNSD));
                                            end;
                                        end;
                                        iter = iter + 1;
                                    end;

                                    if strcmpi(lower(StrokeType), 'freestyle') | strcmpi(lower(StrokeType), 'backstroke');
                                        refSD = refSD./2;
                                    elseif strcmpi(lower(StrokeType), 'Butterfly') | strcmpi(lower(StrokeType), 'breaststroke');
                                        %no changes
                                    else;
                                        [legLapIM, colLapIM] = find(legsIM == lap);
                                        if legLapIM == 1 | legLapIM == 3;
                                            refSD = refSD./2;
                                        else;
                                            %no changes
                                        end;
                                    end;
                                    refSDIni = refSD;
                                    remSD = mod(refSD,1);
                                    refSD = floor(refSD) + ceil(remSD.*10)./10;
                                    if zoneProcess == nbZones;
                                        valStroke = (distRef-1.5)./refSD;
                                        %remove 1.5m off the last zone
                                    else;
                                        valStroke = distRef./refSD;
                                    end;

                                    if diffRounding >= 0.9;
                                        valStrokeRound = ceil(valStroke);
                                    elseif diffRounding <= -0.9;
                                        valStrokeRound = floor(valStroke);
                                    else;
                                        valStrokeRound = roundn(valStroke,0);
                                    end;                                    
                                    refStroke(1,zoneProcess) = valStrokeRound;

                                    diffRounding = diffRounding + (valStroke-valStrokeRound);
                                end;
                                zoneProcess = zoneProcess - 1;
                                if zoneProcess < zoneEC;
                                    proceed = 0;
                                end;
                            end;

                            indexNAN = find(isnan(refStroke(1,:)) ~= 1);
                            refStroke = refStroke(1,indexNAN);
                            SectionNb(lap,zoneEC:indexRef) = refStroke;
                            refNb = SectionNb(lap,zoneEC);
                            Nbtxt = [dataToStr(refNb,0) ' str'];

                            countInterpNb = countInterpNb + 1;
                        end;
                    end;
                else;
                    if BODistLap > DistZoneEC;
                        Nbtxt = '  -  ';
                    else;
%                         Nbtxt = timeSecToStr(SectionNb(lap,zoneEC));
                        refNb = SectionNb(lap,zoneEC)./(countInterpNb+1);
                        refNb = roundn(refNb,0);
                        Nbtxt = [dataToStr(refNb,0) ' str'];
                        countInterpNb = 0;
                    end;
                end;
            end;

            if interpZone == 1;
                data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt ' !'];
            else;
                if Source == 3;
                    if isempty(strfind(SRtxt, '-')) == 0 & isempty(strfind(SDtxt, '-')) == 0 & isempty(strfind(Nbtxt, '-')) == 1;
                        data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt ' !'];
                    else;
                        data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
                    end;
                else;
                    data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];
                end;
            end;

            eval(['dataTableStroke{' num2str(lineEC+addline) ',3} = data;']);
            DistZoneEC = DistZoneEC + 5;
            addline = addline + 1;
        end;

        zoneEC = 10; %45-last arm entry
        interpZone = 0;
%             if Source == 1;
%                 addline = addline + 1;
        if Source == 3;
            Nbtxt = [dataToStr(SectionNb(lap,zoneEC),0) ' str'];
            data = ['  -    /    -    /    ' Nbtxt ' !'];
            eval(['dataTableStroke{' num2str(lineEC+addline) ',3} = data;']);
            DistZoneEC = DistZoneEC + 5;
            addline = addline + 1;
        else;
            if isnan(SectionSR(lap,zoneEC)) == 1;
                SRtxt = '  -  ';
            else;
                SRtxt = [dataToStr(SectionSR(lap,zoneEC),1)  ' str/min'];
            end;
            if isnan(SectionSD(lap,zoneEC)) == 1;
                SDtxt = '  -  ';
            else;
                SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
            end;
            if isnan(SectionNb(lap,zoneEC)) == 1;
                Nbtxt = '  -  ';
            else;
                Nbtxt = [dataToStr(SectionNb(lap,zoneEC),0) ' str'];
            end;
            data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];

            eval(['dataTableStroke{' num2str(lineEC+addline) ',3} = data;']);
            DistZoneEC = DistZoneEC + 5;
            addline = addline + 1;
        end;

        lineEC = lineEC + addline + 1;

    else;
        
        zoneEC = 5; %20-last arm entry 
        interpZone = 0;
%             if Source == 1;
%                 addline = addline + 1;
        if Source == 3;
            Nbtxt = [dataToStr(SectionNb(lap,zoneEC),0) ' str'];
            data = ['  -    /    -    /    ' Nbtxt ' !'];
            eval(['dataTableStroke{' num2str(lineEC+addline) ',3} = data;']);
            DistZoneEC = DistZoneEC + 5;
            addline = addline + 1;
        else;
            if isnan(SectionSR(lap,zoneEC)) == 1;
                SRtxt = '  -  ';
            else;
                SRtxt = [dataToStr(SectionSR(lap,zoneEC),1)  ' str/min'];
            end;
            if isnan(SectionSD(lap,zoneEC)) == 1;
                SDtxt = '  -  ';
            else;
                SDtxt = [dataToStr(SectionSD(lap,zoneEC),2) ' m'];
            end;
            if isnan(SectionNb(lap,zoneEC)) == 1;
                Nbtxt = '  -  ';
            else;
                Nbtxt = [dataToStr(SectionNb(lap,zoneEC),0) ' str'];
            end;
            data = [SRtxt '  /  ' SDtxt '  /  ' Nbtxt];

            eval(['dataTableStroke{' num2str(lineEC+addline) ',3} = data;']);
            DistZoneEC = DistZoneEC + 5;
            addline = addline + 1;
        end;
        lineEC = lineEC + addline + 1;
    end;
end;




