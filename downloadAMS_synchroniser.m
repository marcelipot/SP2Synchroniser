nb_waitbar = nbRaces;


%---time series (time, position, velocity)
strokeList = {'Butterfly';'Backstroke';'Breaststroke';'Freestyle';'Medley'};
distList = {'50';'100';'150';'200';'400';'800';'1500'};
courseList = {'SCM';'LCM'};
for courseIter = 1:2;
    courseEC = courseList{courseIter};
    for strokeIter = 1:5;
        strokeEC = strokeList{strokeIter};
        for distIter = 1:7;
            distEC = distList{distIter};
            eval(['dataSeries_' distEC strokeEC '_' courseEC ' = [];']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,1} = ' '''' 'Name' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,2} = ' '''' 'Meet' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,3} = ' '''' 'Year' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,4} = ' '''' 'Stage' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,5} = ' '''' 'Stroke' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,6} = ' '''' 'Distance' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,7} = ' '''' 'Type' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,8} = ' '''' 'Relay' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,9} = ' '''' 'Course' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,10} = ' '''' 'Date' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,11} = ' '''' 'Time' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,12} = ' '''' 'Skill Time' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,13} = ' '''' 'Free-Swim Time' '''' ';']);
            eval(['dataSeries_' distEC strokeEC '_' courseEC '{1,14} = ' '''' 'Splits' '''' ';']);

            eval(['iter_' distEC strokeEC '_' courseEC ' = 3;']);
        end;
    end;
end;

for i = 1:nbRaces;

    scoreN = roundn(i/nb_waitbar,-2);
    scoreT = roundn(i/nb_waitbar*100,0);
    waitbar(scoreN, hexport, {['Preparing data...  ' num2str(scoreT) '%']}, 'interpreter', 'none');
    drawnow;

    RaceUID{i} = handles.uidDB{selectfiles(i)-1, 1};
    UID = RaceUID{i};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];

    Meet = handles.uidDB{selectfiles(i)-1,8};
    Year = handles.uidDB{selectfiles(i)-1,9};
    raceEC = i;
    loadTrialsAWS;
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Stage = handles.RacesDB.' UID '.Stage;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['valRelay = handles.RacesDB.' UID '.valRelay;']);
    eval(['detailRelay = handles.RacesDB.' UID '.detailRelay;']);
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['Lane = handles.RacesDB.' UID '.Lane;']);
    eval(['RaceDate = handles.RacesDB.' UID '.RaceDate;']);

%     if strcmpi(valRelay, 'Flat(L.1)');
%         valRelay = 'Leg1';
%     elseif strcmpi(valRelay, 'Relay(L.2)');
%         valRelay = 'Leg2';
%     elseif strcmpi(valRelay, 'Relay(L.3)');
%         valRelay = 'Leg3';
%     elseif strcmpi(valRelay, 'Relay(L.4)');
%         valRelay = 'Leg4';
%     else;
%         valRelay = 'Flat';
%     end;
    
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['FrameRate = handles.RacesDB.' UID '.FrameRate;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);

    eval(['Distance = handles.RacesDB.' UID '.RawDistance;']);
    eval(['Velocity = handles.RacesDB.' UID '.RawVelocity;']);
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
    eval(['Stroke_Count = handles.RacesDB.' UID '.Stroke_Count;']);
    eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTime;']);

    %---filename
    filename = [Athletename '_' num2str(RaceDist) StrokeType '_' Stage '_' Lane '_' Meet Year '_' valRelay '_' detailRelay];

    if Course == 50;
        CourseDisp = 'LCM';
    elseif Course == 25;
        CourseDisp = 'SCM';
    end;
    eval(['dataSeriesEC = dataSeries_' num2str(RaceDist) StrokeType '_' CourseDisp ';']);
    eval(['iterEC = iter_' num2str(RaceDist) StrokeType '_' CourseDisp ';']);

    handles.filelistAdded = {filename};
    origin = '';

    if AMSExportType == 2;
        if Course == 50;
            if RaceDist >= 150;
                %25m segments
                amsExport_200partialLCM;
            else;
                amsExport_100completeLCM;
            end;
        else;
            if RaceDist >= 150

            else;
                
            end;
        end;
    else;
        if Course == 50;
            if RaceDist >= 150;
                %10/15m segments
                amsExport_200completeLCM;
            else;
                amsExport_100completeLCM;
            end;
        else;
            if RaceDist >= 150

            else;
                
            end;
        end;
    end;
    eval(['dataSeries_' num2str(RaceDist) StrokeType '_' CourseDisp ' = dataSeriesEC;']);
    eval(['iter_' num2str(RaceDist) StrokeType '_' CourseDisp ' = iterEC + 1;']);
    iterEC = [];
end;

if ispc == 1;
    if isfile(AMSExportPath) == 1;
        MDIR = getenv('USERPROFILE');
        command = ['del /Q /S ' AMSExportPath];
        [status, cmdout] = system(command);
    end;
    
    getCount = 0;
    for courseIter = 1:2;
        courseEC = courseList{courseIter};
        for strokeIter = 1:5;
            strokeEC = strokeList{strokeIter};
            for distIter = 1:7;
                distEC = distList{distIter};
                eval(['dataSeriesEC = dataSeries_' distEC strokeEC '_' courseEC ';']);
                li = length(dataSeriesEC(:,1));
                if li > 1;
                    getCount = getCount + 1;
                end;
            end;
        end;
    end;

    scoreN = roundn(1/getCount,-2);
    scoreT = roundn(1/getCount*100,0);
    waitbar(scoreN, hexport, {['Exporting data...  ' num2str(scoreT) '%']}, 'interpreter', 'none');
    drawnow;

    sheetNB = 1;
    specSheet = {};
    nameSheet = {};
    NbTurnsTot = [];
    for courseIter = 1:2;
        courseEC = courseList{courseIter};
        for strokeIter = 1:5;
            strokeEC = strokeList{strokeIter};
            for distIter = 1:7;
                distEC = distList{distIter};
                eval(['dataSeriesEC = dataSeries_' distEC strokeEC '_' courseEC ';']);
                li = length(dataSeriesEC(:,1));

                if li > 1;
                    exportstatusSheetEC = xlswrite(AMSExportPath, dataSeriesEC, sheetNB);
                    if strcmpi(courseEC, 'LCM') == 1
                        transCourse = 50;
                    else;
                        transCourse = 25;
                    end;
                    specSheet{sheetNB, 1} = distEC;
                    specSheet{sheetNB, 2} = strokeEC;
                    specSheet{sheetNB, 3} = transCourse;
                    nameSheet{sheetNB} = [distEC strokeEC '_' courseEC];
                    NbTurnsTot(sheetNB) = (str2num(distEC)./transCourse)-1;

                    scoreN = roundn(sheetNB/getCount,-2);
                    scoreT = roundn(sheetNB/getCount*100,0);
                    waitbar(scoreN, hexport, {['Exporting data...  ' num2str(scoreT) '%']}, 'interpreter', 'none');
                    drawnow;

                    sheetNB = sheetNB + 1;
                end;
            end;
        end;
    end;
    clc;
    excelRenderingAMS_synchroniser;

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

delete(hexport);


