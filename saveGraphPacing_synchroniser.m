NbLapTOT = [];
for race = 1:nbRaces;
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    NbLapTOT = [NbLapTOT NbLap];
end;
NbLapTOT = sum(NbLapTOT) + nbRaces;
lapTOTEC = 1;

MaxLeft = 0;
MinLeft = 1000000;
MaxRight = 0;
MinRight = 1000000;

FigPos = [50 50 1280 720];
Fig = figure('position', FigPos, 'units', 'pixels', 'color', [0 0 0], 'Visible', 'off', ...
    'MenuBar', 'none', 'NumberTitle', 'off');
set(Fig, 'Name', 'FullScreen Display: Velocity graph');
offsetLeftXTitle = 70./FigPos(3);
offsetBottomXTitle = 5./FigPos(4);
widthXTitle = 1130./FigPos(3);
heightXTitle = 20./FigPos(4);
offsetLeftColBar = 70./FigPos(3);
widthColBar = 1130./FigPos(3);
    
if nbRaces == 1;
    GraphPosA1 = [70./FigPos(3), 50./FigPos(4), 1130./FigPos(3), 565./FigPos(4)];
    axesgraphA1 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosA1, 'Visible', 'off');
    
elseif nbRaces == 2;
    GraphPosB1 = [70./FigPos(3), 356./FigPos(4), 1130./FigPos(3), 250./FigPos(4)];
    axesgraphB1 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosB1, 'Visible', 'off');
    GraphPosB2 = [70./FigPos(3), 50./FigPos(4), 1130./FigPos(3), 250./FigPos(4)];
    axesgraphB2 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosB2, 'Visible', 'off');
    
elseif nbRaces == 3;
    GraphPosC1 = [70./FigPos(3), 460./FigPos(4), 1130./FigPos(3), 170./FigPos(4)];
    axesgraphC1 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosC1, 'Visible', 'off');
    GraphPosC2 = [70./FigPos(3), 255./FigPos(4), 1130./FigPos(3), 170./FigPos(4)];
    axesgraphC2 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosC2, 'Visible', 'off');
    GraphPosC3 = [70./FigPos(3), 40./FigPos(4), 1130./FigPos(3), 170./FigPos(4)];
    axesgraphC3 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosC3, 'Visible', 'off');
    
elseif nbRaces == 4;
    GraphPosD1 = [65./FigPos(3), 502./FigPos(4), 1140./FigPos(3), 120./FigPos(4)];
    axesgraphD1 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosD1, 'Visible', 'off');
    GraphPosD2 = [65./FigPos(3), 348./FigPos(4), 1140./FigPos(3), 120./FigPos(4)];
    axesgraphD2 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosD2, 'Visible', 'off');
    GraphPosD3 = [65./FigPos(3), 194./FigPos(4), 1140./FigPos(3), 120./FigPos(4)];
    axesgraphD3 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosD3, 'Visible', 'off');
    GraphPosD4 = [65./FigPos(3), 40./FigPos(4), 1140./FigPos(3), 120./FigPos(4)];
    axesgraphD4 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosD4, 'Visible', 'off');

elseif nbRaces == 5;
    GraphPosE1 = [60./FigPos(3), 543./FigPos(4), 1150./FigPos(3), 102./FigPos(4)];
    axesgraphE1 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosE1, 'Visible', 'off');
    GraphPosE2 = [60./FigPos(3), 416./FigPos(4), 1150./FigPos(3), 102./FigPos(4)];
    axesgraphE2 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosE2, 'Visible', 'off');
    GraphPosE3 = [60./FigPos(3), 289./FigPos(4), 1150./FigPos(3), 102./FigPos(3)];
    axesgraphE3 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosE3, 'Visible', 'off');
    GraphPosE4 = [60./FigPos(3), 162./FigPos(4), 1150./FigPos(3), 102./FigPos(4)];
    axesgraphE4 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosE4, 'Visible', 'off');
    GraphPosE5 = [60./FigPos(3), 35./FigPos(4), 1150./FigPos(3), 102./FigPos(4)];
    axesgraphE5 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosE5, 'Visible', 'off');

elseif nbRaces == 6;
    GraphPosF1 = [60./FigPos(3), 575./FigPos(4), 1150./FigPos(3), 87./FigPos(4)];
    axesgraphF1 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosF1, 'Visible', 'off');
    GraphPosF2 = [60./FigPos(3), 467./FigPos(4), 1150./FigPos(3), 87./FigPos(4)];
    axesgraphF2 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosF2, 'Visible', 'off');
    GraphPosF3 = [60./FigPos(3), 359./FigPos(4), 1150./FigPos(3), 87./FigPos(4)];
    axesgraphF3 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosF3, 'Visible', 'off');
    GraphPosF4 = [60./FigPos(3), 251./FigPos(4), 1150./FigPos(3), 87./FigPos(4)];
    axesgraphF4 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosF4, 'Visible', 'off');
    GraphPosF5 = [60./FigPos(3), 143./FigPos(4), 1150./FigPos(3), 87./FigPos(4)];
    axesgraphF5 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosF5, 'Visible', 'off');
    GraphPosF6 = [60./FigPos(3), 35./FigPos(4), 1150./FigPos(3), 87./FigPos(4)];
    axesgraphF6 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosF6, 'Visible', 'off');
    
elseif nbRaces == 7;
    GraphPosG1 = [55./FigPos(3), 581./FigPos(4), 1160./FigPos(3), 66./FigPos(4)];
    axesgraphG1 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosG1, 'Visible', 'off');
    GraphPosG2 = [55./FigPos(3), 490./FigPos(4), 1160./FigPos(3), 66./FigPos(4)];
    axesgraphG2 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosG2, 'Visible', 'off');
    GraphPosG3 = [55./FigPos(3), 399./FigPos(4), 1160./FigPos(3), 66./FigPos(4)];
    axesgraphG3 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosG3, 'Visible', 'off');
    GraphPosG4 = [55./FigPos(3), 308./FigPos(4), 1160./FigPos(3), 66./FigPos(4)];
    axesgraphG4 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosG4, 'Visible', 'off');
    GraphPosG5 = [55./FigPos(3), 217./FigPos(4), 1160./FigPos(3), 66./FigPos(4)];
    axesgraphG5 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosG5, 'Visible', 'off');
    GraphPosG6 = [55./FigPos(3), 126./FigPos(4), 1160./FigPos(3), 66./FigPos(4)];
    axesgraphG6 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosG6, 'Visible', 'off');
    GraphPosG7 = [55./FigPos(3), 35./FigPos(4), 1160./FigPos(3), 66./FigPos(4)];
    axesgraphG7 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosG7, 'Visible', 'off');
    
elseif nbRaces == 8;
    GraphPosH1 = [55./FigPos(3), 595./FigPos(4), 1160./FigPos(3), 58./FigPos(4)];
    axesgraphH1 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosH1, 'Visible', 'off');
    GraphPosH2 = [55./FigPos(3), 515./FigPos(4), 1160./FigPos(3), 58./FigPos(4)];
    axesgraphH2 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosH2, 'Visible', 'off');
    GraphPosH3 = [55./FigPos(3), 435./FigPos(4), 1160./FigPos(3), 58./FigPos(4)];
    axesgraphH3 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosH3, 'Visible', 'off');
    GraphPosH4 = [55./FigPos(3), 355./FigPos(4), 1160./FigPos(3), 58./FigPos(4)];
    axesgraphH4 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosH4, 'Visible', 'off');
    GraphPosH5 = [55./FigPos(3), 275./FigPos(4), 1160./FigPos(3), 58./FigPos(4)];
    axesgraphH5 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosH5, 'Visible', 'off');
    GraphPosH6 = [55./FigPos(3), 195./FigPos(4), 1160./FigPos(3), 58./FigPos(4)];
    axesgraphH6 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosH6, 'Visible', 'off');
    GraphPosH7 = [55./FigPos(3), 115./FigPos(4), 1160./FigPos(3), 58./FigPos(4)];
    axesgraphH7 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosH7, 'Visible', 'off');
    GraphPosH8 = [55./FigPos(3), 35./FigPos(4), 1160./FigPos(3), 58./FigPos(4)];
    axesgraphH8 = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPosH8, 'Visible', 'off');
    
end;

for race = 1:nbRaces;
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['graph1Pacing_maxYLeft = handles.RacesDB.' UID '.graph1Pacing_maxYLeft;']);
    eval(['graph1Pacing_minYLeft = handles.RacesDB.' UID '.graph1Pacing_minYLeft;']);
    eval(['graph1Pacing_maxYRight = handles.RacesDB.' UID '.graph1Pacing_maxYRight;']);
    eval(['graph1Pacing_minYRight = handles.RacesDB.' UID '.graph1Pacing_minYRight;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    
    if MaxLeft < graph1Pacing_maxYLeft;
        MaxLeft = graph1Pacing_maxYLeft;
    end;
    if MinLeft > graph1Pacing_minYLeft;
        MinLeft = graph1Pacing_minYLeft;
    end;
    if MaxRight < graph1Pacing_maxYRight;
        MaxRight = graph1Pacing_maxYRight;
    end;
    if MinRight > graph1Pacing_minYRight;
        MinRight = graph1Pacing_minYRight;
    end;
    
    if nbRaces == 1;
        offsetbottom = GraphPosA1(2);
        TopPointY = GraphPosA1(4);
        
        offsetleftA = 5./FigPos(3);
        widthA = 20./FigPos(3);
        offsetleftB = 1225./FigPos(3);
        widthB = 20./FigPos(3);
        
        offsetBottomColBar = 690./FigPos(4);
        heightColBar = 20./FigPos(4);
        fontsizecolbar = 12;
        fontsizesplits = 12;
        
        graphEC = axesgraphA1;
        if RaceDist == 800;
            yfontsize = 10;
        elseif RaceDist == 1500;
            yfontsize = 8;
        else;
            yfontsize = 12;
        end;
        
    elseif nbRaces == 2;

        if race == 1;
            offsetbottom = GraphPosB2(2);

            offsetleftA = 5./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1225./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (GraphPosB1(2)+GraphPosB1(4));
        end;
        
        offsetBottomColBar = 690./FigPos(4);
        heightColBar = 20./FigPos(4);
        fontsizecolbar = 12;
        fontsizesplits = 12;
        
        eval(['graphEC = axesgraphB' num2str(race) ';']);
        if RaceDist == 1500;
            yfontsize = 8;
        else;
            yfontsize = 10;
        end;
        
    elseif nbRaces == 3;
        if race == 1;
            offsetbottom = GraphPosC3(2);
            
            offsetleftA = 5./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1225./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (GraphPosC1(2)+GraphPosC1(4));
        end;
        
        offsetBottomColBar = 690./FigPos(4);
        heightColBar = 18./FigPos(4);
        fontsizecolbar = 11;
        fontsizesplits = 10;
        
        eval(['graphEC = axesgraphC' num2str(race) ';']);
        yfontsize = 8;
        
    elseif nbRaces == 4;
        if race == 1;
            offsetbottom = GraphPosD4(2);
            
            offsetleftA = 5./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1225./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (GraphPosD1(2)+GraphPosD1(4));
        end;
        
        offsetBottomColBar = 690./FigPos(4);
        heightColBar = 15./FigPos(4);
        fontsizecolbar = 11;
        fontsizesplits = 9;
        
        eval(['graphEC = axesgraphD' num2str(race) ';']);
        yfontsize = 7;
        
    elseif nbRaces == 5;
        if race == 1;
            offsetbottom = GraphPosE5(2);
            
            offsetleftA = 5./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1225./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (GraphPosE1(2)+GraphPosE1(4));
        end;
        
        offsetBottomColBar = 690./FigPos(4);
        heightColBar = 12./FigPos(4);
        fontsizecolbar = 10;
        fontsizesplits = 9;
        
        eval(['graphEC = axesgraphE' num2str(race) ';']);
        yfontsize = 6;
        
    elseif nbRaces == 6;
        if race == 1;
            offsetbottom = GraphPosF6(2);
            
            offsetleftA = 5./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1225./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (GraphPosF1(2)+GraphPosF1(4));
        end;
        
        offsetBottomColBar = 705./FigPos(4);
        heightColBar = 10./FigPos(4);
        fontsizecolbar = 9;
        fontsizesplits = 9;
        
        eval(['graphEC = axesgraphF' num2str(race) ';']);
        yfontsize = 6;
        
    elseif nbRaces == 7;
        if race == 1;
            offsetbottom = GraphPosG7(2)./FigPos(4);
            
            offsetleftA = 5./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1225./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (GraphPosG1(2)+GraphPosG1(4));
        end;
        
        offsetBottomColBar = 705./FigPos(4);
        heightColBar = 10./FigPos(4);
        fontsizecolbar = 9;
        fontsizesplits = 9;
        
        eval(['graphEC = axesgraphG' num2str(race) ';']);
        yfontsize = 6;
        
    elseif nbRaces == 8;
        if race == 1;
            offsetbottom = GraphPosH8(2)./FigPos(4);
            
            offsetleftA = 5./FigPos(3);
            widthA = 20./FigPos(3);
            offsetleftB = 1225./FigPos(3);
            widthB = 20./FigPos(3);
        
        elseif race == nbRaces;
            TopPointY = (GraphPosH1(2)+GraphPosH1(4));
        end;
        
        offsetBottomColBar = 705./FigPos(4);
        heightColBar = 10./FigPos(4);
        fontsizecolbar = 9;
        fontsizesplits = 9;
        
        toolbar = axtoolbar(graphEC, 'default');
        toolbar.Visible = 'on';

        eval(['graphEC = axesgraphH' num2str(race) ';']);
        yfontsize = 6;
        
    end;
        
end;
graph1Pacing_maxYLeft = MaxLeft;
graph1Pacing_minYLeft = MinLeft;
graph1Pacing_maxYRight = MaxRight;
graph1Pacing_minYRight = MinRight;

RangeLeft = graph1Pacing_maxYLeft - graph1Pacing_minYLeft;
TickSpaceLeft = roundn((RangeLeft./5),-1);
RangeRight = graph1Pacing_maxYRight - graph1Pacing_minYRight;
TickSpaceRight = roundn((RangeRight./5),0);


% waitbar(0.02, hwait, ['Rendering... 2%']);
for race = 1:nbRaces;
    
    if nbRaces == 1;
        graphEC = axesgraphA1;
    elseif nbRaces == 2;
        eval(['graphEC = axesgraphB' num2str(race) ';']);
    elseif nbRaces == 3;
        eval(['graphEC = axesgraphC' num2str(race) ';']);
    elseif nbRaces == 4;
        eval(['graphEC = axesgraphD' num2str(race) ';']);
    elseif nbRaces == 5;
        eval(['graphEC = axesgraphE' num2str(race) ';']);
    elseif nbRaces == 6;
        eval(['graphEC = axesgraphF' num2str(race) ';']);
    elseif nbRaces == 7;
        eval(['graphEC = axesgraphG' num2str(race) ';']);
    elseif nbRaces == 8;
        eval(['graphEC = axesgraphH' num2str(race) ';']);
    end;
    
    UID = RaceUID{race};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['Gender = handles.RacesDB.' UID '.Gender;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);

    eval(['Velocity = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['Distance = handles.RacesDB.' UID '.RawDistance;']);
    eval(['Time = handles.RacesDB.' UID '.RawTime;']);
    eval(['Stroke_Distance = handles.RacesDB.' UID '.Stroke_Distance;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['Stroke_SR = handles.RacesDB.' UID '.Stroke_SR;']);
    eval(['Breath_Frame = handles.RacesDB.' UID '.Breath_Frames;']);
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['FrameRate = handles.RacesDB.' UID '.FrameRate;']);

    %----------------------------Pacing graph----------------------
    %----Velocity bars / SR (left yaxis)
    if strcmpi(Gender, 'MALE');
        if max(Velocity) > 3.6;
            ran = max(Velocity);
            min_val = 0;
            max_val = max(Velocity);
            w = warndlg('Velocity out of scale', 'Warning');
            waitfor(w);
        else;
            ran = 3.6;
            min_val = 0;
            max_val = 3.6;
        end;
    else;
        if max(Velocity) > 2.8;
            ran = max(Velocity);
            min_val = 0;
            max_val = max(Velocity);
            w = warndlg('Velocity out of scale', 'Warning');
            waitfor(w);
        else;
            ran = 2.8;
            min_val = 0;
            max_val = 2.8;
        end;
    end;
    colorVel = floor(((Velocity-min_val)/ran)*63)+1; 
    col = zeros(numel(Velocity),3);

    graph1_gtit = title(graphEC, [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage], ...
        'color', [1 1 1], 'Visible', 'on');
    colorrange = 'parula';
    colorvalue = colormap(colorrange);
            
    yyaxis(graphEC, 'left');
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
        jump = 1;
        linesize = 1;
        linesizeRed = 2;
    elseif RaceDist == 100;
        jump = 1;
        linesize = 1;
        linesizeRed = 2;
    elseif RaceDist == 200;
        if FrameRate == 25;
            jump = 2;
            linesize = 1;
            linesizeRed = 2;
        else;
            jump = 5;
            linesize = 1;
            linesizeRed = 2;
        end;
    elseif RaceDist == 400
        if FrameRate == 25;
            jump = 3;
            linesize = 1;
            linesizeRed = 2;
        else;
            jump = 5;
            linesize = 1;
            linesizeRed = 2;
        end;
    elseif RaceDist == 800;
        if FrameRate == 25;
            jump = 5;
            linesize = 1;
            linesizeRed = 2;
        else;
            jump = 10;
            linesize = 1;
            linesizeRed = 2;
        end;
    elseif RaceDist == 1500;
        if FrameRate == 25;
            jump = 5;
            linesize = 1;
            linesizeRed = 2;
        else;
            jump = 10;
            linesize = 1;
            linesizeRed = 2;
        end;
    end;
    for i = 1:jump:numel(Velocity);
        iter = 1;
        if jump == 1;
            Distance_EC = Stroke_Distancelap(StrokeEC);
            if isnan(Velocity(i)) ~= 1;  
                colraw = colorVel(i);
                graph1_lineMain(i) = line([i i], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colraw,:), 'parent', graphEC, 'visible', 'on');
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
            if i+jump-1 > numel(Velocity);
                maxi = numel(Velocity);
            else;
                maxi = i+jump-1;
            end;
            colraw = colorVel(i:maxi);
            linan = find(isnan(colraw) ~= 1);
            if length(linan) >= (0.8.*jump);
                colraw = roundn(mean(colraw(linan)), 0);
                graph1_lineMain(iter) = line([i maxi], [0 Distance_EC], 'linewidth', linesize, 'Color', colorvalue(colraw,:), 'parent', graphEC, 'visible', 'on');
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

    tickSpeed = [0:0.2:3.6];
    tickColor = (tickSpeed-min_val)/ran;
    tickSpeedTXT = [];
    for i = 1:length(tickSpeed);
        tickSpeedTXT{i} = num2str(tickSpeed(i));
    end;
    
    if RaceDist < 200;
        for lap = 1:NbLap;
            if lap == 1;
                xtickDistance = [0 15 25 35 45];
            else;
                lapdist = Course.*(lap-1);
                xtickDistance = [xtickDistance lapdist lapdist+10 lapdist+15 lapdist+25 lapdist+35 lapdist+45];
            end;
        end;
        xtickDistance = [xtickDistance RaceDist];
    else;
        xtickDistance = [0:25:RaceDist];
    end;
    xtickDistanceConvert = [];
    xticklabelDistance = [];
    
    lap = 1;
    for kdist = 1:length(xtickDistance);
        if kdist == 1;
            xtickDistanceConvert = 0;
            xticklabelDistance{kdist} = '0';
        else;
            if xtickDistance(kdist) == (lap*Course);
                xtickDistanceConvert = [xtickDistanceConvert SplitsAll(lap+1,3)];
                xticklabelDistance{kdist} = num2str(SplitsAll(lap+1,1));
                lap = lap + 1;
            else;
                [~,minloc] = min(abs(Distance-xtickDistance(kdist)));
                xtickDistanceConvert = [xtickDistanceConvert minloc(1)];
                xticklabelDistance{kdist} = num2str(xtickDistance(kdist));
            end;
        end;
    end;
    
    if RaceDist < 200;
        for lap = 1:NbLap;
            if lap == 1;
                xtickDistance = [0 15 25 35 45];
            else;
                lapdist = Course.*(lap-1);
                xtickDistance = [xtickDistance lapdist lapdist+10 lapdist+15 lapdist+25 lapdist+35 lapdist+45];
            end;
        end;
        xtickDistance = [xtickDistance RaceDist];
    else;
        xtickDistance = [0:25:RaceDist];
    end;
    
    %Xaxis
    keyDist = [0:Course:RaceDist];
    xticklabelTime = [];
    for Dist = 1:length(xtickDistance);
        DistEC = xtickDistance(Dist);
        if DistEC == 0;
            xticklabelTime{1} = '0';
        else;
            likey = find(keyDist == DistEC);
            if isempty(likey) == 1;
                [~, locmin] = min(abs(Distance - DistEC));
                timeTXT = timeSecToStr(Time(locmin(1)));
                if strcmpi(timeTXT(end), 's') == 1;
                    timeTXT = timeTXT(1:end-2);
                end;
                xticklabelTime{Dist} = timeTXT;
            else;
                liSplit = find(SplitsAll(:,1) == DistEC);
                timeTXT = timeSecToStr(SplitsAll(liSplit,2));
                if strcmpi(timeTXT(end), 's') == 1;
                    timeTXT = timeTXT(1:end-2);
                end;
                xticklabelTime{Dist} = timeTXT;
            end;
        end;
    end;
    
    %Distance based only
%     if get(handles.Distance_check_analyser, 'value') == 1;
        xlim(graphEC, [0 xtickDistanceConvert(end)]);
        set(graphEC, 'xtick', xtickDistanceConvert, 'xticklabel', xticklabelDistance, 'xcolor', [1 1 1], 'visible', 'on');
%     end;
%     if get(handles.Time_check_analyser, 'value') == 1;
%         xlim(graphEC, [0 xtickDistanceConvert(end)]);
%         set(graphEC, 'xtick', xtickDistanceConvert, 'xticklabel', xticklabelTime, 'xcolor', [1 1 1], 'visible', 'on');
%     end;
    
    %YLeft axis
    yyaxis(graphEC, 'left');
    
    rangeY = [0:TickSpaceLeft:graph1Pacing_maxYLeft+0.1];
    %add DPS
%     if get(handles.DPS_check_analyser, 'value') == 1;
        ylim(graphEC, [0 graph1Pacing_maxYLeft+0.1]);
%     else;
%         ylim(graphEC, [0 0.5]);
%     end;
    li = find(rangeY >= graph1Pacing_minYLeft);
    
    yleftlabel = [rangeY(li(1)):TickSpaceLeft:rangeY(li(end))];
    yleftlabeltxt = [];
    for i = 1:length(yleftlabel);
        yleftlabeltxt{i,1} = num2str(yleftlabel(i));
    end;
    set(graphEC, 'ytick', yleftlabel, 'yticklabel', yleftlabeltxt, 'ycolor', [1 1 1], 'Visible', 'on');    
    set(graphEC, 'color', [0 0 0], 'fontsize', yfontsize);
    
    
    %right axis
    yyaxis(graphEC, 'right');
    hold on;
    graph1_Breath = [];
    iter = 1;
    for lap = 1:NbLap;
        Breath_Framelap = Breath_Frame(lap,:);
        li = find(Breath_Framelap ~= 0);
        if isempty(li) == 0;
            Breath_Framelap = Breath_Frame(lap,li);
            NbBreath = length(Breath_Framelap);
            %display breath always
%             if handles.CurrentstatusBreath == 1;
                if isempty(graph1_Breath) == 0;
                    for breath = 1:NbBreath;
                        graph1_Breath(iter) = plot(Breath_Framelap(breath), 0, '^',...
                            'MarkerEdgeColor', [1 0 0], 'MarkerFaceColor', [1 0 0], 'Parent', graphEC, 'visible', 'off');
                        iter = iter + 1;
                    end;
                end;
%             end;
        end;
    end;

    maxYRightaxis = graph1Pacing_maxYRight;
    minYRightaxis = 0;
    refmax = ((maxYRightaxis-minYRightaxis)./2) + minYRightaxis;
    ylim(graphEC, [minYRightaxis maxYRightaxis]);
    
    keysplit = [];
    for i = 1:jump:numel(Velocity);
        if jump == 1;
            if isnan(Velocity(i)) == 1;
                li = find(SplitsAll(:,3) == i);
                if i == 1;
                    graph1_lineMain(i) = line([0 0], [0 maxYRightaxis], 'linewidth', linesizeRed, 'Color', [1 1 1], 'parent', graphEC, 'visible', 'on');
                else;
                    if isempty(li) == 1;
                        graph1_lineMain(i) = line([i i], [0 maxYRightaxis], 'linewidth', linesize, 'Color', [0 0 0], 'parent', graphEC, 'visible', 'on');
                    else;
                        keysplit = [keysplit i];
                        graph1_lineMain(i) = line([i i], [0 maxYRightaxis], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', graphEC, 'visible', 'on');
                    end;
                end;
            end;
        else;
            if i+jump-1 > numel(Velocity);
                maxi = numel(Velocity);
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

                if i == 1;
                    graph1_lineMain(iter) = line([0 0], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 1 1], 'parent', graphEC, 'visible', 'on');
                else;
                    if isempty(li) == 1;
                        graph1_lineMain(iter) = line([i maxi], [0 maxDistance+0.1], 'linewidth', linesize, 'Color', [0 0 0], 'parent', graphEC, 'visible', 'on');
                    else;
                        keysplit = [keysplit i];
                        graph1_lineMain(iter) = line([findsplit findsplit], [0 maxDistance+0.1], 'linewidth', linesizeRed, 'Color', [1 0 0], 'parent', graphEC, 'visible', 'on');
                    end;
                end;
                iter = iter + 1;
            end;
        end;
    end;
    graph1_lineBottom = line([0 numel(Velocity)], [0 0], 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5, 'parent', graphEC, 'visible', 'on');

    %always display splts
%     if get(handles.Splits_check_analyser, 'value') == 1;
        for lap = 2:NbLap+1;
            hold on;
            li = SplitsAll(lap,3);
            splits = timeSecToStr(roundn(SplitsAll(lap,2),-2));
            if lap ~= 2;
                splitslap = SplitsAll(lap,2) - SplitsAll(lap-1,2);
                splitslapTXT = timeSecToStr(roundn(splitslap,-2));
                if nbRaces <= 5
                    txtsplit = [splitslapTXT '  /  ' splits];
                else;
                    txtsplit = {splitslapTXT; splits};
                end;

                graph1_textPos1(lap-1) = text(li, refmax, txtsplit, 'horizontalalignment', 'center', 'verticalalignment', 'bottom', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizecolbar, 'color', [1 0 0], 'rotation', 90, 'parent', graphEC, 'visible', 'on');
            else;
                graph1_textPos1(lap-1) = text(li, refmax, splits, 'horizontalalignment', 'center', 'verticalalignment', 'bottom', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizecolbar, 'color', [1 0 0], 'rotation', 90, 'parent', graphEC, 'visible', 'on');
            end;
            line(li, [0 graph1Pacing_maxYRight+5], 'Color', [1 0 0], 'LineWidth', 4, 'parent', graphEC, 'visible', 'on');
        end;
%     end;

    %always display SR
%     if handles.CurrentstatusSR == 1;
        iter = 1;
        maxSR = 0;
        minSR = 1000000;
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
                    'color', [1 0 0], 'LineWidth', 2, 'Parent', graphEC, 'visible', 'on');
                iter = iter + 1;
            end;
            if maxSR < max(Stroke_SRlap);
                maxSR = max(Stroke_SRlap);
            end;
            if minSR > min(Stroke_SRlap);
                minSR = min(Stroke_SRlap);
            end;
        end;
%     end;
            
    rangeY = [0:TickSpaceRight:graph1Pacing_maxYRight+2];
    li = find(rangeY >= graph1Pacing_minYRight);
    yrightlabel = [rangeY(li(1)):TickSpaceRight:rangeY(li(end))];
    yrightlabeltxt = [];
    for i = 1:length(yrightlabel);
        yrightlabeltxt{i,1} = num2str(yrightlabel(i));
    end;
%     if handles.CurrentstatusSR == 1;
        set(graphEC, 'ytick', yrightlabel, 'yticklabel', yrightlabeltxt, 'ycolor', [1 1 1], 'visible', 'on');
%     else;
%         set(graphEC, 'ytick', [], 'yticklabel', [], 'ycolor', [1 1 1], 'visible', 'on');
%     end;
    set(graphEC, 'units', 'normalized');
end;

set(Fig, 'units', 'normalized');
axescolbar = axes('parent', Fig, 'Position', [offsetLeftXTitle, offsetBottomColBar, widthXTitle, 0.065], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizecolbar);
colbar = colorbar(axescolbar, 'location', 'northoutside', 'Ticks', tickColor,...
         'TickLabels',tickSpeedTXT, 'color', [1 1 1], 'visible', 'on');
colbar.Label.String = 'Velocity (m/s)';
colbar.Label.FontSize = fontsizecolbar;
colbar.Label.FontWeight = 'bold';
colbar.Label.FontName = 'Antiqua';
colbar.Limits = [0 1];
poscolbar = get(colbar,'position');
poscolbar = [offsetLeftColBar, offsetBottomColBar, widthColBar, heightColBar];
set(colbar, 'position', poscolbar);

axesXTitle = axes('parent', Fig, 'Position', [offsetLeftXTitle, offsetBottomXTitle, widthXTitle, heightXTitle], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesXTitle, [0 1]);
ylim(axesXTitle, [0 1]);

%Distance based only
% if get(handles.Distance_check_analyser, 'value') == 1;
    XTitle = text(0.5, 0.5, 'Distance (m)', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'parent', axesXTitle, 'visible', 'on');
% end;
% if get(handles.Time_check_analyser, 'value') == 1;
%     XTitle = text(0.5, 0.5, 'Time', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
%         'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'parent', axesXTitle, 'visible', 'on');
% end;
set(axesXTitle, 'units', 'Normalized');

axesYLeftTitle = axes('parent', Fig, 'Position', [offsetleftA, offsetbottom, widthA, (TopPointY-offsetbottom)], 'units', 'Normalized', ...
    'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesYLeftTitle, [0 1]);
ylim(axesYLeftTitle, [0 1]);
YLeftTitle = text(0.5, 0.5, 'DPS', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'rotation', 90, 'parent', axesYLeftTitle, 'visible', 'off');
set(axesYLeftTitle, 'units', 'Normalized');

%With DPS always
% if get(handles.DPS_check_analyser, 'value') == 1;
    set(axesYLeftTitle, 'visible', 'on');
    set(YLeftTitle, 'visible', 'on');
% end;

axesYRightTitle = axes('parent', Fig, 'Position', [offsetleftB, offsetbottom, widthB, (TopPointY-offsetbottom)], 'units', 'Normalized', ...
    'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesYRightTitle, [0 1]);
ylim(axesYRightTitle, [0 1]);
YRightTitle = text(0.5, 0.5, 'Stroke Rate', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12, 'color', [1 1 1], 'rotation', 270, 'parent', axesYRightTitle, 'visible', 'off');
set(axesYRightTitle, 'units', 'Normalized');

%With SR only
% if get(handles.SR_check_analyser, 'value') == 1;
    set(axesYRightTitle, 'visible', 'on');
    set(YRightTitle, 'visible', 'on');
% end;

if ispc == 1;
    name = [pathname '\' filenameVelocity];
    
elseif ismac == 1;
    name = [pathname '/' filenameVelocity];

end;
Fig.InvertHardcopy = 'off';
saveas(Fig, name);
clear_figures;
