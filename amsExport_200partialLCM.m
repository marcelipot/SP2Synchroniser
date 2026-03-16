dataSeriesECnew = {};
dataSeriesECnew{1,1} = Athletename;
dataSeriesECnew{1,2} = Meet;
dataSeriesECnew{1,3} = Year;
dataSeriesECnew{1,4} = Stage;
dataSeriesECnew{1,5} = StrokeType;
dataSeriesECnew{1,6} = RaceDist;
dataSeriesECnew{1,7} = valRelay;
dataSeriesECnew{1,8} = detailRelay;
dataSeriesECnew{1,9} = Course;
dataSeriesECnew{1,10} = RaceDate;

%                 if strcmpi(answerReport, 'SP1') == 1;
    create_pacingtableINI;
    create_skilltableINI;
    create_stroketableINI;
%                 else;
%                     create_pacingtable;
%                     create_skilltable;
%                     create_stroketable;
%                 end;

%---Create Splits
dataSeriesECnew{1,11} = timeSecToStr2(dataMatCumSplitsPacingbis(end,2));
dataSeriesECnew{1,12} = TotalSkillTime;
dataSeriesECnew{1,13} = dataMatCumSplitsPacingbis(end,2) - TotalSkillTime;
KeyDist = 25:25:RaceDist;

posTitle = 11;

posEC = length(dataSeriesECnew(1,:));
for spl = 1:length(KeyDist);
    if iterEC == 3;
        %Add titles
        inDist = KeyDist(spl) - 25;
        outDist = KeyDist(spl);

        if AMSExportHeader == 1;
            dataSeriesEC{1,posEC+1} = ['Spl ' num2str(inDist) '-' num2str(outDist) 'm'];
        else;
            dataSeriesEC{2,posEC+1} = [num2str(inDist) '-' num2str(outDist) 'm'];
        end;
    end;
    dataSeriesECnew{1,posEC+1} = dataMatCumSplitsPacing(spl*5,2);
    posEC = length(dataSeriesECnew(1,:));
end;


%---Create Velocities
LapDist = Course:Course:RaceDist;
%                 if strcmpi(answerReport, 'SP1') == 1;
    create_stroketableINI;
%                 else;
%                     create_stroketable;
%                 end;
VelTOT = [];
itervel = 1;

for vel = 1:length(LapDist);
    for sublap = 1:2;
        if sublap == 1;
            eval(['SectionEC = SectionVel(' num2str(vel) ',1:5);']);
        else;
            eval(['SectionEC = SectionVel(' num2str(vel) ',6:10);']);
        end;
        linan = find(isnan(SectionEC) == 0);
        SectionEC = mean(SectionEC(linan));        
        eval(['Vel' num2str(KeyDist(itervel)) 'm = dataToStr(mean(' num2str(SectionEC) '),2);']);
        eval(['VelTOT = [VelTOT ' num2str(SectionEC) '];']);
        
        itervel = itervel + 1;
    end;
end;
posEC = length(dataSeriesECnew(1,:));
posTitle(2) = posEC+1;
if iterEC == 3;
    dataSeriesEC{1,posEC+1} = 'Velocity (m/s)';
end;
for addVal = 1:length(VelTOT);
    if iterEC == 3;
        %Add titles
        inDist = KeyDist(addVal) - 25;
        outDist = KeyDist(addVal);
        if AMSExportHeader == 1
            dataSeriesEC{1,posEC+addVal} = ['Vel ' num2str(inDist) '-' num2str(outDist) 'm'];
        else;
            dataSeriesEC{2,posEC+addVal} = [num2str(inDist) '-' num2str(outDist) 'm'];
        end;
        dataSeriesEC{2,posEC+addVal} = [num2str(inDist) '-' num2str(outDist) 'm'];
    end;
    if VelTOT(addVal) == 0 | VelTOT(addVal) == Inf;
        dataSeriesECnew{1,posEC+addVal} = NaN;
    else;
        dataSeriesECnew{1,posEC+addVal} = VelTOT(addVal);
    end;
end;

%---Create Stroke Counts
posEC = length(dataSeriesECnew(1,:))+2;
posTitle(3) = posEC-1;
if iterEC == 3;
    dataSeriesEC{1,posEC-1} = 'Stroke Count';
end;
for lap = 1:NbLap;
    if iterEC == 3;
        %Add titles
        inDist1 = KeyDist((lap*2)-1) - 25;
        outDist1 = KeyDist((lap*2)-1);
        inDist2 = KeyDist(lap*2) - 25;
        outDist2 = KeyDist(lap*2);

        if AMSExportHeader == 1;
            dataSeriesEC{1,posEC-1} = ['Str ' num2str(inDist1) '-' num2str(outDist1) 'm'];
            dataSeriesEC{1,posEC} = ['Str ' num2str(inDist2) '-' num2str(outDist2) 'm'];
        else;
            dataSeriesEC{2,posEC-1} = [num2str(inDist1) '-' num2str(outDist1) 'm'];
            dataSeriesEC{2,posEC} = [num2str(inDist2) '-' num2str(outDist2) 'm'];
        end;
    end;
    dataSeriesECnew{1,posEC} = Stroke_Count(lap);
    posEC = length(dataSeriesECnew(1,:))+2;
end;

%---Create Stroke rates
SRTOT = [];
iterSR = 1;
for sr = 1:length(LapDist);
    for sublap = 1:2;
        if sublap == 1;
            eval(['SectionEC = SectionSR(' num2str(sr) ',1:5);']);
        else;
            eval(['SectionEC = SectionSR(' num2str(sr) ',6:10);']);
        end;
        linan = find(isnan(SectionEC) == 0);
        SectionEC = mean(SectionEC(linan));
        eval(['SR' num2str(KeyDist(iterSR)) 'm = dataToStr(mean(' num2str(SectionEC) '),1);']);
        eval(['SR' num2str(KeyDist(iterSR)) 'm = SR' num2str(KeyDist(iterSR)) 'm(1:4);']);
        eval(['SRTOT = [SRTOT ' num2str(SectionEC) '];']);
        
        iterSR = iterSR + 1;
    end;
end;
posEC = length(dataSeriesECnew(1,:));
posTitle(4) = posEC+1;
if iterEC == 3;
    dataSeriesEC{1,posEC+1} = 'Stroke Rate (str/min)';
end;
for addVal = 1:length(SRTOT);
    if iterEC == 3;
        %Add titles
        inDist = KeyDist(addVal) - 25;
        outDist = KeyDist(addVal);

        if AMSExportHeader == 1
            dataSeriesEC{1,posEC+addVal} = ['SR ' num2str(inDist) '-' num2str(outDist) 'm'];
        else;
            dataSeriesEC{2,posEC+addVal} = [num2str(inDist) '-' num2str(outDist) 'm'];
        end;
    
    end;
    if SRTOT(addVal) == 0 | SRTOT(addVal) == Inf;
        dataSeriesECnew{1,posEC+addVal} = NaN;
    else;
        dataSeriesECnew{1,posEC+addVal} = SRTOT(addVal);
    end;
end;

%---Create DPS
DPSTOT = [];
iterDPS = 1;
for sl = 1:length(LapDist);
    for sublap = 1:2;
        if sublap == 1;
            eval(['SectionEC = SectionSD(' num2str(sl) ',1:5);']);
        else;
            eval(['SectionEC = SectionSD(' num2str(sl) ',6:10);']);
        end;
        linan = find(isnan(SectionEC) == 0);
        SectionEC = mean(SectionEC(linan));
        eval(['DPS' num2str(KeyDist(iterDPS)) 'm = dataToStr(mean(' num2str(SectionEC) '),1);']);
        eval(['DPS' num2str(KeyDist(iterDPS)) 'm = SR' num2str(KeyDist(iterDPS)) 'm(1:4);']);
        eval(['DPSTOT = [DPSTOT ' num2str(SectionEC) '];']);
        
        iterDPS = iterDPS + 1;
    end;
end;
posEC = length(dataSeriesECnew(1,:));
posTitle(5) = posEC+1;
if iterEC == 3;
    dataSeriesEC{1,posEC+1} = 'Stroke Length (m)';
end;
for addVal = 1:length(DPSTOT);
    if iterEC == 3;
        %Add titles
        inDist = KeyDist(addVal) - 25;
        outDist = KeyDist(addVal);
        if AMSExportHeader == 1
            dataSeriesEC{1,posEC+addVal} = ['DPS ' num2str(inDist) '-' num2str(outDist) 'm'];
        else;
            dataSeriesEC{2,posEC+addVal} = [num2str(inDist) '-' num2str(outDist) 'm'];
        end;
    end;
    if DPSTOT(addVal) == 0 | DPSTOT(addVal) == Inf;
        dataSeriesECnew{1,posEC+addVal} = NaN;
    else;
        dataSeriesECnew{1,posEC+addVal} = DPSTOT(addVal);
    end;
end;

%---Create skills
origin = 'graph';
%                 if strcmpi(answerReport, 'SP1') == 1;
    create_skilltableINI;
%                 else;
%                     create_skilltable;
%                 end;
eval(['RT = handles.RacesDB.' UID '.RT;']);
RT = timeSecToStr2(RT);
%                 if strcmpi(answerReport, 'SP1') == 1;
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);
%                 else;
%                     eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
%                 end;
StartTime = timeSecToStr2(DiveT15);

StartBOTime = timeSecToStr2(BOAll(1,2));
StartBODist = dataToStr(BOAll(1,3),1);
for tt = 1:length(LapDist)-1;
    eval(['Turn' num2str(tt) 'BOTime = timeSecToStr2(BOAll(' num2str(tt+1) ',2));']);
    eval(['TurnECBODist = dataToStr(BOAll(' num2str(tt+1) ',3) - LapDist(' num2str(tt) '),1);']);
    if strcmpi(TurnECBODist(1:end-1), '.');
        eval(['Turn' num2str(tt) 'BODist = TurnECBODist;']);
    else;
        eval(['Turn' num2str(tt) 'BODist = TurnECBODist;']);
    end;
end;
eval(['Last5mINI = handles.RacesDB.' UID '.Last5mINI;']);


for kc = 1:length(LapDist);
    eval(['KickCountLapEC = dataToStr(length(find(Kick_Frame(' num2str(kc) ',:) ~= 0)),0);']);
    if strcmpi(KickCountLapEC, '0');
        eval(['KickCountLap' num2str(kc) ' = ' '''' '''' ';']);
    else;
        if strcmpi(KickCountLapEC, '.');
            eval(['KickCountLap' num2str(kc) ' = KickCountLapEC(1);']);
        else;
            eval(['KickCountLap' num2str(kc) ' = KickCountLapEC;']);
        end;
    end;
end;

posEC = length(dataSeriesECnew(1,:));
posTitle(6) = posEC+1;
if iterEC == 3
    %add titles
    dataSeriesEC{1,posEC+1} = 'Start';
    dataSeriesEC{1,posEC+3} = 'Reaction Time';
    dataSeriesEC{1,posEC+2} = 'Start BO Distance';
    dataSeriesEC{1,posEC+4} = 'Start BO Time';
    dataSeriesEC{1,posEC+5} = 'Start Kicks';
    dataSeriesEC{1,posEC+6} = 'Turn TT';
end;
dataSeriesECnew{1,posEC+1} = StartTime;
dataSeriesECnew{1,posEC+2} = RT;
dataSeriesECnew{1,posEC+3} = StartBODist;
dataSeriesECnew{1,posEC+4} = StartBOTime;
eval(['kcl = KickCountLap' num2str(1) ';']);
dataSeriesECnew{1,posEC+5} = kcl;
dataSeriesECnew{1,posEC+6} = sum(Turn_Time);

posEC = length(dataSeriesECnew(1,:));
NbTurns = length(Turn_Time);
for tt = 1:length(Turn_Time);
    if AMSExportHeader == 1;
        if iterEC == 3;
            dataSeriesEC{1,posEC+1} = ['T. ' num2str(tt) ' In'];
            dataSeriesEC{1,posEC+2} = ['T. ' num2str(tt) ' Out'];
            dataSeriesEC{1,posEC+3} = ['T. ' num2str(tt) ' Time'];
            dataSeriesEC{1,posEC+4} = ['T. ' num2str(tt) ' BO Turn'];
            dataSeriesEC{1,posEC+5} = ['T. ' num2str(tt) ' Kicks'];
            dataSeriesEC{1,posEC+6} = ['T. ' num2str(tt) ' T Index'];
        end;
    else;
        if iterEC == 3
            dataSeriesEC{1,posEC+1} = ['Turn ' num2str(tt)];
            dataSeriesEC{2,posEC+1} = 'In';
            dataSeriesEC{2,posEC+2} = 'Out';
            dataSeriesEC{2,posEC+3} = 'Time';
            dataSeriesEC{2,posEC+4} = 'BO Turn';
            dataSeriesEC{2,posEC+5} = 'Kicks';
            dataSeriesEC{2,posEC+6} = 'T Index';
        end;
    end;

    dataSeriesECnew{1,posEC+1} = Turn_TimeIn(tt);
    dataSeriesECnew{1,posEC+2} = Turn_TimeOut(tt);
    dataSeriesECnew{1,posEC+3} = Turn_Time(tt);
    eval(['TurnECBODist = Turn' num2str(tt) 'BODist;']);
    dataSeriesECnew{1,posEC+4} = TurnECBODist;
    eval(['kcl = KickCountLap' num2str(tt+1) ';']);
    dataSeriesECnew{1,posEC+5} = kcl;
    dataSeriesECnew{1,posEC+6} = [];

    posEC = length(dataSeriesECnew(1,:));
end;

if iterEC == 3;
    dataSeriesEC{1,posEC+1} = 'Finish';
end;
dataSeriesECnew{1,posEC+1} = Last5mINI;

for val = 1:length(dataSeriesECnew);
    if AMSExportHeader == 1;
        dataSeriesEC{iterEC-1,val} = dataSeriesECnew{1,val};
    else;
        dataSeriesEC{iterEC,val} = dataSeriesECnew{1,val};
    end;
end;
