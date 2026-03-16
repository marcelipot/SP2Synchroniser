function dataTableSkill = create_skilltable_SP1Report_synchroniser(Athletename, Source, ...
    framerate, RaceDist, StrokeType, Meet, Year, ...
    valRelay, detailRelay, Course, Stage, SplitsAll, NbLap, ...
    RaceLocation, TotalSkillTime, Turn_Time, Turn_TimeIn, Turn_TimeOut, ...
    DiveT15, RT, StartUWVelocity, StartEntryDist, StartUWDist, StartUWTime, ...
    KicksNb, BOAll, BOEff, VelAfterBO, VelBeforeBO, ...
    ApproachEff, Approach2CycleAll, ApproachLastCycleAll, GlideLastStroke, Last5m);




formatlist{1} = 'char';
formatlist{2} = 'char';
edittablelist(1) = false;
edittablelist(2) = false;
formatlist{3} = 'numeric';
edittablelist(3) = false;


dataTableSkill = {};
dataTableSkill{1,2} = 'Metadata';
dataTableSkill{8,2} = 'Skills';

dataTableSkill{9,1} = 'Totals';
dataTableSkill{10,2} = 'Skill Time';
dataTableSkill{11,2} = 'Tot underwater Dist';
dataTableSkill{12,2} = 'Tot underwater Time';
dataTableSkill{13,2} = 'Tot Turns (In/Out/Tot)';

dataTableSkill{14,1} = 'Start';
dataTableSkill{15,2} = 'Start Time';
dataTableSkill{16,2} = 'Reaction Time';
dataTableSkill{17,2} = 'Entry Distance';
dataTableSkill{18,2} = 'Unverwater Distance';
dataTableSkill{19,2} = 'Unverwater Time';
dataTableSkill{20,2} = 'Unverwater Speed';
dataTableSkill{21,2} = 'Underwater Kicks';
dataTableSkill{22,2} = 'Breakout Distance';
dataTableSkill{23,2} = 'Breakout Time';
dataTableSkill{24,2} = 'Breakout Skill';

dataTableSkill{25,1} = 'Turns Averages';
dataTableSkill{26,2} = 'Av Times (In/Out/Tot)';
dataTableSkill{27,2} = 'Av Kicks';
dataTableSkill{28,2} = 'Av Breakout Distance';
dataTableSkill{29,2} = 'Av Breakout Time';
dataTableSkill{30,2} = 'Av Breakout Skill';


Turn_TimeALL = [];
Turn_TimeInALL = [];
Turn_TimeOutALL = [];



%----------------------------------Meta--------------------------------
dataTableSkill{2,3} = Athletename;
str = [num2str(RaceDist) '-' StrokeType];
dataTableSkill{3,3} = str;    
str = [Meet '-' num2str(Year)];
dataTableSkill{4,3} = str;

if strcmpi(detailRelay, 'None') == 1;
    str = Stage;
else;
    str = [Stage ' - ' detailRelay ' ' valRelay];
end;
dataTableSkill{5,3} = str;

TT = SplitsAll(end,2);
TTtxt = timeSecToStr(TT);
dataTableSkill{6,3} = TTtxt;

if Source == 1;
    dataTableSkill{7,3} = 'Sparta 1';
elseif Source == 2;
    dataTableSkill{7,3} = 'Sparta 2';
elseif Source == 3;
    dataTableSkill{7,3} = 'GreenEye';
end;


%--------------------------------Skills--------------------------------
lineEC = 31;
for lap = 1:NbLap-1;
    dataTableSkill{lineEC,1} = ['Turn ' num2str(lap)];

    dataTableSkill{lineEC+1,2} = 'Times (In/Out/Tot)';
    dataTableSkill{lineEC+2,2} = 'Approach Skill';
    dataTableSkill{lineEC+3,2} = 'Glide-Wall (Dist/Time)';
    dataTableSkill{lineEC+4,2} = 'Underwater Kicks';
    dataTableSkill{lineEC+5,2} = 'Breakout Distance';
    dataTableSkill{lineEC+6,2} = 'Breakout Time';
    dataTableSkill{lineEC+7,2} = 'Breakout skill';

    lineEC = lineEC + 8;
end;

dataTableSkill{lineEC,1} = 'Finish';
dataTableSkill{lineEC+1,2} = 'Last 5m Time';
dataTableSkill{lineEC+2,2} = 'Glide-Wall (Dist/Time)';
colorrow(lineEC,:) = [1 0.9 0.70];
colorrow(lineEC+1,:) = [0.9 0.9 0.9];
colorrow(lineEC+2,:) = [0.75 0.75 0.75];

%%%Totals

if Source == 1 | Source == 3;
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
        if Source == 1;
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
            
        elseif Source == 3;
            %cumulative distance
            TurinDist = (lap*Course) - 5;
            TurOutDist = (lap*Course) + 10;
            indexIn = find(RaceLocation(:,5) == TurinDist);
            indexOut = find(RaceLocation(:,5) == TurOutDist); 
            if isnan(RaceLocation(indexIn,3)) == 1;
                isInterpolatedTurns(lap,1) = 1;
                isInterpolatedTurns(lap,3) = 1; 
            end;
            if isnan(RaceLocation(indexOut,3)) == 1;
                isInterpolatedTurns(lap,2) = 1;
                isInterpolatedTurns(lap,3) = 1;
            end;
        end;
    end;

    %Finish interpolation
    if Source == 1;
        if RaceDist == 50 | RaceDist == 150;
            indexFinish = find(RaceLocation(:,5) == Course-5); 
            indexFinish = indexFinish(end);
        else;
            indexFinish = find(RaceLocation(:,5) == 5); 
            indexFinish = indexFinish(end);
        end;
    elseif Source == 3;
        indexFinish = find(RaceLocation(:,5) == RaceDist-5); 
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
else;
    RaceLocation = [];
    isInterpolatedDive = 0;
    isInterpolatedFinish = 0;
    isInterpolatedTurns = zeros(NbLap-1,3);
    isInterpolatedSkills = 0;
end;

TotalSkillTimetxt = timeSecToStr(TotalSkillTime);
if isInterpolatedSkills == 0;
    %no interpolation
    dataTableSkill{10,3} = TotalSkillTimetxt;
else;
    %interpolation
    dataTableSkill{10,3} = [TotalSkillTimetxt ' !'];
end;

dataTableSkill{11,3} = 'na'; %Total underwater Distance
dataTableSkill{12,3} = 'na'; %Total underwater Time

Turn_TimeALL(:,:,3) = Turn_Time;
Turn_TimeInALL(:,:,3) = Turn_TimeIn;
Turn_TimeOutALL(:,:,3) = Turn_TimeOut;
Turn_Timetxt = timeSecToStr(roundn(sum(Turn_Time),-2));
Turn_TimeIntxt = timeSecToStr(roundn(sum(Turn_TimeIn),-2));
Turn_TimeOuttxt = timeSecToStr(roundn(sum(Turn_TimeOut),-2));
if isempty(find(isInterpolatedTurns == 1)) == 1;
    %no interpolation
    dataTableSkill{13,3} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];
else;
    %interpolation
    dataTableSkill{13,3} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt ' !'];
end;

%%%%Start
SplitsAll = SplitsAll(2:end,:);

DiveT15txt = timeSecToStr(roundn(DiveT15,-2));
if isInterpolatedDive == 0;
    dataTableSkill{15,3} = DiveT15txt;
else;
    dataTableSkill{15,3} = [DiveT15txt ' !'];
end;

RTtxt = timeSecToStr(roundn(RT,-2));
dataTableSkill{16,3} = RTtxt;

if isempty(StartUWVelocity) == 1;
    dataTableSkill{17,3} = 'na';    %Entry Distance
    dataTableSkill{18,3} = 'na';    %Unverwater Distance
    dataTableSkill{19,3} = 'na';    %Unverwater Time
    dataTableSkill{20,3} = 'na';    %Unverwater Speed
else;
    dataTableSkill{17,3} = [dataToStr(StartEntryDist, 2) ' m'];     %Entry Distance
    dataTableSkill{18,3} = [dataToStr(StartUWDist, 2) ' m'];        %Unverwater Distance
    dataTableSkill{19,3} = timeSecToStr(StartUWTime);               %Unverwater Time
    dataTableSkill{20,3} = [dataToStr(StartUWVelocity, 2) ' m/s'];  %Unverwater Speed
end;

dataTableSkill{21,3} = [num2str(KicksNb(1)) ' Kicks'];
if Source == 1 | Source == 3;
    isInterpolatedBO = BOAll(:,4);
    BOAll = BOAll(:,1:3);
else;
    isInterpolatedBO = zeros(NbLap,1);
end;
BOdisttxt = dataToStr(BOAll(1,3),1);

if isInterpolatedBO(1) == 0;
    dataTableSkill{22,3} = [BOdisttxt ' m'];
    BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));
    dataTableSkill{23,3} = BOTimetxt;
else;
    dataTableSkill{22,3} = [BOdisttxt ' m !'];
    BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));
    dataTableSkill{23,3} = [BOTimetxt ' !'];
end;
    
BOEfftxt = dataToStr(BOEff(1,1).*100,1);
VelAftertxt = dataToStr(VelAfterBO(1,1),2);
VelBeforetxt = dataToStr(VelBeforeBO(1,1),2);
if Source == 1 | Source == 3;
    dataTableSkill{24,3} = [' na  /  na  /  na '];
elseif Source == 2;
    dataTableSkill{24,3} = [BOEfftxt ' %  /  ' VelBeforetxt ' m/s  /  ' VelAftertxt ' m/s'];
end;


%%%%Turns averages
BOEffTurn = BOEff(2:end);
if NbLap == 1;
    dataTableSkill{26,3} = '  -  /  -  /  -  ';
    dataTableSkill{27,3} = '  -  ';
    dataTableSkill{28,3} = '  -  ';
    dataTableSkill{29,3} = '  -  ';
    dataTableSkill{30,3} = '  -  ';
else;
    AvTurnIn = roundn(mean(Turn_TimeIn),-2);
    AvTurnOut = roundn(mean(Turn_TimeOut),-2);
    AvTurnTime = roundn(mean(Turn_Time),-2);
    AvTurnInALL(:,:,1) = AvTurnIn;
    AvTurnOutALL(:,:,1) = AvTurnOut;
    AvTurnTimeALL(:,:,1) = AvTurnTime;
    AvTurnIntxt = timeSecToStr(roundn(AvTurnIn,-2));
    AvTurnOuttxt = timeSecToStr(roundn(AvTurnOut,-2));
    AvTurnTimetxt = timeSecToStr(roundn(AvTurnTime,-2));    
    if isempty(find(isInterpolatedTurns == 1)) == 1;
        %no interpolation
        dataTableSkill{26,3} = [AvTurnIntxt '  /  ' AvTurnOuttxt '  /  ' AvTurnTimetxt];
    else;
        dataTableSkill{26,3} = [AvTurnIntxt '  /  ' AvTurnOuttxt '  /  ' AvTurnTimetxt ' !'];
    end;

    AvKicksNb = roundn(mean(KicksNb(2:end)),-2);
    AvKicksNbtxt = dataToStr(AvKicksNb,1);
    dataTableSkill{27,3} = [AvKicksNbtxt ' Kicks'];

    BOTurn = [];
    for lap = 2:NbLap;
        BO = BOAll(lap,3);
        BO = BO - ((lap-1).*Course);
        BOTurn = [BOTurn BO];
    end;
    AvBODistTurn = roundn(mean(BOTurn),-2);
    AvBODistTurntxt = dataToStr(AvBODistTurn,1);
    if isempty(find(isInterpolatedBO(2:end) == 1)) == 1;
        %no interpolation
        dataTableSkill{28,3} = [AvBODistTurntxt ' m'];
    else;
        %interpolation
        dataTableSkill{28,3} = [AvBODistTurntxt ' m !'];
    end;

    BOTurn = [];
    for lap = 2:NbLap;
        BO = BOAll(lap,2);
        BO = BO - SplitsAll(lap-1,2);
        BOTurn = [BOTurn BO];
    end;
    AvBOTimeTurn = roundn(mean(BOTurn),-2);
    AvBOTimeTurntxt = timeSecToStr(AvBOTimeTurn);
    if isempty(find(isInterpolatedBO(2:end) == 1)) == 1;
        %no interpolation
        dataTableSkill{29,3} = AvBOTimeTurntxt;
    else;
        %interpolation
        dataTableSkill{29,3} = [AvBOTimeTurntxt ' !'];
    end;        

    BOEffTurnAv = roundn(mean(BOEffTurn).*100,-2);
    BOEffTurnAvtxt = dataToStr(BOEffTurnAv,1);
    VelBefTurnAv = roundn(mean(VelBeforeBO(2:end)),-2);
    VelBefTurnAvtxt = dataToStr(VelBefTurnAv,2);
    VelAftTurnAv = roundn(mean(VelAfterBO(2:end)),-2);
    VelAftTurnAvtxt = dataToStr(VelAftTurnAv,2);
    if Source == 1 | Source == 3;
        dataTableSkill{30,3} = [' na  /  na  /  na '];
    else;
        dataTableSkill{30,3} = [BOEffTurnAvtxt ' %  /  ' VelBefTurnAvtxt ' m/s  /  ' VelAftTurnAvtxt ' m/s'];            
    end;
end;


%%%%Turn Details
if NbLap ~= 1;
    lineEC = 31;
    BOEffTurn = BOEff(2:end);
    for lap = 1:NbLap-1;
        dataTableSkill{lineEC,1} = ['Turn ' num2str(lap)];

        Turn_TimeIntxt = timeSecToStr(roundn(Turn_TimeIn(lap),-2));
        Turn_TimeOuttxt = timeSecToStr(roundn(Turn_TimeOut(lap),-2));
        Turn_Timetxt = timeSecToStr(roundn(Turn_Time(lap),-2));
        if isempty(find(isInterpolatedTurns(lap,:) == 1)) == 1;
            %no interpolation
            dataTableSkill{lineEC+1,3} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];
        else;
            %interpolation
            dataTableSkill{lineEC+1,3} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt ' !'];
        end;

        ApproachEffTurn = roundn(ApproachEff(lap).*100,-2);
        ApproachEffTurntxt = dataToStr(ApproachEffTurn,1);
        Approach2CycleAlltxt = dataToStr(Approach2CycleAll(lap),2);
        ApproachLastCycleAlltxt = dataToStr(ApproachLastCycleAll(lap),2);
        if Source == 1 | Source == 3;
            dataTableSkill{lineEC+2,3} = [' na  /  na  /  na '];
        elseif Source == 2;
            dataTableSkill{lineEC+2,3} = [ApproachEffTurntxt ' %  /  ' Approach2CycleAlltxt ' m/s  /  ' ApproachLastCycleAlltxt ' m/s'];
        end;

        GlideLastStrokeDist = roundn(GlideLastStroke(3,lap),-2);
        GlideLastStrokeTime = roundn(GlideLastStroke(4,lap),-2);
        GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
        GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
        if Source == 1 | Source == 3;
            dataTableSkill{lineEC+3,3} =  [' na  /  na '];
        elseif Source == 2;
            dataTableSkill{lineEC+3,3} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
        end;
        
        KicksNbtxt = dataToStr(KicksNb(lap+1),0);
        dataTableSkill{lineEC+4,3} = [KicksNbtxt ' Kicks'];

        BO = BOAll(lap+1,3);
        BO = roundn(BO - (lap.*Course),-2);
        BOdisttxt = dataToStr(BO,1);
        if isInterpolatedBO(lap+1) == 0;
            %no interpolation
            dataTableSkill{lineEC+5,3} = [BOdisttxt ' m'];
        else;
            %Interpolation
            dataTableSkill{lineEC+5,3} = [BOdisttxt ' m !'];
        end;
        BO = BOAll(lap+1,2);
        BO = BO - SplitsAll(lap,2);
        BOtimetxt = timeSecToStr(BO);
        if isInterpolatedBO(lap+1) == 0;
            %no interpolation
            dataTableSkill{lineEC+6,3} = BOtimetxt;
        else;
            %Interpolation
            dataTableSkill{lineEC+6,3} = [BOtimetxt ' !'];
        end;

        BOEffTurntxt = dataToStr(BOEffTurn(lap).*100,1);
        
        VelAfterBOtxt = dataToStr(VelAfterBO(lap+1),2);
        VelBeforeBOtxt = dataToStr(VelBeforeBO(lap+1),2);
        if Source == 1 | Source == 3;
            dataTableSkill{lineEC+7,3} = [' na  /  na  /  na '];
        elseif Source == 2;
            dataTableSkill{lineEC+7,3} = [BOEffTurntxt ' %  /  ' VelBeforeBOtxt ' m/s  /  ' VelAfterBOtxt ' m/s'];
        end;
        
        lineEC = lineEC + 8;
    end;
end;

Last5mtxt = timeSecToStr(Last5m);
if isInterpolatedFinish == 0;
    %no interpolation
    dataTableSkill{lineEC+1,3} = Last5mtxt;
else;
    %Interpolation
    dataTableSkill{lineEC+1,3} = [Last5mtxt ' !'];
end;

GlideLastStrokeDist = roundn(GlideLastStroke(3,end),-2);
GlideLastStrokeTime = roundn(GlideLastStroke(4,end),-2);
GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
if Source == 1 | Source == 3;
    dataTableSkill{lineEC+2,3} = [' na  /  na '];
else;
    dataTableSkill{lineEC+2,3} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
end;





    
