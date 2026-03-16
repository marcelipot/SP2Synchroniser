if lap == 1;
    DistIni = keydist;
    DistIniStroke = keydist;
else;
    DistIniOther = keydist + 10;
    DistIni = keydist;
end;

if lap == 1;
    SectionSR = zeros(NbLap,10);
    SectionSR(:,:) = NaN;
    SectionSD = zeros(NbLap,10);
    SectionSD(:,:) = NaN;
    SectionNb = zeros(NbLap,10);
    SectionNb(:,:) = NaN;
    SectionVel = zeros(NbLap,10);
    SectionVel(:,:) = NaN;
    SectionSplitTime = zeros(NbLap,10);
    SectionSplitTime(:,:) = NaN;
    SectionCumTime = zeros(NbLap,10);
    SectionCumTime(:,:) = NaN;

    isInterpolatedSR = zeros(NbLap,10);
    isInterpolatedSD = zeros(NbLap,10);
    isInterpolatedSplits = zeros(NbLap,10);
    isInterpolatedVel = zeros(NbLap,10);
    isInterpolatedSRbis = zeros(NbLap,10);
    isInterpolatedSDbis = zeros(NbLap,10);
    isInterpolatedSplitsbis = zeros(NbLap,10);
    isInterpolatedVelbis = zeros(NbLap,10);

    SectionSRbis = [];
    SectionSDbis = [];
    SectionNbbis = [];
    SectionVelbis = [];
    SectionSplitTimebis = [];
    SectionCumTimebis = [];
end;
pos = [3 5 7 9 10];
for zone = 1:5;
    if zone == 1;
        if lap == 1;
            %segment 0-15m after dive
            DistEnd = DistIni + 15;
            DistEndStroke = DistIni + 15;
        else;
            %segment 50-65m after turn (from 60 to 65m)
            DistIniOther = DistIni + 10;
            DistEndOther = DistIniOther + 5;
            DistEnd = DistIni + 15;
        end;
        DistIniOri = DistIni;
    elseif zone == 5;
        DistEnd = DistIni + 5;
        DistEndStroke = DistIni + 5;
    else;
        DistEnd = DistIni + 10;
        DistEndStroke = DistIni + 10;
    end;
    
    indexIni = find(liDistLap(:,5) == DistIni);
    liIni = liDistLap(indexIni,4);   
    TimeIni = (liIni - listart)./framerate;

    if lap ~= 1;
        if zone == 1
            indexIniOther = find(liDistLap(:,5) == DistIniOther);
            liIniOther = liDistLap(indexIniOther,4);   
            TimeIniOther = (liIniOther - listart)./framerate;
        end;
    end;

    indexEnd = find(liDistLap(:,5) == DistEnd);
    liEnd = liDistLap(indexEnd,4);
    TimeEnd = (liEnd - listart)./framerate;

    if BOAll(lap,1)+RaceStart > liEnd;
        if lap == 1;
            SectionSR(lap,pos(zone)) = NaN;
            SectionSD(lap,pos(zone)) = NaN;
            SectionNb(lap,pos(zone)) = NaN;
            SectionVel(lap,pos(zone)) = NaN;
            if isnan(liDistLap(indexEnd,3)) == 1;
                isInterpolatedSplits(lap,pos(zone)) = 1;
            end;
            SectionSplitTime(lap,pos(zone)) = TimeEnd;
            SectionCumTime(lap,pos(zone)) = TimeEnd;
        else;
            SectionSR(lap,pos(zone)) = NaN;
            SectionSD(lap,pos(zone)) = NaN;
            SectionNb(lap,pos(zone)) = NaN;
            SectionVel(lap,pos(zone)) = NaN;
            SectionSplitTime(lap,pos(zone)) = NaN;
            SectionCumTime(lap,pos(zone)) = NaN;
        end;
    else;
        
        if zone == 5;
            VelEC = NaN;
            SectionVel(lap,pos(zone)) = NaN;
        else;
            if lap ~= 1;
                if zone == 1;
                    if isnan(liDistLap(indexIniOther,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                        isInterpolatedVel(lap,pos(zone)) = 1;
                    end;
                    VelEC = (DistEnd-DistIniOther) ./ (TimeEnd-TimeIniOther);
                    SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIniOther) ./ (TimeEnd-TimeIniOther),-2);
                else;
                    if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                        isInterpolatedVel(lap,pos(zone)) = 1;
                    end;
                    VelEC = (DistEnd-DistIni) ./ (TimeEnd-TimeIni);
                    SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
                end;
            else;
                if zone == 1;
                    VelEC = NaN;
                    SectionVel(lap,pos(zone)) = NaN;
                else;
                    liIniBO = BOAll(lap,1)+RaceStart;
                    DistIniBO = BOAll(lap,3);
                    TimeIniBO = (liIniBO - listart)./framerate;
    %                 if DistIniBO > DistIni;
    %                     if BOAll(lap,4) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
    %                         isInterpolatedVel(lap,pos(zone)) = 1;
    %                     end;
    %                     VelEC = (DistEnd-DistIniBO) ./ (TimeEnd-TimeIniBO)
    %                     SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIniBO) ./ (TimeEnd-TimeIniBO),-2);
    %                 else;
                        if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
                            isInterpolatedVel(lap,pos(zone)) = 1;
                        end;
                        VelEC = (DistEnd-DistIni) ./ (TimeEnd-TimeIni);
                        SectionVel(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
    %                 end;
                end;
            end;
        end;
        if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
            isInterpolatedSplits(lap,pos(zone)) = 1;
        end;
        SectionSplitTime(lap,pos(zone)) = TimeEnd-TimeIni;
        SectionCumTime(lap,pos(zone)) = TimeEnd;

        indexStrokeSec = find(liStrokeLap >= liIni & liStrokeLap < liEnd);
        liStrokeSec = liStrokeLap(indexStrokeSec);

        if lap ~= 1;
            if zone == 1;
                indexStrokeSecOther = find(liStrokeLap >= liIniOther & liStrokeLap < liEnd);
                liStrokeSecOther = liStrokeLap(indexStrokeSecOther);
            end;
        end;
        
        if lap >= 2;
            liStrokeSecRef = liStrokeSec;
            liIniRef = liIni;
            liEndRef = liEnd;

            if zone == 1;
                if BOAll(lap,3) < DistIni;
                    DistIniRef = DistIni;
                else;
                    DistIniRef = BOAll(lap,3); 
                    liIniRef = BOAll(lap,1)+RaceStart;
                end;
                DistEndRef = DistEnd;
            elseif zone == 5;
                liStrokeSecRef = liStrokeSec;
                liIniRef = liIni;
                liEndRef = liEnd;
                DistIniRef = DistIni;
            else;
                DistIniRef = DistIni;
                DistEndRef = DistEnd;
                
            end;
        else;
            liStrokeSecRef = liStrokeSec;
            liIniRef = liIni;
            liEndRef = liEnd;

            if zone == 1;
                liIniRef = BOAll(lap,1)+RaceStart;
                DistIniRef = BOAll(lap,3);
                DistEndRef = DistEnd;
            elseif zone == 5;
                liStrokeSecRef = liStrokeSec;
                liIniRef = liIni;
                liEndRef = liEnd;
                DistIniRef = DistIni;
            else;
                DistIniRef = DistIni;
                DistEndRef = DistEnd;
            end;
        end;

        if isempty(liStrokeSecRef) == 0;
            if strcmpi(StrokeType, 'Breaststroke') | strcmpi(StrokeType, 'Butterfly');
                if length(liStrokeSecRef) <= 1;
                    SectionSR(lap,pos(zone)) = NaN;
                    SectionSD(lap,pos(zone)) = NaN;
                    SectionNb(lap,pos(zone)) = length(liStrokeSecRef);

                    SectionSRbis(lap,pos(zone)) = NaN;
                    SectionSDbis(lap,pos(zone)) = NaN;
                    SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);

                elseif length(liStrokeSecRef) > 1 & length(liStrokeSecRef) < 2;

                    if zone == 1;
                        indexPlusStrokes = find(liStrokeLap > liStrokeSecRef(end));
                        IDstroke = [liStrokeSecRef(1) liStrokeSecRef(2) liStrokeLap(indexPlusStrokes(1))];
                    elseif zone == 5;
                        indexMinusStrokes = find(liStrokeLap < liStrokeSecRef(end-1));
                        IDstroke = [liStrokeLap(indexMinusStrokes(end)) liStrokeSecRef(1) liStrokeSecRef(2)];
                    else;
                        indexPlusStrokes = find(liStrokeLap > liStrokeSecRef(end));
                        IDstroke = [liStrokeSecRef(1) liStrokeSecRef(2) liStrokeLap(indexPlusStrokes(1))];
                    end;
                    li = find(IDstroke > 1);
                    IDstroke = IDstroke(li);
                    
                    StTime1 = IDstroke(1);
                    StTime2 = IDstroke(end);
                    StrDuration = (StTime2 - StTime1)./framerate;
                    SectionSR(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
                    SectionSRbis(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
                    
                    %position at the beginning and end
%                     VelEC = SectionVel(lap,pos(zone));
                    
                    StTime1 = (IDstroke(1)-listart)./framerate;
                    StTime2 = (IDstroke(end)-listart)./framerate;
                    
                    if lap >= 2;
                        if zone == 1;
                            SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                        else;
                            SegTime1 = (liIniRef-listart)/framerate;
                        end;
                    else;
                        SegTime1 = (liIniRef-listart)/framerate;
                    end;
                    SegTime2 = (liEndRef-listart)/framerate;
                    
                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                    
                    if lap >= 2;
                        if zone == 1;
                            StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                            StDist2 = DistEndRef + PosTime2;
                        elseif zone == 5;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndStroke;
                        else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
                        end;
                    else;
                        if zone == 5;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndStroke;
                        else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
                        end;
                    end;
                    
                    if zone == 5;
                        SectionSD(lap,pos(zone)) = NaN;
                        SectionSDbis(lap,pos(zone)) = NaN;
                    else;
                        SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                        SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                    end;
                    SectionNb(lap,pos(zone)) = 1;
                    SectionNbbis(lap,pos(zone)) = 1;
                    
                else;
                    IDstroke = [];
                    IDstrokeOther = [];
                    for stro = 1:length(liStrokeSecRef);
                        IDstroke = [IDstroke liStrokeSecRef(stro)];
                    end;
                    if lap ~= 1;
                        if zone == 1;
                            for stro = 1:length(liStrokeSecOther);
                                IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
                            end;
                            if length(IDstrokeOther) <= 1;
                                IDstrokeOther = 0; %error not enough strokes
                            elseif length(IDstrokeOther) == 2;
%                                                     indexextra = find(liStrokeLap == IDstrokeOther(end));
                                IDstrokeOther = IDstroke;
                            end;
                        end;
                    end;
                    
                    StTime1 = (IDstroke(1)-listart)./framerate;
                    StTime2 = (IDstroke(end)-listart)./framerate;
                    StrDuration = (StTime2 - StTime1);
                    SectionSR(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
                    SectionSRbis(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
%                     VelEC = SectionVel(lap,pos(zone));

                    %position at the beginning and end
                    if isempty(IDstrokeOther) == 0;
                        StTime1 = (IDstrokeOther(1)-listart)./framerate;
                        StTime2 = (IDstrokeOther(end)-listart)./framerate;
                    else;
                        StTime1 = (IDstroke(1)-listart)./framerate;
                        StTime2 = (IDstroke(end)-listart)./framerate;
                    end;

                    if lap >= 2;
                        if zone == 1;
%                                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                            SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                        else;
                            SegTime1 = (liIniRef-listart)/framerate;
                        end;
                    else;
                        SegTime1 = (liIniRef-listart)/framerate;
                    end;
                    SegTime2 = (liEndRef-listart)/framerate;
                    
                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                
                    if lap >= 2;
                        if zone == 1;
%                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                            StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                            StDist2 = DistEndRef + PosTime2;
                            
                        elseif zone == 5;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndStroke;
                        else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
                        end;
                    else;
                        if zone == 5;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndStroke;
                        else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
                        end;
                    end;
                    
                    if zone == 5;
                        SectionSD(lap,pos(zone)) = NaN;
                        SectionSDbis(lap,pos(zone)) = NaN;
                        SectionNb(lap,pos(zone)) = length(IDstroke);
                        SectionNbbis(lap,pos(zone)) = length(IDstroke);
                    else;
                        if isempty(IDstrokeOther) == 0;
                            if IDstrokeOther == 0;
                                SectionSD(lap,pos(zone)) = NaN;
                                SectionSDbis(lap,pos(zone)) = NaN;
                                
                            else;
                                SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstrokeOther)-1), -2);
                                SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstrokeOther)-1), -2);
                            end;
                            SectionNb(lap,pos(zone)) = length(IDstrokeOther);
                            SectionNbbis(lap,pos(zone)) = length(IDstrokeOther);
                        else;
                            SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                            SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                            SectionNb(lap,pos(zone)) = length(IDstroke);
                            SectionNbbis(lap,pos(zone)) = length(IDstroke);
                        end;
                    end;
                    
                end;

            elseif strcmpi(StrokeType, 'Medley');
                if isempty(lilap) == 1;
                    %BK and FS
                    if length(liStrokeSecRef) >= 2;
                        IDstroke = [];
                        IDstrokeOther = [];
                        for stro = 1:length(liStrokeSecRef);
                            IDstroke = [IDstroke liStrokeSecRef(stro)];
                        end;
                        if lap ~= 1;
                            if zone == 1;
                                for stro = 1:length(liStrokeSecOther);
                                    IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
                                end;
                                if length(IDstrokeOther) <= 1;
                                    IDstrokeOther = 0; %error not enough strokes
                                elseif length(IDstrokeOther) == 2;
%                                                     indexextra = find(liStrokeLap == IDstrokeOther(end));
                                    IDstrokeOther = IDstroke;
                                end;
                            end;
                        end;

                        StTime1 = (IDstroke(1)-listart)./framerate;
                        StTime2 = (IDstroke(end)-listart)./framerate;

                        if length(IDstroke) == 2;
                            StrDuration = abs((StTime2 - StTime1));
                            SectionSR(lap,pos(zone)) = (((length(IDstroke)).*60)./StrDuration)./2;
                            SectionSRbis(lap,pos(zone)) = (((length(IDstroke)).*60)./StrDuration)./2;
                        else;
                            StrDuration = (StTime2 - StTime1);
                            SectionSR(lap,pos(zone)) = ((length(IDstroke)-1).*60)./StrDuration;
                            SectionSRbis(lap,pos(zone)) = ((length(IDstroke)-1).*60)./StrDuration;
                        end;
                        SectionSR(lap,pos(zone)) = roundn(SectionSR(lap,pos(zone))./2,-1);
                        SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone))./2,-1);
                        

                        %position at the beginning and end
%                         VelEC = SectionVel(lap,pos(zone));

                        if isempty(IDstrokeOther) == 0;
                            StTime1Other = (IDstrokeOther(1)-listart)./framerate;
                            StTime2Other = (IDstrokeOther(end)-listart)./framerate;

                            StTime1 = (IDstroke(1)-listart)./framerate;
                            StTime2 = (IDstroke(end)-listart)./framerate;
                        else;
                            StTime1 = (IDstroke(1)-listart)./framerate;
                            StTime2 = (IDstroke(end)-listart)./framerate;
                        end;

                        if lap >= 2;
                            if zone == 1;
%                                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                                SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                            else;
                                SegTime1 = (liIniRef-listart)/framerate;
                            end;
                        else;
                            SegTime1 = (liIniRef-listart)/framerate;
                        end;
                        SegTime2 = (liEndRef-listart)/framerate;
                        
                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                        PosTime2 = (StTime2 - SegTime2) .* VelEC;
                        
                        if lap >= 2;
                            if zone == 1;
%                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                StDist2 = DistEndRef + PosTime2;
                                
                            elseif zone == 5;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndStroke;
                            else;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndRef + PosTime2;
                            end;
                        else;
                            if zone == 5;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndStroke;
                            else;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndRef + PosTime2;
                            end;
                        end;

                        if length(IDstroke) == 2;
                            SectionSD(lap,pos(zone)) = roundn((abs((StDist2 - StDist1)) ./ (length(IDstroke))).*4,-2);
                            SectionSDbis(lap,pos(zone)) = roundn((abs((StDist2 - StDist1)) ./ (length(IDstroke))).*4,-2);
                        else;
                            SectionSD(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(IDstroke)-1)).*2,-2);
                            SectionSDbis(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(IDstroke)-1)).*2,-2);
                        end;
                        SectionNb(lap,pos(zone)) = length(IDstroke);
                        SectionNbbis(lap,pos(zone)) = length(IDstroke);

                    else;
                        SectionSR(lap,pos(zone)) = NaN;
                        SectionSD(lap,pos(zone)) = NaN;
                        SectionNb(lap,pos(zone)) = length(liStrokeSecRef);

                        SectionSRbis(lap,pos(zone)) = NaN;
                        SectionSDbis(lap,pos(zone)) = NaN;
                        SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                    end;
                else;
                    %BF and BR
                    if length(liStrokeSecRef) <= 1;
                        SectionSR(lap,pos(zone)) = NaN;
                        SectionSD(lap,pos(zone)) = NaN;
                        SectionNb(lap,pos(zone)) = length(liStrokeSecRef);

                        SectionSRbis(lap,pos(zone)) = NaN;
                        SectionSDbis(lap,pos(zone)) = NaN;
                        SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);

                    elseif length(liStrokeSecRef) > 1 & length(liStrokeSecRef) < 2;

                        if zone == 1;
                            indexPlusStrokes = find(liStrokeLap > liStrokeSecRef(end));
                            IDstroke = [liStrokeSecRef(1) liStrokeSecRef(2) liStrokeLap(indexPlusStrokes(1))];
                        elseif zone == 5;
                            indexMinusStrokes = find(liStrokeLap < liStrokeSecRef(end-1));
                            IDstroke = [liStrokeLap(indexMinusStrokes(end)) liStrokeSecRef(1) liStrokeSecRef(2)];
                        else;
                            indexPlusStrokes = find(liStrokeLap > liStrokeSecRef(end));
                            IDstroke = [liStrokeSecRef(1) liStrokeSecRef(2) liStrokeLap(indexPlusStrokes(1))];
                        end;
                        li = find(IDstroke > 1);
                        IDstroke = IDstroke(li);
                        
                        StTime1 = IDstroke(1);
                        StTime2 = IDstroke(end);
                        StrDuration = (StTime2 - StTime1)./framerate;
                        SectionSR(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
                        SectionSRbis(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
                        
                        %position at the beginning and end
%                         VelEC = SectionVel(lap,pos(zone));
                        
                        StTime1 = (IDstroke(1)-listart)./framerate;
                        StTime2 = (IDstroke(end)-listart)./framerate;
                        
                        if lap >= 2;
                            if zone == 1;
                                SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                            else;
                                SegTime1 = (liIniRef-listart)/framerate;
                            end;
                        else;
                            SegTime1 = (liIniRef-listart)/framerate;
                        end;
                        SegTime2 = (liEndRef-listart)/framerate;
                        
                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                        PosTime2 = (StTime2 - SegTime2) .* VelEC;
                        
                        if lap >= 2;
                            if zone == 1;
                                StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                StDist2 = DistEndRef + PosTime2;
                            elseif zone == 5;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndStroke;
                            else;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndRef + PosTime2;
                            end;
                        else;
                            if zone == 5;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndStroke;
                            else;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndRef + PosTime2;
                            end;
                        end;
                        
                        if zone == 5;
                            SectionSD(lap,pos(zone)) = NaN;
                            SectionSDbis(lap,pos(zone)) = NaN;
                        else;
                            SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                            SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                        end;
                        SectionNb(lap,pos(zone)) = 1;
                        SectionNbbis(lap,pos(zone)) = 1;
                        
                    else;

                        IDstroke = [];
                        IDstrokeOther = [];
                        for stro = 1:length(liStrokeSecRef);
                            IDstroke = [IDstroke liStrokeSecRef(stro)];
                        end;
                        if lap ~= 1;
                            if zone == 1;
                                for stro = 1:length(liStrokeSecOther);
                                    IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
                                end;
                                if length(IDstrokeOther) <= 1;
                                    IDstrokeOther = 0; %error not enough strokes
                                elseif length(IDstrokeOther) == 2;
%                                                     indexextra = find(liStrokeLap == IDstrokeOther(end));
                                    IDstrokeOther = IDstroke;
                                end;
                            end;
                        end;
                        
                        StTime1 = (IDstroke(1)-listart)./framerate;
                        StTime2 = (IDstroke(end)-listart)./framerate;
                        StrDuration = (StTime2 - StTime1);
                        SectionSR(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
                        SectionSRbis(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
%                         VelEC = SectionVel(lap,pos(zone));

                        %position at the beginning and end
                        if isempty(IDstrokeOther) == 0;
                            StTime1 = (IDstrokeOther(1)-listart)./framerate;
                            StTime2 = (IDstrokeOther(end)-listart)./framerate;
                        else;
                            StTime1 = (IDstroke(1)-listart)./framerate;
                            StTime2 = (IDstroke(end)-listart)./framerate;
                        end;

                        if lap >= 2;
                            if zone == 1;
%                                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                                SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                            else;
                                SegTime1 = (liIniRef-listart)/framerate;
                            end;
                        else;
                            SegTime1 = (liIniRef-listart)/framerate;
                        end;
                        SegTime2 = (liEndRef-listart)/framerate;
                        
                        PosTime1 = (StTime1 - SegTime1) .* VelEC;
                        PosTime2 = (StTime2 - SegTime2) .* VelEC;
                    
                        if lap >= 2;
                            if zone == 1;
%                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                                StDist2 = DistEndRef + PosTime2;
                                
                            elseif zone == 5;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndStroke;
                            else;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndRef + PosTime2;
                            end;
                        else;
                            if zone == 5;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndStroke;
                            else;
                                StDist1 = DistIniRef + PosTime1;
                                StDist2 = DistEndRef + PosTime2;
                            end;
                        end;
                        
                        if zone == 5;
                            SectionSD(lap,pos(zone)) = NaN;
                            SectionSDbis(lap,pos(zone)) = NaN;
                            SectionNb(lap,pos(zone)) = length(IDstroke);
                            SectionNbbis(lap,pos(zone)) = length(IDstroke);
                        else;
                            if isempty(IDstrokeOther) == 0;
                                if IDstrokeOther == 0;
                                    SectionSD(lap,pos(zone)) = NaN;
                                    SectionSDbis(lap,pos(zone)) = NaN;
                                    
                                else;
                                    SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstrokeOther)-1), -2);
                                    SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstrokeOther)-1), -2);
                                end;
                                SectionNb(lap,pos(zone)) = length(IDstrokeOther);
                                SectionNbbis(lap,pos(zone)) = length(IDstrokeOther);
                            else;
                                SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                                SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                                SectionNb(lap,pos(zone)) = length(IDstroke);
                                SectionNbbis(lap,pos(zone)) = length(IDstroke);
                            end;
                        end;
                    end;
                end;

            else;
                %FS AND BK
                if length(liStrokeSecRef) >= 2;
                    
                    IDstroke = [];
                    IDstrokeOther = [];
                    for stro = 1:length(liStrokeSecRef);
                        IDstroke = [IDstroke liStrokeSecRef(stro)];
                    end;
                    if lap ~= 1;
                        if zone == 1;
                            for stro = 1:length(liStrokeSecOther);
                                IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
                            end;
                            if length(IDstrokeOther) <= 1;
                                IDstrokeOther = 0; %error not enough strokes
                            elseif length(IDstrokeOther) == 2;
%                                                     indexextra = find(liStrokeLap == IDstrokeOther(end));
                                IDstrokeOther = IDstroke;
                            end;
                        end;
                    end;

                    StTime1 = (IDstroke(1)-listart)./framerate;
                    StTime2 = (IDstroke(end)-listart)./framerate;

                    if length(IDstroke) == 2;
                        StrDuration = abs((StTime2 - StTime1));
                        SectionSR(lap,pos(zone)) = (((length(IDstroke)).*60)./StrDuration)./2;
                        SectionSRbis(lap,pos(zone)) = (((length(IDstroke)).*60)./StrDuration)./2;
                    else;
                        StrDuration = (StTime2 - StTime1);
                        SectionSR(lap,pos(zone)) = ((length(IDstroke)-1).*60)./StrDuration;
                        SectionSRbis(lap,pos(zone)) = ((length(IDstroke)-1).*60)./StrDuration;
                    end;
                    SectionSR(lap,pos(zone)) = roundn(SectionSR(lap,pos(zone))./2,-1);
                    SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone))./2,-1);
                    

                    %position at the beginning and end
%                     VelEC = SectionVel(lap,pos(zone));

                    if isempty(IDstrokeOther) == 0;
                        StTime1Other = (IDstrokeOther(1)-listart)./framerate;
                        StTime2Other = (IDstrokeOther(end)-listart)./framerate;

                        StTime1 = (IDstroke(1)-listart)./framerate;
                        StTime2 = (IDstroke(end)-listart)./framerate;
                    else;
                        StTime1 = (IDstroke(1)-listart)./framerate;
                        StTime2 = (IDstroke(end)-listart)./framerate;
                    end;

                    if lap >= 2;
                        if zone == 1;
%                                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                            SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
                        else;
                            SegTime1 = (liIniRef-listart)/framerate;
                        end;
                    else;
                        SegTime1 = (liIniRef-listart)/framerate;
                    end;
                    SegTime2 = (liEndRef-listart)/framerate;
                    
                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                    
                    if lap >= 2;
                        if zone == 1;
%                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                            StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                            StDist2 = DistEndRef + PosTime2;
                            
                        elseif zone == 5;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndStroke;
                        else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
                        end;
                    else;
                        if zone == 5;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndStroke;
                        else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
                        end;
                    end;



























                    if zone == 5;
                        SectionSD(lap,pos(zone)) = NaN;
                        SectionSDbis(lap,pos(zone)) = NaN;
                    else;
                        if lap == 1;
                            if zone == 1;
                                SectionSD(lap,pos(zone)) = NaN;
                                SectionSDbis(lap,pos(zone)) = NaN;
                            else;
                                if length(IDstroke) == 2;
                                    SectionSD(lap,pos(zone)) = roundn((abs((StDist2 - StDist1)) ./ (length(IDstroke))).*4,-2);
                                    SectionSDbis(lap,pos(zone)) = roundn((abs((StDist2 - StDist1)) ./ (length(IDstroke))).*4,-2);
                                else;
                                    SectionSD(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(IDstroke)-1)).*2,-2);
                                    SectionSDbis(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(IDstroke)-1)).*2,-2);
                                end;
                            end;
                        else;
                            if length(IDstroke) == 2;
                                SectionSD(lap,pos(zone)) = roundn((abs((StDist2 - StDist1)) ./ (length(IDstroke))).*4,-2);
                                SectionSDbis(lap,pos(zone)) = roundn((abs((StDist2 - StDist1)) ./ (length(IDstroke))).*4,-2);
                            else;
                                SectionSD(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(IDstroke)-1)).*2,-2);
                                SectionSDbis(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(IDstroke)-1)).*2,-2);
                            end;
                        end;
                    end;
                    SectionNb(lap,pos(zone)) = length(IDstroke);
                    SectionNbbis(lap,pos(zone)) = length(IDstroke);
                else;
                    SectionSR(lap,pos(zone)) = NaN;
                    SectionSD(lap,pos(zone)) = NaN;
                    SectionNb(lap,pos(zone)) = length(liStrokeSecRef);

                    SectionSRbis(lap,pos(zone)) = NaN;
                    SectionSDbis(lap,pos(zone)) = NaN;
                    SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
                end;
            end;
        else;
            SectionSR(lap,pos(zone)) = NaN;
            SectionSD(lap,pos(zone)) = NaN;
            SectionNb(lap,pos(zone)) = NaN;

            SectionSRbis(lap,pos(zone)) = NaN;
            SectionSDbis(lap,pos(zone)) = NaN;
            SectionNbbis(lap,pos(zone)) = NaN;
        end;
    end;     
    DistIni = DistEnd;
%                         DistIniStroke = DistEndStroke;DistIni = DistEnd;
end;
% SectionVelbis = SectionVel;
% SectionSplitTimebis = SectionSplitTime;
% SectionCumTimebis = SectionCumTime;
% isInterpolatedSplitsbis = isInterpolatedSplits;
% isInterpolatedVelbis = isInterpolatedVel;
% isInterpolatedSD = isInterpolatedVel;
% isInterpolatedSDbis = isInterpolatedVelbis;

SectionVel_short = SectionVel;
isInterpolatedVel_short = isInterpolatedVel;
SectionSplitTime_short = SectionSplitTime;
SectionCumTime_short = SectionCumTime;
isInterpolatedSplits_short = isInterpolatedSplits;

SectionSR_short = SectionSR;
SectionSD_short = SectionSD;
SectionNb_short = SectionNb;
isInterpolatedSR_short = isInterpolatedSR;
isInterpolatedSD_short = isInterpolatedVel;
% isInterpolatedSDbis = isInterpolatedVelbis;

liSplitIni = SplitsAll(lap,3) + 1;
