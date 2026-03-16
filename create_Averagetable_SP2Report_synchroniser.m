function [dataTableAverageAll, dataTableBreathAll, avVELlap, avSRlap, avDPSlap, avVELRace, avSRRace, avDPSRace] = create_Averagetable_SP2Report_synchroniser(StrokeType, NbLap, ...
    RaceDist, Course, SplitsAll, framerate, DistanceEC, TimeEC, ...
    Stroke_Frame, Breath_Frames, BOAll, BOEC);

    
%     eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
%     eval(['Source = handles.RacesDB.' UID '.Source;']);
%     eval(['Meet = handles.RacesDB.' UID '.Meet;']);
%     eval(['Year = handles.RacesDB.' UID '.Year;']);
%     eval(['Stage = handles.RacesDB.' UID '.Stage;']);

%     idx = isstrprop(Meet,'upper');
%     MeetShort = Meet(idx);
%     if strcmpi(Stage, 'Semi-Final');
%         StageShort = 'SF';
%     elseif strcmpi(Stage, 'Semi-final');
%         StageShort = 'SF';
%     else;
%         StageShort = Stage;
%     end;
%     YearShort = Year(3:4);
%     graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
%     storeTitle2{mainIter-2} = graphTitle2;

NbLap = roundn(RaceDist./Course,0);
TT = SplitsAll(end,2);
TTtxt = timeSecToStr(TT);
dataTableAverageAll = {};
dataTableBreathAll = [];
SplitsAllSave = SplitsAll;
avVELlap = [];
avSRlap = [];
avDPSlap = [];
avVELRace = [];
avSRRace = [];
avDPSRace = [];


lapZoneLim = 1;

if RaceDist <= 100;
    maininterval = 1;
else;
    maininterval = 2;
end;

%---------------------------------Pacing-------------------------------
for intervalEC = 1:3;

    SplitsAll = SplitsAllSave;
    dataTableAverage = {};
    dataTableBreath = [];
    dataZone = [];

    if intervalEC == 1;
        %Apply short distance races intervals to all races
        if Course == 25;
            if RaceDist == 50;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
        
            elseif RaceDist == 100;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-20m';
                dataTableAverage{3,1} = '20-25m';
                dataTableAverage{4,1} = '25-35m';
                dataTableAverage{5,1} = '35-45m';
                dataTableAverage{6,1} = '45-50m';
                dataTableAverage{7,1} = '50-60m';
                dataTableAverage{8,1} = '60-70m';
                dataTableAverage{9,1} = '70-75m';
                dataTableAverage{10,1} = '75-85m';
                dataTableAverage{11,1} = '85-95m';
                dataTableAverage{12,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 20];
                dataZone(3,:) = [20 25];
                dataZone(4,:) = [25 35];
                dataZone(5,:) = [35 45];
                dataZone(6,:) = [45 50];
                dataZone(7,:) = [50 60];
                dataZone(8,:) = [60 70];
                dataZone(9,:) = [70 75];
                dataZone(10,:) = [75 85];
                dataZone(11,:) = [85 95];
                dataZone(12,:) = [95 100];
        
            elseif RaceDist >= 150;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-20m';
                dataTableAverage{3,1} = '20-25m';
                dataTableAverage{4,1} = '25-35m';
                dataTableAverage{5,1} = '35-45m';
                dataTableAverage{6,1} = '45-50m';
                dataTableAverage{7,1} = '50-60m';
                dataTableAverage{8,1} = '60-70m';
                dataTableAverage{9,1} = '70-75m';
                dataTableAverage{10,1} = '75-85m';
                dataTableAverage{11,1} = '85-95m';
                dataTableAverage{12,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 20];
                dataZone(3,:) = [20 25];
                dataZone(4,:) = [25 35];
                dataZone(5,:) = [35 45];
                dataZone(6,:) = [45 50];
                dataZone(7,:) = [50 60];
                dataZone(8,:) = [60 70];
                dataZone(9,:) = [70 75];
                dataZone(10,:) = [75 85];
                dataZone(11,:) = [85 95];
                dataZone(12,:) = [95 100];

                extraLap = (RaceDist/Course) - 4;
                locRow = length(dataZone(:,1));
                for lapEC = 1:extraLap;
                    row1 = [dataZone(end,2) dataZone(end,2)+10];
                    row2 = [dataZone(end,2)+10 dataZone(end,2)+20];
                    row3 = [dataZone(end,2)+20 dataZone(end,2)+25];
                    
                    eval(['dataTableAverage{' num2str(locRow+1) ',1} = ' '''' num2str(row1(1,1)) '-' num2str(row1(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+2) ',1} = ' '''' num2str(row2(1,1)) '-' num2str(row2(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+3) ',1} = ' '''' num2str(row3(1,1)) '-' num2str(row3(1,2)) 'm' '''' ';']);
                    dataZone(locRow+1,:) = row1;
                    dataZone(locRow+2,:) = row2;
                    dataZone(locRow+3,:) = row3;

                    locRow = length(dataZone(:,1));
                end;
            end;
        elseif Course == 50;
            if RaceDist == 50;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
        
            elseif RaceDist == 100;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
                dataTableAverage{6,1} = '50-65m';
                dataTableAverage{7,1} = '65-75m';
                dataTableAverage{8,1} = '75-85m';
                dataTableAverage{9,1} = '85-95m';
                dataTableAverage{10,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
                dataZone(6,:) = [50 65];
                dataZone(7,:) = [65 75];
                dataZone(8,:) = [75 85];
                dataZone(9,:) = [85 95];
                dataZone(10,:) = [95 100];
        
            elseif RaceDist >= 150;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
                dataTableAverage{6,1} = '50-65m';
                dataTableAverage{7,1} = '65-75m';
                dataTableAverage{8,1} = '75-85m';
                dataTableAverage{9,1} = '85-95m';
                dataTableAverage{10,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
                dataZone(6,:) = [50 65];
                dataZone(7,:) = [65 75];
                dataZone(8,:) = [75 85];
                dataZone(9,:) = [85 95];
                dataZone(10,:) = [95 100];

                extraLap = (RaceDist/Course) - 2;
                locRow = length(dataZone(:,1));
                for lapEC = 1:extraLap;
                    row1 = [dataZone(end,2) dataZone(end,2)+15];
                    row2 = [dataZone(end,2)+15 dataZone(end,2)+25];
                    row3 = [dataZone(end,2)+25 dataZone(end,2)+35];
                    row4 = [dataZone(end,2)+35 dataZone(end,2)+45];
                    row5 = [dataZone(end,2)+45 dataZone(end,2)+50];
                    
                    eval(['dataTableAverage{' num2str(locRow+1) ',1} = ' '''' num2str(row1(1,1)) '-' num2str(row1(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+2) ',1} = ' '''' num2str(row2(1,1)) '-' num2str(row2(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+3) ',1} = ' '''' num2str(row3(1,1)) '-' num2str(row3(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+4) ',1} = ' '''' num2str(row4(1,1)) '-' num2str(row4(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+5) ',1} = ' '''' num2str(row5(1,1)) '-' num2str(row5(1,2)) 'm' '''' ';']);
                    dataZone(locRow+1,:) = row1;
                    dataZone(locRow+2,:) = row2;
                    dataZone(locRow+3,:) = row3;
                    dataZone(locRow+4,:) = row4;
                    dataZone(locRow+5,:) = row5;

                    locRow = length(dataZone(:,1));
                end;
            end;
        end;

    elseif intervalEC == 2;
        %Apply normal intervals to all races
%         if Course == 25;
%             if RaceDist == 50;
%                 dataTableAverage{1,1} = '0-15m';
%                 dataTableAverage{2,1} = '15-25m';
%                 dataTableAverage{3,1} = '25-35m';
%                 dataTableAverage{4,1} = '35-45m';
%                 dataTableAverage{5,1} = '45-50m';
%         
%                 dataZone(1,:) = [0 15];
%                 dataZone(2,:) = [15 25];
%                 dataZone(3,:) = [25 35];
%                 dataZone(4,:) = [35 45];
%                 dataZone(5,:) = [45 50];
%         
%             elseif RaceDist == 100;
%                 dataTableAverage{1,1} = '0-15m';
%                 dataTableAverage{2,1} = '15-20m';
%                 dataTableAverage{3,1} = '20-25m';
%                 dataTableAverage{4,1} = '25-35m';
%                 dataTableAverage{5,1} = '35-45m';
%                 dataTableAverage{6,1} = '45-50m';
%                 dataTableAverage{7,1} = '50-60m';
%                 dataTableAverage{8,1} = '60-70m';
%                 dataTableAverage{9,1} = '70-75m';
%                 dataTableAverage{10,1} = '75-85m';
%                 dataTableAverage{11,1} = '85-95m';
%                 dataTableAverage{12,1} = '95-100m';
%         
%                 dataZone(1,:) = [0 15];
%                 dataZone(2,:) = [15 20];
%                 dataZone(3,:) = [20 25];
%                 dataZone(4,:) = [25 35];
%                 dataZone(5,:) = [35 45];
%                 dataZone(6,:) = [45 50];
%                 dataZone(7,:) = [50 60];
%                 dataZone(8,:) = [60 70];
%                 dataZone(9,:) = [70 75];
%                 dataZone(10,:) = [75 85];
%                 dataZone(11,:) = [85 95];
%                 dataZone(12,:) = [95 100];
%         
%             elseif RaceDist >= 150;
%                 keyDistEC = 25:25:RaceDist;
%                 for distEC = 1:length(keyDistEC);
%                     if distEC == 1;
%                         eval(['dataTableAverage{distEC,1} = ' '''' '0-' num2str(keyDistEC(distEC)) 'm' '''' ';']);
%                         dataZone(distEC,:) = [0 keyDistEC(distEC)];
%                     else;
%                         eval(['dataTableAverage{distEC,1} = ' '''' num2str(keyDistEC(distEC-1)) '-' num2str(keyDistEC(distEC)) 'm' '''' ';']);
%                         dataZone(distEC,:) = [keyDistEC(distEC-1) keyDistEC(distEC)];
%                     end;
%                 end;
%             end;
%         elseif Course == 50;
%             if RaceDist == 50;
%                 dataTableAverage{1,1} = '0-15m';
%                 dataTableAverage{2,1} = '15-25m';
%                 dataTableAverage{3,1} = '25-35m';
%                 dataTableAverage{4,1} = '35-45m';
%                 dataTableAverage{5,1} = '45-50m';
%         
%                 dataZone(1,:) = [0 15];
%                 dataZone(2,:) = [15 25];
%                 dataZone(3,:) = [25 35];
%                 dataZone(4,:) = [35 45];
%                 dataZone(5,:) = [45 50];
%         
%             elseif RaceDist == 100;
%                 dataTableAverage{1,1} = '0-15m';
%                 dataTableAverage{2,1} = '15-25m';
%                 dataTableAverage{3,1} = '25-35m';
%                 dataTableAverage{4,1} = '35-45m';
%                 dataTableAverage{5,1} = '45-50m';
%                 dataTableAverage{6,1} = '50-65m';
%                 dataTableAverage{7,1} = '65-75m';
%                 dataTableAverage{8,1} = '75-85m';
%                 dataTableAverage{9,1} = '85-95m';
%                 dataTableAverage{10,1} = '95-100m';
%         
%                 dataZone(1,:) = [0 15];
%                 dataZone(2,:) = [15 25];
%                 dataZone(3,:) = [25 35];
%                 dataZone(4,:) = [35 45];
%                 dataZone(5,:) = [45 50];
%                 dataZone(6,:) = [50 65];
%                 dataZone(7,:) = [65 75];
%                 dataZone(8,:) = [75 85];
%                 dataZone(9,:) = [85 95];
%                 dataZone(10,:) = [95 100];
%         
%             elseif RaceDist >= 150;
                keyDistEC = 25:25:RaceDist;
                for distEC = 1:length(keyDistEC);
                    if distEC == 1;
                        eval(['dataTableAverage{distEC,1} = ' '''' '0-' num2str(keyDistEC(distEC)) 'm' '''' ';']);
                        dataZone(distEC,:) = [0 keyDistEC(distEC)];
                    else;
                        eval(['dataTableAverage{distEC,1} = ' '''' num2str(keyDistEC(distEC-1)) '-' num2str(keyDistEC(distEC)) 'm' '''' ';']);
                        dataZone(distEC,:) = [keyDistEC(distEC-1) keyDistEC(distEC)];
                    end;
                end;
%             end;
%         end;

    elseif intervalEC == 3;
        %Apply 5m intervals to all races
        nbZonesTot = (RaceDist./Course) .* (Course./5);
        for zoneEC = 1:nbZonesTot;
            dataZone(zoneEC,:) = [(zoneEC.*5)-5 zoneEC.*5];
            eval(['dataTableAverage{zoneEC,1} = ' '''' num2str(dataZone(zoneEC,1)) '-' num2str(dataZone(zoneEC,2)) 'm' '''' ';']);
        end;
    end;

    SplitsAll = SplitsAll(2:end,:);
    
    %calculate velocities per sections
    lapLim = Course:Course:RaceDist;
    lapEC = 1;
    updateLap = 0;
    ratioSegLap = NaN(1, length(dataZone(:,1)));
    ratioSegRace = NaN(1, length(dataZone(:,1)));
    VelAll = NaN(length(dataZone(:,1)),1);
    for zoneEC = 1:length(dataTableAverage(:,1));

        zone_dist_ini = dataZone(zoneEC,1);
        zone_dist_end = dataZone(zoneEC,2);
    
        indexLap = find(lapLim == zone_dist_end);
        if isempty(indexLap) == 0;
            %Last zone for a lap, remove 2m
            zone_dist_end = zone_dist_end-2;
            updateLap = 1;
        end;

        if BOAll(lapEC,3) > zone_dist_end;
            %BO happened in the following zone
            VelEC = [];
    
        elseif BOAll(lapEC,3) <= zone_dist_end & BOAll(lapEC,3) > zone_dist_ini;
            %BO happened in this zone
            distBO2End = zone_dist_end-BOAll(lapEC,3);
            if distBO2End <= 2;
                %Less than 2m to end of zone
                VelEC = [];
    
            else;
                %more than 2m to calculate the speed
                zone_dist_ini = BOAll(lapEC,3);
                zone_time_ini = BOAll(lapEC,2);
    
                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                zone_time_end = TimeEC(minLoc(1));
    
                VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
            end;
        else;
            %BO happened before
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
            zone_time_ini = TimeEC(minLoc(1));
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
            zone_time_end = TimeEC(minLoc(1));
            VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
        end;
        if isempty(VelEC) == 0;
            VelAll(zoneEC,1) = VelEC;
        end;
        dataTableAverage{zoneEC,2} = VelEC;

        if intervalEC == maininterval;
            if isempty(VelEC) == 0
% 
%                 zone_dist_ini
%                 zone_dist_end
% 

                valRatioLap = (zone_dist_end-zone_dist_ini)./Course;
                valRatioRace = (zone_dist_end-zone_dist_ini)./RaceDist;
% 
% 
%                 zone_dist_ini
%                 valRatioRace
% 

                ratioSegLap(zoneEC) = valRatioLap;
                ratioSegRace(zoneEC) = valRatioRace;
            end;
        end;
    
        if updateLap == 1;
            updateLap = 0;
            lapEC = lapEC + 1;
            if intervalEC == maininterval;
                lapZoneLim = [lapZoneLim; zoneEC];
            end;
        end;
    end;

    if intervalEC == maininterval;
        for lapEC = 1:NbLap;
            if lapEC == 1;
                rowIn = lapZoneLim(lapEC, 1);
            else;
                rowIn = lapZoneLim(lapEC, 1) + 1;
            end;
            rowOut = lapZoneLim(lapEC+1, 1);

            VelEC = VelAll(rowIn:rowOut);
            ratioSegLapEC = ratioSegLap(rowIn:rowOut)';
            index = find(isnan(VelEC) == 0 & VelEC ~= 0);
            VelEC = VelEC(index);
            ratioSegLapEC = ratioSegLapEC(index);
            avVELlap(lapEC,1) = sum(ratioSegLapEC.*VelEC) ./ sum(ratioSegLapEC);
        end;

% 
%         
%         
%         
%         d=ratioSegRace
%         e=VelAll
% 
% 

        index = find(isnan(VelAll) == 0 & VelAll ~= 0);
        VelAll = VelAll(index);
        ratioSegRaceEC = ratioSegRace(index);
% 
% 
% 
%         f=VelAll
%         g=ratioSegRaceEC
% 
% 

        avVELRace = sum(ratioSegRaceEC'.*VelAll) ./ sum(ratioSegRaceEC');
    end;


    %calculate SR per sections
    %find legs if IM
    if strcmpi(lower(StrokeType), 'medley') | strcmpi(lower(StrokeType), 'para-medley');
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
    
    lapEC = 1;
    updateLap = 0;
    ratioSegLap = NaN(1, length(dataZone(:,1)));
    ratioSegRace = NaN(1, length(dataZone(:,1)));
    SRAll = NaN(length(dataZone(:,1)),1);
    for zoneEC = 1:length(dataZone(:,1));
    
        durationStroke = [];
        durationStrokeSave = [];
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
        if BOAll(lapEC,3) <= zone_dist_end & BOAll(lapEC,3) > zone_dist_ini;
            zone_dist_ini = BOAll(lapEC,3);
            zone_frame_ini = BOAll(lapEC,1);
        end;

        indexLap = find(lapLim == zone_dist_end);
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
        if zoneEC == length(dataZone(:,1));
            li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc <= zone_frame_end);
%         elseif zoneEC == 1;
%             li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc < zone_frame_end);
        else;
            li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc < zone_frame_end);
        end;
        strokeList = Stroke_FrameRestruc(1,li_stroke);
        strokeCount = length(strokeList);
        strokeCountTrue = strokeCount;

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
                    if Course == 25;
                        if RaceDist >= 150;
                            caseSC = 1;
                        else;
                            caseSC = 0;
                        end;
                    else;
                        caseSC = 0;
                    end
    
                    if caseSC == 1;
                        strokeList = strokeList(1:end-1);
                    else;
                        if strcmpi(searchExtraStroke, 'pre');
                            %look for stroke in the 5s leading to the
                            %zone
                            zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                            zone_frame_endExtra = strokeList(1) - 1;
                            
                            %take the last stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
    
                            if isempty(li_strokeExtra) == 1;
                                %couldn't find a stroke pre
                                strokeList = strokeList(2:end);
                            else;
                                li_strokeExtra = li_strokeExtra(end);
                                strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                            end;
                            
                        elseif strcmpi(searchExtraStroke, 'post');
                            %look for stroke in the 5s leading to the
                            %zone
                            zone_frame_endExtra = zone_frame_end + (5*framerate);
                            zone_frame_iniExtra = strokeList(end) + 1;
    
                            %take the first stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                            
                            if isempty(li_strokeExtra) == 1;
                                %couldn't find a stroke post
                                strokeList = strokeList(1:end-1);
                            else;
                                li_strokeExtra = li_strokeExtra(1);
                                strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                            end;
                        end;
                    end;    
                end;
                SREC = [];

                for strokeEC = 2:length(strokeList);
                    durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                end;
                avDurationStroke = mean(durationStroke);
                SREC = 60./avDurationStroke;
                SREC = SREC./2;
    
            elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
                SREC = [];
                for strokeEC = 2:length(strokeList);
                    durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                end;
                avDurationStroke = mean(durationStroke);
                SREC = 60./avDurationStroke;

            elseif strcmpi(lower(StrokeType), 'medley');
                SREC = [];
                [li, co] = find(legsIM == lapEC);
                if li == 1 | li == 3;
                    for strokeEC = 2:length(strokeList);
                        durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                    end;
                    avDurationStroke = mean(durationStroke);
                    SREC = 60./avDurationStroke;

                else;
                    if rem(strokeCount,2) == 1;
                        %odd stroke count: no need for another stroke
                        
                    else;
                        %even stroke count: add another stroke to get a
                        %full cycle
                        if Course == 25;
                            if RaceDist >= 150;
                                caseSC = 1;
                            else;
                                caseSC = 0;
                            end;
                        else;
                            caseSC = 0;
                        end;
    
                        if caseSC == 1;
                            strokeList = strokeList(1:end-1);
                        else;
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
    
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke pre
                                    strokeList = strokeList(2:end);
                                else;
                                    li_strokeExtra = li_strokeExtra(end);
                                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                end;
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (5*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;
        
                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke post
                                    strokeList = strokeList(1:end-1);
                                else;
                                    li_strokeExtra = li_strokeExtra(1);
                                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                                end;
                            end;
                        end;
                    end;
                    for strokeEC = 2:length(strokeList);
                        durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                    end;
                    avDurationStroke = mean(durationStroke);
                    SREC = 60./avDurationStroke;
                    SREC = SREC./2;
                end;

            elseif strcmpi(lower(StrokeType), 'para-medley');
                SREC = [];
                [li, co] = find(legsIM == lapEC);
                if li == 2;
                    for strokeEC = 2:length(strokeList);
                        durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                    end;
                    avDurationStroke = mean(durationStroke);
                    SREC = 60./avDurationStroke;
                else;
                    if rem(strokeCount,2) == 1;
                        %odd stroke count: no need for another stroke
                        
                    else;
                        %even stroke count: add another stroke to get a
                        %full cycle
                        if Course == 25;
                            if RaceDist >= 150;
                                caseSC = 1;
                            else;
                                caseSC = 0;
                            end;
                        else;
                            caseSC = 0;
                        end;
    
                        if caseSC == 1;
                            strokeList = strokeList(1:end-1);
                        else;
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
    
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke pre
                                    strokeList = strokeList(2:end);
                                else;
                                    li_strokeExtra = li_strokeExtra(end);
                                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                end;
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (5*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;
        
                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke post
                                    strokeList = strokeList(1:end-1);
                                else;
                                    li_strokeExtra = li_strokeExtra(1);
                                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                                end;
                            end;
                        end;
                    end;
                    for strokeEC = 2:length(strokeList);
                        durationStroke(strokeEC-1) = (strokeList(strokeEC) - strokeList(strokeEC-1))./framerate;
                    end;
                    avDurationStroke = mean(durationStroke);
                    SREC = 60./avDurationStroke;
                    SREC = SREC./2;
                end;

            end;
            dataTableAverage{zoneEC,3} = SREC;
            if isempty(SREC) == 0;
                SRAll(zoneEC,1) = SREC;
            end;
            
            if intervalEC == maininterval;
                if isempty(SREC) == 0;
                    valRatioLap = (zone_dist_end-zone_dist_ini)./Course;
                    valRatioRace = (zone_dist_end-zone_dist_ini)./RaceDist;
                    ratioSegLap(zoneEC) = valRatioLap;
                    ratioSegRace(zoneEC) = valRatioRace;
                end;
            end;
        end;
        dataTableAverage{zoneEC,6} = strokeCountTrue;

        if updateLap == 1;
            %Calculate average SR for Lap
            updateLap = 0;
            lapEC = lapEC + 1;
        end;
    end;

    if intervalEC == maininterval;
        for lapEC = 1:NbLap;
            rowIn = lapZoneLim(lapEC, 1);
            rowOut = lapZoneLim(lapEC+1, 1);

            SRALLEC = SRAll(rowIn:rowOut);
            ratioSegLapEC = ratioSegLap(rowIn:rowOut)';
            index = find(isnan(SRALLEC) == 0 & SRALLEC ~= 0);
            SRALLEC = SRALLEC(index);
            ratioSegLapEC = ratioSegLapEC(index);
            avSRlap(lapEC,1) = sum(ratioSegLapEC.*SRALLEC) ./ sum(ratioSegLapEC);
        end;
        index = find(isnan(SRAll) == 0 & SRAll ~= 0);
        SRAll = SRAll(index);
        ratioSegRaceEC = ratioSegRace(index);
        avSRRace = sum(ratioSegRaceEC'.*SRAll) ./ sum(ratioSegRaceEC');
    end;

    %calculate DPS per sections
    lapEC = 1;
    updateLap = 0;
    ratioSegLap = NaN(1, length(dataZone(:,1)));
    ratioSegRace = NaN(1, length(dataZone(:,1)));
    DPSAll = NaN(length(dataZone(:,1)),1);
    for zoneEC = 1:length(dataZone(:,1));
    
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
        if BOAll(lapEC,3) <= zone_dist_end & BOAll(lapEC,3) > zone_dist_ini;
            zone_dist_ini = BOAll(lapEC,3);
            zone_frame_ini = BOAll(lapEC,1);
        end;
        
        indexLap = find(lapLim == zone_dist_end);

        if isempty(indexLap) == 0;
            %Last zone for a lap, remove 2m
            zone_dist_end = zone_dist_end-2;
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
        if zoneEC == length(dataZone(:,1));
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
                    if Course == 25;
                        if RaceDist >= 150;
                            caseSC = 1;
                        else;
                            caseSC = 0;
                        end;
                    else;
                        caseSC = 0;
                    end;
    
                    if caseSC == 1;
                        strokeList = strokeList(1:end-1);
                    else;
                        if strcmpi(searchExtraStroke, 'pre');
                            %look for stroke in the 5s leading to the
                            %zone
                            zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                            zone_frame_endExtra = strokeList(1) - 1;
                            
                            %take the last stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                           
                            if isempty(li_strokeExtra) == 1;
                                %couldn't find a stroke pre
                                strokeList = strokeList(2:end);
                            else;
                                li_strokeExtra = li_strokeExtra(end);
                                strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                            end;
    
                        elseif strcmpi(searchExtraStroke, 'post');
                            %look for stroke in the 5s leading to the
                            %zone
                            zone_frame_endExtra = zone_frame_end + (5*framerate);
                            zone_frame_iniExtra = strokeList(end) + 1;
    
                            %take the first stroke available
                            li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                             if isempty(li_strokeExtra) == 1;
                                %couldn't find a stroke post
                                strokeList = strokeList(1:end-1);
                            else;
                                li_strokeExtra = li_strokeExtra(1);
                                strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                            end;
                        end;
                    end;
                end;
    
                DPSEC = [];
                for strokeEC = 2:length(strokeList);
                    distanceStroke(strokeEC) = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                    DPSEC(strokeEC-1) = distanceStroke(strokeEC).*2;
                end;

                DPSEC = mean(DPSEC);

            elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
    
                DPSEC = [];
                for strokeEC = 2:length(strokeList);
                    distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                    DPSEC(strokeEC-1) = distanceStroke;
                end;
                DPSEC = mean(DPSEC);
    
            elseif strcmpi(lower(StrokeType), 'medley');
                [li, co] = find(legsIM == lapEC);
                if li == 1 | li == 3;
                    %butterfly and breaststroke legs
                    DPSEC = [];
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
                        if Course == 25;
                            if RaceDist >= 150;
                                caseSC = 1;
                            else;
                                caseSC = 0;
                            end;
                        else;
                            caseSC = 0;
                        end;
    
                        if caseSC == 1;
                            strokeList = strokeList(1:end-1);
                        else;
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke pre
                                    strokeList = strokeList(2:end);
                                else;
                                    li_strokeExtra = li_strokeExtra(end);
                                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                end;
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (5*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;
    
                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke post
                                    strokeList = strokeList(1:end-1);
                                else;
                                    li_strokeExtra = li_strokeExtra(1);
                                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                                end;
                            end;
                        end;
                    end;
    
                    DPSEC = [];
                    for strokeEC = 2:length(strokeList);
                        distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                        DPSEC(strokeEC-1) = distanceStroke.*2;
                    end;
                    DPSEC = mean(DPSEC);
                end;

            elseif strcmpi(lower(StrokeType), 'para-medley');
                [li, co] = find(legsIM == lapEC);
                if li == 2;
                    %breaststroke leg
                    DPSEC = [];
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
                        if Course == 25;
                            if RaceDist >= 150;
                                caseSC = 1;
                            else;
                                caseSC = 0;
                            end;
                        else;
                            caseSC = 0;
                        end;
    
                        if caseSC == 1;
                            strokeList = strokeList(1:end-1);
                        else;
                            if strcmpi(searchExtraStroke, 'pre');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_iniExtra = zone_frame_ini - (5*framerate);
                                zone_frame_endExtra = strokeList(1) - 1;
                                
                                %take the last stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke pre
                                    strokeList = strokeList(2:end);
                                else;
                                    li_strokeExtra = li_strokeExtra(end);
                                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                                end;
                                
                            elseif strcmpi(searchExtraStroke, 'post');
                                %look for stroke in the 5s leading to the
                                %zone
                                zone_frame_endExtra = zone_frame_end + (5*framerate);
                                zone_frame_iniExtra = strokeList(end) + 1;
    
                                %take the first stroke available
                                li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                                if isempty(li_strokeExtra) == 1;
                                    %couldn't find a stroke post
                                    strokeList = strokeList(1:end-1);
                                else;
                                    li_strokeExtra = li_strokeExtra(1);
                                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                                end;
                            end;
                        end;
                    end;
    
                    DPSEC = [];
                    for strokeEC = 2:length(strokeList);
                        distanceStroke = DistanceEC(strokeList(strokeEC)) - DistanceEC(strokeList(strokeEC-1));
                        DPSEC(strokeEC-1) = distanceStroke.*2;
                    end;
                    DPSEC = mean(DPSEC);
                end;
            end;
            dataTableAverage{zoneEC,4} = DPSEC;
            if isempty(DPSEC) == 0;
                DPSAll(zoneEC,1) = DPSEC;
            end;
            
            if intervalEC == maininterval;
                if isempty(DPSEC) == 0
                    valRatioLap = (zone_dist_end-zone_dist_ini)./Course;
                    valRatioRace = (zone_dist_end-zone_dist_ini)./RaceDist;
                    ratioSegLap(zoneEC) = valRatioLap;
                    ratioSegRace(zoneEC) = valRatioRace;
                end;
            end;
        end;
            
        if updateLap == 1;
            updateLap = 0;
            lapEC = lapEC + 1;
        end;
    end;
    
    if intervalEC == maininterval;
        for lapEC = 1:NbLap;
            rowIn = lapZoneLim(lapEC, 1);
            rowOut = lapZoneLim(lapEC+1, 1);

            DPSALLEC = DPSAll(rowIn:rowOut);
            ratioSegLapEC = ratioSegLap(rowIn:rowOut)';
            index = find(isnan(DPSALLEC) == 0 & DPSALLEC ~= 0);
            DPSALLEC = DPSALLEC(index);
            ratioSegLapEC = ratioSegLapEC(index);
            avDPSlap(lapEC,1) = sum(ratioSegLapEC.*DPSALLEC) ./ sum(ratioSegLapEC);
        end;
        index = find(isnan(DPSAll) == 0 & DPSAll ~= 0);
        DPSAll = DPSAll(index);
        ratioSegRaceEC = ratioSegRace(index);
        avDPSRace = sum(ratioSegRaceEC'.*DPSAll) ./ sum(ratioSegRaceEC');
    end;
    
    
    %calculate splits
    lapEC = 1;
    updateLap = 0;
    for zoneEC = 1:length(dataTableAverage(:,1));
    
        if zoneEC == 1;
            zone_time_ini = 0;
            
            zone_dist_end = dataZone(zoneEC,2);
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
            zone_frame_end = minLoc(1);
            zone_time_end = TimeEC(zone_frame_end);
    
        else;
            
            zone_dist_end = dataZone(zoneEC,2);
            indexLap = find(lapLim == zone_dist_end);
            if isempty(indexLap) == 0;
                zone_time_end = SplitsAll(indexLap,2);
            else;
                zone_dist_end = dataZone(zoneEC,2);
                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                zone_frame_end = minLoc(1);
                zone_time_end = TimeEC(zone_frame_end);
            end;
        end;
        if zoneEC == 1;
            dataTableAverage{zoneEC,5} = zone_time_end - zone_time_ini;                
        else;
            dataTableAverage{zoneEC,5} = dataTableAverage{zoneEC-1,5} + (zone_time_end - zone_time_ini); 
        end;
        zone_time_ini = zone_time_end;
    end;
    
    
    %---Breath Table
    lapLim = Course:Course:RaceDist;
    nbZones = length(dataZone(:,1));
    
    lapEC = 1;
    for zoneEC = 1:nbZones;
        if zoneEC == 1;
            zone_time_ini = 0;            
            zone_frame_ini = 1;
    
            zone_dist_end = dataZone(zoneEC,2);
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
            zone_frame_end = minLoc(1);
        else;
            zone_dist_ini = dataZone(zoneEC-1,2);
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
            zone_frame_ini = minLoc(1);
    
            zone_dist_end = dataZone(zoneEC,2);
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
            zone_frame_end = minLoc(1);
        end;
        if zoneEC == nbZones;
            indexBreath = find(Breath_Frames(lapEC,:) >= zone_frame_ini & Breath_Frames(lapEC,:) <= zone_frame_end);
        else;
            indexBreath = find(Breath_Frames(lapEC,:) >= zone_frame_ini & Breath_Frames(lapEC,:) < zone_frame_end);
        end;
        dataTableBreath = [dataTableBreath; length(indexBreath)];
    
        indexLap = find(lapLim == zone_dist_end);
    
        if isempty(indexLap) == 0;
            %Last zone for a lap
            lapEC = lapEC + 1;
        end;
    end;


    %Save the data
    if intervalEC == 1;
        dataTableAverage1 = dataTableAverage;
        dataTableBreath1 = dataTableBreath;
        dataZone1 = dataZone;
    elseif intervalEC == 2;
        dataTableAverage2 = dataTableAverage;
        dataTableBreath2 = dataTableBreath;
        dataZone2 = dataZone;
    elseif intervalEC == 3;
        dataTableAverage3 = dataTableAverage;
        dataTableBreath3 = dataTableBreath;
        dataZone3 = dataZone;
    end;
end;


%Combine the data
dataTableAverageAll = dataTableAverage3(:,1); %---dist per 5m
dataTableAverageAll(:,2) = dataTableAverage3(:,2); %---Vel per 5m
dataTableAverageAll(:,5) = dataTableAverage3(:,3); %---SR per 5m
dataTableAverageAll(:,8) = dataTableAverage3(:,4); %---DPS per 5m
dataTableAverageAll(:,11) = dataTableAverage3(:,5); %---Splits per 5m
dataTableAverageAll(:,14) = dataTableAverage3(:,6); %---Stroke nb per 5m


dataTableBreathAll = dataTableBreath3;
for rowEC = 1:length(dataTableAverage1(:,1));
    valDistEC = dataZone1(rowEC,2);
    indexDist = find(dataZone3(:,2) == valDistEC);
    
    dataTableAverageAll{indexDist,3} = dataTableAverage1{rowEC,2}; %---Vel per short dist standard
    dataTableAverageAll{indexDist,6} = dataTableAverage1{rowEC,3}; %---SR per short dist standard
    dataTableAverageAll{indexDist,9} = dataTableAverage1{rowEC,4}; %---DPS per short dist standard
    dataTableAverageAll{indexDist,12} = dataTableAverage1{rowEC,5}; %---Splits per short dist standard
    dataTableAverageAll{indexDist,15} = dataTableAverage1{rowEC,6}; %---Stroke nb per short dist standard

    dataTableBreathAll(indexDist,2) = dataTableBreath1(rowEC,1);  %---Breath per short dist standard
end;
for rowEC = 1:length(dataTableAverage2(:,1));
    valDistEC = dataZone2(rowEC,2);
    indexDist = find(dataZone3(:,2) == valDistEC);
    
    dataTableAverageAll{indexDist,4} = dataTableAverage2{rowEC,2}; %---Vel per 200m dist standard
    dataTableAverageAll{indexDist,7} = dataTableAverage2{rowEC,3}; %---SR per 200m dist standard
    dataTableAverageAll{indexDist,10} = dataTableAverage2{rowEC,4}; %---DPS per 200m dist standard
    dataTableAverageAll{indexDist,13} = dataTableAverage2{rowEC,5}; %---Splits per 200m dist standard
    dataTableAverageAll{indexDist,16} = dataTableAverage2{rowEC,6}; %---stroke nb per 200m dist standard

    dataTableBreathAll(indexDist,3) = dataTableBreath2(rowEC,1);  %---Breath per 200m dist standard
end;

