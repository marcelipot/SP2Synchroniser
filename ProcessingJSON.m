function [axesgraph1, axescolbar, AllDB, competitionName, flagFR] = ProcessingJSON(handles2, source, dataEC, count, fileListAWSNew, AllDB, fileECout, axesgraph1, axescolbar);


if count == 1;
    axesgraph1 = axes('parent', gcf, 'units', 'pixels', ...
        'Position', [180, 1, 880, 668], 'Visible', 'off');
end;

if ispc == 1;
    MDIR = getenv('USERPROFILE');
end;









% %paraDB conversion
% Para2 = table2cell(Para);
% ParaDB.Names = Para2;
% for i = 1:97;
%     ParaDB.Names{i,1} = convertStringsToChars(ParaDB.Names{i,1});
%     ParaDB.Names{i,2} = convertStringsToChars(ParaDB.Names{i,2});
% end;
% 
% 
% 
% 
% load single file
% ID_key = 'AKIARMARPY3XJ6R7X7OV';
% access_key = 'Q5/GcwXUoPsJP8eiLfSG2yeKfAdPIIMl7IwHH2Ko';
% region = 'ap-southeast-2';
% 
% setenv('AWS_ACCESS_KEY_ID', ID_key);
% setenv('AWS_SECRET_ACCESS_KEY', access_key); 
% setenv('AWS_REGION', region);
% 
% AWSds = fileDatastore('s3://sparta2-prod/', ...
%     'FileExtensions', '.json',...
%     'ReadFcn', @AWSReadJson,...
%     'IncludeSubfolders', true);
% %change list with only 1 file
% jsonID = '9e7302c48e5461310f036b7c4aca4c9073064c629e20bdb737d759b81b5e2ba1_5_0.json';

%     jsonID = {'s3://sparta2-prod/sparta2-swims/2021/OlympicTrials2021/c3d79995255a20e1e1224a2bb736606f7b814888df15318498539b7f6b112bb6_5_0.json'}
%     {'s3://sparta2-prod/sparta2-swims/309a89f080c8ddc5f845626b4659d2fa34c3e45bd1335d390167292fc43cbbe8_5_0.json'   }
%     {'s3://sparta2-prod/sparta2-analyses/35149054e28c26aca0945af61a1ebd4a91680c5718a6db5bb8f278fe7eb1f4fd_5_0.json'}
%     {'s3://sparta2-prod/sparta2-swims/464fdfebac543e8e7452ea894b28d3bb0dbd7726a5deb46f6f98d5cc900a276a_4_0.json'   }
%     {'s3://sparta2-prod/sparta2-swims/69f4338e63f3ed5632bab295635983f9e5aff66209bf75a922f84e05ec4f194e_6_0.json'   }
%     {'s3://sparta2-prod/sparta2-analyses/7e154c0fda1976b5e3a7eb5ac1731176d64c2e7d22f5ed7316d59ea130034943_4_2.json'}
%     {'s3://sparta2-prod/sparta2-analyses/7e154c0fda1976b5e3a7eb5ac1731176d64c2e7d22f5ed7316d59ea130034943_4_3.json'}
    
% index = find(contains(AWSds.Files, jsonID));
% index = index(1);
% AWSds.Files = AWSds.Files{index};
% MDIR = getenv('USERPROFILE');
% load([MDIR '\SP2Viewer\SP2viewerDB.mat']);
% handles.AthletesDB = AthletesDB;
% handles.ParaDB = ParaDB;
% handles.uidDB = uidDB;
% handles.FullDB = FullDB;
% handles.PBsDB = PBsDB;
% handles.LastUpdate = LastUpdate;
% 
% AllDB.uidDB = handles.uidDB;
% AllDB.FullDB = handles.FullDB;
% AllDB.AthletesDB = handles.AthletesDB;
% AllDB.ParaDB = handles.ParaDB;
% AllDB.PBsDB = handles.PBsDB;
% 
% handles2.AllDB = AllDB;
% handles2.colorrange = parula(256);
% handles2.colorvalue = colormap(handles2.colorrange);
% handles2.source_user = 'All';
% handles2.selectfiles = 1;
% dataEC = AWSds.read;



%---------------------------------Preparation------------------------------
race = 1;
loop = 1;
txterror = {};
cla(axesgraph1,'reset');
set(axesgraph1, 'Visible', 'off');
eval(['uidDB_SP2 = AllDB.uidDB_SP2_' num2str(handles2.yearSelectionAll{count,1}) ';']);
eval(['FullDB_SP2 = AllDB.FullDB_SP2_' num2str(handles2.yearSelectionAll{count,1}) ';']);
eval(['AgeGroup_SP2 = AllDB.AgeGroup_SP2_' num2str(handles2.yearSelectionAll{count,1}) ';']);

AthletesDB = AllDB.AthletesDB;
ParaDB = AllDB.ParaDB;
PBsDB = AllDB.PBsDB;
PBsDB_SC = AllDB.PBsDB_SC;
RoundDB = AllDB.RoundDB;
MeetDB = AllDB.MeetDB;
colorrange = handles2.colorrange;
colorvalue = handles2.colorvalue;
source_user = handles2.source_user;
selectfiles = handles2.selectfiles;
%--------------------------------------------------------------------------

        

stepCheck = 1
flagFR = '0';







%--------------------------------Build Raw Data----------------------------
Annotations = dataEC.annotations;
Time = [];
Frame = [];
Distance = [];
Velocity = [];
VelocityTrend = [];
Breath = [];
Stroke = [];
Breakout = [];
Kick = [];

% startFrame = dataEC.startFrame;
for i =  1:length(Annotations);
    setEC = Annotations(i);
    Time(i) = setEC.time;
    Frame(i) = setEC.frame;
    Distance(i) = setEC.distance;
    Breath(i) = setEC.breath;
    Stroke(i) = setEC.stroke;
    Breakout(i) = setEC.breakout;
    Kick(i) = setEC.kick;
end;


% 
% 
% 
% 
% 
% 
% a = [(1:length(Stroke))' Frame' Distance' Stroke'];
% a = a(1050:1060,:)
% 
% e=e

% 
% liStroke = find(a(:,4) == 1);
% 
% b = [(1:length(liStroke))' a(liStroke,2) liStroke]
% 
% e=e
% 

% a = [(1:length(Stroke))' Frame' Distance' Stroke'];
% e=e



FrameRate = roundn(1/(Time(2)-Time(1)), 0);

if dataEC.relayLeg == 0;
    relayleg = 'Flat';
elseif dataEC.relayLeg == 1;
    relayleg = 'Relay';
elseif dataEC.relayLeg == 2;
    relayleg = 'Relay';
elseif dataEC.relayLeg == 3;
    relayleg = 'Relay';
elseif dataEC.relayLeg == 4;
    relayleg = 'Relay';
end;

if strcmpi(relayleg, 'Flat');
    if Time(1) < 0;
        Time(1) = 0;
    end;
    TimeExtra = 0:1/FrameRate:Time(1)-(1/FrameRate);
    Time = [TimeExtra Time];
    Distance = [zeros(1, length(TimeExtra)) Distance];
    Breath = [zeros(1, length(TimeExtra)) Breath];
    Stroke = [zeros(1, length(TimeExtra)) Stroke];
    Breakout = [zeros(1, length(TimeExtra)) Breakout];
    Kick = [zeros(1, length(TimeExtra)) Kick];
end;


%---check for FrameRate errors
for i = 2:length(Time);
    ValEC = Time(i);
    modulus = mod(ValEC, 1);
    if modulus ~= 0;
        if roundn(rem(modulus*100, 2),-2) == 1;
            if i ~= length(Time);
                ValBefore = Time(i-1);
                ValAfter = Time(i+1);
                if ValEC - ValBefore < (1./FrameRate);
                    ValEC = ValEC + 0.01;
                elseif ValAfter - ValEC < (1./FrameRate);
                    ValEC = ValEC - 0.01;
                else;
                    ValEC = ValEC - 0.01;
                end;
            else;
                ValEC = ValEC - 0.01;
            end;
            Time(i) = ValEC;
        end;
    end;
end;
if Time(end-1) == Time(end);
    Time(end) = Time(end-1) + (1./FrameRate);
end;

difftime = roundn(diff(Time), -2);
liDiff = find(difftime > 1./FrameRate);

if isempty(liDiff) == 0;
    proceedSub = 1;
    while proceedSub == 1;
        li = liDiff(1);
        if li == 1;
            if Time(li) < (1./FrameRate);
                TimeExtra = [0 : (1./FrameRate) : Time(li+1)-(1./FrameRate)];
                ini = 1;
            else;
                TimeExtra = [Time(li)+(1./FrameRate) : (1./FrameRate) : Time(li+1)-(1./FrameRate)];
                ini = 0;
            end;
        else;
            TimeExtra = [Time(li)+(1./FrameRate) : (1./FrameRate) : Time(li+1)-(1./FrameRate)];
            ini = 0;
        end;
        
        if isempty(TimeExtra) == 0;
            if ini == 0;
                Time = [Time(1:li) TimeExtra Time(li+1:end)];
                Distance = [Distance(1:li) zeros(1, length(TimeExtra)) Distance(li+1:end)];
                Breath = [Breath(1:li) zeros(1, length(TimeExtra)) Breath(li+1:end)];
                Stroke = [Stroke(1:li) zeros(1, length(TimeExtra)) Stroke(li+1:end)];
                Breakout = [Breakout(1:li) zeros(1, length(TimeExtra)) Breakout(li+1:end)];
                Kick = [Kick(1:li) zeros(1, length(TimeExtra)) Kick(li+1:end)];
            else;
                Time = [TimeExtra Time(li+1:end)];
                Distance = [zeros(1, length(TimeExtra)) Distance(li+1:end)];
                Breath = [zeros(1, length(TimeExtra)) Breath(li+1:end)];
                Stroke = [zeros(1, length(TimeExtra)) Stroke(li+1:end)];
                Breakout = [zeros(1, length(TimeExtra)) Breakout(li+1:end)];
                Kick = [zeros(1, length(TimeExtra)) Kick(li+1:end)];
            end;

            difftime = roundn(diff(Time), -2);  
            liDiff = find(difftime > 1./FrameRate);
        else;
            liDiff = liDiff(2:end);
        end;
        if isempty(liDiff) == 1;
            proceedSub = 0;
        end;
    end;
end;

if Distance(end) == 0;
    Distance = Distance(1:end-1);
end;

splitEC = dataEC.splits(end);
RaceTime = splitEC.time;

if (RaceTime-Time(end)) < (1/FrameRate);
    TimeExtra = Time(end)+(1/FrameRate) : 1/FrameRate : RaceTime;
    Time = [Time TimeExtra];
    Distance = [Distance zeros(1, length(TimeExtra))];
    Breath = [Breath zeros(1, length(TimeExtra))];
    Stroke = [Stroke zeros(1, length(TimeExtra))];
    Breakout = [Breakout zeros(1, length(TimeExtra))];
    Kick = [Kick zeros(1, length(TimeExtra))];
end;


if Time(1) == (1/FrameRate);
    Time = [0 Time];
    Distance = [0 Distance];
    Breath = [0 Breath];
    Stroke = [0 Stroke];
    Breakout = [0 Breakout];
    Kick = [0 Kick];
    
elseif Time(1) > 0 & Time(1) < (1/FrameRate);
    Time = 0 : 1/FrameRate : Time(end);
    Distance = [0 Distance];
    Breath = [0 Breath];
    Stroke = [0 Stroke];
    Breakout = [0 Breakout];
    Kick = [0 Kick];
end;


if dataEC.relayLeg >= 1;
%     dataEC.splits.time
    Time = Time - Time(1);
end;

Velocity = diff(Distance')./(1./FrameRate);
Velocity = [Velocity(1); Velocity];
Velocity = Velocity';
li = find(Distance == 0);
if isempty(li) == 0;
    lidiff = find(diff(li) > 1);
    liini = 1;
    if length(li) == 1;
        Distance(li) = NaN;
        Velocity(li) = NaN;
    else;
        for i = 1:length(lidiff);
            liend = li(lidiff(i));

            Distance(liini:liend) = NaN;
            if liini == 1;
                Velocity(liini:liend+1) = NaN;
            else;
                Velocity(liini-1:liend+1) = NaN;
            end;
            liini = li(lidiff(i)+1);
        end;
        liend = li(end);
        Distance(liini:liend) = NaN;
        
        if liend > length(Velocity);
            if liini == 1;
                Velocity(liini:liend) = NaN;
            else;
                Velocity(liini-1:end) = NaN;
            end;
    %     elseif liend+1 > length(Velocity);
    %         
    %         liini
    %         liend
    %         size(Velocity)
    %         length(Velocity)
    %         a=liend+1 > length(Velocity)
    %         
    %         Velocity(liini-1:liend+1) = NaN;
        else;
            if liini == 1;
                Velocity(liini:liend) = NaN;
            else;
                Velocity(liini-1:liend) = NaN;
            end;
        end;
    end;
    
end;
%--------------------------------------------------------------------------



%-----------------------------Initiate parameters--------------------------
li = find(AthletesDB.AMSID == dataEC.athleteId);
if isempty(li);
    Athletename = 'UnknownA';
    AthletenameFull = 'UnknownA';
    Firstname = 'Athlete';
    Lastname = 'Unknown';
    Gender = 'MALE';
    DOB = '01/01/2000';
    Country = 'INTER';
else;
    Firstname = AthletesDB.Names{li,1};
    Lastname = AthletesDB.Names{li,2};
    DOB = AthletesDB.DOB{li,1};
    Gender = AthletesDB.Gender(li,1);
    if Gender == 1;
        Gender = 'MALE';
    else;
        Gender = 'FEMALE';
    end;
    Country = AthletesDB.Nat{li,1};
    Athletename = [Lastname Firstname(1)];
    AthletenameFull = [Firstname ' ' Lastname];
end;


% %Age Group (based on DOB and race date)
% index = strfind(dataEC.date, '-');
% RaceDate = datetime(str2num(dataEC.date(1:index(1)-1)), str2num(dataEC.date(index(1)+1:index(2)-1)), str2num(dataEC.date(index(2)+1:end)));
% index = strfind(DOB, '/');
% DOBDate = datetime(str2num(DOB(index(2)+1:end)), str2num(DOB(index(1)+1:index(2)-1)), str2num(DOB(1:index(1)-1)));
% dateDiff(1) = DOBDate;
% dateDiff(2) = RaceDate;
% D = caldiff(dateDiff, {'years','months','days'});
% [AgeDOB(1), AgeDOB(2), AgeDOB(3)] = split(D, {'years','months','days'});
% 
% YearEve = [dataEC.date(1:4) '-12-31'];
% index = strfind(YearEve, '-');
% dateDiff(2) = datetime(str2num(YearEve(1:index(1)-1)), str2num(YearEve(index(1)+1:index(2)-1)), str2num(YearEve(index(2)+1:end)));
% D = caldiff(dateDiff, {'years','months','days'});
% [AgeYear(1), AgeYear(2), AgeYear(3)] = split(D, {'years','months','days'});
% if AgeYear(1) <= 13;
%     AgeGroupVal = '13y & under';
% elseif AgeYear(1) == 14;
%     AgeGroupVal = '14y';
% elseif AgeYear(1) == 15;
%     AgeGroupVal = '15y';
% elseif AgeYear(1) == 16;
%     AgeGroupVal = '16y';
% elseif AgeYear(1) == 17;
%     AgeGroupVal = '17y';
% elseif AgeYear(1) == 18; 
%     AgeGroupVal = '18y';
% else;
%     AgeGroupVal = 'Open';
% end;


li = find(ParaDB.AMSID == dataEC.athleteId);
if isempty(li) == 1;
    Paralympic = 'Able';
else;
    Paralympic = 'Para';
end;

% Gender = dataEC.sex;
% if strcmpi(Gender, 'MIXED') == 1;
%     
% end;
Meet = dataEC.competitionName;
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

Stage = dataEC.eventType;
li = findstr(Stage, ' ');
if isempty(li) == 0;
    liop = [];
    for k = 1:length(Stage);
        lik = find(li == k);
        if isempty(lik) == 1;
            liop = [liop k];
        end;
    end;
    Stage = Stage(liop);
end;
li = findstr(Stage, '-');
if isempty(li) == 0;
    liop = [];
    for k = 1:length(Stage);
        lik = find(li == k);
        if isempty(lik) == 1;
            liop = [liop k];
        end;
    end;
    Stage = Stage(liop);
end;
DateEntr = dataEC.enteredOn;
DateRace = dataEC.date;
Year = dataEC.date;
Year = Year(1:4);
relayType = dataEC.relayType;

StrokeType = dataEC.strokeType;
% if strcmpi(lower(StrokeType), 'para-medley') == 1;
%     StrokeType = 'Medley';
% end;
if strcmpi(relayType, 'null') == 1;
    StrokeType = dataEC.strokeType;
    valRelay = 'Flat';
    detailRelay = 'None';
elseif isempty(relayType) == 1;
    StrokeType = dataEC.strokeType;
    valRelay = 'Flat';
    detailRelay = 'None';
else;
    if strcmpi(dataEC.strokeType, 'Medley') == 1;
        if dataEC.relayLeg == 0;
            StrokeType = 'Backstroke';
        elseif dataEC.relayLeg == 1;
            StrokeType = 'Breaststroke';
        elseif dataEC.relayLeg == 2;
            StrokeType = 'Butterfly';
        elseif dataEC.relayLeg == 3;
            StrokeType = 'Freestyle';
        end;
        
        if strcmpi(dataEC.sex, 'MIXED');
            detailRelay = 'MxIM';
        elseif strcmpi(dataEC.sex, 'MALE');
            detailRelay = 'MIM';
        elseif strcmpi(dataEC.sex, 'FEMALE');
            detailRelay = 'WIM';
        end;
    else;
        if strcmpi(dataEC.sex, 'MIXED');
            detailRelay = 'MxFS';
        elseif strcmpi(dataEC.sex, 'MALE');
            detailRelay = 'MFS';
        elseif strcmpi(dataEC.sex, 'FEMALE');
            detailRelay = 'WFS';
        end;
    end;
    
    if dataEC.relayLeg == 0;
        valRelay = 'Flat(L.1)';
    elseif dataEC.relayLeg == 1;
        valRelay = 'Relay(L.2)';
    elseif dataEC.relayLeg == 2;
        valRelay = 'Relay(L.3)';
    elseif dataEC.relayLeg == 3;
        valRelay = 'Relay(L.4)';
    end;
end;

RaceDist = dataEC.distance;
RaceDist = roundn(RaceDist,0);
NbLap = length(dataEC.splits);
Course = roundn(RaceDist./NbLap,0);
Lane = ['Lane' num2str(dataEC.lane)];
FilenameNew =  [Athletename '_' num2str(RaceDist) StrokeType '_' Stage '_' Lane '_' Meet Year '_' valRelay '_' detailRelay];


% 
% FilenameNew
% e=e





% [dataEC.videoId '_' Lane(5:end) '_' num2str(dataEC.relayLeg) '.json']
% e=e

%%%%%%
li = strfind(Athletename, ' ');
if isempty(li) == 0;
    AthletenameDisp = [Athletename(1:li(1)-1) '-' Athletename(li(1)+1:end)];
else;
    AthletenameDisp = Athletename;
end;
set(handles2.txtFileName_main, 'fontunits', 'points', 'Fontsize', 12);
set(handles2.txtFileName_main, 'fontunits', 'normalized');
FilenameDisp =  ['File :  ' AthletenameDisp '_' num2str(RaceDist) StrokeType '_' Stage '_' Lane '_' Meet Year];
set(handles2.txtFileName_main, 'String', FilenameDisp);
pos_Extent = get(handles2.txtFileName_main, 'Extent');
pos_Real = get(handles2.txtFileName_main, 'Position');

if pos_Extent(3) > pos_Real(3);
    proceed = 1;
else;
    proceed = 0;
end;
fontref = 12;
iter = 1;
while proceed == 1;
    set(handles2.txtFileName_main, 'fontunits', 'points', 'Fontsize', fontref-iter);
    pos_Extent = get(handles2.txtFileName_main, 'Extent');
    pos_Real = get(handles2.txtFileName_main, 'Position');
    if pos_Extent(3) > pos_Real(3);
        iter = iter + 1;
    else;
        proceed = 0;
    end;
    
    if fontref <= 3;
        proceed = 0;
    end;
end;
set(handles2.txtFileName_main, 'fontunits', 'normalized');
% drawnow;

if strcmpi(source_user, 'Select');
    set(handles2.txtNew_main, 'String', ['Replacing selected races :   ' num2str(count) ' / ' num2str(length(fileListAWSNew(:,1)))]);
elseif strcmpi(source_user, 'Update');
    set(handles2.txtNew_main, 'String', ['Adding new races :   ' num2str(count) ' / ' num2str(length(fileListAWSNew(:,1)))]);
elseif strcmpi(source_user, 'All');
    set(handles2.txtNew_main, 'String', ['Replacing all races :   ' num2str(count) ' / ' num2str(length(fileListAWSNew(:,1)))]);
end;
drawnow;


% jsonName = [dataEC.videoId '_' Lane(5:end) '_' num2str(dataEC.relayLeg) '.json']


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if strcmpi(relayleg, 'Relay') == 1;
%     e=e;
% end;

SplitsAll = [];
if strcmpi(relayleg, 'Relay') == 1;
    for lap = 1:NbLap
        splitEC = dataEC.splits(lap);
        SplitsAll(lap,1) = splitEC.distance;
        SplitsAll(lap,2) = splitEC.time;
        diffTime = abs(Time-(splitEC.time+Time(1)));
        [~,liSplit] = min(diffTime);
        SplitsAll(lap,3) = liSplit;
    end;

    if dataEC.blockTime < 100
        RT = str2num(['0.0' num2str(dataEC.blockTime)]);
    else;
        RT = str2num(['0.' num2str(dataEC.blockTime)]);
    end;
    diffTime = abs(Time-(RT+Time(1)));
    [~,liSplit] = min(diffTime);
    SplitsAll = [[NaN RT liSplit]; SplitsAll];
else;
    for lap = 1:NbLap
        splitEC = dataEC.splits(lap);
        SplitsAll(lap,1) = splitEC.distance;
        SplitsAll(lap,2) = splitEC.time;
        diffTime = abs(Time-splitEC.time);
        [~,liSplit] = min(diffTime);
        SplitsAll(lap,3) = liSplit;
    end;
    
    if length(num2str(dataEC.blockTime)) == 3;
        RT = str2num(['0.' num2str(dataEC.blockTime)]);
    elseif length(num2str(dataEC.blockTime)) == 4;
        val = num2str(dataEC.blockTime);
        RT = str2num(['1.' val(2:end)]);
    else;
        RT = 0.65;
    end;
    diffTime = abs(Time-RT);
    [~,liSplit] = min(diffTime);
    SplitsAll = [[NaN RT liSplit]; SplitsAll];
end;
SplitsAvSpeed = [];
for lap = 1:NbLap;
    SplitsAvSpeed(lap) = SplitsAll(lap+1,1)./SplitsAll(lap+1,2);
end;

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
BOAll = [];
BOAllINI = [];
Turn_Time = [];
Turn_TimeIn = [];
Turn_TimeOut = [];
Turn_TimeINI = [];
Turn_TimeInINI = [];
Turn_TimeOutINI = [];
Turn_BODist = [];
Turn_BODistINI = [];
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
%--------------------------------------------------------------------------





stepCheck = 2






%-------------------------------Calculate Data-----------------------------
VelocityRaw = Velocity;
VelocityTrend = Velocity;
VelocityINI = Velocity;
DistanceINI = Distance;
DistanceINIBO = Distance;
VelLapAv = [];
TurnUWVelocity = [];
for lap = 1:NbLap;
    if lap == 1;
        liSplit = SplitsAll(lap+1,3);
        liSplitPrev = SplitsAll(lap+1,3);
        liStroke = find(Stroke(1:liSplit) == 1);
        if liStroke(end)+1 < liSplit;
            Distance(liStroke(end)+1:liSplit) = NaN;
            DistanceINI(liStroke(end)+1:liSplit) = NaN;
            Velocity(liStroke(end)+1:liSplit) = NaN;
            VelocityRaw(liStroke(end)+1:liSplit) = NaN;
            VelocityTrend(liStroke(end)+1:liSplit) = NaN;
            VelocityINI(liStroke(end)+1:liSplit) = NaN;
        end;

        liBO = find(Breakout(1:liSplit) == 1);
        if liBO == 0;
            liBO = 1;
        end;
        if liBO < (FrameRate./2);
            liBO1s = liBO;
        elseif liBO >= (FrameRate./2) & liBO < FrameRate;
            liBO1s = liBO - (FrameRate./2);
        else;
            liBO1s = liBO - FrameRate;
        end;
        if liBO1s < 1;
            liBO1s = liBO;
        end;
        
        if liBO1s > 1;
            Distance(1:liBO1s-1) = NaN;
            DistanceINI(1:liBO1s-1) = NaN;
            Velocity(1:liBO1s-1) = NaN;
            VelocityRaw(1:liBO1s-1) = NaN;
            VelocityTrend(1:liBO1s-1) = NaN;
            VelocityINI(1:liBO1s-1) = NaN;
        end;
        if liBO >= liStroke(1);
            txt = {FilenameDisp; ['Error lap ' num2str(lap) ': First stroke annotated before breakout']};
            warnwindow = warndlg(txt, 'Warning');
            if ispc == 1;
                jFrame = get(handle(warnwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
%                 clc;
            end;
            if isempty(txterror) == 0;
                li = length(txterror(:,1));
            else;
                li = 1;
            end;
            txterror{li,1} = txt{2,:};
%             waitfor(warnwindow);
        end;
        
        %---threshold values for velocity
        reference_velocitythreshold;

        Distance2 = Distance(liBO1s:liStroke(end));
        
        %check last 2m
        Dist2mEnd = SplitsAll(lap+1,1);
        
        diff2mEnd = abs(Distance2-(Dist2mEnd - 2));
        [minVal, minLoc] = min(diff2mEnd);
        minLocCorr = [];
        minLocCorr = minLoc + liBO1s - 1;
        DPSError = 0;
        
        liStroke2m = find(liStroke >= minLocCorr);
        if isempty(liStroke2m) == 0;
            %stroke withing the last 2m
            DPSlast = Distance(liStroke(end))-Distance(liStroke(end-1));
            if length(liStroke) > 3;
                DPSref1 = Distance(liStroke(4))-Distance(liStroke(3));
            else;
                DPSref1 = [];
            end;
            DPSref2 = Distance(liStroke(3))-Distance(liStroke(2));
            if DPSlast >= 0.35*mean([DPSref1 DPSref2]) == 1;
                %issue with DPS in the last 2m ... Calibration issue: Fish eye
                DPSError = 1;
            end;
        end;
        
        Time2 = Time(liBO1s:liStroke(end));
        Velocity2 = Velocity(liBO1s:liStroke(end));
        lioutliers = find(Velocity2 >= thresTop);
        if length(lioutliers) == 0
            Distance2int = naninterpCustom(Distance2, 'linear');
        else;
            %check if it's the beginning of the data
            Distance2(lioutliers) = NaN;
            if SplitsAvSpeed(lap) > thresBottom;
                lioutliers = find(Velocity2 <= thresBottom);
                if length(lioutliers) == 0;
                    Distance2int = naninterpCustom(Distance2, 'linear');
                else;
                    Distance2(lioutliers) = NaN;
                    Distance2int = naninterpCustom(Distance2, 'linear');
                end;
            else;
                Distance2int = naninterpCustom(Distance2, 'linear');
            end;
        end;
        Distance2int = Distance2int';
        Time2 = Time2';
        [~, ~, Velocity2Raw, ~] = spline2_SP2(Distance2int, FrameRate);

        R = 0.15; 
        Nr = FrameRate;
        N = size(Distance2int, 1);
        NR = min(round(N*R), Nr); % At most 50 points
        for i = 1:size(Distance2int,2);
            x1(:,i) = 2*Distance2int(1,i)-flipud(Distance2int(2:NR+1,i));  % maintain continuity in level and slope
            x2(:,i) = 2*Distance2int(end,i)-flipud(Distance2int(end-NR:end-1,i));
        end;
        Distance2int = [x1; Distance2int; x2];
        [Distance2filt, Velocity2filt, alis] = Butter_SP2(Time2, Distance2int, FrameRate, cutoffFreq, orderval);
        Distance2filt(1:length(x1)) = [];
        Distance2filt(N+1:end) = [];
        Velocity2filt(1:length(x1)) = [];
        Velocity2filt(N+1:end) = [];

        Distance2filt = Distance2filt';
        Velocity2filt = Velocity2filt';
        
        seg = floor(FrameRate./2);
        refneg1 = Distance2filt(1,1:seg);
        checkneg = diff(refneg1);
        lineg = find(checkneg <= 0);
        CORNEG = 0;
        if isempty(lineg) == 0;
            %negative value
            coef = polyfit(1:length(refneg1), refneg1, 1);
            refneg1COR = polyval(coef, 1:length(refneg1));
            Distance2filt(1,1:seg) = refneg1COR;
            CORNEG = 1;
        end;
        refneg2 = Distance2filt(1,(end-seg):end);
        checkneg = diff(refneg2);
        lineg = find(checkneg <= 0);
        if isempty(lineg) == 0;
            %negative value
            coef = polyfit(1:length(refneg2), refneg2, 1);
            refneg2COR = polyval(coef, 1:length(refneg2));
            Distance2filt(1,(end-seg):end) = refneg2COR;
            CORNEG = 1;
        end;
        if CORNEG == 1;
            [~,~,Velocity2filt,~] = spline2_SP2(Distance2filt', FrameRate);
            Velocity2filt = Velocity2filt';
        end;
        
        lioutliers = find(Velocity2filt >= thresTop);
        Velocity2filt(lioutliers) = NaN;
        if SplitsAvSpeed(lap) > thresBottom; 
            lioutliers = find(Velocity2filt <= thresBottom);
            Velocity2filt(lioutliers) = NaN;
        end;
        Velocity2filt = naninterpCustom(Velocity2filt, 'spline');
        
        lioutliers = find(Velocity2filt >= thresTop);
        Velocity2filt(lioutliers) = thresTop;
        if SplitsAvSpeed(lap) > thresBottom; 
            lioutliers = find(Velocity2filt <= thresBottom);
            Velocity2filt(lioutliers) = thresBottom;
        end;
        
        coef = polyfit([1:length(Velocity2filt)]', Velocity2filt', 20);
%         clc;
        partialTrend = polyval(coef, [1:length(Velocity2filt)]');
        
        Distance(liBO1s:liStroke(end)) = Distance2filt;
        Velocity(liBO1s:liStroke(end)) = Velocity2filt;
        VelocityRaw(liBO1s:liStroke(end)) = Velocity2Raw;
        VelocityTrend(liBO1s:liStroke(end)) = partialTrend;
        if liBO1s == liBO;
            VelBeforeBO(lap) = NaN;
            VelAfterBO(lap) = NaN;
            BOEff(lap) = NaN;
            BOEffCorr(lap) = NaN;
        else;
            VelBeforeBO(lap) = mean(Velocity(liBO1s+1:liBO));
            if strcmpi(StrokeType, 'Freestyle') | strcmpi(StrokeType, 'Backstroke');
                VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(2)));
            else;
                VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(1)));
            end;
            BOEff(lap) = (VelAfterBO(lap)-VelBeforeBO(lap))./VelBeforeBO(lap);
            
            if strcmpi(Gender, 'MALE');
                if strcmpi(StrokeType, 'Backstroke');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.50;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.47;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.35;
                    else;
                        UWMaxSpeed = 2.35;
                    end;
                elseif strcmpi(StrokeType, 'Breaststroke');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.45;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.33;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.23;
                    else;
                        UWMaxSpeed = 2.23;
                    end;
                elseif strcmpi(StrokeType, 'Butterfly');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.95;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.92;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.72;
                    else;
                        UWMaxSpeed = 2.72;
                    end;
                elseif strcmpi(StrokeType, 'Freestyle');
                    if RaceDist == 50;
                        UWMaxSpeed = 3.10;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 3.05;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.92;
                    elseif RaceDist == 400;
                        UWMaxSpeed = 2.90;
                    elseif RaceDist == 800;
                        UWMaxSpeed = 2.70;
                    elseif RaceDist == 1500;
                        UWMaxSpeed = 2.60;
                    else;
                        UWMaxSpeed = 2.60;
                    end;
                else;
                    if RaceDist == 150;
                        UWMaxSpeed = 1;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.65;
                    elseif RaceDist == 400;
                        UWMaxSpeed = 2.60;
                    else;
                        UWMaxSpeed = 2.60;
                    end;
                end;
            else;
                if strcmpi(StrokeType, 'Backstroke');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.25;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.20;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.12;
                    else;
                        UWMaxSpeed = 2.12;
                    end;
                elseif strcmpi(StrokeType, 'Breaststroke');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.22;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.20;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.12;
                    else;
                        UWMaxSpeed = 2.12;
                    end;
                elseif strcmpi(StrokeType, 'Butterfly');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.52;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.50;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.40;
                    else;
                        UWMaxSpeed = 2.40;
                    end;
                elseif strcmpi(StrokeType, 'Freestyle');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.82;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.75;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.66;
                    elseif RaceDist == 400;
                        UWMaxSpeed = 2.57;
                    elseif RaceDist == 800;
                        UWMaxSpeed = 2.55;
                    elseif RaceDist == 1500;
                        UWMaxSpeed = 2.55;
                    else;
                        UWMaxSpeed = 2.55;
                    end;
                else;
                    if RaceDist == 150;
                        UWMaxSpeed = 1;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.37;
                    elseif RaceDist == 400;
                        UWMaxSpeed = 2.30;
                    else;
                        UWMaxSpeed = 2.30;
                    end;
                end;
            end;
            coefUWspeed = VelBeforeBO(lap)./UWMaxSpeed;
            if coefUWspeed > 1;
                coefUWspeed = 1;
            end;
            BOEffCorr(lap) = BOEff(lap).*(coefUWspeed^3);
        end;
        VelLapAv(lap) = mean(Velocity(liStroke(2):liStroke(end)));

        diff15 = abs(Distance - 15);
        [valmin, limin] = min(diff15);
        DiveT15 = Time(limin(1));
        diff15 = abs(DistanceINI - 15);
        [valmin, limin] = min(diff15);
%         limin = find(DistanceINI > 15, 1);
        DiveT15INI = Time(limin(1));
        liBreath = find(Breath(1:liSplit) == 1);
        BreathsNb = [BreathsNb length(liBreath)];
        Breath_Frames(lap,1:length(liBreath)) = liBreath;

        liKick = find(Kick(1:liSplit) == 1);
        KicksNb = [KicksNb length(liKick)];
        Kick_Frames(lap,1:length(liKick)) = liKick;
    else;
        liSplit = SplitsAll(lap+1,3);
        liStroke = find(Stroke(liSplitPrev:liSplit) == 1);
        liStroke = liStroke + liSplitPrev - 1;
        if liStroke(end)+1 < liSplit;
            Distance(liStroke(end)+1:liSplit) = NaN;
            DistanceINI(liStroke(end)+1:liSplit) = NaN;
            Velocity(liStroke(end)+1:liSplit) = NaN;
            VelocityRaw(liStroke(end)+1:liSplit) = NaN;
            VelocityTrend(liStroke(end)+1:liSplit) = NaN;
            VelocityINI(liStroke(end)+1:liSplit) = NaN;
        end;

        liBO = find(Breakout(liSplitPrev:liSplit) == 1);
        liBO = liBO + liSplitPrev - 1;
        if (liBO-liSplitPrev+1) < (FrameRate./2);
            liBO1s = liBO;
        elseif (liBO-liSplitPrev+1) >= (FrameRate./2) & (liBO-liSplitPrev+1) < FrameRate;
            liBO1s = liBO - (FrameRate./2);
        else;
            liBO1s = liBO - FrameRate;
        end;
        if liBO1s < 1;
            liBO1s = liBO;
        end;

        Velocity(liSplitPrev:liBO1s-1) = NaN;
        VelocityRaw(liSplitPrev:liBO1s-1) = NaN;
        VelocityTrend(liSplitPrev:liBO1s-1) = NaN;
        VelocityINI(liSplitPrev:liBO1s-1) = NaN;

        %---threshold values for velocity
        reference_velocitythreshold;
        
        if liBO >= liStroke(1);
            txt = {FilenameDisp; ['Error lap ' num2str(lap) ': First stroke annotated before breakout']};
            warnwindow = warndlg(txt, 'Warning');
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                jFrame = get(handle(warnwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SpartaSynchroniser\SpartaSynchroniser_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
%                 clc;
            end;
            if isempty(txterror) == 1;
                txterror{1,1} = txt{2,:};
            else;
                li = length(txterror(:,1));
                txterror{li+1,1} = txt{2,:};
            end;
        end;
        Distance2 = Distance(liBO1s:liStroke(end));
        Time2 = Time(liBO1s:liStroke(end));
        Velocity2 = Velocity(liBO1s:liStroke(end));

        %check last 2m
        Dist2mEnd = SplitsAll(lap+1,1);
        diff2mEnd = abs(Distance2-(Dist2mEnd - 2));
        [minVal, minLoc] = min(diff2mEnd);
        
        minLocCorr = minLoc + liBO1s - 1;
        DPSError = 0;
        liStroke2m = find(liStroke >= minLocCorr);
        if isempty(liStroke2m) == 0;
            %stroke withing the last 2m
            DPSlast = Distance(liStroke(end))-Distance(liStroke(end-1));
            DPSref1 = Distance(liStroke(4))-Distance(liStroke(3));
            DPSref2 = Distance(liStroke(3))-Distance(liStroke(2));
            if DPSlast >= 0.35*mean([DPSref1 DPSref2]) == 1;
                %issue with DPS in the last 2m ... Calibration issue: Fish eye
                DPSError = 1;
            end;
        end;        
        
        lioutliers = find(Velocity2 >= thresTop);
        if length(lioutliers) == 0
            Distance2int = naninterpCustom(Distance2, 'linear');
        else;
            %check if it's the beginning of the data
            Distance2(lioutliers) = NaN;
            if SplitsAvSpeed(lap) > thresBottom;
                lioutliers = find(Velocity2 <= thresBottom);
                if length(lioutliers) == 0;
                    Distance2int = naninterpCustom(Distance2, 'linear');
                else;
                    Distance2(lioutliers) = NaN;
                    Distance2int = naninterpCustom(Distance2, 'linear');
                end;
            else;
                Distance2int = naninterpCustom(Distance2, 'linear');
            end;
        end;
        
        Distance2int = Distance2int';
        [~, ~, Velocity2Raw, ~] = spline2_SP2(Distance2int, FrameRate);

        x1 = [];
        x2 = [];
        Time2 = Time2';
        R = 0.15; 
        Nr = FrameRate;
        N = size(Distance2int, 1);
        NR = min(round(N*R), Nr); % At most 50 points
        for i = 1:size(Distance2int,2);
            x1(:,i) = 2*Distance2int(1,i)-flipud(Distance2int(2:NR+1,i));  % maintain continuity in level and slope
            x2(:,i) = 2*Distance2int(end,i)-flipud(Distance2int(end-NR:end-1,i));
        end;
        Distance2int = [x1; Distance2int; x2];
        [Distance2filt, Velocity2filt, alis] = Butter_SP2(Time2', Distance2int, FrameRate, cutoffFreq, orderval);
        Distance2filt(1:length(x1)) = [];
        Distance2filt(N+1:end) = [];
        Velocity2filt(1:length(x1)) = [];
        Velocity2filt(N+1:end) = [];

        Distance2filt = Distance2filt';
        Velocity2filt = Velocity2filt';

        lioutliers = find(Velocity2filt >= thresTop);
        Velocity2filt(lioutliers) = NaN;
        if SplitsAvSpeed(lap) > thresBottom;
            lioutliers = find(Velocity2filt <= thresBottom);
            Velocity2filt(lioutliers) = NaN;
            Velocity2filt = naninterpCustom(Velocity2filt, 'spline');
        end;
        
        lioutliers = find(Velocity2filt >= thresTop);
        Velocity2filt(lioutliers) = thresTop;
        if SplitsAvSpeed(lap) > thresBottom;
            lioutliers = find(Velocity2filt <= thresBottom);
            Velocity2filt(lioutliers) = thresBottom;
        end;
        
        coef = polyfit([1:length(Velocity2filt)]', Velocity2filt', 20);
%         clc;
        partialTrend = polyval(coef, [1:length(Velocity2filt)]');
        
        Distance(liBO1s:liStroke(end)) = Distance2filt;
        Velocity(liBO1s:liStroke(end)) = Velocity2filt;
        VelocityRaw(liBO1s:liStroke(end)) = Velocity2Raw;
        VelocityTrend(liBO1s:liStroke(end)) = partialTrend;

        VelLapAv(lap) = mean(Velocity(liStroke(2):liStroke(end)));
        
        if liBO1s == liBO;
            VelBeforeBO(lap) = NaN;
            VelAfterBO(lap) = NaN;
            BOEff(lap) = NaN;
            BOEffCorr(lap) = NaN;
        else;
            VelBeforeBO(lap) = mean(Velocity(liBO1s:liBO));
            if strcmpi(StrokeType, 'Freestyle') | strcmpi(StrokeType, 'Backstroke');
                VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(2)));
            elseif strcmpi(StrokeType, 'IndividualMedley') | strcmpi(StrokeType, 'Medley');
                if Course == 50
                    if RaceDist == 200;
                        if lap == 2 | lap == 4;
                            VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(2)));
                        else;
                            VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(1)));
                        end;
                    else;
                        if lap == 3 | lap == 4 | lap == 7 | lap == 8;
                            VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(2)));
                        else;
                            VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(1)));
                        end;
                    end;
                else;
                    if RaceDist == 200;
                        if lap == 3 | lap == 4 | lap == 7 | lap == 8;
                            VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(2)));
                        else;
                            VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(1)));
                        end;
                    else;
                        if lap == 5 | lap == 6 | lap == 7 | lap == 8 | lap == 13 | lap == 14 | lap == 15 | lap == 16;
                            VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(2)));
                        else;
                            VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(1)));
                        end;
                    end;
                end;
            else;
                VelAfterBO(lap) = mean(Velocity(liBO+1:liStroke(1)));
            end;
            BOEff(lap) = (VelAfterBO(lap)-VelBeforeBO(lap))./VelBeforeBO(lap);
            
            if strcmpi(dataEC.ageGroup, 'Open') == 1;
                if strcmpi(Gender, 'MALE');
                    refsize = 1.8;
                else;
                    refsize = 1.7;
                end;
            elseif strcmpi(dataEC.ageGroup, 'Under18');
                if strcmpi(Gender, 'MALE');
                    refsize = 1.75;
                else;
                    refsize = 1.65;
                end;
            elseif strcmpi(dataEC.ageGroup, 'Under15');
                refsize = 1.6;
            else;
                refsize = 1.5;
            end;
            TurnUWVelocity(lap-1) = (Distance(liBO)-refsize)./Time(liBO);

            if strcmpi(Gender, 'MALE');
                if strcmpi(StrokeType, 'Backstroke');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.08;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 1.87;
                    end;
                elseif strcmpi(StrokeType, 'Breaststroke');
                    if RaceDist == 50;
                        UWMaxSpeed = 1.83;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 1.90;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 1.70;
                    end;
                elseif strcmpi(StrokeType, 'Butterfly');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.20;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.12;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 1.90;
                    end;
                elseif strcmpi(StrokeType, 'Freestyle');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.35;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.25;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 2.05;
                    elseif RaceDist == 400;
                        UWMaxSpeed = 1.87;
                    elseif RaceDist == 800;
                        UWMaxSpeed = 1.77;
                    elseif RaceDist == 1500;
                        UWMaxSpeed = 1.71;
                    end;
                else;
                    if RaceDist == 200;
                        UWMaxSpeed = 1.85;
                    elseif RaceDist == 150;
                        UWMaxSpeed = 1;
                    elseif RaceDist == 400;
                        UWMaxSpeed = 1.68;
                    end;
                end;
            else;
                if strcmpi(StrokeType, 'Backstroke');
                    if RaceDist == 50;
                        UWMaxSpeed = 1.90;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 1.82;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 1.70;
                    end;
                elseif strcmpi(StrokeType, 'Breaststroke');
                    if RaceDist == 50;
                        UWMaxSpeed = 1.7;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 1.60;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 1.52;
                    end;
                elseif strcmpi(StrokeType, 'Butterfly');
                    if RaceDist == 50;
                        UWMaxSpeed = 2;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 1.89;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 1.70;
                    end;
                elseif strcmpi(StrokeType, 'Freestyle');
                    if RaceDist == 50;
                        UWMaxSpeed = 2.1;
                    elseif RaceDist == 100;
                        UWMaxSpeed = 2.02;
                    elseif RaceDist == 200;
                        UWMaxSpeed = 1.85;
                    elseif RaceDist == 400;
                        UWMaxSpeed = 1.72;
                    elseif RaceDist == 800;
                        UWMaxSpeed = 1.67;
                    elseif RaceDist == 1500;
                        UWMaxSpeed = 1.62;
                    end;
                else;
                    if RaceDist == 200;
                        UWMaxSpeed = 1.64;
                    elseif RaceDist == 150;
                        UWMaxSpeed = 1;
                    elseif RaceDist == 400;
                        UWMaxSpeed = 1.52;
                    end;
                end;
            end;
            coefUWspeed = VelBeforeBO(lap)./UWMaxSpeed;
            if coefUWspeed > 1;
                coefUWspeed = 1;
            end;
            BOEffCorr(lap) = BOEff(lap).*(coefUWspeed^3);
        end;
        DistEC = SplitsAll(lap,1);
        TimeEC = SplitsAll(lap,2);

        diffSplit = abs(Distance - (DistEC-5));
        [~,li5in] = min(diffSplit);
        diffSplit = abs(Distance - (DistEC+10));
        [~,li10out] = min(diffSplit);

        Turn_Time(lap-1) = Time(li10out) - Time(li5in);
        Turn_TimeIn(lap-1) =  TimeEC - Time(li5in);
        Turn_TimeOut(lap-1) = Time(li10out) - TimeEC;


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        diffSplit = abs(DistanceINI - (DistEC-5));
        [~,li5inINI] = min(diffSplit);
        diffSplit = abs(DistanceINI - (DistEC+10));
        [~,li10outINI] = min(diffSplit);
        diffSplit = abs(DistanceINIBO - (DistEC+10));
        [~,li10outINIBO] = min(diffSplit);
%         li5inINI = find(DistanceINI > (DistEC-5), 1);
%         li10outINI = find(DistanceINI > (DistEC+10), 1);
%         li10outINIBO = find(DistanceINIBO > (DistEC+10), 1);

        Turn_TimeINI(lap-1) = Time(li10outINIBO) - Time(li5inINI);
        Turn_TimeInINI(lap-1) =  TimeEC - Time(li5inINI);
        Turn_TimeOutINI(lap-1) = Time(li10outINIBO) - TimeEC;

        Turn_BODist(lap-1) = Distance(liBO) - DistEC;
        Turn_BODistINI(lap-1) = DistanceINI(liBO) - DistEC;

        liBreath = find(Breath(liSplitPrev:liSplit) == 1);
        liBreath = liBreath + liSplitPrev - 1;
        BreathsNb = [BreathsNb length(liBreath)];
        Breath_Frames(lap,1:length(liBreath)) = liBreath;

        liKick = find(Kick(liSplitPrev:liSplit) == 1);
        liKick = liKick + liSplitPrev - 1;
        KicksNb = [KicksNb length(liKick)];
        Kick_Frames(lap,1:length(liKick)) = liKick;

        liSplitPrev = liSplit;
    end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% liStroke

    Stroke_Frame(lap,1:length(liStroke)) = liStroke;

    BOAll = [BOAll; liBO Time(liBO) Distance(liBO)];
    BOAllINI = [BOAllINI; liBO Time(liBO) DistanceINI(liBO)];

    if strcmpi(StrokeType, 'Freestyle') | strcmpi(StrokeType, 'Backstroke');
        SpeedLastCycle = roundn(mean(Velocity(liStroke(end-2):liStroke(end))),-2);
        Speed2Cycle = roundn(mean(Velocity(liStroke(end-6):liStroke(end-2))),-2);
    elseif strcmpi(StrokeType, 'IndividualMedley') | strcmpi(StrokeType, 'Medley');
        if Course == 50
            if RaceDist == 200;
                if lap == 2 | lap == 4;
                    SpeedLastCycle = roundn(mean(Velocity(liStroke(end-2):liStroke(end))),-2);
                    Speed2Cycle = roundn(mean(Velocity(liStroke(end-6):liStroke(end-2))),-2);
                else;
                    SpeedLastCycle = roundn(mean(Velocity(liStroke(end-1):liStroke(end))),-2);
                    Speed2Cycle = roundn(mean(Velocity(liStroke(end-3):liStroke(end-1))),-2);
                end;
            else;
                if lap == 3 | lap == 4 | lap == 7 | lap == 8;
                    SpeedLastCycle = roundn(mean(Velocity(liStroke(end-2):liStroke(end))),-2);
                    Speed2Cycle = roundn(mean(Velocity(liStroke(end-6):liStroke(end-2))),-2);
                else;
                    SpeedLastCycle = roundn(mean(Velocity(liStroke(end-1):liStroke(end))),-2);
                    Speed2Cycle = roundn(mean(Velocity(liStroke(end-3):liStroke(end-1))),-2);
                end;
            end;
        else;
            if RaceDist == 200;
                if lap == 3 | lap == 4 | lap == 7 | lap == 8;
                    SpeedLastCycle = roundn(mean(Velocity(liStroke(end-2):liStroke(end))),-2);
                    Speed2Cycle = roundn(mean(Velocity(liStroke(end-6):liStroke(end-2))),-2);
                else;
                    SpeedLastCycle = roundn(mean(Velocity(liStroke(end-1):liStroke(end))),-2);
                    Speed2Cycle = roundn(mean(Velocity(liStroke(end-3):liStroke(end-1))),-2);
                end;
            else;
                if lap == 5 | lap == 6 | lap == 7 | lap == 8 | lap == 13 | lap == 14 | lap == 15 | lap == 16;
                    SpeedLastCycle = roundn(mean(Velocity(liStroke(end-2):liStroke(end))),-2);
                    Speed2Cycle = roundn(mean(Velocity(liStroke(end-6):liStroke(end-2))),-2);
                else;
                    SpeedLastCycle = roundn(mean(Velocity(liStroke(end-1):liStroke(end))),-2);
                    Speed2Cycle = roundn(mean(Velocity(liStroke(end-3):liStroke(end-1))),-2);
                end;
            end;
        end;
    else;
        SpeedLastCycle = roundn(mean(Velocity(liStroke(end-1):liStroke(end))),-2);
        if length(liStroke) > 3;
            Speed2Cycle = roundn(mean(Velocity(liStroke(end-3):liStroke(end-1))),-2);
        else;
            Speed2Cycle = roundn(mean(Velocity(liStroke(end-2):liStroke(end-1))),-2);
        end;
    end;
    ApproachSpeedLastCycleAll(lap) = SpeedLastCycle;
    ApproachSpeed2CycleAll(lap) = Speed2Cycle;
    ApproachEff(lap) = (SpeedLastCycle-Speed2Cycle)./Speed2Cycle;

    GlideLastStrokeEC(1,lap) = Distance(liStroke(end));
    GlideLastStrokeEC(2,lap) = 50-((lap.*Course)-GlideLastStrokeEC(1,lap));
    GlideLastStrokeEC(3,lap) = ((lap.*Course)-GlideLastStrokeEC(1,lap));
    diffdist = abs(Distance - GlideLastStrokeEC(1,lap));
    [~, lidist] = min(diffdist);
    GlideLastStrokeEC(4,lap) = SplitsAll(lap+1,2) - Time(lidist(1));

    Stroke_Number(lap) = length(liStroke);
    timeStroke = diff(liStroke)./FrameRate;
    Stroke_Time(lap,1:length(timeStroke)) = timeStroke;
    if strcmpi(StrokeType, 'Freestyle') | strcmpi(StrokeType, 'Backstroke');
        Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
        keyDist = Distance(liStroke);
        diffDist = diff(keyDist).*2;   
        Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
        for strEC = 2:length(liStroke);
            segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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
        
        keyDistINI = DistanceINI(liStroke);
        diffDistINI = diff(keyDistINI).*2;
        Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
        Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
        Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
        
        if DPSError == 1;
            Velini = liStroke(liStroke2m(1)-3);
            Velend = liStroke(liStroke2m(1)-1);
            VelRef = mean(Velocity(Velini:Velend));
            VelRefTrend = mean(VelocityTrend(Velini:Velend));
            for str = 1:length(liStroke2m);
                valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
                Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                
                Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                for it = 1:length((Velend:liStroke(liStroke2m(end))))
                    Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                end;
            end;
        end;
        
    elseif strcmpi(StrokeType, 'Medley');
        if Course == 50;
            if RaceDist == 200;
                if lap == 2 | lap == 4;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist).*2;
                    Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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
                    
                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI).*2;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
                    
                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
        
                else;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist);
                    Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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
                    
                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI);
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));
                    
                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                end;
            elseif RaceDist == 150;
                if lap == 1 | lap == 3;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist).*2;
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI).*2;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                else;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist);
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI);
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                end;
            else;
                if lap == 3 | lap == 4 | lap == 7 | lap == 8;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist).*2;
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI).*2;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                else;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist);
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI);
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                end;
            end;
        else;
            if RaceDist == 100;
                if lap == 2 | lap == 4;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist).*2;
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI).*2;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                else;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist);
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI);
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                end;
            elseif RaceDist == 200;
                if lap == 3 | lap == 4 | lap == 7 | lap == 8;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist).*2;
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI).*2;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                else;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist);
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI).*2;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                end;
            elseif RaceDist == 150;
                if lap == 1 | lap == 2 | lap == 5 | lap == 6;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist).*2;
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI).*2;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                else;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist);
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI);
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                end;
            else;
                if lap == 5 | lap == 6 | lap == 7 | lap == 8 | lap == 13 | lap == 14 | lap == 15 | lap == 16;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60)./2;
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist).*2;
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = (diffDist./timeStroke)./2;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI).*2;
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = (diffDistINI./timeStroke)./2;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1).*2;
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                else;
                    Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
                    keyDist = Distance(liStroke);
                    diffDist = diff(keyDist);
                    Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
                    Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
                    for strEC = 2:length(liStroke);
                        segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

                    keyDistINI = DistanceINI(liStroke);
                    diffDistINI = diff(keyDistINI);
                    Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
                    Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
                    Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

                    if DPSError == 1;
                        Velini = liStroke(liStroke2m(1)-3);
                        Velend = liStroke(liStroke2m(1)-1);
                        VelRef = mean(Velocity(Velini:Velend));
                        VelRefTrend = mean(VelocityTrend(Velini:Velend));
                        for str = 1:length(liStroke2m);
                            valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
                            Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                            Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                            Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                            Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                            VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                            for it = 1:length((Velend:liStroke(liStroke2m(end))))
                                Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                            end;
                        end;
                    end;
                end;
            end;
        end;

    else;
        Stroke_SR(lap,1:length(timeStroke)) = ((1./timeStroke).*60);
        keyDist = Distance(liStroke);
        diffDist = diff(keyDist);
        Stroke_Distance(lap,1:length(timeStroke)) = diffDist;
        Stroke_Velocity(lap,1:length(timeStroke)) = diffDist./timeStroke;
        for strEC = 2:length(liStroke);
            segVel = Velocity(liStroke(strEC-1):liStroke(strEC));
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

        keyDistINI = DistanceINI(liStroke);
        diffDistINI = diff(keyDistINI);
        Stroke_DistanceINI(lap,1:length(timeStroke)) = diffDistINI;
        Stroke_VelocityINI(lap,1:length(timeStroke)) = diffDistINI./timeStroke;
        Stroke_SIINI(lap,1:length(timeStroke)) = Stroke_VelocityINI(lap,1:length(timeStroke)).*Stroke_DistanceINI(lap,1:length(timeStroke));

        if DPSError == 1;
            if length(liStroke) > 3;
                Velini = liStroke(liStroke2m(1)-3);
            else;
                Velini = liStroke(liStroke2m(1)-2);
            end;
            Velend = liStroke(liStroke2m(1)-1);
            VelRef = mean(Velocity(Velini:Velend));
            VelRefTrend = mean(VelocityTrend(Velini:Velend));
            for str = 1:length(liStroke2m);
                valNew = VelRef.*Stroke_Time(lap,liStroke2m(str)-1);
                Stroke_Distance(lap,liStroke2m(str)-1) = valNew;
                Stroke_DistanceINI(lap,liStroke2m(str)-1) = valNew;
                Stroke_SI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                Stroke_SIINI(lap,liStroke2m(str)-1) = VelRef.*valNew;
                Velocity(Velend:liStroke(liStroke2m(end))) = VelRef;
                VelocityTrend(Velend:liStroke(liStroke2m(end))) = VelRefTrend;
                for it = 1:length((Velend:liStroke(liStroke2m(end))))
                    Distance(1,Velend+it) = Distance(1,Velend) + (it*1./FrameRate.*VelRef);
                end;
            end;
        end;
    end;
end;
% ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
try;
    skipEntry = 0;
    if dataEC.independent_actions.headAtWaterEntry.dist > 45 & dataEC.independent_actions.headAtWaterEntry.dist < 50;
        StartEntryDist = 50 - dataEC.independent_actions.headAtWaterEntry.dist;
    elseif dataEC.independent_actions.headAtWaterEntry.dist > 20 & dataEC.independent_actions.headAtWaterEntry.dist < 25;
        StartEntryDist = 25 - dataEC.independent_actions.headAtWaterEntry.dist;
    elseif dataEC.independent_actions.headAtWaterEntry.dist == 0;
        skipEntry = 1;
    else;
        StartEntryDist = dataEC.independent_actions.headAtWaterEntry.dist;
    end;

    if skipEntry == 0
        UWDist = BOAll(1,3) -  StartEntryDist;
        UWTime = (BOAll(1,1) - ceil(dataEC.independent_actions.headAtWaterEntry.frame - dataEC.startFrame))./FrameRate;
        StartUWVelocity = roundn(UWDist./UWTime,-2);
        
        StartUWVelocity = roundn(StartUWVelocity, -2);
        StartEntryDist = roundn(StartEntryDist, -2);
        StartUWDist = roundn(UWDist,-2);
        StartUWTime = roundn(UWTime,-2);
    else;
        StartUWVelocity = [];
        StartEntryDist = [];
        StartUWDist = [];
        StartUWTime = [];
    end;
catch;
    StartUWVelocity = [];
    StartEntryDist = [];
    StartUWDist = [];
    StartUWTime = [];
end;
% ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù

            
keyDistLast5 = RaceDist - 5;
Diff5m = abs(Distance(BOAll(lap,1):liStroke(end)-1) - keyDistLast5);
[~, minli] = min(Diff5m);
minli = minli + BOAll(lap,1) - 1;
Last5m = SplitsAll(end,2) - Time(minli(1));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
keyDistLast5INI = RaceDist - 5;
Diff5m = abs(DistanceINI(BOAllINI(lap,1):liStroke(end)-1) - keyDistLast5INI);
[~, minli] = min(Diff5m);
% minli = find(DistanceINI(BOAllINI(lap,1):liStroke(end)-1) > keyDistLast5INI, 1);
% minli = minli + BOAllINI(lap,1) - 1;
minli = minli(1) + BOAllINI(lap,1) - 1;

Last5mINI = SplitsAll(end,2) - Time(minli);

TotalSkillTime = DiveT15 + sum(Turn_Time) + Last5m;
TotalSkillTimeINI = DiveT15INI + sum(Turn_TimeINI) + Last5mINI;
TurnsTotal = [sum(Turn_TimeIn) sum(Turn_TimeOut) sum(Turn_Time)];
TurnsTotalINI = [sum(Turn_TimeInINI) sum(Turn_TimeOutINI) sum(Turn_TimeINI)];
TurnsAv = [mean(Turn_TimeIn) mean(Turn_TimeOut) mean(Turn_Time)];
TurnsAvINI = [mean(Turn_TimeInINI) mean(Turn_TimeOutINI) mean(Turn_TimeINI)];
TurnsAvBODist = BOAll(2:end,3);
TurnsAvBODistINI = BOAllINI(2:end,3);

linan = find(isnan(BOEff(2:end)) == 1);
if isempty(linan) == 1;
    TurnsAvBOEff = mean(BOEff(2:end));
    TurnsAvBOEffCorr = mean(BOEffCorr(2:end));
    TurnsAvVelAfterBO = mean(VelAfterBO(2:end));
    TurnsAvVelBeforeBO = mean(VelBeforeBO(2:end));
    TurnsAvKicks = mean(KicksNb(2:end));
else;
    if length(linan) == length(BOEff(2:end));
        TurnsAvBOEff = NaN;
        TurnsAvBOEffCorr = NaN;
        TurnsAvVelAfterBO = NaN;
        TurnsAvVelBeforeBO = NaN;
        TurnsAvKicks = NaN;
    else;
        linankeep = find(isnan(BOEff(2:end)) == 0);
        linankeep = linankeep + 1;
        TurnsAvBOEff = mean(BOEff(2:end));
        TurnsAvBOEffCorr = mean(BOEffCorr(linankeep));
        TurnsAvVelAfterBO = mean(VelAfterBO(linankeep));
        TurnsAvVelBeforeBO = mean(VelBeforeBO(linankeep));
        TurnsAvKicks = mean(KicksNb(linankeep));
    end;
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
clear SectionVel;
clear SectionVelbis;
clear SectionVel2;
clear SectionNb;
clear SectionNbbis;
clear SectionSR;
clear SectionSR2;
clear SectionSRbis;
clear SectionSD;
clear SectionSD2;
clear SectionSDbis;


lapLim = Course:Course:RaceDist;
lapEC = 1;
updateLap = 0;
SectionVel = [];
    
dataZone = [];
totZone = NbLap.*(Course./5);
distIni = 0;
jumDist = 5;
for zEC = 1:totZone;
    dataZone(zEC,:) = [distIni distIni+5];
    distIni = distIni + 5;
end;
zoneVel = 1;

for zoneEC = 1:totZone;

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
        VelEC = NaN;

    elseif BOAll(lapEC,3) <= zone_dist_end & BOAll(lapEC,3) > zone_dist_ini;
        %BO happened in this zone
        distBO2End = zone_dist_end-BOAll(lapEC,3);
        if distBO2End <= 2;
            %Less than 2m to end of zone
            VelEC = NaN;
        else;
            %more than 2m to calculate the speed
            zone_dist_ini = BOAll(lapEC,3);
            zone_time_ini = BOAll(lapEC,2);

            [minVal, minLoc] = min(abs(DistanceINI-zone_dist_end));
            zone_time_end = Time(minLoc(1));
            VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
        end;
    else;
        %BO happened before
        [minVal, minLoc] = min(abs(DistanceINI-zone_dist_ini));
        zone_time_ini = Time(minLoc(1));

        [minVal, minLoc] = min(abs(DistanceINI-zone_dist_end));
        zone_time_end = Time(minLoc(1));
        VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
    end;
    SectionVel(lapEC,zoneVel) = VelEC;
    zoneVel = zoneVel + 1;

    if updateLap == 1;
        updateLap = 0;
        lapEC = lapEC + 1;
        zoneVel = 1;
    end;
end;

nbZones = Course./5;
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
elseif strcmpi(lower(StrokeType), 'para-medley');
    if Course == 25;
        legsIM = [[1 2]; [3 4]; [5 6]];
    elseif Course == 50;
        legsIM = [1; 2; 3];
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
            [minVal, minLoc] = min(abs(DistanceINI-zone_dist_ini));
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
            [minVal, minLoc] = min(abs(DistanceINI-zone_dist_end));
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
    
    li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc < zone_frame_end);

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
                    zone_frame_iniExtra = zone_frame_ini - (10*FrameRate);
                    zone_frame_endExtra = strokeList(1) - 1;
                    
                    %take the last stroke available
                    li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                    li_strokeExtra = li_strokeExtra(end);

                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                    
                elseif strcmpi(searchExtraStroke, 'post');
                    %look for stroke in the 10s leading to the
                    %zone
                    zone_frame_endExtra = zone_frame_end + (10*FrameRate);
                    zone_frame_iniExtra = strokeList(end) + 1;

                    %take the first stroke available
                    li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                    li_strokeExtra = li_strokeExtra(1);

                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                end;
            end;

            for strokeEC = 2:length(strokeList);
                durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./FrameRate;
                SREC(strokeEC-1) = 60/durationStroke;
                SREC(strokeEC-1) = SREC(strokeEC-1)./2;
            end;
            SREC = mean(SREC);

        elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
            for strokeEC = 2:length(strokeList);
                durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./FrameRate;
                SREC(strokeEC-1) = 60/durationStroke;
            end;
            SREC = mean(SREC);

        elseif strcmpi(lower(StrokeType), 'medley');
            [li, co] = find(legsIM == lapEC);
            if li == 1 | li == 3;
                %butterfly and breaststroke legs
                for strokeEC = 2:length(strokeList);
                    durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./FrameRate;
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
                        zone_frame_iniExtra = zone_frame_ini - (10*FrameRate);
                        zone_frame_endExtra = strokeList(1) - 1;
                        
                        %take the last stroke available
                        li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                        li_strokeExtra = li_stroke(end);

                        strokeList = [strokeList li_strokeExtra];

                    elseif strcmpi(searchExtraStroke, 'post');
                        %look for stroke in the 10s leading to the
                        %zone
                        zone_frame_endExtra = zone_frame_end + (10*FrameRate);
                        zone_frame_iniExtra = strokeList(end) + 1;

                        %take the first stroke available
                        li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                        li_strokeExtra = li_stroke(1);

                        strokeList = [strokeList li_strokeExtra];
                    end;
                end;

                for strokeEC = 2:length(strokeList);
                    durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./FrameRate;
                    SREC(strokeEC-1) = 60/durationStroke;
                    SREC(strokeEC-1) = SREC(strokeEC-1)./2;
                end;
                SREC = mean(SREC);
            end;
            
        elseif strcmpi(lower(StrokeType), 'para-medley');
            [li, co] = find(legsIM == lapEC);
            if li == 2;
                %butterfly and breaststroke legs
                for strokeEC = 2:length(strokeList);
                    durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./FrameRate;
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
                        zone_frame_iniExtra = zone_frame_ini - (10*FrameRate);
                        zone_frame_endExtra = strokeList(1) - 1;
                        
                        %take the last stroke available
                        li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                        li_strokeExtra = li_stroke(end);

                        strokeList = [strokeList li_strokeExtra];

                    elseif strcmpi(searchExtraStroke, 'post');
                        %look for stroke in the 10s leading to the
                        %zone
                        zone_frame_endExtra = zone_frame_end + (10*FrameRate);
                        zone_frame_iniExtra = strokeList(end) + 1;

                        %take the first stroke available
                        li_strokeExtra = find(Stroke_FrameRestruc >= zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                        li_strokeExtra = li_stroke(1);

                        strokeList = [strokeList li_strokeExtra];
                    end;
                end;

                for strokeEC = 2:length(strokeList);
                    durationStroke = (strokeList(strokeEC) - strokeList(strokeEC-1))./FrameRate;
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


%calculate DPS per sections
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
            [minVal, minLoc] = min(abs(DistanceINI-zone_dist_ini));
            zone_frame_ini = minLoc(1);
        end;
    end;
    
    indexLap = find(lapLim == zone_dist_end);
    if isempty(indexLap) == 0;
        %Last zone for a lap, remove 2m
        zone_dist_end = zone_dist_end-2;
        updateLap = 1;
    end;
    [minVal, minLoc] = min(abs(DistanceINI-zone_dist_end));
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
    
    li_stroke = find(Stroke_FrameRestruc >= zone_frame_ini & Stroke_FrameRestruc < zone_frame_end);

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
                    zone_frame_iniExtra = zone_frame_ini - (10*FrameRate);
                    zone_frame_endExtra = strokeList(1) - 1;
                    
                    %take the last stroke available
                    li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                    li_strokeExtra = li_strokeExtra(end);

                    strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                    
                elseif strcmpi(searchExtraStroke, 'post');
                    %look for stroke in the 10s leading to the
                    %zone
                    zone_frame_endExtra = zone_frame_end + (10*FrameRate);
                    zone_frame_iniExtra = strokeList(end) + 1;

                    %take the first stroke available
                    li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                    li_strokeExtra = li_strokeExtra(1);

                    strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                end;
            end;

            for strokeEC = 2:length(strokeList);
                distanceStroke(strokeEC) = DistanceINI(strokeList(strokeEC)) - DistanceINI(strokeList(strokeEC-1));
                DPSEC(strokeEC-1) = distanceStroke(strokeEC).*2;
            end;
            DPSEC = mean(DPSEC);

        elseif strcmpi(lower(StrokeType), 'breaststroke') | strcmpi(lower(StrokeType), 'butterfly');
            for strokeEC = 2:length(strokeList);
                distanceStroke = DistanceINI(strokeList(strokeEC)) - DistanceINI(strokeList(strokeEC-1));
                DPSEC(strokeEC-1) = distanceStroke;
            end;
            DPSEC = mean(DPSEC);

        elseif strcmpi(lower(StrokeType), 'medley');
            [li, co] = find(legsIM == lapEC);
            if li == 1 | li == 3;
                %butterfly and breaststroke legs
                for strokeEC = 2:length(strokeList);
                    distanceStroke = DistanceINI(strokeList(strokeEC)) - DistanceINI(strokeList(strokeEC-1));
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
                        zone_frame_iniExtra = zone_frame_ini - (10*FrameRate);
                        zone_frame_endExtra = strokeList(1) - 1;
                        
                        %take the last stroke available
                        li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                        li_strokeExtra = li_strokeExtra(end);

                        strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                        
                    elseif strcmpi(searchExtraStroke, 'post');
                        %look for stroke in the 10s leading to the
                        %zone
                        zone_frame_endExtra = zone_frame_end + (10*FrameRate);
                        zone_frame_iniExtra = strokeList(end) + 1;

                        %take the first stroke available
                        li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                        li_strokeExtra = li_strokeExtra(1);

                        strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                    end;
                end;

                for strokeEC = 2:length(strokeList);
                    distanceStroke = DistanceINI(strokeList(strokeEC)) - DistanceINI(strokeList(strokeEC-1));
                    DPSEC(strokeEC-1) = distanceStroke.*2;
                end;
                DPSEC = mean(DPSEC);
            end;

        elseif strcmpi(lower(StrokeType), 'para-medley');
            [li, co] = find(legsIM == lapEC);
            if li == 2;
                %breaststroke legs
                for strokeEC = 2:length(strokeList);
                    distanceStroke = DistanceINI(strokeList(strokeEC)) - DistanceINI(strokeList(strokeEC-1));
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
                        zone_frame_iniExtra = zone_frame_ini - (10*FrameRate);
                        zone_frame_endExtra = strokeList(1) - 1;
                        
                        %take the last stroke available
                        li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                        li_strokeExtra = li_strokeExtra(end);

                        strokeList = [Stroke_FrameRestruc(li_strokeExtra) strokeList];
                        
                    elseif strcmpi(searchExtraStroke, 'post');
                        %look for stroke in the 10s leading to the
                        %zone
                        zone_frame_endExtra = zone_frame_end + (10*FrameRate);
                        zone_frame_iniExtra = strokeList(end) + 1;

                        %take the first stroke available
                        li_strokeExtra = find(Stroke_FrameRestruc > zone_frame_iniExtra & Stroke_FrameRestruc < zone_frame_endExtra);
                        li_strokeExtra = li_strokeExtra(1);

                        strokeList = [strokeList Stroke_FrameRestruc(li_strokeExtra)];
                    end;
                end;

                for strokeEC = 2:length(strokeList);
                    distanceStroke = DistanceINI(strokeList(strokeEC)) - DistanceINI(strokeList(strokeEC-1));
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
SectionSDbis = SectionSD;
SectionSRbis = SectionSR;
SectionNbbis = SectionNb;
SectionSD = roundn(SectionSD,-2);
SectionSR = roundn(SectionSR,-1);
SectionNb = roundn(SectionNb,0);
SectionSDbis = roundn(SectionSDbis,-2);
SectionSRbis = roundn(SectionSRbis,-2);
SectionNbbis = roundn(SectionNbbis,0);


%calculate average and max Vel, SD and SR
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
SectionSRBIS = reshape(SectionSR, li*co, 1);
linan = find(isnan(SectionSRBIS) == 0);
valmax = max(SectionSRBIS(linan));
MaxSRDouble = roundn(valmax,-2);
MaxSR = dataToStr(MaxSRDouble,2);
[MaxSRLoc_Lap, MaxSRLoc_Seg] = find(SectionSR == valmax);
MaxSR = [MaxSR ' [Lap:' num2str(MaxSRLoc_Lap(1)) '-Seg:' num2str(MaxSRLoc_Seg(1)) ']'];
valmean = mean(SectionSRBIS(linan));
MeanSR = dataToStr(valmean,2);
MaxSR = [MeanSR ' / ' MaxSR];

SectionDPS = SectionSD;
[li,co] = size(SectionDPS);
SectionDPSBIS = reshape(SectionDPS, li*co, 1);
linan = find(isnan(SectionDPSBIS) == 0);
valmax = max(SectionDPSBIS(linan));
MaxDPSDouble = roundn(valmax,-2);
MaxDPS = dataToStr(MaxDPSDouble,2);
[MaxDPSLoc_Lap, MaxDPSLoc_Seg] = find(SectionDPS == valmax);
MaxDPS = [MaxDPS ' [Lap:' num2str(MaxDPSLoc_Lap(1)) '-Seg:' num2str(MaxDPSLoc_Seg(1)) ']'];
valmean = mean(SectionDPSBIS(linan));
MeanDPS = dataToStr(valmean,2);
MaxDPS = [MeanDPS ' / ' MaxDPS];


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
Stroke_VelocityDecay = Stroke_Velocity;
if strcmpi(StrokeType, 'Freestyle') | strcmpi(StrokeType, 'Backstroke');
    %remove first 2 and last 2 strokes
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
            Cycle_TimeTOT = [Cycle_TimeTOT Cycle_Time(lapEC,:)];
            Cycle_VelocityTOT = [Cycle_VelocityTOT Cycle_Velocity(lapEC,:)];
        else;
            Cycle_Time(lapEC,1) = NaN;
            Cycle_Velocity(lapEC,1) = NaN;
        end;
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
            Cycle_TimeTOT = [Cycle_TimeTOT Cycle_Time(lapEC,:)];
            Cycle_VelocityTOT = [Cycle_VelocityTOT Cycle_Velocity(lapEC,:)];
        else;
            Cycle_Time(lapEC,1) = NaN;
            Cycle_Velocity(lapEC,1) = NaN;
        end;
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
            index = find(addTime ~= 0 & isnan(addTime) == 0);
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
        index = find(Cycle_VelocityLeg ~= 0 & isnan(Cycle_VelocityLeg) == 0);
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

%Check DistanceEC, TimeEC and VelocityEC length and adjust if different
lengthdata = [length(Distance) length(DistanceINI) length(Velocity) length(VelocityRaw) length(VelocityTrend) length(VelocityINI) length(Time)];
if min(lengthdata) == max(lengthdata);
    [minVal, minLoc] = min(lengthdata);
    minLoc = minLoc(1);
    if minLoc == 1;
        %Distance is the shortest
        DistanceINI = DistanceINI(1:length(Distance));
        Velocity = Velocity(1:length(Distance));
        VelocityRaw = VelocityRaw(1:length(Distance));
        VelocityTrend = VelocityTrend(1:length(Distance));
        VelocityINI = VelocityINI(1:length(Distance));
        Time = Time(1:length(Distance));
    elseif minLoc == 2;
        %DistanceINI is the shortest
        Distance = Distance(1:length(DistanceINI));
        Velocity = Velocity(1:length(DistanceINI));
        VelocityRaw = VelocityRaw(1:length(DistanceINI));
        VelocityTrend = VelocityTrend(1:length(DistanceINI));
        VelocityINI = VelocityINI(1:length(DistanceINI));
        Time = Time(1:length(DistanceINI));
    elseif minLoc == 3;
        %Velocity is the shortest
        Distance = Distance(1:length(Velocity));
        DistanceINI = DistanceINI(1:length(Velocity));
        VelocityRaw = VelocityRaw(1:length(Velocity));
        VelocityTrend = VelocityTrend(1:length(Velocity));
        VelocityINI = VelocityINI(1:length(Velocity));
        Time = Time(1:length(Velocity));
    elseif minLoc == 4;
        %VelocityRaw is the shortest
        Distance = Distance(1:length(VelocityRaw));
        DistanceINI = DistanceINI(1:length(VelocityRaw));
        Velocity = Velocity(1:length(VelocityRaw));
        VelocityTrend = VelocityTrend(1:length(VelocityRaw));
        VelocityINI = VelocityINI(1:length(VelocityRaw));
        Time = Time(1:length(VelocityRaw));
    elseif minLoc == 5;
        %VelocityTrend is the shortest
        Distance = Distance(1:length(VelocityTrend));
        DistanceINI = DistanceINI(1:length(VelocityTrend));
        Velocity = Velocity(1:length(VelocityTrend));
        VelocityRaw = VelocityRaw(1:length(VelocityTrend));
        VelocityINI = VelocityINI(1:length(VelocityTrend));
        Time = Time(1:length(VelocityTrend));
    elseif minLoc == 6;
        %VelocityINI is the shortest
        Distance = Distance(1:length(VelocityINI));
        DistanceINI = DistanceINI(1:length(VelocityINI));
        Velocity = Velocity(1:length(VelocityINI));
        VelocityRaw = VelocityRaw(1:length(VelocityINI));
        VelocityTrend = VelocityTrend(1:length(VelocityINI));
        Time = Time(1:length(VelocityINI));
    elseif minLoc == 7;
        %Time is the shortest
        Distance = Distance(1:length(Time));
        DistanceINI = DistanceINI(1:length(Time));
        Velocity = Velocity(1:length(Time));
        VelocityRaw = VelocityRaw(1:length(Time));
        VelocityINI = VelocityINI(1:length(Time));
        VelocityTrend = VelocityTrend(1:length(Time));
    end;
end;
%--------------------------------------------------------------------------





stepCheck = 4







%-------------------------------Pacing graph-------------------------------
%----Velocity bars / SR (left yaxis)
% ran = max(Velocity);
% min_val = 0;
% max_val = max(Velocity);
ran = thresTopDisp - thresBottomDisp;
min_val = thresBottomDisp;
max_val = thresTopDisp;

colorVel = floor(((Velocity-min_val)/ran)*256)+1;
colorVelTrend = floor(((VelocityTrend-min_val)/ran)*256)+1;
col = zeros(numel(Velocity),3);

if strcmpi(detailRelay, 'None') == 1;
    str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' (SP2)'];
else;
    str = [Athletename '  ' num2str(RaceDist) 'm-' StrokeType '  ' Meet Year '-' Stage ' - ' detailRelay ' ' valRelay ' (SP2)'];
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
    if FrameRate == 25;
        jump = 5;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 7;
        linesize = 2.2;
        linesizeRed = 3;
    end;
elseif RaceDist == 200;
    if FrameRate == 25;
        jump = 5;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 7;
        linesize = 2.2;
        linesizeRed = 3;
    end;
elseif RaceDist == 400
    if FrameRate == 25;
        jump = 7;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 9;
        linesize = 2.2;
        linesizeRed = 3;
    end;
elseif RaceDist == 800;
    if FrameRate == 25;
        jump = 9;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 15;
        linesize = 2.2;
        linesizeRed = 3;
    end;
elseif RaceDist == 1500;
    if FrameRate == 25;
        jump = 8;
        linesize = 2.2;
        linesizeRed = 3;
    else;
        jump = 15;
        linesize = 2.2;
        linesizeRed = 3;
    end;
end;
for i = 1:jump:numel(Velocity);
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
        if i+jump-1 > numel(Velocity);
            maxi = numel(Velocity);
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
for i = 1:jump:numel(Velocity);
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
graph1_lineBottom = line([0 numel(Velocity)], [0 0], 'Color', [0.5 0.5 0.5], 'LineWidth', 2.5, 'parent', axesgraph1, 'visible', 'off');
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
%     try;
        cla(axescolbar, 'reset');

        set(axescolbar, 'Position', [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.065], 'units', 'Normalized', ...
            'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
            'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12);
%     catch;
%         axescolbar = axes('parent', gcf, 'Position', [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.065], 'units', 'Normalized', ...
%             'Visible', 'off', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
%             'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], 'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 12);
%     end;
end;
colbar = colorbar(axescolbar, 'location', 'northoutside', 'Ticks', tickColor,...
         'TickLabels',tickSpeedTXT, 'color', [1 1 1], 'visible', 'off');
colbar.Label.String = 'Velocity (m/s)';
colbar.Label.FontSize = 12;
colbar.Label.FontWeight = 'bold';
colbar.Label.FontName = 'Antiqua';
colbar.Limits = [0 1];


stepCheck = 5



%---------------------Create SPARTA/LOCKER REPORT--------------------------
if Course == 25;
    metaData_PDF{1,1} = [num2str(RaceDist) 'm ' StrokeType ' (SCM)'];
else;
    metaData_PDF{1,1} = [num2str(RaceDist) 'm ' StrokeType ' (LCM)'];
end;
metaData_PDF{2,1} = DOB;
index = strfind(dataEC.venueName, '''');
if isempty(index) == 0;
    dataEC.venueName(index) = [];
end;
eval(['metaData_PDF{3,1} = ' '''' dataEC.venueName '''' ';']);
eval(['metaData_PDF{4,1} = ' '''' dataEC.enteredOn '''' ';']);
metaData_PDF{5,1} = FrameRate;
metaData_PDF{6,1} = 2; %Source
eval(['metaData_PDF{7,1} = ' '''' dataEC.date '''' ';']);

[dataTableAverage_PDF, dataTableBreath_PDF, avVELlap, avSRlap, avDPSlap, avVELRace, avSRRace, avDPSRace] = create_Averagetable_SP2Report_synchroniser(StrokeType, NbLap, RaceDist, ...
    Course, SplitsAll, FrameRate, DistanceINIBO, Time, Stroke_Frame, Breath_Frames, BOAllINI, Breakout);

[dataTableSkillTXT_PDF, dataTableSkillVAL_PDF] = create_skilltable_SP2Report_synchroniser(StrokeType, NbLap, RaceDist, ...
    Course, SplitsAll, BOAllINI, Year, TotalSkillTimeINI, Turn_TimeINI, Turn_TimeInINI, ...
    Turn_TimeOutINI, DiveT15INI, RT, KicksNb, BOEff, VelAfterBO, VelBeforeBO, Last5mINI, ...
    ApproachEff, ApproachSpeed2CycleAll, ApproachSpeedLastCycleAll, GlideLastStrokeEC, ...
    StartUWVelocity, StartEntryDist, StartUWDist, StartUWTime);

% 
% a=avVELlap
% b=avSRlap
% c=avDPSlap
% 
% d=avVELRace
% e=avSRRace
% f=avDPSRace
% 
% ee=ee
%--------------------------------------------------------------------------



            
%----------------------------------Store data------------------------------
uid = ['A' dataEC.uid 'A'];
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

if ispc == 1;
    index = strfind(fileECout, '\');
elseif ismac == 1;
    index = strfind(fileECout, '/');
end;
fnameout = fileECout(index(end)+1:end);
jsonfile = ['s3://sparta2-prod/sparta2-swims/' Year '/' competitionName '/' fnameout];

eval([uid '.Source = 2;']);
eval([uid '.RawBreath = Breath;']);
eval([uid '.RawDistance = Distance;']);
eval([uid '.RawDistanceINI = DistanceINI;']);
eval([uid '.DistanceINIBO = DistanceINIBO;']);
eval([uid '.RawBreakout = Breakout;']);
eval([uid '.RawVelocity = Velocity;']);
eval([uid '.RawVelocityRaw = VelocityRaw;']);
eval([uid '.RawVelocityTrend = VelocityTrend;']);
eval([uid '.RawVelocityINI = VelocityINI;']);
eval([uid '.RawKick = Kick;']);
eval([uid '.RawTime = Time;']);
eval([uid '.RawStroke = Stroke;']);

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
eval([uid '.AnalysisDate = ' '''' dataEC.enteredOn '''' ';']);
eval([uid '.RaceDate = ' '''' dataEC.date '''' ';']);
eval([uid '.Venue = ' '''' dataEC.venueName '''' ';']);
eval([uid '.NbLap = NbLap;']);
eval([uid '.Course = Course;']);
eval([uid '.RaceDist = RaceDist;']);
eval([uid '.FrameRate = FrameRate;']);
if strcmpi(valRelay, 'Flat') == 1;
    if strcmpi(StrokeType, 'Backstroke') == 1;
        if RT < 0.5;
            SplitsAll(1,2) = 0.6;
            SplitsAll(1,3) = roundn(SplitsAll(1,3) + ((0.6-RT)*FrameRate), 0);
            RT = 0.6;
        end;
    else;
        if RT < 0.56;
            SplitsAll(1,2) = 0.65;
            SplitsAll(1,3) = roundn(SplitsAll(1,3) + ((0.65-RT)*FrameRate), 0);
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

eval([uid '.TotalSkillTime = TotalSkillTime;']);
eval([uid '.TotalSkillTimeINI = TotalSkillTimeINI;']);
eval([uid '.DiveT15 = DiveT15;']);
eval([uid '.Last5m = Last5m;']);
eval([uid '.DiveT15INI = DiveT15INI;']);
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
eval([uid '.Turn_BODist = Turn_BODist;']);
eval([uid '.Turn_BODistINI = Turn_BODistINI;']);
eval([uid '.Turn_Time = Turn_Time;']);
eval([uid '.Turn_TimeIn = Turn_TimeIn;']);
eval([uid '.Turn_TimeOut = Turn_TimeOut;']);
eval([uid '.Turn_TimeINI = Turn_TimeINI;']);
eval([uid '.Turn_TimeInINI = Turn_TimeInINI;']);
eval([uid '.Turn_TimeOutINI = Turn_TimeOutINI;']);
eval([uid '.TurnsAv = TurnsAv;']);
eval([uid '.TurnsAvBODist = TurnsAvBODist;']);
eval([uid '.TurnsAvINI = TurnsAvINI;']);
eval([uid '.TurnsAvBODistINI = TurnsAvBODistINI;']);
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
            
            
race = race + 1;
format longG;
t = now;
DateString = datestr(datetime(t,'ConvertFrom','datenum'));



dataTableRefDist = [5:5:RaceDist]';
if RaceDist <= 100;
    colInterestVel = 3;
    colInterestSR = 6;
    colInterestDPS = 9;
else;
    colInterestVel = 4;
    colInterestSR = 7;
    colInterestDPS = 10;
end;


% avVELlap = [];
% avSRlap = [];
% avDPSlap = [];
% indexLapIni = 1;
% for lapEC = 1:NbLap;
%     indexLapEnd = find(dataTableRefDist == lapLim(lapEC));
%     
%     dataVel = dataTableAverage_PDF(indexLapIni:indexLapEnd, colInterestVel);
%     dataVel = cell2mat(dataVel);
%     indexNan = find(isnan(dataVel) == 1);
%     dataVel(indexNan) = [];
%     avVELlap = [avVELlap mean(dataVel)];
% 
%     dataSR = dataTableAverage_PDF(indexLapIni:indexLapEnd, colInterestSR);
%     dataSR = cell2mat(dataSR);
%     indexNan = find(isnan(dataSR) == 1);
%     dataSR(indexNan) = [];
%     avSRlap = [avSRlap mean(dataSR)];
% 
%     dataDPS = dataTableAverage_PDF(indexLapIni:indexLapEnd, colInterestDPS);
%     dataDPS = cell2mat(dataDPS);
%     indexNan = find(isnan(dataDPS) == 1);
%     dataDPS(indexNan) = [];
%     avDPSlap = [avDPSlap mean(dataDPS)];
% 
%     indexLapIni = indexLapEnd;
% end;
avVEL = roundn(avVELRace,-2); %mean(avVELlap);
avSR = roundn(avSRRace,-1); %mean(avSRlap);
avDPS = roundn(avDPSRace,-2); %mean(avDPSlap);
avSIlap = roundn([avVELlap.*avDPSlap],-2);
avSI = roundn([avVELRace.*avDPSRace],-2);

if isempty(uidDB_SP2) == 1
    uidDB_SP2{1,1} = dataEC.uid;
    uidDB_SP2{1,2} = FilenameNew;
    uidDB_SP2{1,3} = Athletename;
    uidDB_SP2{1,4} = num2str(RaceDist);
    uidDB_SP2{1,5} = StrokeType;
    uidDB_SP2{1,6} = Stage;
    uidDB_SP2{1,7} = Lane;
    uidDB_SP2{1,8} = Meet;
    uidDB_SP2{1,9} = Year;
    uidDB_SP2{1,10} = Gender;
    uidDB_SP2{1,11} = Course;
    uidDB_SP2{1,12} = SplitsAll(end,2);
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    uidDB_SP2{1,13} = [dataEC.videoId '_' Lane(5:end) '_' num2str(dataEC.relayLeg) '.json'];
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    uidDB_SP2{1,14} = txterror;
    uidDB_SP2{1,15} = dataEC.athleteId;
    uidDB_SP2{1,16} = dataEC.competitionId;
    uidDB_SP2{1,17} = BOEffCorr(1);
    uidDB_SP2{1,18} = TurnsAvBOEffCorr;
    uidDB_SP2{1,19} = avSI;
    uidDB_SP2{1,20} = avVEL;
    uidDB_SP2{1,21} = Country;
    uidDB_SP2{1,22} = SpeedDecaySprintRange;
    uidDB_SP2{1,23} = SpeedDecayRef;
    uidDB_SP2{1,24} = valRelay;
    uidDB_SP2{1,25} = detailRelay;
    uidDB_SP2{1,26} = 2;
    uidDB_SP2{1,27} = SpeedDecaySemiRange;
    uidDB_SP2{1,28} = SpeedDecayLongRange;
    uidDB_SP2{1,29} = SpeedDecaySprintMid;
    uidDB_SP2{1,30} = SpeedDecaySemiMid;
    uidDB_SP2{1,31} = SpeedDecayLongMid;
    uidDB_SP2{1,32} = filenameDBout;
    uidDB_SP2{1,33} = jsonfile;
    uidDB_SP2{1,34} = DateString; %always last column
    
else;

    if strcmpi(source, 'New') == 1;
        li = length(uidDB_SP2(:,1))+1;
    else;
        li = selectfiles(count)-1;
    end;

    uidDB_SP2{li,1} = dataEC.uid;
    uidDB_SP2{li,2} = FilenameNew;
    uidDB_SP2{li,3} = Athletename;
    uidDB_SP2{li,4} = num2str(RaceDist);
    uidDB_SP2{li,5} = StrokeType;
    uidDB_SP2{li,6} = Stage;
    uidDB_SP2{li,7} = Lane;
    uidDB_SP2{li,8} = Meet;
    uidDB_SP2{li,9} = Year;
    uidDB_SP2{li,10} = Gender;
    uidDB_SP2{li,11} = Course;
    uidDB_SP2{li,12} = SplitsAll(end,2);
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    uidDB_SP2{li,13} = [dataEC.videoId '_' Lane(5:end) '_' num2str(dataEC.relayLeg) '.json'];
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    uidDB_SP2{li,14} = txterror;
    uidDB_SP2{li,15} = dataEC.athleteId;
    uidDB_SP2{li,16} = dataEC.competitionId;
    uidDB_SP2{li,17} = BOEffCorr(1);
    uidDB_SP2{li,18} = TurnsAvBOEffCorr;
    uidDB_SP2{li,19} = avSI;
    uidDB_SP2{li,20} = avVEL;
    uidDB_SP2{li,21} = Country;
    uidDB_SP2{li,22} = SpeedDecaySprintRange;
    uidDB_SP2{li,23} = SpeedDecayRef;
    uidDB_SP2{li,24} = valRelay;
    uidDB_SP2{li,25} = detailRelay;
    uidDB_SP2{li,26} = 2;
    uidDB_SP2{li,27} = SpeedDecaySemiRange;
    uidDB_SP2{li,28} = SpeedDecayLongRange;
    uidDB_SP2{li,29} = SpeedDecaySprintMid;
    uidDB_SP2{li,30} = SpeedDecaySemiMid;
    uidDB_SP2{li,31} = SpeedDecayLongMid;
    uidDB_SP2{li,32} = filenameDBout;
    uidDB_SP2{li,33} = jsonfile;
    uidDB_SP2{li,34} = DateString; %always last column
end;

if strcmpi(StrokeType, 'Butterfly');
    if RaceDist == 50;
        target = 1;
    elseif RaceDist == 100;
        target = 2;
    elseif RaceDist == 200;
        target = 3;
    end;
elseif strcmpi(StrokeType, 'Backstroke');
    if RaceDist == 50;
        target = 4;
    elseif RaceDist == 100;
        target = 5;
    elseif RaceDist == 200;
        target = 6;
    end;
elseif strcmpi(StrokeType, 'Breaststroke');
    if RaceDist == 50;
        target = 7;
    elseif RaceDist == 100;
        target = 8;
    elseif RaceDist == 200;
        target = 9;
    end;
elseif strcmpi(StrokeType, 'Freestyle');
    if RaceDist == 50;
        target = 10;
    elseif RaceDist == 100;
        target = 11;
    elseif RaceDist == 200;
        target = 12;
    elseif RaceDist == 400;
        target = 13;
    elseif RaceDist == 800;
        target = 14;
    elseif RaceDist == 1500;
        target = 15;
    end;
elseif strcmpi(StrokeType, 'Medley');
    if RaceDist == 100;
        target = 16;
    elseif RaceDist == 150;
        target = 17;
    elseif RaceDist == 200;
        target = 18;
    elseif RaceDist == 400;
        target = 19;
    end;
end;
if isempty(FullDB_SP2) == 1
    FullDB_SP2{1,1} = 'File';
    FullDB_SP2{1,2} = 'Name';
    FullDB_SP2{1,3} = 'Distance';
    FullDB_SP2{1,4} = 'Stroke';
    FullDB_SP2{1,5} = 'Gender';
    FullDB_SP2{1,6} = 'Round';
    FullDB_SP2{1,7} = 'Meet';
    FullDB_SP2{1,8} = 'Year';
    FullDB_SP2{1,9} = 'Lane';
    FullDB_SP2{1,10} = 'Course';
    FullDB_SP2{1,11} = 'Type';
    FullDB_SP2{1,12} = 'Category';
    FullDB_SP2{1,13} = 'DOB';
    FullDB_SP2{1,14} = 'Race Time';
    FullDB_SP2{1,15} = 'Skills (s)';
    FullDB_SP2{1,16} = 'Free Swim (s)';
    FullDB_SP2{1,17} = 'Drop-off (s)';
    FullDB_SP2{1,18} = 'Speed (Av./Max.) (m/s)';
    FullDB_SP2{1,19} = 'Av. SR (Av./Max.) (str/min)';
    FullDB_SP2{1,20} = 'Av. DPS (Av./Max.) (m)';
    FullDB_SP2{1,21} = 'Block (s)';
    FullDB_SP2{1,22} = 'Start (s)';
    FullDB_SP2{1,23} = 'Entry Dist (m)';
    FullDB_SP2{1,24} = 'Start UW. Speed (m/s)';
    FullDB_SP2{1,25} = 'Start BO. Dist (m) (Kicks)';
    FullDB_SP2{1,26} = 'Start BO. Skill (%)';
    FullDB_SP2{1,27} = 'Av. Turn (s) [in / out]';
    FullDB_SP2{1,28} = 'Turn App. Skill (%)';
    FullDB_SP2{1,29} = 'Turn BO. Dist (m) (Av. Kicks)';
    FullDB_SP2{1,30} = 'Turn BO. Skill (%)';
    FullDB_SP2{1,31} = 'Av. Stroke Index (m2/s/str)';
    FullDB_SP2{1,32} = 'Av. Swimming Speed (m/s)';
    FullDB_SP2{1,33} = 'Av. Stroke Rate (str/min)';
    FullDB_SP2{1,34} = 'Av. DPS (m)';
    FullDB_SP2{1,35} = 'Country';
    FullDB_SP2{1,36} = 'MeetID';
    FullDB_SP2{1,37} = 'AV. Turn In (s)';
    FullDB_SP2{1,38} = 'AV. Turn Out (s)';
    FullDB_SP2{1,39} = 'AV. Turn Tot (s)';
    FullDB_SP2{1,40} = 'AthleteID';
    FullDB_SP2{1,41} = 'Finish Time (s)';
    FullDB_SP2{1,42} = 'Speed Decay (% of time)';
    FullDB_SP2{1,43} = 'Speed Decay Ref (50% Max Speed)';
    FullDB_SP2{1,44} = 'Dist App (m)';
    FullDB_SP2{1,45} = 'Time App (s)';
    FullDB_SP2{1,46} = 'Eff App (%)';
    FullDB_SP2{1,47} = 'SI per lap';
    FullDB_SP2{1,48} = 'Speed per lap';
    FullDB_SP2{1,49} = 'SR per lap';
    FullDB_SP2{1,50} = 'DPS per lap';
    FullDB_SP2{1,51} = 'Splits per lap';
    FullDB_SP2{1,52} = 'All Turns';
    FullDB_SP2{1,53} = 'Relay Type';
    FullDB_SP2{1,54} = 'All turn UW. Speed (m/s)';
    FullDB_SP2{1,55} = 'Av turn UW. Speed (m/s)';
    FullDB_SP2{1,56} = 'Analysis Date';
    FullDB_SP2{1,57} = 'Race Date';
    FullDB_SP2{1,58} = 'Source';
    FullDB_SP2{1,59} = 'SpeedDecaySemiRange';
    FullDB_SP2{1,60} = 'SpeedDecayLongRange';
    FullDB_SP2{1,61} = 'SpeedDecaySprintMid';
    FullDB_SP2{1,62} = 'SpeedDecaySemiMid';
    FullDB_SP2{1,63} = 'SpeedDecayLongMid';
    FullDB_SP2{1,64} = 'Kick Count';
    FullDB_SP2{1,65} = 'JSON file';
    FullDB_SP2{1,66} = 'Data file';
    FullDB_SP2{1,67} = 'Metadata_PDF';
    FullDB_SP2{1,68} = 'Data averages PDF';
    FullDB_SP2{1,69} = 'Data breath PDF';
    FullDB_SP2{1,70} = 'Data skills VAL PDF';
    FullDB_SP2{1,71} = 'Data skills TXT PDF';


    FullDB_SP2{2,1} = dataEC.uid;
    FullDB_SP2{2,2} = AthletenameFull;
    FullDB_SP2{2,3} = num2str(RaceDist);
    FullDB_SP2{2,4} = StrokeType;
    FullDB_SP2{2,5} = Gender;
    FullDB_SP2{2,6} = Stage;
    FullDB_SP2{2,7} = Meet;
    FullDB_SP2{2,8} = Year;
    FullDB_SP2{2,9} = Lane;
    FullDB_SP2{2,10} = num2str(Course);
    FullDB_SP2{2,11} = valRelay; %relayleg;
    FullDB_SP2{2,12} = Paralympic;
    FullDB_SP2{2,13} = DOB; %AgeGroupVal
    FullDB_SP2{2,14} = timeSecToStr(SplitsAll(end,2));
%     FullDB_SP2{2,15} = timeSecToStr(TotalSkillTime);
    FullDB_SP2{2,15} = timeSecToStr(TotalSkillTimeINI);
%     FullDB_SP2{2,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTime,-2));
    FullDB_SP2{2,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2));
    FullDB_SP2{2,17} = TimeDropOff;
    FullDB_SP2{2,18} = MaxVelString;
    FullDB_SP2{2,19} = MaxSR;
    FullDB_SP2{2,20} = MaxDPS;
    FullDB_SP2{2,21} = dataToStr(RT,2);
%     FullDB_SP2{2,22} = dataToStr(DiveT15);
    FullDB_SP2{2,22} = dataToStr(DiveT15INI,2);
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    if isempty(StartEntryDist) == 1;
        FullDB_SP2{2,23} = 'na'; %Entry
        FullDB_SP2{2,24} = 'na'; %UW Speed
    else;
        FullDB_SP2{2,23} = dataToStr(StartEntryDist,2); %Entry
        FullDB_SP2{2,24} = dataToStr(StartUWVelocity,2); %UW Speed
    end;
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%     FullDB{2,25} = dataToStr(roundn(BOAll(1,3),-2));
    if isempty(KicksNb) == 0;
        if KicksNb(1) == 0;
            FullDB_SP2{2,25} = [dataToStr(BOAllINI(1,3),1) '  (na)'];
        else;
            KickTXT = num2str(KicksNb(1));
            FullDB_SP2{2,25} = [dataToStr(BOAllINI(1,3),1) '  (' KickTXT ' kicks)'];
        end;
    else;
        FullDB_SP2{2,25} = [dataToStr(BOAllINI(1,3),1) '  (na)'];
    end;
    val1 = dataToStr(BOEff(1).*100,1);
    val2 = dataToStr(VelBeforeBO(1), 2);
    val3 = dataToStr(VelAfterBO(1), 2);
    val4 = dataToStr(BOEffCorr(1).*100, 1);    
    FullDB_SP2{2,26} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
%     FullDB_SP2{2,27} = Turn_TimeTXT;
    FullDB{2,27} = Turn_TimeTXTINI;
    val1 = dataToStr(mean(ApproachEff(1:end)).*100,1);
    val2 = dataToStr(mean(ApproachSpeed2CycleAll(1:end)),2);
    val3 = dataToStr(mean(ApproachSpeedLastCycleAll(1:end)),2);
    FullDB_SP2{2,28} = [val1 '  [' val2 ' / ' val3 ']'];
%     FullDB_SP2{2,29} = Turn_BODistTXT;

    if Course == 50;
        if RaceDist == 50;
            FullDB_SP2{2,29} = [Turn_BODistTXTINI '  (na)'];
        else;
            if isempty(KicksNb) == 0
                if roundn(mean(KicksNb(2:end)),0) == 0;
                    FullDB_SP2{2,29} = [Turn_BODistTXTINI '  (na)'];
                else;
                    KickTXT = num2str(roundn(mean(KicksNb(2:end)),0));
                    FullDB_SP2{2,29} = [Turn_BODistTXTINI '  (' KickTXT ' kicks)'];
                end;
            else;
                FullDB_SP2{2,29} = [Turn_BODistTXTINI '  (na)'];
            end;
        end;
    else
        if isempty(KicksNb) == 0
            if roundn(mean(KicksNb(2:end)),0) == 0;
                FullDB_SP2{2,29} = [Turn_BODistTXTINI '  (na)'];
            else;
                KickTXT = num2str(roundn(mean(KicksNb(2:end)),0));
                FullDB_SP2{2,29} = [Turn_BODistTXTINI '  (' KickTXT ' kicks)'];
            end;
        else;
            FullDB_SP2{2,29} = [Turn_BODistTXTINI '  (na)'];
        end;
    end;

    val1 = dataToStr(mean(BOEff(2:end)).*100,1);
    val2 = dataToStr(mean(VelBeforeBO(2:end)),2);
    val3 = dataToStr(mean(VelAfterBO(2:end)),2);
    val4 = dataToStr(mean(BOEffCorr(2:end).*100),2);
    FullDB{2,30} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
    FullDB_SP2{2,31} = dataToStr(avSI,2);
    FullDB_SP2{2,32} = dataToStr(avVEL,2);
    FullDB_SP2{2,33} = dataToStr(avSR,1);
    FullDB_SP2{2,34} = dataToStr(avDPS,2);
    FullDB_SP2{2,35} = Country;
    FullDB_SP2{2,36} = ['A' num2str(dataEC.competitionId) '_' Year 'A'];
    FullDB_SP2{2,37} = dataToStr(TurnsAvINI(1,1),2);
    FullDB_SP2{2,38} = dataToStr(TurnsAvINI(1,2),2);
    FullDB_SP2{2,39} = dataToStr(TurnsAvINI(1,3),2);
    FullDB_SP2{2,40} = dataEC.athleteId;
    FullDB_SP2{2,41} = Last5mINI;
    FullDB_SP2{2,42} = SpeedDecaySprintRange;
    FullDB_SP2{2,43} = SpeedDecayRef;
    FullDB_SP2{2,44} = GlideLastStrokeEC(3,end);
    FullDB_SP2{2,45} = GlideLastStrokeEC(4,end);
    FullDB_SP2{2,46} = ApproachEff(1,end);
    FullDB_SP2{2,47} = avSIlap;
    FullDB_SP2{2,48} = avVELlap;
    FullDB_SP2{2,49} = avSRlap;
    FullDB_SP2{2,50} = avDPSlap;
    SplitsLap = [];
    for lap = 2:length(SplitsAll(:,2));
        if lap == 2;
            SplitsLap(lap) = SplitsAll(lap,2);
        else;
            SplitsLap(lap) = SplitsAll(lap,2) - SplitsAll(lap-1,2);
        end;
    end;
    FullDB_SP2{2,51} = SplitsLap;
    FullDB_SP2{2,52} = Turn_Time;
    FullDB_SP2{2,53} = detailRelay;
    FullDB_SP2{2,54} = TurnUWVelocity;
    FullDB_SP2{2,55} = mean(TurnUWVelocity);
    FullDB_SP2{2,56} = dataEC.enteredOn;
    FullDB_SP2{2,57} = dataEC.date;
    FullDB_SP2{2,58} = 2;
    FullDB_SP2{2,59} = SpeedDecaySemiRange;
    FullDB_SP2{2,60} = SpeedDecayLongRange;
    FullDB_SP2{2,61} = SpeedDecaySprintMid;
    FullDB_SP2{2,62} = SpeedDecaySemiMid;
    FullDB_SP2{2,63} = SpeedDecayLongMid;
    FullDB_SP2{2,64} = KicksNb;
    FullDB_SP2{2,65} = filenameDBout;
    FullDB_SP2{2,66} = jsonfile;
    FullDB_SP2{2,67} = metaData_PDF;
    FullDB_SP2{2,68} = dataTableAverage_PDF;
    FullDB_SP2{2,69} = dataTableBreath_PDF;
    FullDB_SP2{2,70} = dataTableSkillVAL_PDF;
    FullDB_SP2{2,71} = dataTableSkillTXT_PDF;


    %look for PBs;
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,1) = ones(19,1).*10000;']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,2) = ones(19,1).*10000;']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,3) = ones(19,1).*10000;']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,4) = ones(19,1).*10000;']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,5) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,6) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,7) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,8) = ones(19,1).*10000;']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,9) = ones(19,1).*10000;']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,10) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,11) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,12) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,13) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,14) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,15) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,16) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,17) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,18) = zeros(19,1);']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,19) = ones(19,1).*10000;']);
%     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,20) = zeros(19,1);']);
%     
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,1) = ones(19,1).*10000;']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,2) = ones(19,1).*10000;']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,3) = ones(19,1).*10000;']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,4) = ones(19,1).*10000;']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,5) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,6) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,7) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,8) = ones(19,1).*10000;']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,9) = ones(19,1).*10000;']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,10) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,11) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,12) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,13) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,14) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,15) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,16) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,17) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,18) = zeros(19,1);']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,19) = ones(19,1).*10000;']);
%     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,21) = zeros(19,1);']);
%     
%     if strfind(valRelay, 'Flat') == 1;
%         if Course == 50;
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',1) = ' num2str(SplitsAll(end,2)) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',2) = ' num2str(TotalSkillTimeINI) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',3) = ' num2str(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2)) ';']);
%             if isempty(DropOff) == 1;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(10000) ';']);
%             else;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(DropOff) ';']);
%             end;
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',5) = ' num2str(MaxVelDouble) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',6) = ' num2str(MaxSRDouble) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',7) = ' num2str(MaxDPSDouble) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',8) = ' num2str(RT) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',9) = ' num2str(DiveT15INI) ';']);
%             if isempty(StartEntryDist) == 1;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(0) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(0) ';']);
%             else;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(StartEntryDist) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(StartUWVelocity) ';']);
%             end;
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',12) = ' num2str(roundn(BOAllINI(1,3),-2)) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',13) = ' num2str(roundn(BOEff(1).*100,-2)) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',14) = ' num2str(roundn(mean(ApproachEff(1:end)).*100,-2)) ';']);
%             if isempty(Turn_BODist) == 1;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(0) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(-10000) ';']);
%             else;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(roundn(mean(Turn_BODistINI),-2)) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(roundn(mean(TurnsAvBOEff).*100,-2)) ';']);
%             end;
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',17) = ' num2str(roundn(avSI, -2)) ';']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',18) = ' num2str(roundn(avVEL, -2)) ';']);
%             if isempty(Turn_BODist) == 1;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(10000) ';']);
%             else;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(roundn(TurnsAvINI(1,3),-2)) ';']);
%             end;
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',20) = ' num2str(roundn(mean(SpeedDecayRef), -2)) ';']);
% 
%         else;
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',1) = ' num2str(SplitsAll(end,2)) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',2) = ' num2str(TotalSkillTimeINI) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',3) = ' num2str(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2)) ';']);
%             if isempty(DropOff) == 1;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(10000) ';']);
%             else;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(DropOff) ';']);
%             end;
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',5) = ' num2str(MaxVelDouble) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',6) = ' num2str(MaxSRDouble) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',7) = ' num2str(MaxDPSDouble) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',8) = ' num2str(RT) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',9) = ' num2str(DiveT15INI) ';']);
%             if isempty(StartEntryDist) == 1;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(0) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(0) ';']);
%             else;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(StartEntryDist) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(StartUWVelocity) ';']);
%             end;
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',12) = ' num2str(roundn(BOAllINI(1,3),-2)) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',13) = ' num2str(roundn(BOEff(1).*100,-2)) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',14) = ' num2str(roundn(mean(ApproachEff(1:end)).*100,-2)) ';']);
%             if isempty(Turn_BODist) == 1;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(0) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(-10000) ';']);
%             else;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(roundn(mean(Turn_BODistINI),-2)) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(roundn(mean(TurnsAvBOEff).*100,-2)) ';']);
%             end;
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',17) = ' num2str(roundn(avSI, -2)) ';']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',18) = ' num2str(roundn(avVEL, -2)) ';']);
%             if isempty(Turn_BODist) == 1;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(10000) ';']);
%             else;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(roundn(TurnsAvINI(1,3),-2)) ';']);
%             end;
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',20) = ' num2str(roundn(mean(SpeedDecayRef), -2)) ';']);
%         end;
%     end;

    %look for AgeGroup
    eval(['AgeGroup_SP2.A' num2str(dataEC.competitionId) '_' Year 'A = ' '''' dataEC.date '''' ';']);

else;
    if strcmpi(source, 'New') == 1;
        li = length(FullDB_SP2(:,1))+1;
    else;
        li = selectfiles(count);
    end;

    FullDB_SP2{li,1} = dataEC.uid;
    FullDB_SP2{li,2} = AthletenameFull;
    FullDB_SP2{li,3} = num2str(RaceDist);
    FullDB_SP2{li,4} = StrokeType;
    FullDB_SP2{li,5} = Gender;
    FullDB_SP2{li,6} = Stage;
    FullDB_SP2{li,7} = Meet;
    FullDB_SP2{li,8} = Year;
    FullDB_SP2{li,9} = Lane;
    FullDB_SP2{li,10} = num2str(Course);
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    FullDB_SP2{li,11} = valRelay;
    FullDB_SP2{li,12} = Paralympic;
    FullDB_SP2{li,13} = DOB;
    FullDB_SP2{li,14} = timeSecToStr(SplitsAll(end,2));
%     FullDB_SP2{li,15} = timeSecToStr(TotalSkillTime);
    FullDB_SP2{li,15} = timeSecToStr(TotalSkillTimeINI);
%     FullDB_SP2{li,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTime,-2));
    FullDB_SP2{li,16} = timeSecToStr(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2));
    FullDB_SP2{li,17} = TimeDropOff;
    FullDB_SP2{li,18} = MaxVelString;
    FullDB_SP2{li,19} = MaxSR;
    FullDB_SP2{li,20} = MaxDPS;
    FullDB_SP2{li,21} = dataToStr(RT,2);
%     FullDB_SP2{li,22} = dataToStr(DiveT15);
    FullDB_SP2{li,22} = dataToStr(DiveT15INI,2);
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
    if isempty(StartEntryDist) == 1;
        FullDB_SP2{li,23} = 'na'; %Entry
        FullDB_SP2{li,24} = 'na'; %UW Speed
    else;
        FullDB_SP2{li,23} = dataToStr(StartEntryDist,2); %Entry
        FullDB_SP2{li,24} = dataToStr(StartUWVelocity,2); %UW Speed
    end;
%     ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%     FullDB{li,25} = dataToStr(roundn(BOAll(1,3),-2));
    if isempty(KicksNb) == 0;
        if KicksNb(1) == 0;
            FullDB_SP2{li,25} = [dataToStr(BOAllINI(1,3),1) '  (na)'];
        else;
            KickTXT = num2str(KicksNb(1));
            FullDB_SP2{li,25} = [dataToStr(BOAllINI(1,3),1) '  (' KickTXT ' kicks)'];
        end;
    else;
        FullDB_SP2{li,25} = [dataToStr(BOAllINI(1,3),1) '  (na)'];
    end;
    val1 = dataToStr(BOEff(1).*100,1);
    val2 = dataToStr(VelBeforeBO(1),2);
    val3 = dataToStr(VelAfterBO(1),2);
    val4 = dataToStr(BOEffCorr(1).*100,1);    
    FullDB_SP2{li,26} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
%     FullDB_SP2{li,27} = Turn_TimeTXT;
    FullDB_SP2{li,27} = Turn_TimeTXTINI;
    val1 = dataToStr(mean(ApproachEff(1:end)).*100,1);
    val2 = dataToStr(mean(ApproachSpeed2CycleAll(1:end)),2);
    val3 = dataToStr(mean(ApproachSpeedLastCycleAll(1:end)),2);
    FullDB_SP2{li,28} = [val1 '  [' val2 ' / ' val3 ']'];
%     FullDB_SP2{li,29} = Turn_BODistTXT;
    


stepCheck = 7

    if Course == 50;
        if RaceDist == 50;
            FullDB_SP2{li,29} = [Turn_BODistTXTINI '  (na)'];
        else;
            if isempty(KicksNb) == 0
                if roundn(mean(KicksNb(2:end)),0) == 0;
                    FullDB_SP2{li,29} = [Turn_BODistTXTINI '  (na)'];
                else;
                    KickTXT = num2str(roundn(mean(KicksNb(2:end)),0));
                    FullDB_SP2{li,29} = [Turn_BODistTXTINI '  (' KickTXT ' kicks)'];
                end;
            else;
                FullDB_SP2{li,29} = [Turn_BODistTXTINI '  (na)'];
            end;
        end;
    else
        if isempty(KicksNb) == 0
            if roundn(mean(KicksNb(2:end)),0) == 0;
                FullDB_SP2{li,29} = [Turn_BODistTXTINI '  (na)'];
            else;
                KickTXT = num2str(roundn(mean(KicksNb(2:end)),0));
                FullDB_SP2{li,29} = [Turn_BODistTXTINI '  (' KickTXT ' kicks)'];
            end;
        else;
            FullDB_SP2{li,29} = [Turn_BODistTXTINI '  (na)'];
        end;
    end;
    
    val1 = dataToStr(mean(BOEff(2:end)).*100,1);
    val2 = dataToStr(mean(VelBeforeBO(2:end)),2);
    val3 = dataToStr(mean(VelAfterBO(2:end)),2);
    val4 = dataToStr(mean(BOEffCorr(2:end).*100),1);
    FullDB_SP2{li,30} = [val1 '  [' val2 '/' val3 '/' val4 ']'];
    FullDB_SP2{li,31} = dataToStr(avSI,2);
    FullDB_SP2{li,32} = dataToStr(avVEL,2);
    FullDB_SP2{li,33} = dataToStr(avSR,1);
    FullDB_SP2{li,34} = dataToStr(avDPS,2);
    FullDB_SP2{li,35} = Country;  
    FullDB_SP2{li,36} = ['A' num2str(dataEC.competitionId) '_' Year 'A'];
    FullDB_SP2{li,37} = dataToStr(TurnsAvINI(1,1),2);
    FullDB_SP2{li,38} = dataToStr(TurnsAvINI(1,2),2);
    FullDB_SP2{li,39} = dataToStr(TurnsAvINI(1,3),2);
    FullDB_SP2{li,40} = dataEC.athleteId;
    FullDB_SP2{li,41} = Last5mINI;
    FullDB_SP2{li,42} = SpeedDecaySprintRange;
    FullDB_SP2{li,43} = SpeedDecayRef;
    FullDB_SP2{li,44} = GlideLastStrokeEC(3,end);
    FullDB_SP2{li,45} = GlideLastStrokeEC(4,end);
    FullDB_SP2{li,46} = ApproachEff(1,end);
    FullDB_SP2{li,47} = avSIlap;
    FullDB_SP2{li,48} = avVELlap;
    FullDB_SP2{li,49} = avSRlap;
    FullDB_SP2{li,50} = avDPSlap;
    for lap = 2:length(SplitsAll(:,2));
        if lap == 2;
            SplitsLap(lap) = SplitsAll(lap,2);
        else;
            SplitsLap(lap) = SplitsAll(lap,2) - SplitsAll(lap-1,2);
        end;
    end;
    SplitsLap = SplitsLap(2:end);
    FullDB_SP2{li,51} = SplitsLap;
    FullDB_SP2{li,52} = Turn_Time;
    FullDB_SP2{li,53} = detailRelay;
    FullDB_SP2{li,54} = TurnUWVelocity;
    FullDB_SP2{li,55} = mean(TurnUWVelocity);
    FullDB_SP2{li,56} = dataEC.enteredOn;
    FullDB_SP2{li,57} = dataEC.date;
    FullDB_SP2{li,58} = 2;
    FullDB_SP2{li,59} = SpeedDecaySemiRange;
    FullDB_SP2{li,60} = SpeedDecayLongRange;
    FullDB_SP2{li,61} = SpeedDecaySprintMid;
    FullDB_SP2{li,62} = SpeedDecaySemiMid;
    FullDB_SP2{li,63} = SpeedDecayLongMid;
    FullDB_SP2{li,64} = KicksNb;
    FullDB_SP2{li,65} = filenameDBout;
    FullDB_SP2{li,66} = jsonfile;
    FullDB_SP2{li,67} = metaData_PDF;
    FullDB_SP2{li,68} = dataTableAverage_PDF;
    FullDB_SP2{li,69} = dataTableBreath_PDF;
    FullDB_SP2{li,70} = dataTableSkillVAL_PDF;
    FullDB_SP2{li,71} = dataTableSkillTXT_PDF;

    stepCheck = 8





    %look for PBs;
%     if strfind(valRelay, 'Flat') == 1;
%         if Course == 50;
%             existathlete = isfield(PBsDB, ['A' num2str(dataEC.athleteId) 'A']);
%             if existathlete == 0;
%                 %add new athlete's PBs
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,1) = ones(19,1).*10000;']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,2) = ones(19,1).*10000;']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,3) = ones(19,1).*10000;']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,4) = ones(19,1).*10000;']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,5) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,6) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,7) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,8) = ones(19,1).*10000;']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,9) = ones(19,1).*10000;']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,10) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,11) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,12) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,13) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,14) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,15) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,16) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,17) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,18) = zeros(19,1);']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,19) = ones(19,1).*10000;']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,20) = zeros(19,1);']);
% 
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',1) = ' num2str(SplitsAll(end,2)) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',2) = ' num2str(TotalSkillTimeINI) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',3) = ' num2str(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2)) ';']);
%                 if isempty(DropOff) == 1;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(10000) ';']);
%                 else;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(DropOff) ';']);
%                 end;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',5) = ' num2str(MaxVelDouble) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',6) = ' num2str(MaxSRDouble) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',7) = ' num2str(MaxDPSDouble) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',8) = ' num2str(RT) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',9) = ' num2str(DiveT15INI) ';']);
%         %         ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%                 if isempty(StartEntryDist) == 1;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(0) ';']);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(0) ';']);
%                 else;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(StartEntryDist) ';']);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(StartUWVelocity) ';']);
%                 end;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',12) = ' num2str(roundn(BOAllINI(1,3),-2)) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',13) = ' num2str(roundn(BOEff(1).*100,-2)) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',14) = ' num2str(roundn(mean(ApproachEff(1:end)).*100,-2)) ';']);
%                 if isempty(Turn_BODist) == 1;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(0) ';']);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(-10000) ';']);
%                 else;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(roundn(mean(Turn_BODistINI),-2)) ';']);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(roundn(mean(TurnsAvBOEff).*100,-2)) ';']);
%                 end;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',17) = ' num2str(roundn(avSI, -2)) ';']);
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',18) = ' num2str(roundn(avVEL, -2)) ';']);
%                 if isempty(Turn_BODist) == 1;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(10000) ';']);
%                 else;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(roundn(TurnsAvINI(1,3),-2)) ';']);
%                 end;
%                 eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',20) = ' num2str(roundn(mean(SpeedDecaySprintRange), -2)) ';']);
%                 
%             else;
%                 %Athlete exists
%                 eval(['checkfile = PBsDB.A' num2str(dataEC.athleteId) 'A;']);
%                 [li, co] = size(checkfile);
%                 if li < 19 | co < 19;
%                     fullfile(:,1) = ones(19,1).*10000;
%                     fullfile(:,2) = ones(19,1).*10000;
%                     fullfile(:,3) = ones(19,1).*10000;
%                     fullfile(:,4) = ones(19,1).*10000;
%                     fullfile(:,5) = zeros(19,1);
%                     fullfile(:,6) = zeros(19,1);
%                     fullfile(:,7) = zeros(19,1);
%                     fullfile(:,8) = ones(19,1).*10000;
%                     fullfile(:,9) = ones(19,1).*10000;
%                     fullfile(:,10) = zeros(19,1);
%                     fullfile(:,11) = zeros(19,1);
%                     fullfile(:,12) = zeros(19,1);
%                     fullfile(:,13) = zeros(19,1);
%                     fullfile(:,14) = zeros(19,1);
%                     fullfile(:,15) = zeros(19,1);
%                     fullfile(:,16) = zeros(19,1);
%                     fullfile(:,17) = zeros(19,1);
%                     fullfile(:,18) = zeros(19,1);
%                     fullfile(:,19) = ones(19,1).*10000;
%                     fullfile(:,20) = zeros(19,1);
%                 
%                     [indexL, indexC] = find(checkfile ~= 0 & checkfile ~= 10000);
%                     for rep = 1:length(indexL);
%                        fullfile(indexL(rep), indexC(rep)) = checkfile(indexL(rep), indexC(rep));
%                     end;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A = fullfile;']);
%                 end;
%                 
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',1);']);
%                 if check > SplitsAll(end,2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',1) = ' num2str(SplitsAll(end,2)) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',2);']);
%                 if check > TotalSkillTimeINI;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',2) = ' num2str(TotalSkillTimeINI) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',3);']);
%                 if check > roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',3) = ' num2str(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2)) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4);']);
%                 if isempty(DropOff) == 0;
%                     if check > DropOff;
%                         eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(DropOff) ';']);
%                     end;
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',5);']);
%                 if check < MaxVelDouble;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',5) = ' num2str(MaxVelDouble) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',6);']);
%                 if check < MaxSRDouble;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',6) = ' num2str(MaxSRDouble) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',7);']);
%                 if check < MaxDPSDouble;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',7) = ' num2str(MaxDPSDouble) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',8);']);
%                 if check > RT;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',8) = ' num2str(RT) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',9);']);
%                 if check > DiveT15INI;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',9) = ' num2str(DiveT15INI) ';']);
%                 end;
%         %         ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%                 if isempty(StartEntryDist) == 0;
%                     eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10);']);
%                     if check < StartEntryDist;
%                         eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(StartEntryDist) ';']);
%                     end;
%                     eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11);']);
%                     if check < StartUWVelocity;
%                         eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(StartUWVelocity) ';']);
%                     end;
%                 end;
%         %         ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',12);']);
%                 if check < roundn(BOAllINI(1,3),-2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',12) = ' num2str(roundn(BOAllINI(1,3),-2)) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',13);']);
%                 if check < roundn(BOEff(1).*100,-2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',13) = ' num2str(roundn(BOEff(1).*100,-2)) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',14);']);
%                 if check < roundn(mean(ApproachEff(1:end)).*100,-2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',14) = ' num2str(roundn(mean(ApproachEff(1:end)).*100,-2)) ';']);
%                 end;
%                 if isempty(Turn_BODist) == 0;
%                     eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15);']);
%                     if check < roundn(mean(Turn_BODistINI),-2);
%                         eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(roundn(mean(Turn_BODistINI),-2)) ';']);
%                     end;
%                     eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16);']);
%                     if check < roundn(mean(TurnsAvBOEff).*100,-2);
%                         eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(roundn(mean(TurnsAvBOEff).*100,-2)) ';']);
%                     end;
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',17);']);
%                 if check < roundn(avSI, -2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',17) = ' num2str(roundn(avSI, -2)) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',18);']);
%                 if check < roundn(avVEL, -2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',18) = ' num2str(roundn(avVEL, -2)) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19);']);
%                 if check > roundn(TurnsAvINI(1,3),-2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(roundn(TurnsAvINI(1,3), -2)) ';']);
%                 end;
%                 eval(['check = PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',20);']);
%                 if check < roundn(mean(SpeedDecaySprintRange), -2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',20) = ' num2str(roundn(mean(SpeedDecaySprint), -2)) ';']);
%                 end;
%             end;
%         else;
%             existathlete = isfield(PBsDB_SC, ['A' num2str(dataEC.athleteId) 'A']);
%             if existathlete == 0;
%                 %add new athlete's PBs_SC
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,1) = ones(19,1).*10000;']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,2) = ones(19,1).*10000;']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,3) = ones(19,1).*10000;']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,4) = ones(19,1).*10000;']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,5) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,6) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,7) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,8) = ones(19,1).*10000;']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,9) = ones(19,1).*10000;']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,10) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,11) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,12) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,13) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,14) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,15) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,16) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,17) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,18) = zeros(19,1);']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,19) = ones(19,1).*10000;']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,20) = zeros(19,1);']);
%                 
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',1) = ' num2str(SplitsAll(end,2)) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',2) = ' num2str(TotalSkillTimeINI) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',3) = ' num2str(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2)) ';']);
%                 if isempty(DropOff) == 1;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(10000) ';']);
%                 else;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(DropOff) ';']);
%                 end;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',5) = ' num2str(MaxVelDouble) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',6) = ' num2str(MaxSRDouble) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',7) = ' num2str(MaxDPSDouble) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',8) = ' num2str(RT) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',9) = ' num2str(DiveT15INI) ';']);
%         %         ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%                 if isempty(StartEntryDist) == 1;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(0) ';']);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(0) ';']);
%                 else;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(StartEntryDist) ';']);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(StartUWVelocity) ';']);
%                 end;
%         %         ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',12) = ' num2str(roundn(BOAllINI(1,3),-2)) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',13) = ' num2str(roundn(BOEff(1).*100,-2)) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',14) = ' num2str(roundn(mean(ApproachEff(1:end)).*100,-2)) ';']);
%                 if isempty(Turn_BODist) == 1;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(0) ';']);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(-10000) ';']);
%                 else;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(roundn(mean(Turn_BODistINI),-2)) ';']);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(roundn(mean(TurnsAvBOEff).*100,-2)) ';']);
%                 end;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',17) = ' num2str(roundn(avSI, -2)) ';']);
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',18) = ' num2str(roundn(avVEL, -2)) ';']);
%                 if isempty(Turn_BODist) == 1;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(10000) ';']);
%                 else;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(roundn(TurnsAvINI(1,3),-2)) ';']);
%                 end;
%                 eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',20) = ' num2str(roundn(mean(SpeedDecaySprintRange), -2)) ';']);
%             else;
%                 %Athlete exists
%                 eval(['checkfile = PBsDB_SC.A' num2str(dataEC.athleteId) 'A;']);
%                 [li, co] = size(checkfile);
%                 if li < 19 | co < 19;
%                     fullfile(:,1) = ones(19,1).*10000;
%                     fullfile(:,2) = ones(19,1).*10000;
%                     fullfile(:,3) = ones(19,1).*10000;
%                     fullfile(:,4) = ones(19,1).*10000;
%                     fullfile(:,5) = zeros(19,1);
%                     fullfile(:,6) = zeros(19,1);
%                     fullfile(:,7) = zeros(19,1);
%                     fullfile(:,8) = ones(19,1).*10000;
%                     fullfile(:,9) = ones(19,1).*10000;
%                     fullfile(:,10) = zeros(19,1);
%                     fullfile(:,11) = zeros(19,1);
%                     fullfile(:,12) = zeros(19,1);
%                     fullfile(:,13) = zeros(19,1);
%                     fullfile(:,14) = zeros(19,1);
%                     fullfile(:,15) = zeros(19,1);
%                     fullfile(:,16) = zeros(19,1);
%                     fullfile(:,17) = zeros(19,1);
%                     fullfile(:,18) = zeros(19,1);
%                     fullfile(:,19) = ones(19,1).*10000;
%                     fullfile(:,20) = zeros(19,1);
%                 
%                     [indexL, indexC] = find(checkfile ~= 0 & checkfile ~= 10000);
%                     for rep = 1:length(indexL);
%                        fullfile(indexL(rep), indexC(rep)) = checkfile(indexL(rep), indexC(rep));
%                     end;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A = fullfile;']);
%                 end;
%                 
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',1);']);
%                 if check > SplitsAll(end,2);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',1) = ' num2str(SplitsAll(end,2)) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',2);']);
%                 if check > TotalSkillTimeINI;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',2) = ' num2str(TotalSkillTimeINI) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',3);']);
%                 if check > roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',3) = ' num2str(roundn(SplitsAll(end,2)-TotalSkillTimeINI,-2)) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4);']);
%                 if isempty(DropOff) == 0;
%                     if check > DropOff;
%                         eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',4) = ' num2str(DropOff) ';']);
%                     end;
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',5);']);
%                 if check < MaxVelDouble;
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',5) = ' num2str(MaxVelDouble) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',6);']);
%                 if check < MaxSRDouble;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',6) = ' num2str(MaxSRDouble) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',7);']);
%                 if check < MaxDPSDouble;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',7) = ' num2str(MaxDPSDouble) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',8);']);
%                 if check > RT;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',8) = ' num2str(RT) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',9);']);
%                 if check > DiveT15INI;
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',9) = ' num2str(DiveT15INI) ';']);
%                 end;
%         %         ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%                 if isempty(StartEntryDist) == 0;
%                     eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10);']);
%                     if check < StartEntryDist;
%                         eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',10) = ' num2str(StartEntryDist) ';']);
%                     end;
%                     eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11);']);
%                     if check < StartUWVelocity;
%                         eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',11) = ' num2str(StartUWVelocity) ';']);
%                     end;
%                 end;
%         %         ùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùùù
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',12);']);
%                 if check < roundn(BOAllINI(1,3),-2);
%                     eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',12) = ' num2str(roundn(BOAllINI(1,3),-2)) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',13);']);
%                 if check < roundn(BOEff(1).*100,-2);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',13) = ' num2str(roundn(BOEff(1).*100,-2)) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',14);']);
%                 if check < roundn(mean(ApproachEff(1:end)).*100,-2);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',14) = ' num2str(roundn(mean(ApproachEff(1:end)).*100,-2)) ';']);
%                 end;
%                 if isempty(Turn_BODist) == 0;
%                     eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15);']);
%                     if check < roundn(mean(Turn_BODistINI),-2);
%                         eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',15) = ' num2str(roundn(mean(Turn_BODistINI),-2)) ';']);
%                     end;
%                     eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16);']);
%                     if check < roundn(mean(TurnsAvBOEff).*100,-2);
%                         eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',16) = ' num2str(roundn(mean(TurnsAvBOEff).*100,-2)) ';']);
%                     end;
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',17);']);
%                 if check < roundn(avSI, -2);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',17) = ' num2str(roundn(avSI, -2)) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',18);']);
%                 if check < roundn(avVEL, -2);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',18) = ' num2str(roundn(avVEL, -2)) ';']);
%                 end;      
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19);']);
%                 if check > roundn(TurnsAvINI(1,3),-2);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',19) = ' num2str(roundn(TurnsAvINI(1,3), -2)) ';']);
%                 end;
%                 eval(['check = PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',20);']);
%                 if check < roundn(mean(SpeedDecaySprintRange), -2);
%                     eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(' num2str(target) ',20) = ' num2str(roundn(mean(SpeedDecaySprintRange), -2)) ';']);
%                 end;
%             end;
%         end;
%     else;
%         %relay
%         existathlete = isfield(PBsDB, ['A' num2str(dataEC.athleteId) 'A']);
%         if existathlete == 0;
%             %add new athlete's PBs
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,1) = ones(19,1).*10000;']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,2) = ones(19,1).*10000;']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,3) = ones(19,1).*10000;']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,4) = ones(19,1).*10000;']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,5) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,6) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,7) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,8) = ones(19,1).*10000;']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,9) = ones(19,1).*10000;']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,10) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,11) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,12) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,13) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,14) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,15) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,16) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,17) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,18) = zeros(19,1);']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,19) = ones(19,1).*10000;']);
%             eval(['PBsDB.A' num2str(dataEC.athleteId) 'A(:,20) = zeros(19,1);']);
% 
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,1) = ones(19,1).*10000;']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,2) = ones(19,1).*10000;']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,3) = ones(19,1).*10000;']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,4) = ones(19,1).*10000;']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,5) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,6) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,7) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,8) = ones(19,1).*10000;']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,9) = ones(19,1).*10000;']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,10) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,11) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,12) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,13) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,14) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,15) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,16) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,17) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,18) = zeros(19,1);']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,19) = ones(19,1).*10000;']);
%             eval(['PBsDB_SC.A' num2str(dataEC.athleteId) 'A(:,20) = zeros(19,1);']);
%         end;
%     end;
    
    %look for AgeGroup_SP2
    existmeet = isfield(AgeGroup_SP2, ['A' num2str(dataEC.competitionId) '_' Year 'A']);
    if existmeet == 1;
        eval(['check = AgeGroup_SP2.A' num2str(dataEC.competitionId) '_' Year 'A;']);
        index = strfind(dataEC.date, '-');
        RaceDate = datetime(str2num(dataEC.date(index(2)+1:end)), str2num(dataEC.date(index(1)+1:index(2)-1)), str2num(dataEC.date(1:index(1)-1)));
        index = strfind(check, '-');
        CheckDate = datetime(str2num(check(index(2)+1:end)), str2num(check(index(1)+1:index(2)-1)), str2num(check(1:index(1)-1)));
        dateDiff(1) = RaceDate;
        dateDiff(2) = CheckDate;
        D = caldiff(dateDiff, 'days');
        D = split(D, 'days');
        if D > 0;
            %the race was earlier
            eval(['AgeGroup_SP2.A' num2str(dataEC.competitionId) '_' Year 'A = ' '''' dataEC.date '''' ';']);
        end;
    else;
        eval(['AgeGroup_SP2.A' num2str(dataEC.competitionId) '_' Year 'A = ' '''' dataEC.date '''' ';']);
    end;
end;

eval(['AllDB.uidDB_SP2_' num2str(handles2.yearSelectionAll{count,1}) ' = uidDB_SP2;']);
eval(['AllDB.FullDB_SP2_' num2str(handles2.yearSelectionAll{count,1}) ' = FullDB_SP2;']);
eval(['AllDB.AgeGroup_SP2_' num2str(handles2.yearSelectionAll{count,1}) ' = AgeGroup_SP2;']);
% AllDB.uidDB_SP2 = uidDB_SP2;
% AllDB.FullDB_SP2 = FullDB_SP2;
AllDB.AthletesDB = AthletesDB;
AllDB.ParaDB = ParaDB;
% AllDB.PBsDB = PBsDB;
% AllDB.PBsDB_SC = PBsDB_SC;
AllDB.PBsDB = {};
AllDB.PBsDB_SC = {};
% AllDB.AgeGroup_SP2 = AgeGroup_SP2;
AllDB.RoundDB = RoundDB;
AllDB.MeetDB = MeetDB;
            
filelist{race} = FilenameNew;
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


stepCheck = 9

eval(['clear ' uid]);
clear Breakout;
clear Breath;
clear Distance;
clear Velocity;
clear VelocityTrend;
clear Kick;
clear Time;
clear Stroke;
clear dataEC;
clear graph1_lineMain;
clear graph1_lineBottom;
clear graph1_lineTop;
clear graph1_text;
clear graph1_Distance;
clear colorrange;
clear colorvalue;

