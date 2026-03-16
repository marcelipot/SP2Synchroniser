function [dataTableSkillTXT, dataTableSkillVAL] = create_skilltable_SP2Report_synchroniser(StrokeType, NbLap, RaceDist, Course, ...
    SplitsAll, BOAll, Year, TotalSkillTime, Turn_Time, Turn_TimeIn, Turn_TimeOut, DiveT15, RT, ...
    KicksNb, BOEff, VelAfterBO, VelBeforeBO, ...
    Last5m, ApproachEff, ApproachSpeed2CycleAll, ApproachSpeedLastCycleAll, GlideLastStroke, ...
    StartUWVelocity, StartEntryDist, StartUWDist, StartUWTime);



Turn_TimeALL = [];
Turn_TimeInALL = [];
Turn_TimeOutALL = [];

NbLap = roundn(RaceDist./Course,0);
TT = SplitsAll(end,2);
TTtxt = timeSecToStr(TT);


%%%Totals
TotalSkillTimetxt = timeSecToStr(TotalSkillTime);
Turn_TimeALL = Turn_Time;
Turn_TimeInALL = Turn_TimeIn;
Turn_TimeOutALL = Turn_TimeOut;
Turn_Timetxt = timeSecToStr(roundn(sum(Turn_Time),-2));
Turn_TimeIntxt = timeSecToStr(roundn(sum(Turn_TimeIn),-2));
Turn_TimeOuttxt = timeSecToStr(roundn(sum(Turn_TimeOut),-2));

%%%%Start
SplitsAll = SplitsAll(2:end,:);

DiveT15txt = timeSecToStr(roundn(DiveT15,-2));

RTtxt = timeSecToStr(roundn(RT,-2));

BOdisttxt = dataToStr(BOAll(1,3),1);

BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));

BOEfftxt = dataToStr(BOEff(1,1).*100,1);
VelAftertxt = dataToStr(VelAfterBO(1,1),2);
VelBeforetxt = dataToStr(VelBeforeBO(1,1),2);

%%%%Turns averages
if NbLap == 1;
    AvTurnIn = [];
    AvTurnOut = [];
    AvTurnTime = [];
    AvTurnInALL = [];
    AvTurnOutALL = [];
    AvTurnTimeALL = [];
    AvTurnIntxt = '';
    AvTurnOuttxt = '';
    AvTurnTimetxt = '';

    AvKicksNb = [];
    AvKicksNbtxt = [];

    AvBODistTurn = [];
    AvBODistTurntxt = '';
    
    AvBOTimeTurn = [];
    AvBOTimeTurntxt = '';
    
    BOEffTurn = [];
    BOEffTurnAll = [];
    BOEffTurntxt = '';
    VelBefTurn = [];
    VelBefTurnAll = [];
    VelBefTurntxt = '';
    VelAftTurn = [];
    VelAftTurnAll = [];
    VelAftTurntxt = '';
else;
    AvTurnIn = roundn(mean(Turn_TimeIn),-2);
    AvTurnOut = roundn(mean(Turn_TimeOut),-2);
    AvTurnTime = roundn(mean(Turn_Time),-2);
    AvTurnInALL = AvTurnIn;
    AvTurnOutALL = AvTurnOut;
    AvTurnTimeALL = AvTurnTime;
    AvTurnIntxt = timeSecToStr(roundn(AvTurnIn,-2));
    AvTurnOuttxt = timeSecToStr(roundn(AvTurnOut,-2));
    AvTurnTimetxt = timeSecToStr(roundn(AvTurnTime,-2));    

    AvKicksNb = roundn(mean(KicksNb(2:end)),-2);
    AvKicksNbtxt = dataToStr(AvKicksNb,1);

    BOTurn = [];
    for lap = 2:NbLap
        BO = BOAll(lap,3);
        BO = BO - ((lap-1).*Course);
        BOTurn = [BOTurn BO];
    end;
    AvBODistTurn = roundn(mean(BOTurn),-2);
    AvBODistTurntxt = dataToStr(AvBODistTurn,1);
    
    BOTurn = [];
    for lap = 2:NbLap;
        BO = BOAll(lap,2);
        BO = BO - SplitsAll(lap-1,2);
        BOTurn = [BOTurn BO];
    end;
    AvBOTimeTurn = roundn(mean(BOTurn),-2);
    AvBOTimeTurntxt = timeSecToStr(AvBOTimeTurn);
    
    BOEffTurn = BOEff(2:end);
    BOEffTurnAll = BOEffTurn;
    BOEffTurn = roundn(mean(BOEffTurn).*100,-2);
    BOEffTurntxt = dataToStr(BOEffTurn,1);
    VelBefTurn = roundn(mean(VelBeforeBO(2:end)),-2);
    VelBefTurnAll = VelBeforeBO(2:end);
    VelBefTurntxt = dataToStr(VelBefTurn,2);
    VelAftTurn = roundn(mean(VelAfterBO(2:end)),-2);
    VelAftTurnAll = VelAfterBO(2:end);
    VelAftTurntxt = dataToStr(VelAftTurn,2);
end;

Last5mtxt = timeSecToStr(Last5m);


dataTableSkillTXT{1,1} = TotalSkillTimetxt;
dataTableSkillTXT{1,2} = Turn_Timetxt;
dataTableSkillTXT{1,3} = Turn_TimeIntxt;
dataTableSkillTXT{1,4} = Turn_TimeOuttxt;
dataTableSkillTXT{1,5} = DiveT15txt;
dataTableSkillTXT{1,6} = BOdisttxt;
dataTableSkillTXT{1,7} = BOTimetxt;
dataTableSkillTXT{1,8} = BOEfftxt;
dataTableSkillTXT{1,9} = VelAftertxt;
dataTableSkillTXT{1,10} = VelBeforetxt;
dataTableSkillTXT{1,11} = AvTurnIntxt;
dataTableSkillTXT{1,12} = AvTurnOuttxt;
dataTableSkillTXT{1,13} = AvTurnTimetxt;
dataTableSkillTXT{1,14} = AvKicksNbtxt;
dataTableSkillTXT{1,15} = AvBODistTurntxt;
dataTableSkillTXT{1,16} = AvBOTimeTurntxt;
dataTableSkillTXT{1,17} = BOEffTurntxt;
dataTableSkillTXT{1,18} = VelBefTurntxt;
dataTableSkillTXT{1,19} = VelAftTurntxt;
dataTableSkillTXT{1,20} = Last5mtxt;
dataTableSkillTXT{1,21} = TTtxt;
dataTableSkillTXT{1,22} = RTtxt;

dataTableSkillVAL{1,1} = TotalSkillTime;
dataTableSkillVAL{1,2} = Turn_TimeALL;
dataTableSkillVAL{1,3} = Turn_TimeInALL;
dataTableSkillVAL{1,4} = Turn_TimeOutALL;
dataTableSkillVAL{1,5} = roundn(DiveT15,-2);
dataTableSkillVAL{1,6} = roundn(BOAll(1,3),-1);
dataTableSkillVAL{1,7} = roundn(BOAll(1,2),-2);
dataTableSkillVAL{1,8} = roundn(BOEff(1,1).*100, -1);
dataTableSkillVAL{1,9} = roundn(VelAfterBO(1,1), -2);
dataTableSkillVAL{1,10} = roundn(VelBeforeBO(1,1), -2);
dataTableSkillVAL{1,11} = AvTurnIn;
dataTableSkillVAL{1,12} = AvTurnOut;
dataTableSkillVAL{1,13} = AvTurnTime;
dataTableSkillVAL{1,14} = AvKicksNb;
dataTableSkillVAL{1,15} = roundn(AvBODistTurn,-1);
dataTableSkillVAL{1,16} = AvBOTimeTurn;
dataTableSkillVAL{1,17} = BOEffTurn;
dataTableSkillVAL{1,18} = VelBefTurn;
dataTableSkillVAL{1,19} = VelAftTurn;
dataTableSkillVAL{1,20} = Last5m;
dataTableSkillVAL{1,21} = TT;
dataTableSkillVAL{1,22} = roundn(RT,-2);
dataTableSkillVAL{1,23} = SplitsAll;
dataTableSkillVAL{1,24} = BOAll;
dataTableSkillVAL{1,25} = BOEffTurnAll;
dataTableSkillVAL{1,26} = VelBefTurnAll;
dataTableSkillVAL{1,27} = VelAftTurnAll;
dataTableSkillVAL{1,28} = ApproachEff;
dataTableSkillVAL{1,29} = ApproachSpeed2CycleAll;
dataTableSkillVAL{1,30} = ApproachSpeedLastCycleAll;
dataTableSkillVAL{1,31} = GlideLastStroke;
dataTableSkillVAL{1,32} = StartUWVelocity;
dataTableSkillVAL{1,33} = StartEntryDist;
dataTableSkillVAL{1,34} = StartUWDist;
dataTableSkillVAL{1,35} = StartUWTime;
