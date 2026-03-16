nb_waitbar = nbRaces;
waitbar(0, hexport, ['Exporting data...  0%'], 'fontsize', 7);
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame=get(handle(hexport), 'javaframe');
    jicon=javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaLogoSmall.jpg']);
    jFrame.setFigureIcon(jicon);
    clc;
end;

for i = 1:nbRaces;

    UID = RaceUID{i};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    if findstr(valRelay, 'L.1');
        valRelay = 'Leg1';
    elseif findstr(valRelay, 'L.2');
        valRelay = 'Leg2';
    elseif findstr(valRelay, 'L.3');
        valRelay = 'Leg3';
    elseif findstr(valRelay, 'L.4');
        valRelay = 'Leg4';
    else;
        valRelay = 'Flat';
    end;
    
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['FrameRate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);

    eval(['Distance = handles.RacesDB.' UID '.RawDistance;']);
    eval(['Velocity = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['VelocityTrend = handles.RacesDB.' UID '.RawVelocityTrend;']);
    eval(['VelocityRaw = handles.RacesDB.' UID '.RawVelocityRaw;']);
    eval(['Time = handles.RacesDB.' UID '.RawTime;']);
    
    eval(['Stroke_SR = handles.RacesDB.' UID '.Stroke_SR;']);
    eval(['Stroke_SL = handles.RacesDB.' UID '.Stroke_Distance;']);
    eval(['Stroke_SI = handles.RacesDB.' UID '.Stroke_SI;']);
    eval(['Stroke_Velocity = handles.RacesDB.' UID '.Stroke_Velocity;']);
    eval(['Stroke_Count = handles.RacesDB.' UID '.Stroke_Count;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['Breath_Frame = handles.RacesDB.' UID '.Breath_Frames;']);
    eval(['BreathsNb = handles.RacesDB.' UID '.BreathsNb;']);
    eval(['Kick_Frame = handles.RacesDB.' UID '.Kick_Frames;']);
    eval(['KicksNb = handles.RacesDB.' UID '.KicksNb;']);
    
    %---filename
    filename = [Athletename '_' num2str(RaceDist) 'm-' StrokeType '_' Meet Year '-' Stage '_' valRelay '_Raw'];
    
    scoreN = roundn(i/nb_waitbar,-2);
    scoreT = roundn(i/nb_waitbar*100,0);
    waitbar(scoreN, hexport, {['Exporting data...  ' num2str(scoreT) '%']; filename});
    drawnow;
    
    %---time series (time, position, velocity)
    dataTimeSeries = [];
    dataTimeSeries{1,1} = 'Continuous data';
    dataTimeSeries{1,2} = '(start at Breakout - 1s)';
    dataTimeSeries{2,1} = 'Time (s)';
    dataTimeSeries{2,2} = 'Distance (m)';
    dataTimeSeries{2,3} = 'Velocity (m/s)';
    dataTimeSeries{2,4} = 'Velocity Trend (m/s)';
    dataTimeSeries{2,5} = 'Velocity Raw (m/s)';
    for raws = 1:length(Time);
        Timetxt = dataToStr(Time(raws),2);
        dataTimeSeries{raws+2,1} = Timetxt;

        if isnan(Distance(raws)) == 1;
            Distancetxt = '';
        else;
            Distancetxt = dataToStr(Distance(raws),2);
        end;
        dataTimeSeries{raws+2,2} = Distancetxt;

        if isnan(Velocity(raws)) == 1;
            Velocitytxt = '';
        else;
            Velocitytxt = dataToStr(Velocity(raws),3);
        end;
        dataTimeSeries{raws+2,3} = Velocitytxt;

        if isnan(VelocityTrend(raws)) == 1;
            VelocityTrendtxt = '';
        else;
            VelocityTrendtxt = dataToStr(VelocityTrend(raws),3);
        end;
        dataTimeSeries{raws+2,4} = VelocityTrendtxt;

        if isnan(VelocityRaw(raws)) == 1;
            VelocityRawtxt = '';
        else;
            VelocityRawtxt = dataToStr(VelocityRaw(raws),3);
        end;
        dataTimeSeries{raws+2,5} = VelocityRawtxt;
    end;

    %---Events
    dataEvent = [];
    dataEvent{1,1} = 'Strokes';
    dataEvent{2,1} = 'Lap';
    dataEvent{2,2} = 'Number';
    dataEvent{2,3} = 'Time (s)';
    dataEvent{2,4} = 'Distance (m)';
    dataEvent{2,5} = 'Rate (stroke/min)';
    dataEvent{2,6} = 'Stroke Index (m2/s/str)';
    dataEvent{2,7} = 'Velocity (m/s)';
    offset = 0;

    for lap = 1:NbLap;
        for stroke = 1:Stroke_Count(lap);
            dataEvent{stroke+2+offset,1} = num2str(lap);
            dataEvent{stroke+2+offset,2} = num2str(stroke);
            Timetxt = dataToStr(Stroke_Frame(lap,stroke)./FrameRate,2);
            dataEvent{stroke+2+offset,3} = Timetxt;
            if stroke == 1;
                Distancetxt = '';
            else;
                Distancetxt = dataToStr(Stroke_SL(lap,stroke-1),2);
            end;
            dataEvent{stroke+2+offset,4} = Distancetxt;
            if stroke == 1;
                Ratetxt = '';
            else;
                Ratetxt = dataToStr(Stroke_SR(lap,stroke-1),2);
                Ratetxt = Ratetxt(1:end-1);
            end;
            dataEvent{stroke+2+offset,5} = Ratetxt;
            if stroke == 1;
                SItxt = '';
            else;
                SItxt = dataToStr(Stroke_SI(lap,stroke-1),2);
                SItxt = SItxt(1:end-1);
            end;
            dataEvent{stroke+2+offset,6} = SItxt;            
            if stroke == 1;
                Veltxt = '';
            else;
                Veltxt = dataToStr(Stroke_Velocity(lap,stroke-1),2);
                Veltxt = Veltxt(1:end-1);
            end;
            dataEvent{stroke+2+offset,7} = Veltxt;
            
        end;
        offset = stroke;
    end;
    
    dataEvent{1,9} = 'Breaths';
    dataEvent{2,9} = 'Lap';
    dataEvent{2,10} = 'Number';
    dataEvent{2,11} = 'Time (s)';
    offset = 0;
    for lap = 1:NbLap;
        for breath = 1:BreathsNb(lap);
            dataEvent{breath+2+offset,9} = num2str(lap);
            dataEvent{breath+2+offset,10} = num2str(breath);
            Timetxt = dataToStr(Breath_Frame(lap,breath)./FrameRate,2);
            dataEvent{breath+2+offset,11} = Timetxt;
        end;
        offset = breath;
    end;
    
    dataEvent{1,13} = 'UW Kicks';
    dataEvent{2,13} = 'Lap';
    dataEvent{2,14} = 'Number';
    dataEvent{2,15} = 'Time (s)';
    offset = 0;
    for lap = 1:NbLap;
        for kick = 1:KicksNb(lap);
            dataEvent{kick+2+offset,13} = num2str(lap);
            dataEvent{kick+2+offset,14} = num2str(kick);
            Timetxt = dataToStr(Kick_Frame(lap,kick)./FrameRate,2);
            dataEvent{kick+2+offset,15} = Timetxt;
        end;
        if isempty(kick) == 0;
            offset = sum(KicksNb(1:lap));
        end;
    end;
    
    dataEvent{1,17} = 'Breakouts';
    dataEvent{2,17} = 'Lap';
    dataEvent{2,18} = 'Time Lap (s)';
    dataEvent{2,19} = 'Time Race (s)';
    dataEvent{2,20} = 'Distance (m)';
    for lap = 1:NbLap;
        dataEvent{lap+2,17} = num2str(lap);
        if lap == 1;
            BOTimetxt = dataToStr(BOAll(lap,2),2);
        else;
            BOTimetxt = dataToStr(BOAll(lap,2)-SplitsAll(lap,2),2);
        end;
        dataEvent{lap+2,18} = BOTimetxt;
        BOTimetxt = dataToStr(BOAll(lap,2),2);
        dataEvent{lap+2,19} = BOTimetxt;
        BODisttxt = dataToStr(BOAll(lap,3) - (Course.*(lap-1)),2);
        dataEvent{lap+2,20} = BODisttxt;
    end;
    
    dataEvent{1,22} = 'Splits';
    dataEvent{2,22} = 'Lap';
    dataEvent{2,23} = 'Lap Time (s)'; 
    dataEvent{2,24} = 'Cumulative Time (s)';
    for lap = 1:NbLap+1;
        if lap == 1
            dataEvent{lap+2,22} = 'Block';
        else;
            dataEvent{lap+2,22} = ['Lap ' num2str(lap)];
        end;
        if lap <= 2;
            Timetxt = dataToStr(SplitsAll(lap,2),2);
        else;
            Timetxt = dataToStr(SplitsAll(lap,2) - SplitsAll(lap-1,2),2);
        end;
        dataEvent{lap+2,23} = Timetxt;
        Timetxt = dataToStr(SplitsAll(lap,2),2);
        dataEvent{lap+2,24} = Timetxt;
    end;
    
    listdir = dir(pathname);
    proceed = 1;
    existfilesave = 0;
    iter = 1;
    
    while proceed == 1;
        for file = 1:length(listdir);
            fileEC = listdir(file).name;
            existfile = strcmpi([filename '.xlsx'], fileEC);
            if existfile == 1;
                if iter == 1;
                    filename = [filename '_copy(' num2str(iter) ')'];
                else;
                    licopy = findstr(filename, '_copy');
                    filename = [filename(1:licopy-1) '_copy(' num2str(iter) ')'];
                end;
                existfilesave = 1;
            end;
        end;
        if existfilesave == 1;
            iter = iter + 1;
            existfilesave = 0;
        else;
            proceed = 0;
        end;
    end;
    
    if ispc == 1;
        filename = [filename '.xlsx'];
        if isfile(filename) == 1;
            MDIR = getenv('USERPROFILE');
            command = ['del /Q /S ' filename];
            [status, cmdout] = system(command);
        end;
        
        exportstatusSheet1 = xlswrite([pathname '\' filename], dataEvent, 1);
        exportstatusSheet2 = xlswrite([pathname '\' filename], dataTimeSeries, 2);
        clc;
        excelRenderingRaw_synchroniser;
    elseif ismac == 1;
        filename = [filename '.xls'];
        if isfile([pathname '/' filename]) == 1;
            command = ['rm -rf ' pathname '/' filename];
            [status, cmdout] = system(command);
        end;
        
        javaaddpath('poi-3.8-20120326.jar');
        javaaddpath('poi-ooxml-3.8-20120326.jar');
        javaaddpath('poi-ooxml-schemas-3.8-20120326.jar');
        javaaddpath('xmlbeans-2.3.0.jar');
        javaaddpath('dom4j-1.6.1.jar');
        javaaddpath('stax-api-1.0.1.jar');

        xlwrite([pathname '/' filename], dataEvent, 'Event Data', 'A1');
        xlwrite([pathname '/' filename], dataTimeSeries, 'Time Series', 'A1');
        clc;
    end;
    
end;
delete(hexport);


