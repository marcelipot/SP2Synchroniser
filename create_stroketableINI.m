RacesTOT = length(handles.uidDB(:,1));
nbRaces = length(handles.filelistAdded);
RaceUID = [];
for raceEC = 1:nbRaces;
    fileEC = handles.filelistAdded{raceEC};
    proceed = 1;
    iter = 1;
    while proceed == 1;
        raceCHECK = handles.uidDB{iter,2};
        if strcmpi(fileEC, raceCHECK) == 1;
            RaceUID{raceEC} = handles.uidDB{iter,1};
            proceed = 0;
        else;
            iter = iter + 1;
        end;
    end;
end;
set(gcf, 'units', 'pixels');
PosFig = get(gcf, 'Position');
set(gcf, 'units', 'normalized');

colorrow(1,:) = [1 0.9 0.1];
colorrow(2,:) = [0.9 0.9 0.9];
colorrow(3,:) = [0.75 0.75 0.75];
colorrow(4,:) = [0.9 0.9 0.9];
colorrow(5,:) = [0.75 0.75 0.75];
colorrow(6,:) = [0.9 0.9 0.9];
colorrow(7,:) = [1 1 1];
colorrow(8,:) = [1 0.9 0.1];

formatlist{1} = 'char';
formatlist{2} = 'char';
edittablelist(1) = false;
edittablelist(2) = false;
for i = 1:nbRaces;
    formatlist{i+2} = 'numeric';
    edittablelist(i+2) = false;
end;

if strcmpi(origin, 'table') == 1;
    PosINI = get(handles.StrokeData_table_analyser, 'Position');
    posCorr = PosINI;
    PosINI = PosINI(3);
    posCorr(3) = PosINI - handles.diffPosStrokeTable;
    set(handles.StrokeData_table_analyser, 'Position', posCorr);

    set(handles.StrokeData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
        'rowstriping', 'on');
    pos = get(handles.StrokeData_table_analyser, 'position');
    PixelTot = pos(3);
    PixelSwimmers = floor((PixelTot - 100 - 150)./nbRaces);
    if PixelSwimmers < 200;
        PixelSwimmers = 200;
        Extent = 0;
    else;
        Extent = 1;
    end;
    ColWidth = {100 150};
    for i = 3:nbRaces+2;
        ColWidth{i} = PixelSwimmers;
    end;
    set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
end;
% set(handles.StrokeData_table_analyser, 'Units', 'normalized');

dataTableStroke = {};
dataTableStroke{1,2} = 'Metadata';
dataTableStroke{8,2} = 'Stroke Management';
dataTableStroke{9,1} = 'SR / SL / Stroke';

SectionSRALL = [];
SectionSDALL = [];;
SectionVelALL = [];
SectionSRALLbis = [];
SectionSDALLbis = [];;
SectionVelALLbis = [];

for i = 3:nbRaces+2;

    %----------------------------------Meta--------------------------------
    UID = RaceUID{i-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['dataTableStroke{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableStroke{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTableStroke{4,' num2str(i) '} = str;']);
    eval(['dataTableStroke{5,' num2str(i) '} = handles.RacesDB.' UID '.Stage;']);
    eval(['FrameRate = handles.RacesDB.' UID '.FrameRate;']);
    
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTableStroke{6,i} = TTtxt;


    %---------------------------------Stroke-------------------------------
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['SREC = handles.RacesDB.' UID '.Stroke_SR;']);
    eval(['SDEC = handles.RacesDB.' UID '.Stroke_DistanceINI;']);
    if i == 3;
        if Course == 25;
            colorrow(9,:) = [1 0.9 0.70];
            lineEC = 10;
            for lap = 1:NbLap;
                dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];
                dataTableStroke{lineEC+1,2} = '0m-5m';
                dataTableStroke{lineEC+2,2} = '5m-10m';
                dataTableStroke{lineEC+3,2} = '10m-15m';
                dataTableStroke{lineEC+4,2} = '15m-20m';
                dataTableStroke{lineEC+5,2} = '20m-Last arm entry';

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];

                lineEC = lineEC + 6;
            end;
            
        else;
            colorrow(9,:) = [1 0.9 0.70];
            lineEC = 10;
            for lap = 1:NbLap;
                dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];
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

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];
                colorrow(lineEC+6,:) = [0.75 0.75 0.75];
                colorrow(lineEC+7,:) = [0.9 0.9 0.9];
                colorrow(lineEC+8,:) = [0.75 0.75 0.75];
                colorrow(lineEC+9,:) = [0.9 0.9 0.9];
                colorrow(lineEC+10,:) = [0.75 0.75 0.75];

                lineEC = lineEC + 11;
            end;
        end;
    end;

    %calculate values per 5m-sections
    SplitsAll = SplitsAll(2:end,:);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.RawDistanceINI;']);
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocityINI;']);
    eval(['StrokeEC = handles.RacesDB.' UID '.RawStroke;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);

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
        liSplitEnd = SplitsAll(lap,3);
        liStrokeLap = Stroke_Frame(lap,:);
        liInterest = find(liStrokeLap ~= 0);
        liStrokeLap = liStrokeLap(liInterest);
        
        if strcmpi(StrokeType, 'Medley');
            lilap = find(lapBFBR == lap);
        end;
        
        keydist = (lap-1).*Course;
        DistIni = keydist;
        
%         if Course == 25;
%             nbzone = 5;
%         else;
%             nbzone = 10;
%         end;
        
        if Course == 50;
            RaceDist = NbLap.*Course;
            if RaceDist <= 100;
                keydist = (lap-1).*Course;
                if lap == 1;
                    DistIni = keydist;
                    DistIniStroke = keydist;
                else;
                    DistIni = keydist + 10;
                    DistIniStroke = keydist;
                end;
            
                if lap == 1;
                    SectionSR = zeros(NbLap,10);
                    SectionSR(:,:) = NaN;
                    SectionSD = zeros(NbLap,10);
                    SectionSD(:,:) = NaN;
                    SectionVel = zeros(NbLap,10);
                    SectionVel(:,:) = NaN;
                    SectionSplitTime = zeros(NbLap,10);
                    SectionSplitTime(:,:) = NaN;
                    SectionCumTime = zeros(NbLap,10);
                    SectionCumTime(:,:) = NaN;

                    SectionSRbis = [];
                    SectionSDbis = [];
                    SectionVelbis = [];
                    SectionSplitTimebis = [];
                    SectionCumTimebis = [];
                end;
                pos = [3 5 7 9 10];
                for zone = 1:5;
                    if zone == 1;
                        if lap == 1;
                            %segment 0-15m after dive
                            DistEnd = DistIni + 15;
                            DistEndStroke = DistIni + 15;
                        else;
                            %segment 50-65m after turn (from 60 to 65m)
                            DistEnd = DistIni + 5;
                            DistEndStroke = DistIniStroke + 15;
                        end;
                    elseif zone == 5;
                        DistEnd = DistIni + 5;
                        DistEndStroke = DistIni + 5;
                    else;
                        DistEnd = DistIni + 10;
                        DistEndStroke = DistIni + 10;
                    end;
                    
                    diffIni = abs(DistanceEC - DistIni);
                    [~, liIni] = min(diffIni);
                    
                    if lap == 1;
                        liIniStroke = liIni;
                    else;
                        diffIni = abs(DistanceEC - DistIniStroke);
                        [~, liIniStroke] = min(diffIni);
                    end;
                    
                    if zone == nbzone;
                        linan = find(isnan(DistanceEC(liIni:liSplitEnd)) == 0);
                        linan = linan + liIni - 1;
                        liEnd = linan(end);
                        liEndStroke = linan(end);
                    else;
                        diffEnd = abs(DistanceEC - DistEnd);
                        [~, liEnd] = min(diffEnd);
                        
                        diffEnd = abs(DistanceEC - DistEndStroke);
                        [~, liEndStroke] = min(diffEnd);
                        
                    end;

                    if BOAll(lap,1) > liEnd;
                        SectionSR(lap,pos(zone)) = NaN;
                        SectionSD(lap,pos(zone)) = NaN;
                        SectionVel(lap,pos(zone)) = NaN;
                        SectionSplitTime(lap,pos(zone)) = NaN;
                        SectionCumTime(lap,pos(zone)) = NaN;
                    else;
                        if BOAll(lap,1) > liIni;
                            liIni = BOAll(lap,1) + 1;
                        end;
                        if BOAll(lap,1) > liIniStroke;
                            liIniStroke = BOAll(lap,1) + 1;
                        end;
                        
                        interestDist = DistanceEC(liIni:liEnd);
                        linonnan = find(isnan(interestDist) == 0);
                        interestDist = interestDist(linonnan);
                        
                        interestTime = TimeEC(liIni:liEnd);
                        linonnan = find(isnan(interestTime) == 0);
                        interestTime = interestTime(linonnan);
                        
                        SectionVel(lap,pos(zone)) = roundn((interestDist(end)-interestDist(1)) ./ (interestTime(end)-interestTime(1)), -2);
                        SectionSplitTime(lap,pos(zone)) = 0;
                        SectionCumTime(lap,pos(zone)) = interestTime(end);        

                        liStrokeSec = find(StrokeEC(liIni:liEnd) == 1);
                        liStrokeSecStroke = find(StrokeEC(liIniStroke:liEndStroke) == 1);
                        
                        if lap >= 2;
                            if zone == 1;
                                liStrokeSecRef = liStrokeSecStroke;
                                liIniRef = liIniStroke;
                                liEndRef = liEndStroke;
                                if BOAll(lap,3) < DistIniStroke+10;
                                    DistIniRef = DistIniStroke+10;
                                else;
                                    DistIniRef = BOAll(lap,3); 
                                end;
                                DistEndRef = DistEndStroke;
                            elseif zone == 5;
                                liStrokeSecRef = liStrokeSec;
                                liIniRef = liIni;
                                liEndRef = liEnd;
                                DistIniRef = DistIni;
                                
                                StrLap = Stroke_Frame(lap, :);
                                index = find(StrLap ~= 0);
                                StrLapLast = StrLap(index(end));
                                DistEndStroke = DistanceEC(StrLapLast);
                            else;
                                liStrokeSecRef = liStrokeSec;
                                liIniRef = liIni;
                                liEndRef = liEnd;
                                DistIniRef = DistIni;
                                DistEndRef = DistEnd;
                                
                            end;
                        else;
                            liStrokeSecRef = liStrokeSec;
                            liIniRef = liIni;
                            liEndRef = liEnd;

                            if zone == 1;
                                DistIniRef = BOAll(lap,3);
                                DistEndRef = DistEnd;
                            elseif zone == 5;
                                liStrokeSecRef = liStrokeSec;
                                liIniRef = liIni;
                                liEndRef = liEnd;
                                DistIniRef = DistIni;
                                
                                StrLap = Stroke_Frame(lap, :);
                                index = find(StrLap ~= 0);
                                StrLapLast = StrLap(index(end));
                                DistEndStroke = DistanceEC(StrLapLast);
                            else;
                                DistIniRef = DistIni;
                                DistEndRef = DistEnd;
                            end;
                        end;

                        if isempty(liStrokeSecRef) == 0;
                            if strcmpi(StrokeType, 'Breaststroke') | strcmpi(StrokeType, 'Butterfly');
                                if length(liStrokeSecRef) < 1;
                                    SectionSR(lap,pos(zone)) = NaN;
                                    SectionSD(lap,pos(zone)) = NaN;
                                    SectionNb(lap,pos(zone)) = NaN;

                                    SectionSRbis(lap,pos(zone)) = NaN;
                                    SectionSDbis(lap,pos(zone)) = NaN;
                                    SectionNbbis(lap,pos(zone)) = NaN;

                                elseif length(liStrokeSecRef) >= 1 & length(liStrokeSecRef) < 2;
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;
                                    if zone == 1;
                                        IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                                    elseif zone == 5;
                                        IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                                    else;
                                        IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                                    end;
                                    li = find(IDstroke > 1);
                                    IDstroke = IDstroke(li);
                                    
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));
                                    StrDuration = (StTime2 - StTime1)./FrameRate;
                                    SectionSR(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                    SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                    
                                    %position at the beginning and end
                                    VelEC = SectionVel(lap,pos(zone));
                                    
                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);
                                    
                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD + 1;
                                            SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        SegTime1 = TimeEC(liIniRef);
                                    end;
                                    SegTime2 = TimeEC(liEndRef);
                                    
                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                                    
                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            StDist2 = DistEndRef + PosTime2;
                                        elseif zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    else;
                                        if zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    end;
                                    
                                    SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    SectionNb(lap,pos(zone)) = 1;
                                    SectionNbbis(lap,pos(zone)) = 1;
                                    
                                else;
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;
                                    
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));
                                    StrDuration = (StTime2 - StTime1)./FrameRate;
                                    SectionSR(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                    SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                    VelEC = SectionVel(lap,pos(zone));

                                    %position at the beginning and end
                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);
                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD + 1;
                                            SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        SegTime1 = TimeEC(liIniRef);
                                    end;
                                    SegTime2 = TimeEC(liEndRef);
                                    
                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                                    
                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            StDist2 = DistEndRef + PosTime2;
                                        elseif zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    else;
                                        if zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    end;
                                    
                                    SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    SectionNb(lap,pos(zone)) = length(liStrokeSecRef);
                                    SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                end;

                            elseif strcmpi(StrokeType, 'Medley');
                                if isempty(lilap) == 1;
                                    %BK and FS
                                    if length(liStrokeSecRef) >= 2;
                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                        StTime1 = Stroke_Frame(lap, IDstroke(1)-1);
                                        StTime2 = Stroke_Frame(lap, IDstroke(end)-1);
                                        
                                        if IDstroke(end) + 1 < length(Stroke_Frame(lap,:));
                                            StTime3 = Stroke_Frame(lap, IDstroke(end) + 1);
                                        else;
                                            StTime3 = Stroke_Frame(lap, IDstroke(1) - 1);
                                        end;

                                        if length(liStrokeSecRef) == 2;
                                            StrDuration = abs((StTime3 - StTime1))./FrameRate;
                                            SectionSR(lap,pos(zone)) = ((length(liStrokeSecRef)).*60)./StrDuration;
                                            SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)).*60)./StrDuration;
                                        else;
                                            StrDuration = (StTime2 - StTime1)./FrameRate;
                                            SectionSR(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                            SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                        end;
                                        SectionSR(lap,pos(zone)) = roundn(SectionSR(lap,pos(zone)) ./ 2, -1);
                                        SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone)) ./ 2, -1);
                                        
                                        %position at the beginning and end
                                        VelEC = SectionVelbis(lap,pos(zone));

                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);

                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD + 1;
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                        SegTime2 = TimeEC(liEndRef);

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                            end;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                        end;
                                        StDist2 = DistEndRef + PosTime2;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                                StDist2 = DistEndRef + PosTime2;
                                            elseif zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        else;
                                            if zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        end;
    
                                        if length(liStrokeSecRef) == 2;
                                            StrUseful = find(Stroke_Frame(lap,:) ~= 0);
                                            StrUseful = Stroke_Frame(lap,StrUseful);
    
                                            if IDstroke(end) + 1 < length(StrUseful);
                                                StTime3 = Stroke_Frame(lap, IDstroke(end)+1);
                                                StTime3 = TimeEC(StTime3);
                                                PosTime3 = (StTime3 - SegTime2) .* VelEC;
                                                StDist3 = DistEndRef + PosTime3;
                                            else;
                                                StTime3 = Stroke_Frame(lap, IDstroke(1)-1);
                                                StTime3 = TimeEC(StTime3);
                                                PosTime3 = (SegTime1 - StTime3) .* VelEC;
                                                if lap >= 2;
                                                    if zone == 1;
                                                        StDist3 = DistIni + PosTime3;
                                                    else;
                                                        StDist3 = DistIniRef + PosTime3;
                                                    end;
                                                else;
                                                    StDist3 = DistIniRef + PosTime3;
                                                end;
                                            end;
                                            SectionSD(lap,pos(zone)) = roundn((abs((StDist3 - StDist1)) ./ (length(liStrokeSecRef))).*2,-2);
                                            SectionSDbis(lap,pos(zone)) = roundn((abs((StDist3 - StDist1)) ./ (length(liStrokeSecRef))).*2,-2);
                                        else;
                                            SectionSD(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1)).*2,-2);
                                            SectionSDbis(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1)).*2,-2);
                                        end;
                                        SectionNb(lap,pos(zone)) = length(liStrokeSecRef);
                                        SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                    
                                    else;
                                        SectionSR(lap,pos(zone)) = NaN;
                                        SectionSD(lap,pos(zone)) = NaN;
                                        SectionNb(lap,pos(zone)) = NaN;

                                        SectionSRbis(lap,pos(zone)) = NaN;
                                        SectionSDbis(lap,pos(zone)) = NaN;
                                        SectionNbbis(lap,pos(zone)) = NaN;
                                    end;
                                else;
                                    %BF and BR
                                    if length(liStrokeSecRef) < 1;
                                        SectionSR(lap,pos(zone)) = NaN;
                                        SectionSD(lap,pos(zone)) = NaN;
                                        SectionNb(lap,pos(zone)) = NaN;

                                        SectionSRbis(lap,pos(zone)) = NaN;
                                        SectionSDbis(lap,pos(zone)) = NaN;
                                        SectionNbbis(lap,pos(zone)) = NaN;

                                    elseif length(liStrokeSecRef) >= 1 & length(liStrokeSecRef) < 2;
                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                        if zone == 1;
                                            IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                                        elseif zone == 5;
                                            IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                                        else;
                                            IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                                        end;
                                        
                                        StTime1 = Stroke_Frame(lap, IDstroke(1));
                                        StTime2 = Stroke_Frame(lap, IDstroke(end));
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSR(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                        SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                        VelEC = SectionVel(lap,pos(zone));

                                        %position at the beginning and end
                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);
                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD + 1;
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                        SegTime2 = TimeEC(liEndRef);

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                                StDist2 = DistEndRef + PosTime2;
                                            elseif zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        else;
                                            if zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        end;

                                        SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionNb(lap,pos(zone)) = 1;
                                        SectionNbbis(lap,pos(zone)) = 1;
                                        
                                    else;
                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                        StTime1 = Stroke_Frame(lap, IDstroke(1)-1);
                                        StTime2 = Stroke_Frame(lap, IDstroke(end)-1);
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSR(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                        SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                        VelEC = SectionVel(lap,pos(zone));

                                        %position at the beginning and end
                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);
                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD + 1;
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                        SegTime2 = TimeEC(liEndRef);

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                                StDist2 = DistEndRef + PosTime2;
                                            elseif zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        else;
                                            if zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        end;

                                        SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionNb(lap,pos(zone)) = length(liStrokeSecRef);
                                        SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                    end;
                                end;

                            else;
                                if length(liStrokeSecRef) >= 2;
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));

                                    if IDstroke(end) + 1 < length(Stroke_Frame(lap,:));
                                        StTime3 = Stroke_Frame(lap, IDstroke(end) + 1);
                                    else;
                                        StTime3 = Stroke_Frame(lap, IDstroke(1) - 1);
                                    end;

                                    if length(liStrokeSecRef) == 2;
                                        StrDuration = abs((StTime3 - StTime1))./FrameRate;
                                        SectionSR(lap,pos(zone)) = ((length(liStrokeSecRef)).*60)./StrDuration;
                                        SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)).*60)./StrDuration;
                                    else;
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSR(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                        SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                    end;
                                    SectionSR(lap,pos(zone)) = roundn(SectionSR(lap,pos(zone)) ./ 2, -1);
                                    SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone)) ./ 2, -1);
                                    
                                    %position at the beginning and end
                                    VelEC = SectionVel(lap,pos(zone));

                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);

                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD + 1;
                                            SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        SegTime1 = TimeEC(liIniRef);
                                    end;
                                    SegTime2 = TimeEC(liEndRef);
                                    
                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                                    
                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            StDist2 = DistEndRef + PosTime2;
                                        elseif zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    else;
                                        if zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    end;

                                    if length(liStrokeSecRef) == 2;
                                        StrUseful = find(Stroke_Frame(lap,:) ~= 0);
                                        StrUseful = Stroke_Frame(lap,StrUseful);

                                        if IDstroke(end) + 1 < length(StrUseful);
                                            StTime3 = Stroke_Frame(lap, IDstroke(end)+1);
                                            StTime3 = TimeEC(StTime3);
                                            PosTime3 = (StTime3 - SegTime2) .* VelEC;
                                            StDist3 = DistEndRef + PosTime3;
                                        else;
                                            StTime3 = Stroke_Frame(lap, IDstroke(1)-1);
                                            StTime3 = TimeEC(StTime3);
                                            PosTime3 = (SegTime1 - StTime3) .* VelEC;
                                            if lap >= 2;
                                                if zone == 1;
                                                    StDist3 = DistIni + PosTime3;
                                                else;
                                                    StDist3 = DistIniRef + PosTime3;
                                                end;
                                            else;
                                                StDist3 = DistIniRef + PosTime3;
                                            end;
                                        end;
                                        SectionSD(lap,pos(zone)) = roundn((abs((StDist3 - StDist1)) ./ (length(liStrokeSecRef))).*2,-2);
                                        SectionSDbis(lap,pos(zone)) = roundn((abs((StDist3 - StDist1)) ./ (length(liStrokeSecRef))).*2,-2);
                                    else;
                                        SectionSD(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1)).*2,-2);
                                        SectionSDbis(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1)).*2,-2);
                                    end;
                                    SectionNb(lap,pos(zone)) = length(liStrokeSecRef);
                                    SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);

                                else;
                                    SectionSR(lap,pos(zone)) = NaN;
                                    SectionSD(lap,pos(zone)) = NaN;
                                    SectionNb(lap,pos(zone)) = NaN;

                                    SectionSRbis(lap,pos(zone)) = NaN;
                                    SectionSDbis(lap,pos(zone)) = NaN;
                                    SectionNbbis(lap,pos(zone)) = NaN;
                                end;
                            end;
                        else;
                            SectionSR(lap,pos(zone)) = NaN;
                            SectionSD(lap,pos(zone)) = NaN;
                            SectionNb(lap,pos(zone)) = NaN;

                            SectionSRbis(lap,pos(zone)) = NaN;
                            SectionSDbis(lap,pos(zone)) = NaN;
                            SectionNbbis(lap,pos(zone)) = NaN;
                        end;
                    end;     
                    DistIni = DistEnd;
                    DistIniStroke = DistEndStroke;DistIni = DistEnd;
                end;
                SectionVelbis = SectionVel;
                SectionSplitTimebis = SectionSplitTime;
                SectionCumTimebis = SectionCumTime;
                liSplitIni = SplitsAll(lap,3) + 1;

            else;
                %200 and above
                keydist = (lap-1).*Course;

                if lap == 1;
                    DistIni = keydist + 15;
                    DistIniStroke = keydist;
                else;
                    DistIni = keydist + 10;
                    DistIniStroke = keydist;
                end;
                
                if lap == 1;
                    SectionSR = zeros(NbLap,10);
                    SectionSR(:,:) = NaN;
                    SectionSD = zeros(NbLap,10);
                    SectionSD(:,:) = NaN;
                    SectionVel = zeros(NbLap,10);
                    SectionVel(:,:) = NaN;
                    SectionSplitTime = zeros(NbLap,10);
                    SectionSplitTime(:,:) = NaN;
                    SectionCumTime = zeros(NbLap,10);
                    SectionCumTime(:,:) = NaN;
                end;
                pos = [5 10];
                for zone = 1:2;
                    if zone == 1;
                        if lap == 1;
                            %segment 0-15m after dive
                            DistEnd = DistIni + 10;
                            DistEndStroke = DistIniStroke + 25;
                        else;
                            %segment 50-65m after turn (from 60 to 65m)
                            DistEnd = DistIni + 15;
                            DistEndStroke = DistIniStroke + 25;
                        end;
                    elseif zone == 2;
                        DistEnd = DistIni + 20;
                        DistEndStroke = DistIniStroke + 25;
                    end;
                    
                    diffIni = abs(DistanceEC - DistIni);
                    [~, liIni] = min(diffIni);
                    
                    diffIni = abs(DistanceEC - DistIniStroke);
                    [~, liIniStroke] = min(diffIni);
                    
                    diffEnd = abs(DistanceEC - DistEnd);
                    [~, liEnd] = min(diffEnd);
                    
                    diffEnd = abs(DistanceEC - DistEndStroke);
                    [~, liEndStroke] = min(diffEnd);
                    
                    if BOAll(lap,1) > liEnd;
                        SectionSR(lap,pos(zone)) = NaN;
                        SectionSD(lap,pos(zone)) = NaN;
                        SectionVel(lap,pos(zone)) = NaN;
                        SectionSplitTime(lap,pos(zone)) = NaN;
                        SectionCumTime(lap,pos(zone)) = NaN;

                        SectionSRbis(lap,pos(zone)) = NaN;
                        SectionSDbis(lap,pos(zone)) = NaN;
                        SectionVelbis(lap,pos(zone)) = NaN;
                        SectionSplitTimebis(lap,pos(zone)) = NaN;
                        SectionCumTimebis(lap,pos(zone)) = NaN;
                    else;
                        if BOAll(lap,1) > liIni;
                            liIni = BOAll(lap,1) + 1;
                        end;
                        if BOAll(lap,1) > liIniStroke;
                            liIniStroke = BOAll(lap,1) + 1;
                        end;
                        
                        interestDist = DistanceEC(liIni:liEnd);
                        linonnan = find(isnan(interestDist) == 0);
                        interestDist = interestDist(linonnan);
                        
                        interestTime = TimeEC(liIni:liEnd);
                        linonnan = find(isnan(interestTime) == 0);
                        interestTime = interestTime(linonnan);
                        
                        SectionVel(lap,pos(zone)) = roundn((interestDist(end)-interestDist(1)) ./ (interestTime(end)-interestTime(1)), -2);
                        SectionSplitTime(lap,pos(zone)) = 0;
                        SectionCumTime(lap,pos(zone)) = interestTime(end);        

                        SectionVelbis(lap,pos(zone)) = roundn((interestDist(end)-interestDist(1)) ./ (interestTime(end)-interestTime(1)), -2);
                        SectionSplitTimebis(lap,pos(zone)) = 0;
                        SectionCumTimebis(lap,pos(zone)) = interestTime(end);

                        liStrokeSec = find(StrokeEC(liIni:liEnd) == 1);
                        liStrokeSecStroke = find(StrokeEC(liIniStroke:liEndStroke) == 1);
                        
                        if lap >= 2;
                            if zone == 1;
                                liStrokeSecRef = liStrokeSecStroke;
                                liIniRef = liIniStroke;
                                liEndRef = liEndStroke;
                                if BOAll(lap,3) < DistIniStroke+10;
                                    DistIniRef = DistIniStroke+10;
                                else;
                                    DistIniRef = BOAll(lap,3); 
                                end;
                                DistEndRef = DistEndStroke;

                            else;
                                liStrokeSecRef = liStrokeSecStroke;
                                liIniRef = liIniStroke;
                                liEndRef = liEndStroke;
                                DistIniRef = DistIniStroke;
                                DistEndRef = DistEndStroke;
                                
                            end;
                        else;
                            if zone == 1;
                                liStrokeSecRef = liStrokeSecStroke;
                                liIniRef = liIniStroke;
                                liEndRef = liEndStroke;
                                DistIniRef = DistIniStroke;
                                DistEndRef = DistEndStroke;
                                
                            else;
                                liStrokeSecRef = liStrokeSecStroke;
                                liIniRef = liIniStroke;
                                liEndRef = liEndStroke;
                                DistIniRef = DistIniStroke;
                                DistEndRef = DistEndStroke;
                                
                            end;
                        end;
                        
                        if isempty(liStrokeSecRef) == 0;
                            if strcmpi(StrokeType, 'Breaststroke') | strcmpi(StrokeType, 'Butterfly');
                                if length(liStrokeSecRef) < 1;
                                    SectionSR(lap,pos(zone)) = NaN;
                                    SectionSD(lap,pos(zone)) = NaN;
                                    SectionNb(lap,pos(zone)) = NaN;

                                    SectionSRbis(lap,pos(zone)) = NaN;
                                    SectionSDbis(lap,pos(zone)) = NaN;
                                    SectionNbbis(lap,pos(zone)) = NaN;

                                elseif length(liStrokeSecRef) >= 1 & length(liStrokeSecRef) < 2;
                                    
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;
                                    if zone == 1;
                                        IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                                    elseif zone == 5;
                                        IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                                    else;
                                        IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                                    end;
                                    li = find(IDstroke > 1);
                                    IDstroke = IDstroke(li);
                                    
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));
                                    StrDuration = (StTime2 - StTime1)./FrameRate;
                                    SectionSR(lap,pos(zone)) = roundn((2.*60)./StrDuration, -1);
                                    SectionSRbis(lap,pos(zone)) = roundn((2.*60)./StrDuration, -1);
                                    VelEC = SectionVel(lap,pos(zone));

                                    %position at the beginning and end
                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);
                                    
                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD + 1;
                                            SegTime1 = TimeEC(liIniSD);
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            SegTime1 = TimeEC(liIniSD); %take the 15m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    end;
                                    if zone == 1;
                                        SegTime2 = TimeEC(liEndRef);
                                    elseif zone == 2;
                                        diffEnd = abs(DistanceEC - DistEnd);
                                        [~, liEndSD] = min(diffEnd);
                                        liEndSD = liEndSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                        SegTime2 = TimeEC(liEndSD);
                                    end;

                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                        end;
                                    else;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                        end;
                                    end;
                                    if lap >= 2;
                                        if zone == 1;
                                            StDist2 = DistEndRef + PosTime2; %take the 40m mark (not DistIniRef) to extrapolate the position
                                        else;
                                            StDist2 = DistEnd + PosTime2;
                                        end;
                                    else;
                                        if zone == 1;
                                            StDist2 = DistEndRef + PosTime2;
                                        else;
                                            StDist2 = DistEnd + PosTime2;
                                        end;
                                    end;
                                    
                                    SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    SectionNb(lap,pos(zone)) = 1;
                                    SectionNbbis(lap,pos(zone)) = 1;
                                    
                                else;
                                    
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;
                                    
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));
                                    StrDuration = (StTime2 - StTime1)./FrameRate;
                                    
                                    SectionSR(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                    SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                    

                                    %position at the beginning and end
                                    VelEC = SectionVel(lap,pos(zone));
                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);
                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            SegTime1 = TimeEC(liIniSD); %take the 15m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    end;
                                    if zone == 1;
                                        SegTime2 = TimeEC(liEndRef);
                                    elseif zone == 2;
                                        diffEnd = abs(DistanceEC - DistEnd);
                                        [~, liEndSD] = min(diffEnd);
                                        liEndSD = liEndSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                        SegTime2 = TimeEC(liEndSD);
                                    end;

                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                        end;
                                    else;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                        end;
                                    end;
                                    if lap >= 2;
                                        if zone == 1;
                                            StDist2 = DistEndRef + PosTime2; %take the 40m mark (not DistIniRef) to extrapolate the position
                                        else;
                                            StDist2 = DistEnd + PosTime2;
                                        end;
                                    else;
                                        if zone == 1;
                                            StDist2 = DistEndRef + PosTime2;
                                        else;
                                            StDist2 = DistEnd + PosTime2;
                                        end;
                                    end;
                                    
                                    SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    SectionNb(lap,pos(zone)) = length(liStrokeSecRef);
                                    SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                end;

                            elseif strcmpi(StrokeType, 'Medley');
                                if isempty(lilap) == 1;
                                    %BK and FS
                                    if length(liStrokeSecRef) >= 2;

                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                        
                                        StTime1 = Stroke_Frame(lap, IDstroke(1));
                                        StTime2 = Stroke_Frame(lap, IDstroke(end));
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSR(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                        SectionSR(lap,pos(zone)) = roundn(SectionSR(lap,pos(zone)) ./ 2, -1);
                                        SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                        SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone)) ./ 2, -1);

                                        VelEC = SectionVel(lap,pos(zone));

                                        %position at the beginning and end
                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);
                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                SegTime1 = TimeEC(liIniSD); %take the 15m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        end;
                                        if zone == 1;
                                            SegTime2 = TimeEC(liEndRef);
                                        elseif zone == 2;
                                            diffEnd = abs(DistanceEC - DistEnd);
                                            [~, liEndSD] = min(diffEnd);
                                            liEndSD = liEndSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            SegTime2 = TimeEC(liEndSD);
                                        end;

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                            end;
                                        else;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                            end;
                                        end;
                                        if lap >= 2;
                                            if zone == 1;
                                                StDist2 = DistEndRef + PosTime2; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            else;
                                                StDist2 = DistEnd + PosTime2;
                                            end;
                                        else;
                                            if zone == 1;
                                                StDist2 = DistEndRef + PosTime2;
                                            else;
                                                StDist2 = DistEnd + PosTime2;
                                            end;
                                        end;

                                        SectionSD(lap,pos(zone)) = (StDist2 - StDist1) ./ (length(liStrokeSecRef)-1);;
                                        SectionSD(lap,pos(zone)) = roundn(SectionSD(lap,pos(zone)) .* 2, -2);
                                        SectionSDbis(lap,pos(zone)) = (StDist2 - StDist1) ./ (length(liStrokeSecRef)-1);;
                                        SectionSDbis(lap,pos(zone)) = roundn(SectionSDbis(lap,pos(zone)) .* 2, -2);

                                        SectionNb(lap,pos(zone)) = length(liStrokeSecRef);
                                        SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                    else;
                                        SectionSR(lap,pos(zone)) = NaN;
                                        SectionSD(lap,pos(zone)) = NaN;
                                        SectionNb(lap,pos(zone)) = NaN;

                                        SectionSRbis(lap,pos(zone)) = NaN;
                                        SectionSDbis(lap,pos(zone)) = NaN;
                                        SectionNbbis(lap,pos(zone)) = NaN;
                                    end;
                                else;
                                    %BF and BR
                                    if length(liStrokeSecRef) < 1;
                                        SectionSR(lap,pos(zone)) = NaN;
                                        SectionSD(lap,pos(zone)) = NaN;
                                        SectionNb(lap,pos(zone)) = NaN;

                                        SectionSRbis(lap,pos(zone)) = NaN;
                                        SectionSDbis(lap,pos(zone)) = NaN;
                                        SectionNbbis(lap,pos(zone)) = NaN;

                                    elseif length(liStrokeSecRef) >= 1 & length(liStrokeSecRef) < 2;
                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                        if zone == 1;
                                            IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                                        elseif zone == 5;
                                            IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                                        else;
                                            IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                                        end;
                                        
                                        StTime1 = Stroke_Frame(lap, IDstroke(1));
                                        StTime2 = Stroke_Frame(lap, IDstroke(end));
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSR(lap,pos(zone)) = roundn((2.*60)./StrDuration, -1);
                                        SectionSRbis(lap,pos(zone)) = roundn((2.*60)./StrDuration, -1);
                                        VelEC = SectionVel(lap,pos(zone));

                                        %position at the beginning and end
                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);
                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                SegTime1 = TimeEC(liIniSD); %take the 15m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        end;
                                        if zone == 1;
                                            SegTime2 = TimeEC(liEndRef);
                                        elseif zone == 2;
                                            diffEnd = abs(DistanceEC - DistEnd);
                                            [~, liEndSD] = min(diffEnd);
                                            liEndSD = liEndSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            SegTime2 = TimeEC(liEndSD);
                                        end;

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                            end;
                                        else;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                            end;
                                        end;
                                        if lap >= 2;
                                            if zone == 1;
                                                StDist2 = DistEndRef + PosTime2; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            else;
                                                StDist2 = DistEnd + PosTime2;
                                            end;
                                        else;
                                            if zone == 1;
                                                StDist2 = DistEndRef + PosTime2;
                                            else;
                                                StDist2 = DistEnd + PosTime2;
                                            end;
                                        end;

                                        SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionNb(lap,pos(zone)) = 1;
                                        SectionNbbis(lap,pos(zone)) = 1;
                                        
                                    else;
                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                        StTime1 = Stroke_Frame(lap, IDstroke(1));
                                        StTime2 = Stroke_Frame(lap, IDstroke(end));
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSR(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                        SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                        VelEC = SectionVel(lap,pos(zone));

                                        %position at the beginning and end
                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);
                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                SegTime1 = TimeEC(liIniSD); %take the 15m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        end;
                                        if zone == 1;
                                            SegTime2 = TimeEC(liEndRef);
                                        elseif zone == 2;
                                            diffEnd = abs(DistanceEC - DistEnd);
                                            [~, liEndSD] = min(diffEnd);
                                            liEndSD = liEndSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            SegTime2 = TimeEC(liEndSD);
                                        end;

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                            end;
                                        else;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                            end;
                                        end;
                                        if lap >= 2;
                                            if zone == 1;
                                                StDist2 = DistEndRef + PosTime2; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            else;
                                                StDist2 = DistEnd + PosTime2;
                                            end;
                                        else;
                                            if zone == 1;
                                                StDist2 = DistEndRef + PosTime2;
                                            else;
                                                StDist2 = DistEnd + PosTime2;
                                            end;
                                        end;
                                        
                                        SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionNb(lap,pos(zone)) = length(liStrokeSecRef);
                                        SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                    end;
                                end;

                            else;
                                if length(liStrokeSecRef) >= 2;
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;                                    
                                    
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));
                                    StrDuration = (StTime2 - StTime1)./FrameRate;
                                    SectionSR(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                    SectionSR(lap,pos(zone)) = roundn(SectionSR(lap,pos(zone)) ./ 2, -1);
                                    SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                    SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone)) ./ 2, -1);
                                    
                                    %position at the beginning and end
                                    VelEC = SectionVel(lap,pos(zone));
                                    
                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);
                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            SegTime1 = TimeEC(liIniSD); %take the 15m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    end;
                                    if zone == 1;
                                        SegTime2 = TimeEC(liEndRef);
                                    elseif zone == 2;
                                        diffEnd = abs(DistanceEC - DistEnd);
                                        [~, liEndSD] = min(diffEnd);
                                        liEndSD = liEndSD; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                        SegTime2 = TimeEC(liEndSD);
                                    end;

                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                        end;
                                    else;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                        end;
                                    end;
                                    if lap >= 2;
                                        if zone == 1;
                                            StDist2 = DistEndRef + PosTime2; %take the 40m mark (not DistIniRef) to extrapolate the position
                                        else;
                                            StDist2 = DistEnd + PosTime2;
                                        end;
                                    else;
                                        if zone == 1;
                                            StDist2 = DistEndRef + PosTime2;
                                        else;
                                            StDist2 = DistEnd + PosTime2;
                                        end;
                                    end;

                                    SectionSD(lap,pos(zone)) = (StDist2 - StDist1) ./ (length(liStrokeSecRef)-1);
                                    SectionSD(lap,pos(zone)) = roundn(SectionSD(lap,pos(zone)) .* 2, -2);
                                    SectionSDbis(lap,pos(zone)) = (StDist2 - StDist1) ./ (length(liStrokeSecRef)-1);
                                    SectionSDbis(lap,pos(zone)) = roundn(SectionSDbis(lap,pos(zone)) .* 2, -2);
                                    SectionNb(lap,pos(zone)) = length(liStrokeSecRef);
                                    SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                    
                                else;
                                    SectionSR(lap,pos(zone)) = NaN;
                                    SectionSD(lap,pos(zone)) = NaN;
                                    SectionNb(lap,pos(zone)) = NaN;

                                    SectionSRbis(lap,pos(zone)) = NaN;
                                    SectionSDbis(lap,pos(zone)) = NaN;
                                    SectionNbbis(lap,pos(zone)) = NaN;
                                end;
                            end;
                        else;
                            SectionSR(lap,pos(zone)) = NaN;
                            SectionSD(lap,pos(zone)) = NaN;
                            SectionNb(lap,pos(zone)) = NaN;

                            SectionSRbis(lap,pos(zone)) = NaN;
                            SectionSDbis(lap,pos(zone)) = NaN;
                            SectionNbbis(lap,pos(zone)) = NaN;
                        end;
                    end;     
                    DistIni = DistEnd;
                    DistIniStroke = DistEndStroke;
                end;
                liSplitIni = SplitsAll(lap,3) + 1;

                %Do the same thing with the 100m segments
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                keydist = (lap-1).*Course;
                if lap == 1;
                    DistIni = keydist;
                    DistIniStroke = keydist;
                else;
                    DistIni = keydist + 10;
                    DistIniStroke = keydist;
                end;
            
                if lap == 1;
                    SectionSRbis = zeros(NbLap,10);
                    SectionSRbis(:,:) = NaN;
                    SectionSDbis = zeros(NbLap,10);
                    SectionSDbis(:,:) = NaN;
                    SectionVelbis = zeros(NbLap,10);
                    SectionVelbis(:,:) = NaN;
                    SectionSplitTimebis = zeros(NbLap,10);
                    SectionSplitTimebis(:,:) = NaN;
                    SectionCumTimebis = zeros(NbLap,10);
                    SectionCumTimebis(:,:) = NaN;
                end;
                pos = [3 5 7 9 10];
                for zone = 1:5;
                    if zone == 1;
                        if lap == 1;
                            %segment 0-15m after dive
                            DistEnd = DistIni + 15;
                            DistEndStroke = DistIni + 15;
                        else;
                            %segment 50-65m after turn (from 60 to 65m)
                            DistEnd = DistIni + 5;
                            DistEndStroke = DistIniStroke + 15;
                        end;
                    elseif zone == 5;
                        DistEnd = DistIni + 5;
                        DistEndStroke = DistIni + 5;
                    else;
                        DistEnd = DistIni + 10;
                        DistEndStroke = DistIni + 10;
                    end;
                    
                    diffIni = abs(DistanceEC - DistIni);
                    [~, liIni] = min(diffIni);
                    
                    if lap == 1;
                        liIniStroke = liIni;
                    else;
                        diffIni = abs(DistanceEC - DistIniStroke);
                        [~, liIniStroke] = min(diffIni);
                    end;
                    
                    if zone == nbzone;
                        linan = find(isnan(DistanceEC(liIni:liSplitEnd)) == 0);
                        linan = linan + liIni - 1;
                        liEnd = linan(end);
                        liEndStroke = linan(end);
                    else;
                        diffEnd = abs(DistanceEC - DistEnd);
                        [~, liEnd] = min(diffEnd);
                        
                        diffEnd = abs(DistanceEC - DistEndStroke);
                        [~, liEndStroke] = min(diffEnd);
                        
                    end;

                    if BOAll(lap,1) > liEnd;
                        SectionSRbis(lap,pos(zone)) = NaN;
                        SectionSDbis(lap,pos(zone)) = NaN;
                        SectionVelbis(lap,pos(zone)) = NaN;
                        SectionSplitTimebis(lap,pos(zone)) = NaN;
                        SectionCumTimebis(lap,pos(zone)) = NaN;
                    else;
                        if BOAll(lap,1) > liIni;
                            liIni = BOAll(lap,1) + 1;
                        end;
                        if BOAll(lap,1) > liIniStroke;
                            liIniStroke = BOAll(lap,1) + 1;
                        end;
                        
                        interestDist = DistanceEC(liIni:liEnd);
                        linonnan = find(isnan(interestDist) == 0);
                        interestDist = interestDist(linonnan);
                        
                        interestTime = TimeEC(liIni:liEnd);
                        linonnan = find(isnan(interestTime) == 0);
                        interestTime = interestTime(linonnan);
                        
                        SectionVelbis(lap,pos(zone)) = roundn((interestDist(end)-interestDist(1)) ./ (interestTime(end)-interestTime(1)), -2);
                        SectionSplitTimebis(lap,pos(zone)) = 0;
                        SectionCumTimebis(lap,pos(zone)) = interestTime(end);        

                        liStrokeSec = find(StrokeEC(liIni:liEnd) == 1);
                        liStrokeSecStroke = find(StrokeEC(liIniStroke:liEndStroke) == 1);
                        
                        if lap >= 2;
                            if zone == 1;
                                liStrokeSecRef = liStrokeSecStroke;
                                liIniRef = liIniStroke;
                                liEndRef = liEndStroke;
                                if BOAll(lap,3) < DistIniStroke+10;
                                    DistIniRef = DistIniStroke+10;
                                else;
                                    DistIniRef = BOAll(lap,3); 
                                end;
                                DistEndRef = DistEndStroke;
                            elseif zone == 5;
                                liStrokeSecRef = liStrokeSec;
                                liIniRef = liIni;
                                liEndRef = liEnd;
                                DistIniRef = DistIni;
                                
                                StrLap = Stroke_Frame(lap, :);
                                index = find(StrLap ~= 0);
                                StrLapLast = StrLap(index(end));
                                DistEndStroke = DistanceEC(StrLapLast);
                            else;
                                liStrokeSecRef = liStrokeSec;
                                liIniRef = liIni;
                                liEndRef = liEnd;
                                DistIniRef = DistIni;
                                DistEndRef = DistEnd;
                                
                            end;
                        else;
                            liStrokeSecRef = liStrokeSec;
                            liIniRef = liIni;
                            liEndRef = liEnd;

                            if zone == 1;
                                DistIniRef = BOAll(lap,3);
                                DistEndRef = DistEnd;
                            elseif zone == 5;
                                liStrokeSecRef = liStrokeSec;
                                liIniRef = liIni;
                                liEndRef = liEnd;
                                DistIniRef = DistIni;
                                
                                StrLap = Stroke_Frame(lap, :);
                                index = find(StrLap ~= 0);
                                StrLapLast = StrLap(index(end));
                                DistEndStroke = DistanceEC(StrLapLast);
                            else;
                                DistIniRef = DistIni;
                                DistEndRef = DistEnd;
                            end;
                        end;
                                
                        if isempty(liStrokeSecRef) == 0;

                            if strcmpi(StrokeType, 'Breaststroke') | strcmpi(StrokeType, 'Butterfly');
                                if length(liStrokeSecRef) < 1;
                                    SectionSRbis(lap,pos(zone)) = NaN;
                                    SectionSDbis(lap,pos(zone)) = NaN;
                                    SectionNbbis(lap,pos(zone)) = NaN;

                                elseif length(liStrokeSecRef) >= 1 & length(liStrokeSecRef) < 2;
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;
                                    if zone == 1;
                                        IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                                    elseif zone == 5;
                                        IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                                    else;
                                        IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                                    end;
                                    li = find(IDstroke > 1);
                                    IDstroke = IDstroke(li);
                                    
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));
                                    StrDuration = (StTime2 - StTime1)./FrameRate;
                                    SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                    
                                    %position at the beginning and end
                                    VelEC = SectionVelbis(lap,pos(zone));
                                    
                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);
                                    
                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD + 1;
                                            SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        SegTime1 = TimeEC(liIniRef);
                                    end;
                                    SegTime2 = TimeEC(liEndRef);
                                    
                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                                    
                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            StDist2 = DistEndRef + PosTime2;
                                        elseif zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    else;
                                        if zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    end;
                                    
                                    SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    
                                    SectionNbbis(lap,pos(zone)) = 1;
                                    
                                else;
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;
                                    
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));
                                    StrDuration = (StTime2 - StTime1)./FrameRate;
                                    SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                    VelEC = SectionVelbis(lap,pos(zone));

                                    %position at the beginning and end
                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);
                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD + 1;
                                            SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        SegTime1 = TimeEC(liIniRef);
                                    end;
                                    SegTime2 = TimeEC(liEndRef);
                                    
                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                                    
                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            StDist2 = DistEndRef + PosTime2;
                                        elseif zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    else;
                                        if zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    end;
                                    
                                    SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                    
                                    SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                end;

                            elseif strcmpi(StrokeType, 'Medley');
                                if isempty(lilap) == 1;
                                    %BK and FS
                                    if length(liStrokeSecRef) > 2;
                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                        
                                        StTime1 = Stroke_Frame(lap, IDstroke(1));
                                        StTime2 = Stroke_Frame(lap, IDstroke(end));
                                        
                                        if IDstroke(end) + 1 < length(Stroke_Frame(lap,:));
                                            StTime3 = Stroke_Frame(lap, IDstroke(end) + 1);
                                        else;
                                            StTime3 = Stroke_Frame(lap, IDstroke(1) - 1);
                                        end;

                                        if length(liStrokeSecRef) == 2;
                                            StrDuration = abs((StTime3 - StTime1))./FrameRate;
                                            SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)).*60)./StrDuration;
                                        else;
                                            StrDuration = (StTime2 - StTime1)./FrameRate;
                                            SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                        end;
                                        SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone)) ./ 2, -1);
                                    
                                        %position at the beginning and end
                                        VelEC = SectionVelbis(lap,pos(zone));

                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);

                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD + 1;
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                        SegTime2 = TimeEC(liEndRef);

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                                StDist2 = DistEndRef + PosTime2;
                                            elseif zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        else;
                                            if zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        end;
    
                                        if length(liStrokeSecRef) == 2;
                                            StrUseful = find(Stroke_Frame(lap,:) ~= 0);
                                            StrUseful = Stroke_Frame(lap,StrUseful);
    
                                            if IDstroke(end) + 1 < length(StrUseful);
                                                StTime3 = Stroke_Frame(lap, IDstroke(end)+1);
                                                StTime3 = TimeEC(StTime3);
                                                PosTime3 = (StTime3 - SegTime2) .* VelEC;
                                                StDist3 = DistEndRef + PosTime3;
                                            else;
                                                StTime3 = Stroke_Frame(lap, IDstroke(1)-1);
                                                StTime3 = TimeEC(StTime3);
                                                PosTime3 = (SegTime1 - StTime3) .* VelEC;
                                                if lap >= 2;
                                                    if zone == 1;
                                                        StDist3 = DistIni + PosTime3;
                                                    else;
                                                        StDist3 = DistIniRef + PosTime3;
                                                    end;
                                                else;
                                                    StDist3 = DistIniRef + PosTime3;
                                                end;
                                            end;
                                            SectionSDbis(lap,pos(zone)) = roundn((abs((StDist3 - StDist1)) ./ (length(liStrokeSecRef))).*2,-2);
                                        else;
                                            SectionSDbis(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1)).*2,-2);
                                        end;
                                        SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                   
                                    else;
                                        SectionSRbis(lap,pos(zone)) = NaN;
                                        SectionSDbis(lap,pos(zone)) = NaN;
                                        SectionNbbis(lap,pos(zone)) = NaN;
                                    end;
                                else;
                                    %BF and BR
                                    if length(liStrokeSecRef) < 1;
                                        SectionSRbis(lap,pos(zone)) = NaN;
                                        SectionSDbis(lap,pos(zone)) = NaN;
                                        SectionNbbis(lap,pos(zone)) = NaN;

                                    elseif length(liStrokeSecRef) >= 1 & length(liStrokeSecRef) < 2;
                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                        if zone == 1;
                                            IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                                        elseif zone == 5;
                                            IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                                        else;
                                            IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                                        end;
                                        
                                        StTime1 = Stroke_Frame(lap, IDstroke(1));
                                        StTime2 = Stroke_Frame(lap, IDstroke(end));
                                        
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                        VelEC = SectionVel(lap,pos(zone));

                                        %position at the beginning and end
                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);
                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD + 1;
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                        SegTime2 = TimeEC(liEndRef);

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                                StDist2 = DistEndRef + PosTime2;
                                            elseif zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        else;
                                            if zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        end;
                                        SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);
                                        SectionNbbis(lap,pos(zone)) = 1;
                                        
                                    else;
                                        liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                        IDstroke = [];
                                        for stro = 1:length(liStrokeSecRef);
                                            IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                        end;
                                    
                                        StTime1 = Stroke_Frame(lap, IDstroke(1));
                                        StTime2 = Stroke_Frame(lap, IDstroke(end));
                                    
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSRbis(lap,pos(zone)) = roundn(((length(liStrokeSecRef)-1).*60)./StrDuration, -1);
                                        VelEC = SectionVelbis(lap,pos(zone));

                                        %position at the beginning and end
                                        StTime1 = TimeEC(StTime1);
                                        StTime2 = TimeEC(StTime2);
                                        if lap >= 2;
                                            if zone == 1;
                                                diffIni = abs(DistanceEC - DistIni);
                                                [~, liIniSD] = min(diffIni);
                                                liIniSD = liIniSD + 1;
                                                SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                            else;
                                                SegTime1 = TimeEC(liIniRef);
                                            end;
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                        SegTime2 = TimeEC(liEndRef);

                                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                        PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                        if lap >= 2;
                                            if zone == 1;
                                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                                StDist2 = DistEndRef + PosTime2;
                                            elseif zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        else;
                                            if zone == 5;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndStroke;
                                            else;
                                                StDist1 = DistIniRef + PosTime1;
                                                StDist2 = DistEndRef + PosTime2;
                                            end;
                                        end;

                                        SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(liStrokeSecRef)-1), -2);

                                        SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                    end;
                                end;

                            else;
                                
                                if length(liStrokeSecRef) >= 2;
                                    
                                    liStrokeSecRef = liStrokeSecRef + liIniRef - 1;
                                    IDstroke = [];
                                    for stro = 1:length(liStrokeSecRef);
                                        IDstroke = [IDstroke find(liStrokeLap == liStrokeSecRef(stro))];
                                    end;
                                    StTime1 = Stroke_Frame(lap, IDstroke(1));
                                    StTime2 = Stroke_Frame(lap, IDstroke(end));

                                    if IDstroke(end) + 1 < length(Stroke_Frame(lap,:));
                                        StTime3 = Stroke_Frame(lap, IDstroke(end) + 1);
                                    else;
                                        StTime3 = Stroke_Frame(lap, IDstroke(1) - 1);
                                    end;

                                    if length(liStrokeSecRef) == 2;
                                        StrDuration = abs((StTime3 - StTime1))./FrameRate;
                                        SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)).*60)./StrDuration;
                                    else;
                                        StrDuration = (StTime2 - StTime1)./FrameRate;
                                        SectionSRbis(lap,pos(zone)) = ((length(liStrokeSecRef)-1).*60)./StrDuration;
                                    end;
                                    SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone)) ./ 2, -1);
                                    
                                    %position at the beginning and end
                                    VelEC = SectionVelbis(lap,pos(zone));
                                    
                                    StTime1 = TimeEC(StTime1);
                                    StTime2 = TimeEC(StTime2);

                                    if lap >= 2;
                                        if zone == 1;
                                            diffIni = abs(DistanceEC - DistIni);
                                            [~, liIniSD] = min(diffIni);
                                            liIniSD = liIniSD + 1;
                                            SegTime1 = TimeEC(liIniSD); %take the 40m mark (not liIniRef) to extrapolate the position
                                        else;
                                            SegTime1 = TimeEC(liIniRef);
                                        end;
                                    else;
                                        SegTime1 = TimeEC(liIniRef);
                                    end;
                                    SegTime2 = TimeEC(liEndRef);

                                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                                    PosTime2 = (StTime2 - SegTime2) .* VelEC;

                                    if lap >= 2;
                                        if zone == 1;
                                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                            StDist2 = DistEndRef + PosTime2;
                                        elseif zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    else;
                                        if zone == 5;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndStroke;
                                        else;
                                            StDist1 = DistIniRef + PosTime1;
                                            StDist2 = DistEndRef + PosTime2;
                                        end;
                                    end;

                                    if length(liStrokeSecRef) == 2;
                                        StrUseful = find(Stroke_Frame(lap,:) ~= 0);
                                        StrUseful = Stroke_Frame(lap,StrUseful);

                                        if IDstroke(end) + 1 < length(StrUseful);
                                            StTime3 = Stroke_Frame(lap, IDstroke(end)+1);
                                            StTime3 = TimeEC(StTime3);
                                            PosTime3 = (StTime3 - SegTime2) .* VelEC;
                                            StDist3 = DistEndRef + PosTime3;
                                        else;
                                            StTime3 = Stroke_Frame(lap, IDstroke(1)-1);
                                            StTime3 = TimeEC(StTime3);
                                            PosTime3 = (SegTime1 - StTime3) .* VelEC;
                                            if lap >= 2;
                                                if zone == 1;
                                                    StDist3 = DistIni + PosTime3;
                                                else;
                                                    StDist3 = DistIniRef + PosTime3;
                                                end;
                                            else;
                                                StDist3 = DistIniRef + PosTime3;
                                            end;
                                        end;
                                        SectionSDbis(lap,pos(zone)) = abs((StDist3 - StDist1)) ./ (length(liStrokeSecRef));
                                    else;
                                        SectionSDbis(lap,pos(zone)) = (StDist2 - StDist1) ./ (length(liStrokeSecRef)-1);
                                    end;
                                    SectionSDbis(lap,pos(zone)) = roundn(SectionSDbis(lap,pos(zone)) .* 2, -2);
                                    SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                                    
                                else;
                                    SectionSRbis(lap,pos(zone)) = NaN;
                                    SectionSDbis(lap,pos(zone)) = NaN;
                                    SectionNbbis(lap,pos(zone)) = NaN;
                                end;
                            end;
                        else;
                            SectionSRbis(lap,pos(zone)) = NaN;
                            SectionSDbis(lap,pos(zone)) = NaN;
                            SectionNbbis(lap,pos(zone)) = NaN;
                        end;
                    end;     
                    DistIni = DistEnd;
                    DistIniStroke = DistEndStroke;
                    DistIni = DistEnd;
                end;
                liSplitIni = SplitsAll(lap,3) + 1;


            end;        
        else;
            %Course 25m
        end;
    end;

    SectionSRALL(:,:,i-2) = SectionSR;
    SectionSDALL(:,:,i-2) = SectionSD;
    SectionVelALL(:,:,i-2) = SectionVel;
    if isempty(SectionSRbis) == 0;
        SectionSRALLbis(:,:,i-2) = SectionSRbis;
        SectionSDALLbis(:,:,i-2) = SectionSDbis;
        SectionVelALLbis(:,:,i-2) = SectionVelbis;
    end;
    


    lineEC = 11;
    for lap = 1:NbLap;
        if isnan(SectionSR(lap,1)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,1),1);
            SDtxt = dataToStr(SectionSD(lap,1),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,1)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC) ',' num2str(i) '} = data;']);
        
        if isnan(SectionSR(lap,2)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,2),1);
            SDtxt = dataToStr(SectionSD(lap,2),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,2)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC+1) ',' num2str(i) '} = data;']);
        
        if isnan(SectionSR(lap,3)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,3),1);
            SDtxt = dataToStr(SectionSD(lap,3),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,3)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC+2) ',' num2str(i) '} = data;']);
        
        if isnan(SectionSR(lap,4)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,4),1);
            SDtxt = dataToStr(SectionSD(lap,4),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,4)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC+3) ',' num2str(i) '} = data;']);
        
        if isnan(SectionSR(lap,5)) == 1;
            data = ['  -  /  -  /  -  '];
        else;
            SRtxt = dataToStr(SectionSR(lap,5),1);
            SDtxt = dataToStr(SectionSD(lap,5),2);
            data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,5)) ' str'];
        end;
        eval(['dataTableStroke{' num2str(lineEC+4) ',' num2str(i) '} = data;']);
        
        if Course == 50;
            if isnan(SectionSR(lap,6)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,6),1);
                SDtxt = dataToStr(SectionSD(lap,6),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,6)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+5) ',' num2str(i) '} = data;']);

            if isnan(SectionSR(lap,7)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,7),1);
                SDtxt = dataToStr(SectionSD(lap,7),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,7)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+6) ',' num2str(i) '} = data;']);

            if isnan(SectionSR(lap,8)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,8),1);
                SDtxt = dataToStr(SectionSD(lap,8),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,8)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+7) ',' num2str(i) '} = data;']);

            if isnan(SectionSR(lap,9)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,9),1);
                SDtxt = dataToStr(SectionSD(lap,9),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,9)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+8) ',' num2str(i) '} = data;']);

            if isnan(SectionSR(lap,10)) == 1;
                data = ['  -  /  -  /  -  '];
            else;
                SRtxt = dataToStr(SectionSR(lap,10),1);
                SDtxt = dataToStr(SectionSD(lap,10),2);
                data = [SRtxt ' cyc/min  /  ' SDtxt ' m  /  ' num2str(SectionNb(lap,10)) ' str'];
            end;
            eval(['dataTableStroke{' num2str(lineEC+9) ',' num2str(i) '} = data;']);
        end;
        
        if Course == 50;
            lineEC = lineEC + 11;
        else;
            lineEC = lineEC + 6;
        end;
    end;
end;

handles.dataTableStroke = dataTableStroke;
handles.colorrowStroke = colorrow;

% if strcmpi(origin, 'table');
%     set(handles.StrokeData_table_analyser, 'data', dataTableStroke, 'backgroundcolor', colorrow); %'RowName', rowNameList,
%     set(handles.SkillData_table_analyser, 'Visible', 'off');
%     set(handles.PacingData_table_analyser, 'Visible', 'off');
%     set(handles.SummaryData_table_analyser, 'Visible', 'off');
%     
%     table_extent = get(handles.StrokeData_table_analyser, 'Extent');
%     table_position = get(handles.StrokeData_table_analyser, 'Position');
%     pos_cor = table_position;
%     if table_extent(4) < table_position(4);
% 
%         if Extent == 0;
%             %Add 5% to give space for the slider bar at the bottom
%             offset = 18;
%             pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)-offset;
%             pos_cor(4) = table_extent(4)+offset;
%         else;
%             pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)+1;
%             pos_cor(4) = table_extent(4)+1;
%         end;
% 
%     elseif table_extent(4) >= table_position(4);
%         if table_position(2) < (0.0069*PosFig(4));
%             pos_cor(2) = (0.0069*PosFig(4))+1;
%             pos_cor(4) = (handles.TopINI_StrokeTable*PosFig(4))+1;
% 
%             offset = 18;
%             PixelSwimmers = floor((PixelTot - 100 - 150 - offset)./nbRaces);
%             if PixelSwimmers < 200;
%                 PixelSwimmers = 200;
%                 Extent = 0;
%             else;
%                 Extent = 1;
%             end;
%             ColWidth = {100 150};
%             for i = 3:nbRaces+2;
%                 ColWidth{i} = PixelSwimmers;
%             end;
%             set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
%         else;
%             if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
%                 pos_cor(2) = (0.0069*PosFig(4))+1;
%                 pos_cor(4) = (handles.TopINI_StrokeTable*PosFig(4))+1;
% 
%                 offset = 18;
%                 PixelSwimmers = floor((PixelTot - 100 - 150 - offset)./nbRaces);
%                 if PixelSwimmers < 200;
%                     PixelSwimmers = 200;
%                     Extent = 0;
%                 else;
%                     Extent = 1;
%                 end;
%                 ColWidth = {100 150};
%                 for i = 3:nbRaces+2;
%                     ColWidth{i} = PixelSwimmers;
%                 end;
%                 set(handles.StrokeData_table_analyser, 'ColumnWidth', ColWidth);
%             else;
%                 if Extent == 0;
%                     %Add 5% to give space for the slider bar at the bottom
%                     offset = 18;
%                     pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)-offset;
%                     pos_cor(4) = table_extent(4)+offset;
%                 else;
%                     pos_cor(2) = (handles.TopINI_StrokeTable*PosFig(4))-table_extent(4)+1;
%                     pos_cor(4) = table_extent(4)+1;
%                 end;
%             end;
%         end;
%     end;
% 
%     if Extent == 1;
%         if table_extent(3) > table_position(3);
%             pos_cor(3) = table_extent(3);
%         end;
%     end;
%     set(handles.StrokeData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
%     set(handles.StrokeData_table_analyser, 'Units', 'normalized');
% 
%     PosEND = get(handles.StrokeData_table_analyser, 'Position');
%     PosEND = PosEND(3);
%     handles.diffPosStrokeTable = PosEND - handles.PosINI_StrokeTable;
% end;



