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
colorrow(9,:) = [1 0.9 0.70];
colorrow(10,:) = [0.9 0.9 0.9];
colorrow(11,:) = [0.75 0.75 0.75];
colorrow(12,:) = [0.9 0.9 0.9];
colorrow(13,:) = [0.75 0.75 0.75];
colorrow(14,:) = [1 0.9 0.70];
colorrow(15,:) = [0.9 0.9 0.9];
colorrow(16,:) = [0.75 0.75 0.75];
colorrow(17,:) = [0.9 0.9 0.9];
colorrow(18,:) = [0.75 0.75 0.75];
colorrow(19,:) = [0.9 0.9 0.9];
colorrow(20,:) = [0.75 0.75 0.75];
colorrow(21,:) = [0.9 0.9 0.9];
colorrow(22,:) = [0.75 0.75 0.75];
colorrow(23,:) = [0.9 0.9 0.9];
colorrow(24,:) = [0.75 0.75 0.75];
colorrow(25,:) = [1 0.9 0.70];
colorrow(26,:) = [0.9 0.9 0.9];
colorrow(27,:) = [0.75 0.75 0.75];
colorrow(28,:) = [0.9 0.9 0.9];
colorrow(29,:) = [0.75 0.75 0.75];
colorrow(30,:) = [0.9 0.9 0.9];

formatlist{1} = 'char';
formatlist{2} = 'char';
edittablelist(1) = false;
edittablelist(2) = false;
for i = 1:nbRaces;
    formatlist{i+2} = 'numeric';
    edittablelist(i+2) = false;
end;

if strcmpi(origin, 'table') == 1;
    PosINI = get(handles.SkillData_table_analyser, 'Position');
    posCorr = PosINI;
    PosINI = PosINI(3);
    posCorr(3) = PosINI - handles.diffPosSkillTable;
    set(handles.SkillData_table_analyser, 'Position', posCorr);

    set(handles.SkillData_table_analyser, 'units', 'pixels', 'ColumnFormat', formatlist, ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', 10, 'ColumnEditable', edittablelist, ...
        'rowstriping', 'on');
    pos = get(handles.SkillData_table_analyser, 'position');
    
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
    set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
end;


% set(handles.SkillData_table_analyser, 'Units', 'normalized');


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


for i = 3:nbRaces+2;

    %----------------------------------Meta--------------------------------
    UID = RaceUID{i-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['dataTableSkill{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableSkill{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTableSkill{4,' num2str(i) '} = str;']);
    eval(['dataTableSkill{5,' num2str(i) '} = handles.RacesDB.' UID '.Stage;']);
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTableSkill{6,i} = TTtxt;



    %--------------------------------Skills--------------------------------
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    if i == 3;
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

            colorrow(lineEC,:) = [1 0.9 0.70];
            colorrow(lineEC+1,:) = [0.9 0.9 0.9];
            colorrow(lineEC+2,:) = [0.75 0.75 0.75];
            colorrow(lineEC+3,:) = [0.9 0.9 0.9];
            colorrow(lineEC+4,:) = [0.75 0.75 0.75];
            colorrow(lineEC+5,:) = [0.9 0.9 0.9];
            colorrow(lineEC+6,:) = [0.75 0.75 0.75];
            colorrow(lineEC+7,:) = [0.9 0.9 0.9];

            lineEC = lineEC + 8;
        end;

        dataTableSkill{lineEC,1} = 'Finish';
        dataTableSkill{lineEC+1,2} = 'Last 5m Time';
        dataTableSkill{lineEC+2,2} = 'Glide-Wall (Dist/Time)';
        colorrow(lineEC,:) = [1 0.9 0.70];
        colorrow(lineEC+1,:) = [0.9 0.9 0.9];
        colorrow(lineEC+2,:) = [0.75 0.75 0.75];
    end;

    %%%Totals
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTime;']);
    TotalSkillTimetxt = timeSecToStr(TotalSkillTime);
    dataTableSkill{10,i} = TotalSkillTimetxt;

    dataTableSkill{11,i} = 'na'; %Total underwater Distance
    dataTableSkill{12,i} = 'na'; %Total underwater Time
    
    eval(['Turn_Time = handles.RacesDB.' UID '.Turn_TimeINI;']);%%%%%%%%%%%%%%
    eval(['Turn_TimeIn = handles.RacesDB.' UID '.Turn_TimeInINI;']);%%%%%%%%%%
    eval(['Turn_TimeOut = handles.RacesDB.' UID '.Turn_TimeOutINI;']);%%%%%%%%
    Turn_TimeALL = [];
    Turn_TimeInALL = [];
    Turn_TimeOutALL = [];
    Turn_TimeALL(:,:,i-2) = Turn_Time;
    Turn_TimeInALL(:,:,i-2) = Turn_TimeIn;
    Turn_TimeOutALL(:,:,i-2) = Turn_TimeOut;
    Turn_Timetxt = timeSecToStr(roundn(sum(Turn_Time),-2));
    Turn_TimeIntxt = timeSecToStr(roundn(sum(Turn_TimeIn),-2));
    Turn_TimeOuttxt = timeSecToStr(roundn(sum(Turn_TimeOut),-2));
    dataTableSkill{13,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];

    
    %%%%Start
    SplitsAll = SplitsAll(2:end,:);

    eval(['DiveT15 = handles.RacesDB.' UID '.DiveT15INI;']);%%%%%%%%%%%%%%%%%%
    DiveT15txt = timeSecToStr(roundn(DiveT15,-2));
    dataTableSkill{15,i} = DiveT15txt;
    
    eval(['RT = handles.RacesDB.' UID '.RT;']);
    RTtxt = timeSecToStr(roundn(RT,-2));
    dataTableSkill{16,i} = RTtxt;
    
    eval(['StartUWVelocity = handles.RacesDB.' UID '.StartUWVelocity;']);
    eval(['StartEntryDist = handles.RacesDB.' UID '.StartEntryDist;']);
    eval(['StartUWDist = handles.RacesDB.' UID '.StartUWDist;']);
    eval(['StartUWTime = handles.RacesDB.' UID '.StartUWTime;']);
    if isempty(StartUWVelocity) == 1;
        dataTableSkill{17,i} = 'na';    %Entry Distance
        dataTableSkill{18,i} = 'na';    %Unverwater Distance
        dataTableSkill{19,i} = 'na';    %Unverwater Time
        dataTableSkill{20,i} = 'na';    %Unverwater Speed
    else;
        dataTableSkill{17,i} = [dataToStr(StartEntryDist, 2) ' m'];     %Entry Distance
        dataTableSkill{18,i} = [dataToStr(StartUWDist, 2) ' m'];        %Unverwater Distance
        dataTableSkill{19,i} = timeSecToStr(StartUWTime);               %Unverwater Time
        dataTableSkill{20,i} = [dataToStr(StartUWVelocity, 2) ' m/s'];  %Unverwater Speed
    end;
    
    eval(['KicksNb = handles.RacesDB.' UID '.KicksNb;']);
    dataTableSkill{21,i} = [num2str(KicksNb(1)) ' Kicks'];
    
    eval(['BOAll = handles.RacesDB.' UID '.BOAllINI;']);%%%%%%%%%%%%%%%%%%%%%%
    BOdisttxt = dataToStr(BOAll(1,3),1);
    dataTableSkill{22,i} = [BOdisttxt ' m'];
    
    BOTimetxt = timeSecToStr(roundn(BOAll(1,2),-2));
    dataTableSkill{23,i} = BOTimetxt;
    
    eval(['BOEff = handles.RacesDB.' UID '.BOEff;']);
    eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
    eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
    BOEfftxt = dataToStr(BOEff(1,1).*100,1);
    VelAftertxt = dataToStr(VelAfterBO(1,1),2);
    VelBeforetxt = dataToStr(VelBeforeBO(1,1),2);
    dataTableSkill{24,i} = [BOEfftxt ' %  /  ' VelBeforetxt ' m/s  /  ' VelAftertxt ' m/s'];
    
    
    %%%%Turns averages
    if NbLap == 1;
        dataTableSkill{26,i} = '  -  /  -  /  -  ';
        dataTableSkill{27,i} = '  -  ';
        dataTableSkill{28,i} = '  -  ';
        dataTableSkill{29,i} = '  -  ';
        dataTableSkill{30,i} = '  -  ';
    else;
        AvTurnIn = roundn(mean(Turn_TimeIn),-2);
        AvTurnOut = roundn(mean(Turn_TimeOut),-2);
        AvTurnTime = roundn(mean(Turn_Time),-2);
        AvTurnInALL(:,:,i-2) = AvTurnIn;
        AvTurnOutALL(:,:,i-2) = AvTurnOut;
        AvTurnTimeALL(:,:,i-2) = AvTurnTime;
        AvTurnIntxt = timeSecToStr(roundn(AvTurnIn,-2));
        AvTurnOuttxt = timeSecToStr(roundn(AvTurnOut,-2));
        AvTurnTimetxt = timeSecToStr(roundn(AvTurnTime,-2));    
        dataTableSkill{26,i} = [AvTurnIntxt '  /  ' AvTurnOuttxt '  /  ' AvTurnTimetxt];

        AvKicksNb = roundn(mean(KicksNb(2:end)),-2);
        AvKicksNbtxt = dataToStr(AvKicksNb,1);
        dataTableSkill{27,i} = [AvKicksNbtxt ' Kicks'];

        BOTurn = [];
        for lap = 2:NbLap;
            BO = BOAll(lap,3);
            BO = BO - ((lap-1).*Course);
            BOTurn = [BOTurn BO];
        end;
        AvBODistTurn = roundn(mean(BOTurn),-2);
        AvBODistTurntxt = dataToStr(AvBODistTurn,1);
        dataTableSkill{28,i} = [AvBODistTurntxt ' m'];

        BOTurn = [];
        for lap = 2:NbLap;
            BO = BOAll(lap,2);
            BO = BO - SplitsAll(lap-1,2);
            BOTurn = [BOTurn BO];
        end;
        AvBOTimeTurn = roundn(mean(BOTurn),-2);
        AvBOTimeTurntxt = timeSecToStr(AvBOTimeTurn);
        dataTableSkill{29,i} = AvBOTimeTurntxt;

        eval(['BOEffTurn = handles.RacesDB.' UID '.BOEff(2:end);']);
        BOEffTurn = roundn(mean(BOEffTurn).*100,-2);
        BOEffTurntxt = dataToStr(BOEffTurn,1);
        VelBefTurn = roundn(mean(VelBeforeBO(2:end)),-2);
        VelBefTurntxt = dataToStr(VelBefTurn,2);
        VelAftTurn = roundn(mean(VelAfterBO(2:end)),-2);
        VelAftTurntxt = dataToStr(VelAftTurn,2);
        dataTableSkill{30,i} = [BOEffTurntxt ' %  /  ' VelBefTurntxt ' m/s  /  ' VelAftTurntxt ' m/s'];            
    end;
    

    %%%%Turn Details
    if NbLap ~= 1;
        lineEC = 31;
        for lap = 1:NbLap-1;
            dataTableSkill{lineEC,1} = ['Turn ' num2str(lap)];

            Turn_TimeIntxt = timeSecToStr(roundn(Turn_TimeIn(lap),-2));
            Turn_TimeOuttxt = timeSecToStr(roundn(Turn_TimeOut(lap),-2));
            Turn_Timetxt = timeSecToStr(roundn(Turn_Time(lap),-2));
            dataTableSkill{lineEC+1,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];

            eval(['ApproachEff = handles.RacesDB.' UID '.ApproachEff;']);
            eval(['Approach2CycleAll = handles.RacesDB.' UID '.ApproachSpeed2CycleAll;']);
            eval(['ApproachLastCycleAll = handles.RacesDB.' UID '.ApproachSpeedLastCycleAll;']);
            ApproachEffTurn = roundn(ApproachEff(lap).*100,-2);
            ApproachEffTurntxt = dataToStr(ApproachEffTurn,1);
            Approach2CycleAlltxt = dataToStr(Approach2CycleAll(lap),2);
            ApproachLastCycleAlltxt = dataToStr(ApproachLastCycleAll(lap),2);
            dataTableSkill{lineEC+2,i} = [ApproachEffTurntxt ' %  /  ' Approach2CycleAlltxt ' m/s  /  ' ApproachLastCycleAlltxt ' m/s'];

            eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
            GlideLastStrokeDist = roundn(GlideLastStroke(3,lap),-2);
            GlideLastStrokeTime = roundn(GlideLastStroke(4,lap),-2);
            GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
            GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
            dataTableSkill{lineEC+3,i} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
            
            KicksNbtxt = dataToStr(KicksNb(lap+1),0);
            dataTableSkill{lineEC+4,i} = [KicksNbtxt ' Kicks'];

            BO = BOAll(lap+1,3);
            BO = roundn(BO - (lap.*Course),-2);
            BOdisttxt = dataToStr(BO,1);
            dataTableSkill{lineEC+5,i} = [BOdisttxt ' m'];
            
            BO = BOAll(lap+1,2);
            BO = BO - SplitsAll(lap,2);
            BOtimetxt = timeSecToStr(BO);
            dataTableSkill{lineEC+6,i} = BOtimetxt;

            eval(['BOEffTurn = handles.RacesDB.' UID '.BOEff;']);
            eval(['VelAfterBO = handles.RacesDB.' UID '.VelAfterBO;']);
            eval(['VelBeforeBO = handles.RacesDB.' UID '.VelBeforeBO;']);
            BOEffTurntxt = dataToStr(BOEffTurn(lap+1).*100,1);
            
            VelAfterBOtxt = dataToStr(VelAfterBO(lap+1),2);
            VelBeforeBOtxt = dataToStr(VelBeforeBO(lap+1),2);
            dataTableSkill{lineEC+7,i} = [BOEffTurntxt ' %  /  ' VelBeforeBOtxt ' m/s  /  ' VelAfterBOtxt ' m/s'];
            
            lineEC = lineEC + 8;
        end;
    end;

    eval(['Last5m = handles.RacesDB.' UID '.Last5mINI;']);%%%%%%%%%%%%%%%%%%%%%
    Last5mtxt = timeSecToStr(Last5m);
    dataTableSkill{lineEC+1,i} = Last5mtxt;

    if NbLap == 1;
        eval(['GlideLastStroke = handles.RacesDB.' UID '.GlideLastStroke;']);
    end;
    GlideLastStrokeDist = roundn(GlideLastStroke(3,end),-2);
    GlideLastStrokeTime = roundn(GlideLastStroke(4,end),-2);
    GlideLastStrokeDisttxt = dataToStr(GlideLastStrokeDist,2);
    GlideLastStrokeTimetxt = timeSecToStr(GlideLastStrokeTime);
    dataTableSkill{lineEC+2,i} = [GlideLastStrokeDisttxt ' m  /  ' GlideLastStrokeTimetxt];
end;

handles.dataTableSkill = dataTableSkill;
handles.colorrowSkill = colorrow;

% if strcmpi(origin, 'table') == 1;
%     set(handles.StrokeData_table_analyser, 'Visible', 'off');
%     set(handles.SkillData_table_analyser, 'data', dataTableSkill, 'backgroundcolor', colorrow);
%     set(handles.PacingData_table_analyser, 'Visible', 'off');
%     set(handles.SummaryData_table_analyser, 'Visible', 'off');
% 
%     table_extent = get(handles.SkillData_table_analyser, 'Extent');
%     table_position = get(handles.SkillData_table_analyser, 'Position');
%     pos_cor = table_position;
%     if table_extent(4) < table_position(4);
% 
%         if Extent == 0;
%             %Add 5% to give space for the slider bar at the bottom
%             offset = 18;
%             pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)-offset;
%             pos_cor(4) = table_extent(4)+offset;
%         else;
%             pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)+1;
%             pos_cor(4) = table_extent(4)+1;
%         end;
% 
%     elseif table_extent(4) >= table_position(4);
%         if table_position(2) < (0.0069*PosFig(4));
%             pos_cor(2) = (0.0069*PosFig(4))+1;
%             pos_cor(4) = (handles.TopINI_SkillTable*PosFig(4))+1;
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
%             set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
%         else;
%             if table_position(2)+table_position(4)-table_extent(4)+1 < (0.0069*PosFig(4));
%                 pos_cor(2) = (0.0069*PosFig(4))+1;
%                 pos_cor(4) = (handles.TopINI_SkillTable*PosFig(4))+1;
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
%                 set(handles.SkillData_table_analyser, 'ColumnWidth', ColWidth);
%             else;
%                 if Extent == 0;
%                     %Add 5% to give space for the slider bar at the bottom
%                     offset = 18;
%                     pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)-offset;
%                     pos_cor(4) = table_extent(4)+offset;
%                 else;
%                     pos_cor(2) = (handles.TopINI_SkillTable*PosFig(4))-table_extent(4)+1;
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
%     set(handles.SkillData_table_analyser, 'Visible', 'on', 'Position', pos_cor);
%     set(handles.SkillData_table_analyser, 'Units', 'normalized');
% 
%     PosEND = get(handles.SkillData_table_analyser, 'Position');
%     PosEND = PosEND(3);
%     handles.diffPosSkillTable = PosEND - handles.PosINI_SkillTable;
% end;
    
