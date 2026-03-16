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

if strcmpi(origin, 'table') == 1;
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
    
    PosINI = get(handles.PacingData_table_analyser, 'Position');
    posCorr = PosINI;
    PosINI = PosINI(3);
    posCorr(3) = PosINI - handles.diffPosPacingTable;
    set(handles.PacingData_table_analyser, 'Position', posCorr);

    set(handles.PacingData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
        'rowstriping', 'on');
    pos = get(handles.PacingData_table_analyser, 'position');
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
    set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
%     set(handles.PacingData_table_analyser, 'Units', 'normalized');
end;

dataTablePacing = {};
dataTablePacing{1,2} = 'Metadata';
dataTablePacing{8,2} = 'Pacing';
dataTablePacing{9,1} = 'Splits / Cumul';
dataTablePacing{9,2} = ' / Speed';
dataMatSplitsPacing = [];
dataMatCumSplitsPacing = [];

for i = 3:nbRaces+2;    

    %----------------------------------Meta--------------------------------
    UID = RaceUID{i-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['dataTablePacing{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTablePacing{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTablePacing{4,' num2str(i) '} = str;']);
    eval(['dataTablePacing{5,' num2str(i) '} = handles.RacesDB.' UID '.Stage;']);
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTablePacing{6,i} = TTtxt;

    graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]};
    graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; timeSecToStr(SplitsAll(end,2))};
    storeTitle{i-2} = graphTitle;
    storeTitleBis{i-2} = graphTitleBis;

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
    storeTitle2{i-2} = graphTitle2;
    
    %---------------------------------Pacing-------------------------------
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);    
    if i == 3;
        colorrow(9,:) = [1 0.9 0.70];
        lineEC = 10;
        lineECmat = 1;
        for lap = 1:NbLap;
            dataTablePacing{lineEC,1} = ['Lap ' num2str(lap)];

            if Course == 25;
                dataTablePacing{lineEC+1,2} = '0m-5m';
                dataTablePacing{lineEC+2,2} = '5m-10m';
                dataTablePacing{lineEC+3,2} = '10m-15m';
                dataTablePacing{lineEC+4,2} = '15m-20m';
                dataTablePacing{lineEC+5,2} = ['20m-Last arm entry'];
                dataTablePacing{lineEC+6,2} = 'Last 5m';
                
                dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
                dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
                dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
                dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
                dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;

                colorrow(lineEC,:) = [1 0.9 0.60];
                colorrow(lineEC+1,:) = [0.9 0.9 0.9];
                colorrow(lineEC+2,:) = [0.75 0.75 0.75];
                colorrow(lineEC+3,:) = [0.9 0.9 0.9];
                colorrow(lineEC+4,:) = [0.75 0.75 0.75];
                colorrow(lineEC+5,:) = [0.9 0.9 0.9];
                colorrow(lineEC+6,:) = [0.75 0.75 0.75];

                lineEC = lineEC + 7;
                lineECmat = lineECmat + 5;
            else;
                dataTablePacing{lineEC+1,2} = '0m-5m';
                dataTablePacing{lineEC+2,2} = '5m-10m';
                dataTablePacing{lineEC+3,2} = '10m-15m';
                dataTablePacing{lineEC+4,2} = '15m-20m';
                dataTablePacing{lineEC+5,2} = '20m-25m';
                dataTablePacing{lineEC+6,2} = '25m-30m';
                dataTablePacing{lineEC+7,2} = '30m-35m';
                dataTablePacing{lineEC+8,2} = '35m-40m';
                dataTablePacing{lineEC+9,2} = '40m-45m';
                dataTablePacing{lineEC+10,2} = ['45m-Last arm entry'];
                dataTablePacing{lineEC+11,2} = 'Last 5m';
                
                dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
                dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
                dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
                dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
                dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;
                dataMatSplitsPacing(lineECmat+5, 1) = (Course*(lap-1)) + 30;
                dataMatSplitsPacing(lineECmat+6, 1) = (Course*(lap-1)) + 35;
                dataMatSplitsPacing(lineECmat+7, 1) = (Course*(lap-1)) + 40;
                dataMatSplitsPacing(lineECmat+8, 1) = (Course*(lap-1)) + 45;
                dataMatSplitsPacing(lineECmat+9, 1) = (Course*(lap-1)) + 50;

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
                colorrow(lineEC+11,:) = [0.9 0.9 0.9];

                lineEC = lineEC + 12;
                lineECmat = lineECmat + 10;
            end;
        end;
    end;
    if i == 3;
        dataMatCumSplitsPacing = dataMatSplitsPacing;
    end;

    %calculate values per 5m-sections
    SplitsAll = SplitsAll(2:end,:);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.RawDistance;']);
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocityINI;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
    
    for lap = 1:NbLap;
        liSplitEnd = SplitsAll(lap,3);
        liStrokeLap = Stroke_Frame(lap,:);
        liInterest = find(liStrokeLap ~= 0);
        liStrokeLap = liStrokeLap(liInterest);
        
        if Course == 25;
            nbzone = 5;
        else;
            nbzone = 10;
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
                        else;
                            %segment 50-65m after turn (from 60 to 65m)
                            DistEnd = DistIni + 5;
                        end;
                    elseif zone == 5;
                        DistEnd = DistIni + 5;
                    else;
                        DistEnd = DistIni + 10;
                    end;
                    
                    diffIni = abs(DistanceEC - DistIni);
                    [~, liIni] = min(diffIni);
                    if zone == nbzone;
                        linan = find(isnan(DistanceEC(liIni:liSplitEnd)) == 0);
                        linan = linan + liIni - 1;
                        liEnd = linan(end);
                    else;
                        diffEnd = abs(DistanceEC - DistEnd);
                        [~, liEnd] = min(diffEnd);
                    end;

                    if BOAll(lap,1) >= liEnd;
                        SectionSplitTime(lap,pos(zone)) = NaN;
                        SectionCumTime(lap,pos(zone)) = NaN;
                    else;
                        if BOAll(lap,1) > liIni;
                            liIni = BOAll(lap,1) + 1;
                        end;

                        interestDist = DistanceEC(liIni:liEnd);
                        linonnan = find(isnan(interestDist) == 0);
                        interestDist = interestDist(linonnan);
                        
                        interestTime = TimeEC(liIni:liEnd);
                        linonnan = find(isnan(interestTime) == 0);
                        interestTime = interestTime(linonnan);
                        
                        SectionVel(lap,pos(zone)) = (interestDist(end)-interestDist(1)) ./ (interestTime(end)-interestTime(1));
                        SectionSplitTime(lap,pos(zone)) = 0;
                        SectionCumTime(lap,pos(zone)) = interestTime(end);                              
                    end;     
                    DistIni = DistEnd;
                end;
                SectionVelbis = SectionVel;
                SectionSplitTimebis = SectionSplitTime;
                SectionCumTimebis = SectionCumTime;

                liSplitIni = SplitsAll(lap,3) + 1;

            else;
                
                if lap == 1;
                    DistIni = keydist + 15;
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
                pos = [5 10];
                for zone = 1:2;
                    if zone == 1;
                        if lap == 1;
                            DistEnd = DistIni + 10;
                        else;
                            DistEnd = DistIni + 15;
                        end;
                    elseif zone == 2;
                        DistEnd = DistIni + 20;
                    end;
                    
                    diffIni = abs(DistanceEC - DistIni);
                    [~, liIni] = min(diffIni);
                    if zone == nbzone;
                        linan = find(isnan(DistanceEC(liIni:liSplitEnd)) == 0);
                        linan = linan + liIni - 1;
                        liEnd = linan(end);
                    else;
                        diffEnd = abs(DistanceEC - DistEnd);
                        [~, liEnd] = min(diffEnd);
                    end;

                    if BOAll(lap,1) >= liEnd;
                        SectionSplitTime(lap,pos(zone)) = NaN;
                        SectionCumTime(lap,pos(zone)) = NaN;
                    else;
                        if BOAll(lap,1) > liIni;
                            liIni = BOAll(lap,1) + 1;
                        end;

                        interestDist = DistanceEC(liIni:liEnd);
                        linonnan = find(isnan(interestDist) == 0);
                        interestDist = interestDist(linonnan);
                        
                        interestTime = TimeEC(liIni:liEnd);
                        linonnan = find(isnan(interestTime) == 0);
                        interestTime = interestTime(linonnan);
                        
                        SectionVel(lap,pos(zone)) = (interestDist(end)-interestDist(1)) ./ (interestTime(end)-interestTime(1));
                        SectionSplitTime(lap,pos(zone)) = 0;
                        SectionCumTime(lap,pos(zone)) = interestTime(end);
                    end;
                    DistIni = DistEnd;
                end;
                liSplitIni = SplitsAll(lap,3) + 1;

                %do the same but with the 100m ranges
                if lap == 1;
                    DistIni = keydist;
                else;
                    DistIni = keydist + 10;
                end;

                pos = [3 5 7 9 10];
                for zone = 1:5;
                    if zone == 1;
                        if lap == 1;
                            %segment 0-15m after dive
                            DistEnd = DistIni + 15;
                        else;
                            %segment 50-65m after turn (from 60 to 65m)
                            DistEnd = DistIni + 5;
                        end;
                    elseif zone == 5;
                        DistEnd = DistIni + 5;
                    else;
                        DistEnd = DistIni + 10;
                    end;
                    
                    diffIni = abs(DistanceEC - DistIni);
                    [~, liIni] = min(diffIni);
                    if zone == nbzone;
                        linan = find(isnan(DistanceEC(liIni:liSplitEnd)) == 0);
                        linan = linan + liIni - 1;
                        liEnd = linan(end);
                    else;
                        diffEnd = abs(DistanceEC - DistEnd);
                        [~, liEnd] = min(diffEnd);
                    end;

                    if BOAll(lap,1) >= liEnd;
                        SectionSplitTimebis(lap,pos(zone)) = NaN;
                        SectionCumTimebis(lap,pos(zone)) = NaN;
                    else;
                        if BOAll(lap,1) > liIni;
                            liIni = BOAll(lap,1) + 1;
                        end;

                        interestDist = DistanceEC(liIni:liEnd);
                        linonnan = find(isnan(interestDist) == 0);
                        interestDist = interestDist(linonnan);
                        
                        interestTime = TimeEC(liIni:liEnd);
                        linonnan = find(isnan(interestTime) == 0);
                        interestTime = interestTime(linonnan);
                        
                        SectionVelbis(lap,pos(zone)) = (interestDist(end)-interestDist(1)) ./ (interestTime(end)-interestTime(1));
                        SectionSplitTimebis(lap,pos(zone)) = 0;
                        SectionCumTimebis(lap,pos(zone)) = interestTime(end);                              
                    end;     
                    DistIni = DistEnd;
                end;
                liSplitIni = SplitsAll(lap,3) + 1;

            end;
        else;
            
        end;
        
    end;
    SectionVel = roundn(SectionVel,-2);
    SectionCumTime = roundn(SectionCumTime,-2);
    SectionSplitTime = roundn(SectionSplitTime,-2);
    
    SectionCumTimeMat = SectionCumTime;
    SectionCumTimeMat(:,end) = SplitsAll(:,2);
    SectionSplitTimeMat = SectionSplitTime;
    SectionSplitTimeMat(:,end) = SectionCumTimeMat(:,end) - SectionCumTimeMat(:,end-1);
    
    dataMatSplitsPacing(:,i-1) = reshape(SectionSplitTimeMat', nbzone*NbLap, 1);
    dataMatCumSplitsPacing(:,i-1) = reshape(SectionCumTimeMat', nbzone*NbLap, 1);

    dataMatSplitsPacingbis = [];
    dataMatCumSplitsPacingbis = [];
    if isempty(SectionVelbis) == 0;
        SectionVelbis = roundn(SectionVelbis,-2);
        SectionCumTimebis = roundn(SectionCumTimebis,-2);
        SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
        
        SectionCumTimeMatbis = SectionCumTimebis;
        SectionCumTimeMatbis(:,end) = SplitsAll(:,2);
        SectionSplitTimeMatbis = SectionSplitTimebis;
        SectionSplitTimeMatbis(:,end) = SectionCumTimeMatbis(:,end) - SectionCumTimeMatbis(:,end-1);

        dataMatSplitsPacingbis(:,i-1) = reshape(SectionSplitTimeMatbis', nbzone*NbLap, 1);
        dataMatCumSplitsPacingbis(:,i-1) = reshape(SectionCumTimeMatbis', nbzone*NbLap, 1);
        dataMatCumSplitsPacingbis(:,1) = dataMatCumSplitsPacing(:,1);
    end;

    lineEC = 11;
    for lap = 1:NbLap;
        if (SectionVel(lap,1)) == 0;
            data = ['  -  /  -  /  -  '];
            
        else;
            VELtxt = dataToStr(SectionVel(lap,1),2);
            CTtxt = timeSecToStr(SectionCumTime(lap,1));
            STtxt = timeSecToStr(SectionSplitTime(lap,1));
            data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
        end;
        eval(['dataTablePacing{' num2str(lineEC) ',' num2str(i) '} = data;']);
        
        if (SectionVel(lap,2)) == 0;
            data = ['  -  /  -  /  -  '];
        else;
            VELtxt = dataToStr(SectionVel(lap,2),2);
            CTtxt = timeSecToStr(SectionCumTime(lap,2));
            STtxt = timeSecToStr(SectionSplitTime(lap,2));
            data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
        end;
        eval(['dataTablePacing{' num2str(lineEC+1) ',' num2str(i) '} = data;']);
        
        if (SectionVel(lap,3)) == 0;
            data = ['  -  /  -  /  -  '];
        else;
            VELtxt = dataToStr(SectionVel(lap,3),2);
            CTtxt = timeSecToStr(SectionCumTime(lap,3));
            STtxt = timeSecToStr(SectionSplitTime(lap,3));
            data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
        end;
        eval(['dataTablePacing{' num2str(lineEC+2) ',' num2str(i) '} = data;']);
        
        if (SectionVel(lap,4)) == 0;
            data = ['  -  /  -  /  -  '];
        else;
            VELtxt = dataToStr(SectionVel(lap,4),2);
            CTtxt = timeSecToStr(SectionCumTime(lap,4));
            STtxt = timeSecToStr(SectionSplitTime(lap,4));
            data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
        end;
        eval(['dataTablePacing{' num2str(lineEC+3) ',' num2str(i) '} = data;']);
        
        if (SectionVel(lap,5)) == 0;
            data = ['  -  /  -  /  -  '];
        else;
            VELtxt = dataToStr(SectionVel(lap,5),2);
            CTtxt = timeSecToStr(SectionCumTime(lap,5));
            STtxt = timeSecToStr(SectionSplitTime(lap,5));
            data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
        end;
        eval(['dataTablePacing{' num2str(lineEC+4) ',' num2str(i) '} = data;']);
        
        if Course == 50;
            if (SectionVel(lap,6)) == 0;
                data = ['  -  /  -  /  -  '];
            else;
                VVELtxt = dataToStr(SectionVel(lap,6),2);
                CTtxt = timeSecToStr(SectionCumTime(lap,6));
                STtxt = timeSecToStr(SectionSplitTime(lap,6));
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
            end;
            eval(['dataTablePacing{' num2str(lineEC+5) ',' num2str(i) '} = data;']);

            if (SectionVel(lap,7)) == 0;
                data = ['  -  /  -  /  -  '];
            else;
                VELtxt = dataToStr(SectionVel(lap,7),2);
                CTtxt = timeSecToStr(SectionCumTime(lap,7));
                STtxt = timeSecToStr(SectionSplitTime(lap,7));
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
            end;
            eval(['dataTablePacing{' num2str(lineEC+6) ',' num2str(i) '} = data;']);

            if (SectionVel(lap,8)) == 0;
                data = ['  -  /  -  /  -  '];
            else;
                VELtxt = dataToStr(SectionVel(lap,8),2);
                CTtxt = timeSecToStr(SectionCumTime(lap,8));
                STtxt = timeSecToStr(SectionSplitTime(lap,8));
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
            end;
            eval(['dataTablePacing{' num2str(lineEC+7) ',' num2str(i) '} = data;']);

            if (SectionVel(lap,9)) == 0;
                data = ['  -  /  -  /  -  '];
            else;
                VELtxt = dataToStr(SectionVel(lap,9),2);
                CTtxt = timeSecToStr(SectionCumTime(lap,9));
                STtxt = timeSecToStr(SectionSplitTime(lap,9));
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
            end;
            eval(['dataTablePacing{' num2str(lineEC+8) ',' num2str(i) '} = data;']);

            if (SectionVel(lap,10)) == 0;
                data = ['  -  /  -  /  -  '];
            else;
                VELtxt = dataToStr(SectionVel(lap,10),2);
                CTtxt = timeSecToStr(SectionCumTime(lap,10));
                STtxt = timeSecToStr(SectionSplitTime(lap,10));
                data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
            end;
            eval(['dataTablePacing{' num2str(lineEC+9) ',' num2str(i) '} = data;']);
            
            eval(['data = handles.RacesDB.' UID '.Last5m;']);
            dataCheck = SplitsAll(lap,2) - (SectionCumTime(lap,9) + data);
            if dataCheck ~= 0;
                data = data+dataCheck;
            end;
            datatxt = num2str(roundn(data, -2));
            while length(datatxt) < 4;
                if length(datatxt) == 1;
                    datatxt = [datatxt '.0'];
                else;
                    datatxt = [datatxt '0'];
                end;
            end;
            data = [datatxt ' s'];
            eval(['dataTablePacing{' num2str(lineEC+10) ',' num2str(i) '} = data;']);

        else;
            
            eval(['data = handles.RacesDB.' UID '.Last5m;']);
            dataCheck = SplitsAll(lap,2) - (SectionCumTime(lap,4) + data);
            if dataCheck ~= 0;
                data = data+dataCheck;
            end;
            datatxt = num2str(roundn(data, -2));
            while length(datatxt) < 4;
                if length(datatxt) == 1;
                    datatxt = [datatxt '.0'];
                else;
                    datatxt = [datatxt '0'];
                end;
            end;
            data = [datatxt ' s'];
            eval(['dataTablePacing{' num2str(lineEC+5) ',' num2str(i) '} = data;']);
        end;
        
        if Course == 50;
            lineEC = lineEC + 12;
        else;
            lineEC = lineEC + 7;
        end;
    end;

    eval(['handles.SplitsAllR' num2str(i-2) ' = SplitsAll;']);
    eval(['handles.BOAllR' num2str(i-2) ' = BOAll;']);
end;

% if strcmpi(origin, 'table') == 1;
%     handles.dataTablePacing = dataTablePacing;
%     handles.colorrowPacing = colorrow;
% 
%     set(handles.StrokeData_table_analyser, 'Visible', 'off');
%     set(handles.SkillData_table_analyser, 'Visible', 'off');
%     set(handles.PacingData_table_analyser, 'data', dataTablePacing, 'backgroundcolor', colorrow);
%     set(handles.SummaryData_table_analyser, 'Visible', 'off');
%     
%     table_extent = get(handles.PacingData_table_analyser, 'Extent');
%     table_position = get(handles.PacingData_table_analyser, 'Position');
%     pos_cor = table_position;
%     if table_extent(4) < table_position(4);
%         
%         if Extent == 0;
%             %Add 5% to give space for the slider bar at the bottom
%             offset = 18;
%             pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)-offset;
%             pos_cor(4) = table_extent(4)+offset;
%         else;
%             pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)+1;
%             pos_cor(4) = table_extent(4)+1;
%         end;
%         
%     elseif table_extent(4) >= table_position(4);
%         if table_position(2) < (0.0069*PosFig(4));
%             pos_cor(2) = (0.0069*PosFig(4))+1;
%             pos_cor(4) = (handles.TopINI_PacingTable*PosFig(4))+1;
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
%             set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
%         else;
%             if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
%                 pos_cor(2) = (0.0069*PosFig(4))+1;
%                 pos_cor(4) = (handles.TopINI_PacingTable*PosFig(4))+1;
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
%                 set(handles.PacingData_table_analyser, 'ColumnWidth', ColWidth);
%             else;
%                 if Extent == 0;
%                     %Add 5% to give space for the slider bar at the bottom
%                     offset = 18;
%                     pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)-offset;
%                     pos_cor(4) = table_extent(4)+offset;
%                 else;
%                     pos_cor(2) = (handles.TopINI_PacingTable*PosFig(4))-table_extent(4)+1;
%                     pos_cor(4) = table_extent(4)+1;
%                 end;
%             end;
%         end;
%     end;
%     
%     if Extent == 1;
%         if table_extent(3) > table_position(3);
%             pos_cor(3) = table_extent(3)+1;
%         end;
%     end;
%     set(handles.PacingData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
%     set(handles.PacingData_table_analyser, 'Units', 'normalized');
%     
%     PosEND = get(handles.PacingData_table_analyser, 'Position');
%     PosEND = PosEND(3);
%     handles.diffPosPacingTable = PosEND - handles.PosINI_PacingTable;
% end;

