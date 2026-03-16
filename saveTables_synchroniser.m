%--------------------------Create summary table----------------------------
%--------------------------------------------------------------------------
dataTableSummary = {};
dataTableSummary{1,2} = 'Metadata';
dataTableSummary{8,2} = 'Summary';

dataTableSummary{9,1} = 'Skills';
dataTableSummary{14,1} = 'SR / SL / Stroke';
dataTableSummary{18,1} = 'Splits';
        
dataTableSummary{10,2} = 'Start Time';
dataTableSummary{11,2} = 'Finish Time';
dataTableSummary{12,2} = 'Tot Turn';
dataTableSummary{13,2} = 'Tot Skill';
dataTableSummary{15,2} = 'Out';
dataTableSummary{16,2} = 'Back';
dataTableSummary{17,2} = 'Drop Off';
dataTableSummary{19,2} = 'Out';
dataTableSummary{20,2} = 'Back';
dataTableSummary{21,2} = 'Drop Off';

rgb_val = @(r,g,b) r*1+g*256+b*256^2;
colorrowSummary(1) = rgb_val(255,230,26); %44
colorrowSummary(2) = rgb_val(230,230,230); %15
colorrowSummary(3) = rgb_val(192,192,192); %16
colorrowSummary(4) = rgb_val(230,230,230);
colorrowSummary(5) = rgb_val(192,192,192);
colorrowSummary(6) = rgb_val(230,230,230);
colorrowSummary(7) = rgb_val(255,255,255); %2
colorrowSummary(8) = rgb_val(255,230,26);
colorrowSummary(9) = rgb_val(255,230,179); %40
colorrowSummary(10) = rgb_val(230,230,230);
colorrowSummary(11) = rgb_val(192,192,192);
colorrowSummary(12) = rgb_val(230,230,230);
colorrowSummary(13) = rgb_val(192,192,192);
colorrowSummary(14) = rgb_val(255,230,179);
colorrowSummary(15) = rgb_val(230,230,230);
colorrowSummary(16) = rgb_val(192,192,192);
colorrowSummary(17) = rgb_val(230,230,230);
colorrowSummary(18) = rgb_val(255,230,179);
colorrowSummary(19) = rgb_val(230,230,230);
colorrowSummary(20) = rgb_val(192,192,192);
colorrowSummary(21) = rgb_val(230,230,230);
colorrowSummary(22) = rgb_val(192,192,192);
colorrowSummary(23) = rgb_val(230,230,230);
colorrowSummary(24) = rgb_val(192,192,192);
colorrowSummary(25) = rgb_val(230,230,230);
colorrowSummary(26) = rgb_val(192,192,192);
colorrowSummary(27) = rgb_val(230,230,230);
colorrowSummary(28) = rgb_val(192,192,192);
colorrowSummary(29) = rgb_val(230,230,230);
colorrowSummary(30) = rgb_val(192,192,192);
colorrowSummary(31) = rgb_val(230,230,230);
colorrowSummary(32) = rgb_val(192,192,192);
colorrowSummary(33) = rgb_val(230,230,230);
colorrowSummary(34) = rgb_val(192,192,192);
colorrowSummary(35) = rgb_val(230,230,230);
colorrowSummary(36) = rgb_val(192,192,192);
colorrowSummary(37) = rgb_val(230,230,230);
colorrowSummary(38) = rgb_val(192,192,192);
colorrowSummary(39) = rgb_val(230,230,230);
colorrowSummary(40) = rgb_val(192,192,192);
colorrowSummary(41) = rgb_val(230,230,230);
colorrowSummary(42) = rgb_val(192,192,192);
colorrowSummary(43) = rgb_val(230,230,230);
colorrowSummary(44) = rgb_val(192,192,192);
colorrowSummary(45) = rgb_val(230,230,230);
colorrowSummary(46) = rgb_val(192,192,192);
colorrowSummary(47) = rgb_val(230,230,230);
colorrowSummary(48) = rgb_val(192,192,192);
colorrowSummary(49) = rgb_val(230,230,230);
colorrowSummary(50) = rgb_val(192,192,192);
colorrowSummary(51) = rgb_val(230,230,230);
colorrowSummary(52) = rgb_val(192,192,192);
colorrowSummary(53) = rgb_val(230,230,230);
colorrowSummary(54) = rgb_val(192,192,192);
colorrowSummary(55) = rgb_val(230,230,230);
colorrowSummary(56) = rgb_val(192,192,192);
colorrowSummary(57) = rgb_val(230,230,230);
colorrowSummary(58) = rgb_val(192,192,192);
colorrowSummary(59) = rgb_val(230,230,230);
colorrowSummary(60) = rgb_val(192,192,192);


for i = 3:nbRaces+2;

    %----------------------------------Meta--------------------------------
    UID = RaceUID{i-2};
    li = findstr(UID, '-');
    UID(li) = '_';
    UID = ['A' UID 'A'];
    
    eval(['Athletename = handles.RacesDB.' UID '.Athletename;']);
    eval(['dataTableSummary{2,' num2str(i) '} = Athletename;']);
    
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['StrokeType = handles.RacesDB.' UID '.StrokeType;']);
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTableSummary{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTableSummary{4,' num2str(i) '} = str;']);
    eval(['dataTableSummary{5,' num2str(i) '} = handles.RacesDB.' UID '.Stage;']);
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTableSummary{6,i} = TTtxt;

    %--------------------------------Summary-------------------------------
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    
    eval(['ST = handles.RacesDB.' UID '.DiveT15;']);
    STtxt = timeSecToStr(ST);
    eval(['dataTableSummary{10,' num2str(i) '} = STtxt;']);
    
    eval(['TL = handles.RacesDB.' UID '.Last5m;']);
    TLtxt = timeSecToStr(TL);
    eval(['dataTableSummary{11,' num2str(i) '} = TLtxt;']);
    
    if NbLap == 1;
        dataTableSummary{12,i} = ['  -  '];
    else;
        eval(['TurnsTotal = handles.RacesDB.' UID '.TurnsTotal;']);
        TT = TurnsTotal(:,3);
        TTtxt = timeSecToStr(TT);
        dataTableSummary{12,i} = TTtxt;
    end;
    
    eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTime;']);
    TotalSkillTimetxt = timeSecToStr(TotalSkillTime);
    dataTableSummary{13,i} = TotalSkillTimetxt;

    eval(['SREC = handles.RacesDB.' UID '.Stroke_SR;']);
    SRMOut = [];
    if NbLap == 1;
        li = find(SREC(1, :) ~= 0);
        SRMOut = roundn(mean(SREC(1, li)),-1);
    else;
        for lap = 1:NbLap/2;
            li = find(SREC(lap, :) ~= 0);
            SRMOut = roundn([SRMOut mean(SREC(lap, li))],-1);
        end;
        SRMOut = mean(SRMOut);
        SRMBack = [];
        for lap = (NbLap/2)+1:NbLap;
            li = find(SREC(lap, :) ~= 0);
            SRMBack = roundn([SRMBack mean(SREC(lap, li))],-1);
        end;
        SRMBack = mean(SRMBack);
    end;
    
    eval(['SLEC = handles.RacesDB.' UID '.Stroke_Distance;']);
    SLMOut = [];
    if NbLap == 1;
        li = find(SLEC(1, :) ~= 0);
        SLMOut = roundn(mean(SLEC(1, li)),-1);
    else;
        for lap = 1:NbLap/2;
            li = find(SLEC(lap, :) ~= 0);
            SLMOut = roundn([SLMOut mean(SLEC(lap, li))],-2);
        end;
        SLMOut = roundn(mean(SLMOut), -2);
        SLMBack = [];
        for lap = (NbLap/2)+1:NbLap;
            li = find(SLEC(lap, :) ~= 0);
            SLMBack = roundn([SLMBack mean(SLEC(lap, li))],-2);
        end;
        SLMBack = roundn(mean(SLMBack), -2);
    end;
    
    eval(['SNEC = handles.RacesDB.' UID '.Stroke_Count;']);
    if NbLap == 1;
        li = find(SNEC(1, :) ~= 0);
        SNMOut = roundn(mean(SNEC(1, li)),-1);
    else;
        SNMOut = [];
        for lap = 1:NbLap/2;
            SNMOut = [SNMOut SNEC(lap)];
        end;
        SNMOut = sum(SNMOut);

        SNMBack = [];
        for lap = (NbLap/2)+1:NbLap;
            SNMBack = [SNMBack SNEC(lap)];
        end;
        SNMBack = sum(SNMBack);
    end;

    SRMOuttxt = dataToStr(SRMOut,1);
    SLMOuttxt = dataToStr(SLMOut,2);
    SNMOuttxt = num2str(SNMOut);
    dataTableSummary{15,i} = [SRMOuttxt ' cyc/min' '   ' SLMOuttxt ' m' '   ' SNMOuttxt ' str'];
    
    if NbLap == 1
        dataTableSummary{16,i} = ['  -  /  -  /  -  '];
    else;
        SRMBacktxt = dataToStr(SRMBack,1);
        SLMBacktxt = dataToStr(SLMBack,2);
        SNMBacktxt = num2str(SNMBack);

        dataTableSummary{16,i} = [SRMBacktxt ' cyc/min' '   ' SLMBacktxt ' m' '   ' SNMBacktxt ' str'];
    end;
    
    if NbLap == 1;
        dataTableSummary{17,i} = ['  -  /  -  /  -  '];
    else;
        diffSRMtxt = dataToStr(SRMBack-SRMOut,1);
        if (SRMBack-SRMOut) < 0;
            diffSRMtxt = ['-' diffSRMtxt(2:end)];
        elseif (SRMBack-SRMOut) > 0;
            diffSRMtxt = ['+' diffSRMtxt];
        else;
            diffSRMtxt = ['=' diffSRMtxt];
        end;
        diffSLMtxt = dataToStr(SLMBack-SLMOut,2);
        if (SLMBack-SLMOut) < 0;
            diffSLMtxt = ['-' diffSLMtxt(2:end)];
        elseif (SRMBack-SRMOut) > 0;
            diffSLMtxt = ['+' diffSLMtxt];
        else;
            diffSLMtxt = ['=' diffSLMtxt];
        end;

        diffStrtxt = num2str(SNMBack-SNMOut);
        if roundn((SNMBack-SNMOut),0) < 0;
            diffStrtxt = ['-' diffStrtxt(2:end)];
        elseif roundn((SNMBack-SNMOut),0) > 0;
            diffStrtxt = ['+' diffStrtxt];
        else;
            diffStrtxt = ['=' diffStrtxt];
        end;
        dataTableSummary{17,i} = [diffSRMtxt ' cyc/min' '   ' diffSLMtxt ' m' '   ' diffStrtxt ' str'];
    end;
    
    eval(['RT = handles.RacesDB.' UID '.RT;']);
    eval(['RaceDist = handles.RacesDB.' UID '.RaceDist;']);
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    SplitsAll = SplitsAll(2:end,:);

    RTtxt = timeSecToStr(roundn(RT,-2));
    if NbLap == 1;
        SplitEnd = SplitsAll(end,2);
        SplitEndtxt = timeSecToStr(SplitEnd);
        
        dataTableSummary{19,i} =  [SplitEndtxt ' (100 %)'];
        dataTableSummary{20,i} =  '-';
        dataTableSummary{21,i} =  '-';
    else;
        SplitMid = SplitsAll(NbLap./2,2);
        SplitEnd = SplitsAll(NbLap,2) - SplitMid;
        SplitMidP = roundn((SplitMid/SplitsAll(NbLap,2)*100), -2);
        SplitEndP = roundn((SplitEnd/SplitsAll(NbLap,2)*100), -2);
        DropOff = SplitEnd - SplitMid;
        
        SplitMidtxt = timeSecToStr(SplitMid);
        SplitEndtxt = timeSecToStr(SplitEnd);
        SplitMidPtxt = dataToStr(SplitMidP,2);
        SplitEndPtxt = dataToStr(SplitEndP,2);
        dataTableSummary{19,i} =  [SplitMidtxt ' (' num2str(SplitMidPtxt) ' %)'];
        dataTableSummary{20,i} =  [SplitEndtxt ' (' num2str(SplitEndPtxt) ' %)'];
        
        DropOfftxt = num2str(DropOff);
        if DropOff > 0;
            DropOfftxt = ['+' DropOfftxt ' s'];
        elseif DropOff < 0;
            DropOfftxt = ['-' DropOfftxt(2:end) ' s'];
        else;
            DropOfftxt = ['=' DropOfftxt ' s'];
        end;
        dataTableSummary{21,i} =  DropOfftxt;
    end;
    
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    dataTableSummary{22,2} = 'Block';
    dataTableSummary{22,i} = RTtxt;
    if RaceDist == 50;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 24;
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;
            
            limli_Summary = 23;
        end;

    elseif RaceDist == 100;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '75m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(3,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 24;
        end;
        
    elseif RaceDist == 150;
        if Course == 25;
            dataTableSummary{23,2} = '25m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '50m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '75m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(3,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            dataTableSummary{27,2} = '125m';
            dataTOTtxt = timeSecToStr(SplitsAll(5,2));
            datatxt = timeSecToStr(SplitsAll(5,2)-SplitsAll(4,2));
            dataTableSummary{27,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{28,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2)-SplitsAll(5,2));
            dataTableSummary{28,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 28;
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 25;
        end;
        
    elseif RaceDist == 200;
        if Course == 25;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(2,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(2,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2)-SplitsAll(4,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2)-SplitsAll(6,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '50m';
            datatxt = timeSecToStr(SplitsAll(1,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '100m';
            dataTOTtxt = timeSecToStr(SplitsAll(2,2));
            datatxt = timeSecToStr(SplitsAll(2,2)-SplitsAll(1,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '150m';
            dataTOTtxt = timeSecToStr(SplitsAll(3,2));
            datatxt = timeSecToStr(SplitsAll(3,2)-SplitsAll(2,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2)-SplitsAll(3,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        end;
        
    elseif RaceDist == 400;
        if Course == 25;
            dataTableSummary{23,2} = '100m';
            datatxt = timeSecToStr(SplitsAll(4,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(4,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '300m';
            dataTOTtxt = timeSecToStr(SplitsAll(12,2));
            datatxt = timeSecToStr(SplitsAll(12,2) - SplitsAll(8,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(12,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '100m';
            datatxt = timeSecToStr(SplitsAll(2,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '200m';
            dataTOTtxt = timeSecToStr(SplitsAll(4,2));
            datatxt = timeSecToStr(SplitsAll(4,2) - SplitsAll(2,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '300m';
            dataTOTtxt = timeSecToStr(SplitsAll(6,2));
            datatxt = timeSecToStr(SplitsAll(6,2) - SplitsAll(4,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(6,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        end;

    elseif RaceDist == 800;
        if Course == 25;
            dataTableSummary{23,2} = '200m';
            datatxt = timeSecToStr(SplitsAll(8,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(8,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '600m';
            dataTOTtxt = timeSecToStr(SplitsAll(24,2));
            datatxt = timeSecToStr(SplitsAll(24,2) - SplitsAll(16,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(32,2));
            datatxt = timeSecToStr(SplitsAll(32,2) - SplitsAll(24,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '200m';
            datatxt = timeSecToStr(SplitsAll(4,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '400m';
            dataTOTtxt = timeSecToStr(SplitsAll(8,2));
            datatxt = timeSecToStr(SplitsAll(8,2) - SplitsAll(4,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '600m';
            dataTOTtxt = timeSecToStr(SplitsAll(12,2));
            datatxt = timeSecToStr(SplitsAll(12,2) - SplitsAll(8,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(12,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        end;

    elseif RaceDist == 1500;
        if Course == 25;
            dataTableSummary{23,2} = '400m';
            datatxt = timeSecToStr(SplitsAll(16,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(32,2));
            datatxt = timeSecToStr(SplitsAll(32,2) - SplitsAll(16,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '1200m';
            dataTOTtxt = timeSecToStr(SplitsAll(48,2));
            datatxt = timeSecToStr(SplitsAll(48,2) - SplitsAll(32,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '1500m';
            dataTOTtxt = timeSecToStr(SplitsAll(60,2));
            datatxt = timeSecToStr(SplitsAll(60,2) - SplitsAll(48,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        else;
            dataTableSummary{23,2} = '400m';
            datatxt = timeSecToStr(SplitsAll(8,2));
            dataTableSummary{23,i} = datatxt;

            dataTableSummary{24,2} = '800m';
            dataTOTtxt = timeSecToStr(SplitsAll(16,2));
            datatxt = timeSecToStr(SplitsAll(16,2) - SplitsAll(8,2));
            dataTableSummary{24,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{25,2} = '1200m';
            dataTOTtxt = timeSecToStr(SplitsAll(24,2));
            datatxt = timeSecToStr(SplitsAll(24,2) - SplitsAll(16,2));
            dataTableSummary{25,i} = [datatxt '  /  ' dataTOTtxt];

            dataTableSummary{26,2} = '1500m';
            dataTOTtxt = timeSecToStr(SplitsAll(30,2));
            datatxt = timeSecToStr(SplitsAll(30,2) - SplitsAll(24,2));
            dataTableSummary{26,i} = [datatxt '  /  ' dataTOTtxt];
            
            limli_Summary = 26;
        end;
    end;
end;
colorrowSummary = colorrowSummary(1:limli_Summary);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------




%---------------------------Create stroke table----------------------------
%--------------------------------------------------------------------------
colorrowStroke(1) = rgb_val(255,230,26);
colorrowStroke(2) = rgb_val(230,230,230);
colorrowStroke(3) = rgb_val(192,192,192);
colorrowStroke(4) = rgb_val(230,230,230);
colorrowStroke(5) = rgb_val(192,192,192);
colorrowStroke(6) = rgb_val(230,230,230);
colorrowStroke(7) = rgb_val(255,255,255);
colorrowStroke(8) = rgb_val(255,230,26);

dataTableStroke = {};
dataTableStroke{1,2} = 'Metadata';
dataTableStroke{8,2} = 'Stroke Management';
dataTableStroke{9,1} = 'SR / SL / Stroke';

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
    str = [Meet '-' num2str(Year)];
    eval(['dataTableStroke{4,' num2str(i) '} = str;']);
    eval(['dataTableStroke{5,' num2str(i) '} = handles.RacesDB.' UID '.Stage;']);
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTableStroke{6,i} = TTtxt;


    %---------------------------------Stroke-------------------------------
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);
    eval(['SREC = handles.RacesDB.' UID '.Stroke_SR;']);
    eval(['SDEC = handles.RacesDB.' UID '.Stroke_Distance;']);
    SectionSR = [];
    SectionSD = [];
    SectionVel = [];
    SectionSplitTime = [];
    SectionCumTime = [];
    SectionNb = [];
    if i == 3;
        if Course == 25;
            colorrowStroke(9) = rgb_val(255,230,179);
            lineEC = 10;
            for lap = 1:NbLap;
                dataTableStroke{lineEC,1} = ['Lap ' num2str(lap)];
                dataTableStroke{lineEC+1,2} = '0m-5m';
                dataTableStroke{lineEC+2,2} = '5m-10m';
                dataTableStroke{lineEC+3,2} = '10m-15m';
                dataTableStroke{lineEC+4,2} = '15m-20m';
                dataTableStroke{lineEC+5,2} = '20m-Last arm entry';

                colorrowStroke(lineEC) = rgb_val(255,230,153);
                colorrowStroke(lineEC+1) = rgb_val(230,230,230);
                colorrowStroke(lineEC+2) = rgb_val(192,192,192);
                colorrowStroke(lineEC+3) = rgb_val(230,230,230);
                colorrowStroke(lineEC+4) = rgb_val(192,192,192);
                colorrowStroke(lineEC+5) = rgb_val(230,230,230);

                lineEC = lineEC + 6;
            end;
            
        else;
            colorrowStroke(9) = rgb_val(255,230,179);
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

                colorrowStroke(lineEC) = rgb_val(255,230,153);
                colorrowStroke(lineEC+1) = rgb_val(230,230,230);
                colorrowStroke(lineEC+2) = rgb_val(192,192,192);
                colorrowStroke(lineEC+3) = rgb_val(230,230,230);
                colorrowStroke(lineEC+4) = rgb_val(192,192,192);
                colorrowStroke(lineEC+5) = rgb_val(230,230,230);
                colorrowStroke(lineEC+6) = rgb_val(192,192,192);
                colorrowStroke(lineEC+7) = rgb_val(230,230,230);
                colorrowStroke(lineEC+8) = rgb_val(192,192,192);
                colorrowStroke(lineEC+9) = rgb_val(230,230,230);
                colorrowStroke(lineEC+10) = rgb_val(192,192,192);

                lineEC = lineEC + 11;
            end;
        end;
    end;
    
    %calculate values per 5m-sections
    SplitsAll = SplitsAll(2:end,:);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.RawDistance;']);
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['StrokeEC = handles.RacesDB.' UID '.RawStroke;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);

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
        if Course == 25;
            nbzone = 5;
        else;
            nbzone = 10;
        end;
        
        for zone = 1:nbzone;
            DistEnd = DistIni + 5;
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
            
            if BOAll(lap,1) > liEnd;
                SectionSR(lap,zone) = NaN;
                SectionSD(lap,zone) = NaN;
                SectionVel(lap,zone) = NaN;
                SectionSplitTime(lap,zone) = NaN;
                SectionCumTime(lap,zone) = NaN;
            else;
                if BOAll(lap,1) > liIni;
                    liIni = BOAll(lap,1) + 1;
                end;
                SectionVel(lap,zone) = mean(VelocityEC(liIni:liEnd));
                SectionSplitTime(lap,zone) = TimeEC(liEnd)- TimeEC(liIni);
                SectionCumTime(lap,zone) = TimeEC(liEnd);
                
                liStrokeSec = find(StrokeEC(liIni:liEnd) == 1);
                if isempty(liStrokeSec) == 0;
                    
                    if strcmpi(StrokeType, 'Breaststroke') | strcmpi(StrokeType, 'Butterfly');
                        if length(liStrokeSec) < 1;
                            SectionSR(lap,zone) = NaN;
                            SectionSD(lap,zone) = NaN;
                            SectionNb(lap,zone) = NaN;
                            
                        elseif length(liStrokeSec) >= 1 & length(liStrokeSec) < 2;
                            liStrokeSec = liStrokeSec + liIni - 1;
                            IDstroke = [];
                            for stro = 1:length(liStrokeSec);
                                IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                            end;
                            if zone == 1;
                                IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                            elseif zone == 10;
                                IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                            else;
                                IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                            end;
                            li = find(IDstroke > 1);
                            IDstroke = IDstroke(li);
                            SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                            SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                            SectionNb(lap,zone) = 1;
                        else;
                            liStrokeSec = liStrokeSec + liIni - 1;
                            IDstroke = [];
                            for stro = 1:length(liStrokeSec);
                                IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                            end;
                            if IDstroke(1) == 1;
                                IDstroke = IDstroke(2:end);
                            end;
                            SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                            SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                            SectionNb(lap,zone) = length(liStrokeSec);
                        end;
                        
                    elseif strcmpi(StrokeType, 'Medley');
                        if isempty(lilap) == 1;
                            %BK and FS
                            if length(liStrokeSec) >= 2;
                                liStrokeSec = liStrokeSec + liIni - 1;
                                IDstroke = [];
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                                end;
                                if IDstroke(1) == 1;
                                    IDstroke = IDstroke(2:end);
                                end;
                                SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                                SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                                SectionNb(lap,zone) = length(liStrokeSec);
                            else;
                                SectionSR(lap,zone) = NaN;
                                SectionSD(lap,zone) = NaN;
                                SectionNb(lap,zone) = NaN;
                            end;
                        else;
                            %BF and BR
                            if length(liStrokeSec) < 1;
                                SectionSR(lap,zone) = NaN;
                                SectionSD(lap,zone) = NaN;
                                SectionNb(lap,zone) = NaN;

                            elseif length(liStrokeSec) >= 1 & length(liStrokeSec) < 2;
                                liStrokeSec = liStrokeSec + liIni - 1;
                                IDstroke = [];
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                                end;
                                if zone == 1;
                                    IDstroke = [IDstroke IDstroke+1 IDstroke+2];
                                elseif zone == 10;
                                    IDstroke = [IDstroke-2 IDstroke-1 IDstroke];
                                else;
                                    IDstroke = [IDstroke-1 IDstroke IDstroke+1];
                                end;
                                li = find(IDstroke > 1);
                                IDstroke = IDstroke(li);
                                SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                                SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                                SectionNb(lap,zone) = 1;
                            else;
                                liStrokeSec = liStrokeSec + liIni - 1;
                                IDstroke = [];
                                for stro = 1:length(liStrokeSec);
                                    IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                                end;
                                if IDstroke(1) == 1;
                                    IDstroke = IDstroke(2:end);
                                end;
                                SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                                SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                                SectionNb(lap,zone) = length(liStrokeSec);
                            end;
                        end;
                        
                    else;
                        if length(liStrokeSec) >= 2;
                            liStrokeSec = liStrokeSec + liIni - 1;
                            IDstroke = [];
                            for stro = 1:length(liStrokeSec);
                                IDstroke = [IDstroke find(liStrokeLap == liStrokeSec(stro))];
                            end;
                            if IDstroke(1) == 1;
                                IDstroke = IDstroke(2:end);
                            end;
                            SectionSR(lap,zone) = roundn(mean(SREC(lap, IDstroke-1)),-1);
                            SectionSD(lap,zone) = roundn(mean(SDEC(lap, IDstroke-1)),-2);
                            SectionNb(lap,zone) = length(liStrokeSec);
                        else;
                            SectionSR(lap,zone) = NaN;
                            SectionSD(lap,zone) = NaN;
                            SectionNb(lap,zone) = NaN;
                        end;
                    end;
                else;
                    SectionSR(lap,zone) = NaN;
                    SectionSD(lap,zone) = NaN;
                    SectionNb(lap,zone) = NaN;
                end;                                
            end;     
            DistIni = DistEnd;
        end;
        
        liSplitIni = SplitsAll(lap,3) + 1;
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
if Course == 50;
    limli_Stroke = lineEC - 11 + 9;
else;
    limli_Stroke = lineEC - 6 + 4;
end;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------




%---------------------------Create pacing table----------------------------
%--------------------------------------------------------------------------
dataTablePacing = {};
dataTablePacing{1,2} = 'Metadata';
dataTablePacing{8,2} = 'Pacing';
dataTablePacing{9,1} = 'Splits';

colorrowPacing(1) = rgb_val(255,230,26);
colorrowPacing(2) = rgb_val(230,230,230);
colorrowPacing(3) = rgb_val(192,192,192);
colorrowPacing(4) = rgb_val(230,230,230);
colorrowPacing(5) = rgb_val(192,192,192);
colorrowPacing(6) = rgb_val(230,230,230);
colorrowPacing(7) = rgb_val(255,255,255);
colorrowPacing(8) = rgb_val(255,230,26);

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
    str = [num2str(RaceDist) '-' StrokeType];
    eval(['dataTablePacing{3,' num2str(i) '} = str;']);    
    eval(['Meet = handles.RacesDB.' UID '.Meet;']);
    eval(['Year = handles.RacesDB.' UID '.Year;']);
    str = [Meet '-' num2str(Year)];
    eval(['dataTablePacing{4,' num2str(i) '} = str;']);
    eval(['dataTablePacing{5,' num2str(i) '} = handles.RacesDB.' UID '.Stage;']);
    
    eval(['SplitsAll = handles.RacesDB.' UID '.SplitsAll;']);
    TT = SplitsAll(end,2);
    TTtxt = timeSecToStr(TT);
    dataTablePacing{6,i} = TTtxt;


    %---------------------------------Pacing-------------------------------
    eval(['NbLap = handles.RacesDB.' UID '.NbLap;']);    
    if i == 3;
        colorrowPacing(9) = rgb_val(255,230,179);
        lineEC = 10;
        for lap = 1:NbLap;
            dataTablePacing{lineEC,1} = ['Lap ' num2str(lap)];

            if Course == 25;
                dataTablePacing{lineEC+1,2} = '0m-5m';
                dataTablePacing{lineEC+2,2} = '5m-10m';
                dataTablePacing{lineEC+3,2} = '10m-15m';
                dataTablePacing{lineEC+4,2} = '15m-20m';
                dataTablePacing{lineEC+5,2} = ['20m-Last arm entry'];
                dataTablePacing{lineEC+6,2} = 'Last 5m';
                
                colorrowPacing(lineEC) = rgb_val(255,230,153);
                colorrowPacing(lineEC+1) = rgb_val(230,230,230);
                colorrowPacing(lineEC+2) = rgb_val(192,192,192);
                colorrowPacing(lineEC+3) = rgb_val(230,230,230);
                colorrowPacing(lineEC+4) = rgb_val(192,192,192);
                colorrowPacing(lineEC+5) = rgb_val(230,230,230);
                colorrowPacing(lineEC+6) = rgb_val(192,192,192);

                lineEC = lineEC + 7;
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

                colorrowPacing(lineEC) = rgb_val(255,230,153);
                colorrowPacing(lineEC+1) = rgb_val(230,230,230);
                colorrowPacing(lineEC+2) = rgb_val(192,192,192);
                colorrowPacing(lineEC+3) = rgb_val(230,230,230);
                colorrowPacing(lineEC+4) = rgb_val(192,192,192);
                colorrowPacing(lineEC+5) = rgb_val(230,230,230);
                colorrowPacing(lineEC+6) = rgb_val(192,192,192);
                colorrowPacing(lineEC+7) = rgb_val(230,230,230);
                colorrowPacing(lineEC+8) = rgb_val(192,192,192);
                colorrowPacing(lineEC+9) = rgb_val(230,230,230);
                colorrowPacing(lineEC+10) = rgb_val(192,192,192);
                colorrowPacing(lineEC+11) = rgb_val(230,230,230);

                lineEC = lineEC + 12;
            end;
        end;
    end;

    %calculate values per 5m-sections
    SplitsAll = SplitsAll(2:end,:);
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['DistanceEC = handles.RacesDB.' UID '.RawDistance;']);
    eval(['VelocityEC = handles.RacesDB.' UID '.RawVelocity;']);
    eval(['TimeEC = handles.RacesDB.' UID '.RawTime;']);
    eval(['Stroke_Frame = handles.RacesDB.' UID '.Stroke_Frame;']);
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
    SectionSplitTime = [];
    SectionCumTime = [];
    SectionVel = [];
    SectionSplitTime = [];
    SectionCumTime = [];
    for lap = 1:NbLap;
        liSplitEnd = SplitsAll(lap,3);
        liStrokeLap = Stroke_Frame(lap,:);
        liInterest = find(liStrokeLap ~= 0);
        liStrokeLap = liStrokeLap(liInterest);
        
        keydist = (lap-1).*Course;
        DistIni = keydist;
        if Course == 25;
            nbzone = 5;
        else;
            nbzone = 10;
        end;
        for zone = 1:nbzone;
            DistEnd = DistIni + 5;
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
            
            if BOAll(lap,1) > liEnd;
                SectionSplitTime(lap,zone) = NaN;
                SectionCumTime(lap,zone) = NaN;
            else;
                if BOAll(lap,1) > liIni;
                    liIni = BOAll(lap,1) + 1;
                end;
                SectionVel(lap,zone) = mean(VelocityEC(liIni:liEnd));
                SectionSplitTime(lap,zone) = TimeEC(liEnd)- TimeEC(liIni);
                SectionCumTime(lap,zone) = TimeEC(liEnd);                              
            end;     
            DistIni = DistEnd;
        end;
        liSplitIni = SplitsAll(lap,3) + 1;
    end;
    SectionVel = roundn(SectionVel,-2);
    SectionCumTime = roundn(SectionCumTime,-2);
    SectionSplitTime = roundn(SectionSplitTime,-2);

    SectionCumTimeMat = SectionCumTime;
    SectionCumTimeMat(:,end) = SplitsAll(:,2);
    SectionSplitTimeMat = SectionSplitTime;
    SectionSplitTimeMat(:,end) = SectionCumTimeMat(:,end) - SectionCumTimeMat(:,end-1);
    
    lineECmat = 1;
    for lap = 1:NbLap;
        dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
        dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
        dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
        dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
        dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;
        if Course == 50;
            dataMatSplitsPacing(lineECmat+5, 1) = (Course*(lap-1)) + 30;
            dataMatSplitsPacing(lineECmat+6, 1) = (Course*(lap-1)) + 35;
            dataMatSplitsPacing(lineECmat+7, 1) = (Course*(lap-1)) + 40;
            dataMatSplitsPacing(lineECmat+8, 1) = (Course*(lap-1)) + 45;
            dataMatSplitsPacing(lineECmat+9, 1) = (Course*(lap-1)) + 50;
            lineECmat = lineECmat + 10;
        else;
            lineECmat = lineECmat + 5;
        end;
    end;
    if Course == 50
        dataMatSplitsPacing(:,2) = reshape(SectionSplitTimeMat', 10*NbLap, 1);
        dataMatCumSplitsPacing(:,2) = reshape(SectionCumTimeMat', 10*NbLap, 1);
    else
        dataMatSplitsPacing(:,2) = reshape(SectionSplitTimeMat', 5*NbLap, 1);
        dataMatCumSplitsPacing(:,2) = reshape(SectionCumTimeMat', 5*NbLap, 1);
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
end;
if Course == 50;
    limli_Pacing = lineEC - 12 + 10;
else;
    limli_Pacing = lineEC - 7 + 5;
end;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------




%---------------------------Create skills table----------------------------
%--------------------------------------------------------------------------
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
dataTableSkill{18,2} = 'Underwater Distance';
dataTableSkill{19,2} = 'Underwater Time';
dataTableSkill{20,2} = 'Underwater Speed';
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

colorrowSkill(1) = rgb_val(255,230,26);
colorrowSkill(2) = rgb_val(230,230,230);
colorrowSkill(3) = rgb_val(192,192,192);
colorrowSkill(4) = rgb_val(230,230,230);
colorrowSkill(5) = rgb_val(192,192,192);
colorrowSkill(6) = rgb_val(230,230,230);
colorrowSkill(7) = rgb_val(255,255,255);
colorrowSkill(8) = rgb_val(255,230,26);
colorrowSkill(9) = rgb_val(255,230,179);
colorrowSkill(10) = rgb_val(230,230,230);
colorrowSkill(11) = rgb_val(192,192,192);
colorrowSkill(12) = rgb_val(230,230,230);
colorrowSkill(13) = rgb_val(192,192,192);
colorrowSkill(14) = rgb_val(255,230,179);
colorrowSkill(15) = rgb_val(230,230,230);
colorrowSkill(16) = rgb_val(192,192,192);
colorrowSkill(17) = rgb_val(230,230,230);
colorrowSkill(18) = rgb_val(192,192,192);
colorrowSkill(19) = rgb_val(230,230,230);
colorrowSkill(20) = rgb_val(192,192,192);
colorrowSkill(21) = rgb_val(230,230,230);
colorrowSkill(22) = rgb_val(192,192,192);
colorrowSkill(23) = rgb_val(230,230,230);
colorrowSkill(24) = rgb_val(192,192,192);
colorrowSkill(25) = rgb_val(255,230,179);
colorrowSkill(26) = rgb_val(230,230,230);
colorrowSkill(27) = rgb_val(192,192,192);
colorrowSkill(28) = rgb_val(230,230,230);
colorrowSkill(29) = rgb_val(192,192,192);
colorrowSkill(30) = rgb_val(230,230,230);

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

            colorrowSkill(lineEC) = rgb_val(255,230,179);
            colorrowSkill(lineEC+1) = rgb_val(230,230,230);
            colorrowSkill(lineEC+2) = rgb_val(192,192,192);
            colorrowSkill(lineEC+3) = rgb_val(230,230,230);
            colorrowSkill(lineEC+4) = rgb_val(192,192,192);
            colorrowSkill(lineEC+5) = rgb_val(230,230,230);
            colorrowSkill(lineEC+6) = rgb_val(192,192,192);
            colorrowSkill(lineEC+7) = rgb_val(230,230,230);
            
            lineEC = lineEC + 8;
        end;

        dataTableSkill{lineEC,1} = 'Finish';
        dataTableSkill{lineEC+1,2} = 'Last 5m Time';
        dataTableSkill{lineEC+2,2} = 'Glide-Wall (Dist/Time)';
        colorrowSkill(lineEC) = rgb_val(255,230,179);
        colorrowSkill(lineEC+1) = rgb_val(230,230,230);
        colorrowSkill(lineEC+2) = rgb_val(192,192,192);
    end;
    
    %%%Totals
    eval(['Course = handles.RacesDB.' UID '.Course;']);
    eval(['TotalSkillTime = handles.RacesDB.' UID '.TotalSkillTime;']);
    TotalSkillTimetxt = timeSecToStr(TotalSkillTime);
    dataTableSkill{10,i} = TotalSkillTimetxt;

    dataTableSkill{11,i} = 'na'; %Total underwater Distance
    dataTableSkill{12,i} = 'na'; %Total underwater Time
    eval(['Turn_Time = handles.RacesDB.' UID '.Turn_Time;']);
    eval(['Turn_TimeIn = handles.RacesDB.' UID '.Turn_TimeIn;']);
    eval(['Turn_TimeOut = handles.RacesDB.' UID '.Turn_TimeOut;']);
    Turn_Timetxt = timeSecToStr(roundn(sum(Turn_Time),-2));
    Turn_TimeIntxt = timeSecToStr(roundn(sum(Turn_TimeIn),-2));
    Turn_TimeOuttxt = timeSecToStr(roundn(sum(Turn_TimeOut),-2));
    dataTableSkill{13,i} = [Turn_TimeIntxt '  /  ' Turn_TimeOuttxt '  /  ' Turn_Timetxt];
    
    %%%%Start
    SplitsAll = SplitsAll(2:end,:);

    eval(['DiveT15 = handles.RacesDB.' UID '.DiveT15;']);
    DiveT15txt = timeSecToStr(roundn(DiveT15,-2));
    dataTableSkill{15,i} = DiveT15txt;
    
    eval(['RT = handles.RacesDB.' UID '.RT;']);
    RTtxt = timeSecToStr(roundn(RT,-2));
    dataTableSkill{16,i} = RTtxt;
    
    dataTableSkill{17,i} = 'na';    %Entry Distance
    dataTableSkill{18,i} = 'na';    %Underwater Distance
    dataTableSkill{19,i} = 'na';    %Underwater Time
    dataTableSkill{20,i} = 'na';    %Underwater Speed
    
    eval(['KicksNb = handles.RacesDB.' UID '.KicksNb;']);
    dataTableSkill{21,i} = [num2str(KicksNb(1)) ' Kicks'];
    
    eval(['BOAll = handles.RacesDB.' UID '.BOAll;']);
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

    eval(['Last5m = handles.RacesDB.' UID '.Last5m;']);
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
limli_Skill = lineEC + 2;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


listdir = dir(pathname);
proceed = 1;
existfilesave = 0;
iter = 1;
while proceed == 1;
    for file = 1:length(listdir);
        fileEC = listdir(file).name;
        existfile = strcmpi([filenameTable '.xlsx'], fileEC);
        if existfile == 1;
            if iter == 1;
                filenameTable = [filenameTable '_copy(' num2str(iter) ')'];
            else;
                licopy = findstr(filenameTable, '_copy');
                filenameTable = [filenameTable(1:licopy-1) '_copy(' num2str(iter) ')'];
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
    name = [pathname '\' filenameTable];
    
    exportstatusSheet1 = xlswrite(name, dataTableSummary, 1);
    exportstatusSheet2 = xlswrite(name, dataTableStroke, 2);
    exportstatusSheet3 = xlswrite(name, dataTablePacing, 3);
    exportstatusSheet4 = xlswrite(name, dataTableSkill, 4);
    clc;
    source = 'database';
    excelRenderingTable_analyser;
    
elseif ismac == 1;
    %---add the path to java
    javaaddpath('poi-3.8-20120326.jar');
    javaaddpath('poi-ooxml-3.8-20120326.jar');
    javaaddpath('poi-ooxml-schemas-3.8-20120326.jar');
    javaaddpath('xmlbeans-2.3.0.jar');
    javaaddpath('dom4j-1.6.1.jar');
    javaaddpath('stax-api-1.0.1.jar');
    
    name = [pathname '/' filenameTable];
    sheetName1 = 'Summary';
    startRange1 = 'A1';
    xlwrite(name, dataTableSummary, sheetName1, startRange1);
    
    sheetName2 = 'Stroke';
    startRange2 = 'A1';
    xlwrite(name, dataTableStroke, sheetName2, startRange2);
    
    sheetName3 = 'Pacing';
    startRange3 = 'A1';
    xlwrite(name, dataTablePacing, sheetName3, startRange3);
    
    sheetName4 = 'Skill';
    startRange4 = 'A1';
    xlwrite(name, dataTableSkill, sheetName4, startRange4);
    clc;
end;
 


