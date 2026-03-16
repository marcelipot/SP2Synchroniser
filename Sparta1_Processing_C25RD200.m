if lap == 1;
    DistIniStroke = keydist;
    DistIni = keydist + 15;
else;
    DistIniStroke = keydist;
    DistIni = keydist + 10;
end;

if lap == 1;
    SectionSR = zeros(NbLap,5);
    SectionSR(:,:) = NaN;
    SectionSD = zeros(NbLap,5);
    SectionSD(:,:) = NaN;
    SectionNb = zeros(NbLap,5);
    SectionNb(:,:) = NaN;
    SectionVel = zeros(NbLap,5);
    SectionVel(:,:) = NaN;
    SectionSplitTime = zeros(NbLap,5);
    SectionSplitTime(:,:) = NaN;
    SectionCumTime = zeros(NbLap,5);
    SectionCumTime(:,:) = NaN;

    SectionSRbis = SectionSR;
    SectionSDbis = SectionSD;
    SectionNbbis = SectionNb;
    SectionVelbis = SectionVel;
    SectionSplitTimebis = SectionSplitTime;
    SectionCumTimebis = SectionCumTime;

    isInterpolatedSR = zeros(NbLap,5);
    isInterpolatedSD = zeros(NbLap,5);
    isInterpolatedSplits = zeros(NbLap,5);
    isInterpolatedVel = zeros(NbLap,5);
end;


pos = 5;
posSD = 5;
posVel = 5;

% for zone = 1:length(pos);
if lap == 1;
    %segment 0-15m after dive
    DistEnd = DistIni + 5;
    DistEndStroke = DistIniStroke + 25;
else;
    %segment 50-65m after turn (from 60 to 65m)
    DistEnd = DistIni + 10;
    DistEndStroke = DistIniStroke + 25;
end;
    
indexIni = find(liDistLap(:,5) == DistIni);
liIni = liDistLap(indexIni,4);   
TimeIni = (liIni - listart)./framerate;

indexIniStroke = find(liDistLap(:,5) == DistIniStroke);
liIniStroke = liDistLap(indexIniStroke,4);   
TimeIniStroke = (liIniStroke - listart)./framerate;

indexEnd = find(liDistLap(:,5) == DistEnd);
liEnd = liDistLap(indexEnd,4);
TimeEnd = (liEnd - listart)./framerate;

indexEndStroke = find(liDistLap(:,5) == DistEndStroke);
liEndStroke = liDistLap(indexEndStroke,4);
TimeEndStroke = (liEndStroke - listart)./framerate;

if BOAll(lap,1)+RaceStart > liEnd;
    SectionSR(lap,pos) = NaN;
    SectionSD(lap,pos) = NaN;
    SectionNb(lap,pos) = NaN;
    SectionVel(lap,pos) = NaN;
    SectionSplitTime(lap,pos) = NaN;
    SectionCumTime(lap,pos) = NaN;

    SectionSRbis(lap,pos) = NaN;
    SectionSDbis(lap,pos) = NaN;
    SectionNbbis(lap,pos) = NaN;
    SectionVelbis(lap,pos) = NaN;
    SectionSplitTimebis(lap,pos) = NaN;
    SectionCumTimebis(lap,pos) = NaN;
else;

    liIniBO = BOAll(lap,1)+1+RaceStart;
    DistIniBO = BOAll(lap,3);
    TimeIniBO = (liIniBO - listart)./framerate;
%     if DistIniBO > DistIni;
%         if BOAll(lap,4) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
%             isInterpolatedVel(lap,pos) = 1;
%         end;
%         VelEC = (DistEnd-DistIniBO) ./ (TimeEnd-TimeIniBO);
%         SectionVel(lap,pos) = roundn((DistEnd-DistIniBO) ./ (TimeEnd-TimeIniBO),-2);
%         SectionVelbis(lap,pos) = roundn((DistEnd-DistIniBO) ./ (TimeEnd-TimeIniBO),-2);
% %         SectionVel(lap,pos) = (DistEnd-DistIniBO) ./ (TimeEnd-TimeIniBO);
% %         SectionVelbis(lap,pos) = (DistEnd-DistIniBO) ./ (TimeEnd-TimeIniBO);
%     else;
        if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
            isInterpolatedVel(lap,pos) = 1;
        end;
        VelEC = (DistEnd-DistIni) ./ (TimeEnd-TimeIni);
        SectionVel(lap,pos) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
        SectionVelbis(lap,pos) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
%         SectionVel(lap,pos) = (DistEnd-DistIni) ./ (TimeEnd-TimeIni);
%         SectionVelbis(lap,pos) = (DistEnd-DistIni) ./ (TimeEnd-TimeIni);
%     end;

    if isnan(liDistLap(indexIniStroke,3)) == 1 | isnan(liDistLap(indexEndStroke,3)) == 1;
        isInterpolatedSplits(lap,pos) = 1;
    end;
    SectionSplitTime(lap,pos) = TimeEndStroke-TimeIniStroke;
    SectionCumTime(lap,pos) = TimeEndStroke;
    SectionSplitTimebis(lap,pos) = TimeEndStroke-TimeIniStroke;
    SectionCumTimebis(lap,pos) = TimeEndStroke;
    

    indexStrokeSec = find(liStrokeLap >= liIniBO & liStrokeLap <= liEndStroke);
    liStrokeSec = liStrokeLap(indexStrokeSec);

    indexStrokeSecOther = find(liStrokeLap >= liIni & liStrokeLap <= liEnd);
    liStrokeSecOther = liStrokeLap(indexStrokeSecOther);

%     if lap ~= 1;
%         if zone == 1;
            indexStrokeSecStroke = find(liStrokeLap >= liIniStroke & liStrokeLap < liEnd);
            liStrokeSecStroke = liStrokeLap(indexStrokeSecStroke);
%         else
%             indexStrokeSecStroke = find(liStrokeLap >= liIniStroke & liStrokeLap < liEndStroke);
%             liStrokeSecStroke = liStrokeLap(indexStrokeSecStroke);
%         end;
%     else;
%         if zone == 1;
%             indexStrokeSecStroke = find(liStrokeLap >= liIniStroke & liStrokeLap < liEnd);
%             liStrokeSecStroke = liStrokeLap(indexStrokeSecStroke);
%         else;
%             indexStrokeSecStroke = find(liStrokeLap >= liIniStroke & liStrokeLap < liEndStroke);
%             liStrokeSecStroke = liStrokeLap(indexStrokeSecStroke);
%         end;
%     end;


    %delete that section?
    if lap >= 2;
        liStrokeSecRef = liStrokeSec;
        liIniRef = liIni;
        liEndRef = liEnd;

%         if zone == 1;
%             if BOAll(lap,3) < DistIni;
%                 DistIniRef = DistIni;
%             else;
%                 DistIniRef = BOAll(lap,3); 
%                 liIniRef = BOAll(lap,1)+RaceStart;
%             end;
%             DistEndRef = DistEnd;
%         else;
            DistIniRef = DistIni;
            DistEndRef = DistEnd;
%             
%         end;
    else;
        liStrokeSecRef = liStrokeSec;
        liIniRef = liIni;
        liEndRef = liEnd;

%         if zone == 1;
%             DistIniRef = BOAll(lap,3);
%             DistEndRef = DistEnd;
        
%         else;
            DistIniRef = DistIni;
            DistEndRef = DistEnd;
%         end;
    end;
    %%%
    
    if isempty(liStrokeSecRef) == 0;
        if strcmpi(StrokeType, 'Breaststroke') | strcmpi(StrokeType, 'Butterfly');
            if length(liStrokeSecRef) <= 1;
                SectionSR(lap,pos) = NaN;
                SectionSD(lap,pos) = NaN;
                SectionNb(lap,pos) = length(liStrokeSecRef);

                SectionSRbis(lap,pos) = NaN;
                SectionSDbis(lap,pos) = NaN;
                SectionNbbis(lap,pos) = length(liStrokeSecRef);

            elseif length(liStrokeSecRef) > 1 & length(liStrokeSecRef) < 2;
                
%                                         ########################
                
            else;
                IDstroke = [];
                IDstrokeOther = [];
                for stro = 1:length(liStrokeSecRef);
                    IDstroke = [IDstroke liStrokeSecRef(stro)];
                end;
                stro1 = stro;
                
                for stro = 1:length(liStrokeSecOther);
                    IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
                end;
                if length(IDstrokeOther) <= 1;
                    IDstrokeOther = 0; %error not enough strokes
                elseif length(IDstrokeOther) == 2;
                    IDstrokeOther = IDstroke;
%                     index = find(IDstroke == IDstrokeOther(1));
%                     if index == 1;
%                         index = find(IDstroke == IDstrokeOther(end));
%                         if length(IDstroke) == index;
%                             %no other stroke available
%                             IDstrokeOther = IDstroke;
%                         else;
%                             %use the previous stroke available
%                             IDstrokeOther = [IDstrokeOther IDstroke(index+1)];
%                         end;
%                     else;
%                         %use the next stroke available
%                         IDstrokeOther = [IDstroke(index-1) IDstrokeOther];
%                     end;
                end;

%                 if lap ~= 1;
%                     IDstrokeStroke = [];
%                     for stro = 1:length(liStrokeSecStroke);
%                         IDstrokeStroke = [IDstrokeStroke liStrokeSecStroke(stro)];
%                     end;
%                 else;
%                     IDstrokeStroke = [];
%                     for stro = 1:length(liStrokeSecStroke);
%                         IDstrokeStroke = [IDstrokeStroke liStrokeSecStroke(stro)];
%                     end;
%                 end;
                
                StTime1 = (IDstroke(1)-listart)./framerate;
                StTime2 = (IDstroke(end)-listart)./framerate;
%                 StTime1Stroke = (IDstrokeStroke(1)-listart)./framerate;
%                 StTime2Stroke = (IDstrokeStroke(end)-listart)./framerate;
                StrDuration = (StTime2 - StTime1);
                SectionSR(lap,pos) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
                SectionSRbis(lap,pos) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
%                 SectionSR(lap,pos) = ((length(IDstroke)-1).*60)./StrDuration;
%                 SectionSRbis(lap,pos) = ((length(IDstroke)-1).*60)./StrDuration;
%                 VelEC = SectionVel(lap,pos);

                %position at the beginning and end
                StTime1 = (IDstroke(1)-listart)./framerate;
                StTime2 = (IDstroke(end)-listart)./framerate;
                if lap >= 2;
%                     if zone == 1;
%                         SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                     else;
                        SegTime1 = (liIniRef-listart)/framerate;
%                     end;
                else;
                    SegTime1 = (liIniRef-listart)/framerate;
                end;
                SegTime2 = (liEndRef-listart)/framerate;
                
                PosTime1 = (StTime1 - SegTime1) .* VelEC;
                PosTime2 = (StTime2 - SegTime2) .* VelEC;

                if lap >= 2;
%                     if zone == 1;
%                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                        StDist1 = DistIniRef + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                        StDist2 = DistEndRef + PosTime2;
                        
%                     elseif zone == length(pos);
%                         StDist1 = DistIniRef + PosTime1;
%                         StDist2 = DistEndStroke;
%                     else;
%                         StDist1 = DistIniRef + PosTime1;
%                         StDist2 = DistEndRef + PosTime2;
%                     end;
                else;
%                         if zone == 5;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
                        StDist1 = DistIniRef + PosTime1;
                        StDist2 = DistEndRef + PosTime2;
%                         end;
                end;

                indexZoneSD = find(posSD == pos);
                if isempty(indexZoneSD) == 1;
                    SectionSD(lap,pos) = NaN;
                    SectionSDbis(lap,pos) = NaN;
                    SectionNb(lap,pos) = length(IDstroke);
                    SectionNbbis(lap,pos) = length(IDstroke);
                else;
%                         if isempty(IDstrokeOther) == 0;
                        if isempty(IDstrokeOther) == 1;
                            SectionSD(lap,pos) = NaN;
                            SectionSDbis(lap,pos) = NaN;
                            
                        else;
                            SectionSD(lap,pos) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                            SectionSDbis(lap,pos) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
%                             SectionSD(lap,pos) = (StDist2 - StDist1) ./ (length(IDstroke)-1);
%                             SectionSDbis(lap,pos) = (StDist2 - StDist1) ./ (length(IDstroke)-1);
                        end;
                        SectionNb(lap,pos) = length(IDstroke);
                        SectionNbbis(lap,pos) = length(IDstroke);
%                         else;
%                             SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
%                             SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
%                             SectionNb(lap,pos(zone)) = length(IDstroke);
%                             SectionNbbis(lap,pos(zone)) = length(IDstroke);
%                         end;
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
                    stro1 = stro;

                    for stro = 1:length(liStrokeSecOther);
                        IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
                    end;
                    if length(IDstrokeOther) <= 1;
                        IDstrokeOther = 0; %error not enough strokes
                    elseif length(IDstrokeOther) == 2;
                        IDstrokeOther = IDstroke;
    %                     index = find(IDstroke == IDstrokeOther(1));
    %                     if index == 1;
    %                         index = find(IDstroke == IDstrokeOther(end));
    %                         if length(IDstroke) == index;
    %                             %no other stroke available
    %                             IDstrokeOther = IDstroke;
    %                         else;
    %                             %use the previous stroke available
    %                             IDstrokeOther = [IDstrokeOther IDstroke(index+1)];
    %                         end;
    %                     else;
    %                         %use the next stroke available
    %                         IDstrokeOther = [IDstroke(index-1) IDstrokeOther];
    %                     end;
                    end;

%                     if lap ~= 1;
%                         IDstrokeStroke = [];
%                         for stro = 1:length(liStrokeSecStroke);
%                             IDstrokeStroke = [IDstrokeStroke liStrokeSecStroke(stro)];
%                         end;
%                     else;
%                         IDstrokeStroke = [];
%                         for stro = 1:length(liStrokeSecStroke);
%                             IDstrokeStroke = [IDstrokeStroke liStrokeSecStroke(stro)];
%                         end;
%                     end;

                    StTime1 = (IDstroke(1)-listart)./framerate;
                    StTime2 = (IDstroke(end)-listart)./framerate;
                    if stro1 + 1 < length(liStrokeLap);
                        indexStrokeNew = find(liStrokeLap == IDstroke(end)) + 1;
                        if indexStrokeNew > length(indexStrokeNew);
                            %just in case
                            indexStrokeNew = find(liStrokeLap == IDstroke(end)) - 1;
                            liStrokeNew = liStrokeLap(indexStrokeNew);
                            StTime3 = (liStrokeNew-listart)./framerate;
                        else;
                            liStrokeNew = liStrokeLap(indexStrokeNew);
                            StTime3 = (liStrokeNew-listart)./framerate;
                        end;
                    else;
                        indexStrokeNew = find(liStrokeLap == IDstroke(end)) - 1;
                        liStrokeNew = liStrokeLap(indexStrokeNew);
                        StTime3 = (liStrokeNew-listart)./framerate;
                    end;

%                     StTime1Stroke = (IDstrokeStroke(1)-listart)./framerate;
%                     StTime2Stroke = (IDstrokeStroke(end)-listart)./framerate;
                    
%                     if zone == 1;
%                         indexStrokeNew = find(liStrokeLap == IDstroke(end)) + 1;
%                         liStrokeNew = liStrokeLap(indexStrokeNew);
%                         StTime3Stroke = (liStrokeNew-listart)./framerate;
%                     else;
%                         indexStrokeNew = find(liStrokeLap == IDstrokeStroke(end)) - 1;
%                         liStrokeNew = liStrokeLap(indexStrokeNew);
%                         StTime3Stroke = (liStrokeNew-listart)./framerate;
%                     end;

                    if length(liStrokeSecStroke) == 2;
                        StrDuration = abs((StTime3Stroke - StTime1));
                        SectionSR(lap,pos) = ((length(IDstroke)).*60)./StrDuration;
                        SectionSRbis(lap,pos) = ((length(IDstroke)).*60)./StrDuration;
                    else;
                        StrDuration = (StTime2 - StTime1);
                        SectionSR(lap,pos) = ((length(IDstroke)-1).*60)./StrDuration;
                        SectionSRbis(lap,pos) = ((length(IDstroke)-1).*60)./StrDuration;
                    end;
                    SectionSR(lap,pos) = roundn(SectionSR(lap,pos)./2,-1);
                    SectionSRbis(lap,pos) = roundn(SectionSRbis(lap,pos)./2,-1);
%                     SectionSR(lap,pos) = SectionSR(lap,pos)./2;
%                     SectionSRbis(lap,pos) = SectionSRbis(lap,pos)./2;
 %                     VelEC = SectionVel(lap,pos);                   

                    %position at the beginning and end
                    StTime1 = (IDstroke(1)-listart)./framerate;
                    StTime2 = (IDstroke(end)-listart)./framerate;
                    if lap >= 2;
%                         if zone == 1;
%                             SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                         else;
                            SegTime1 = (liIniRef-listart)/framerate;
%                         end;
                    else;
                        SegTime1 = (liIniRef-listart)/framerate;
                    end;
                    SegTime2 = (liEndRef-listart)/framerate;
                    
                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                    PosTime2 = (StTime2 - SegTime2) .* VelEC;
                    
                    if lap >= 2;
%                         if zone == 1;
    %                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist2 = DistEndRef + PosTime2;
                            
%                         elseif zone == length(pos);
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
%                         end;
                    else;
    %                         if zone == 5;
    %                             StDist1 = DistIniRef + PosTime1;
    %                             StDist2 = DistEndStroke;
    %                         else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
    %                         end;
                    end;
                    
                    indexZoneSD = find(posSD == pos);
                    if isempty(indexZoneSD) == 1;
                        SectionSD(lap,pos) = NaN;
                        SectionSDbis(lap,pos) = NaN;
                        SectionNb(lap,pos) = length(IDstroke);
                        SectionNbbis(lap,pos) = length(IDstroke);
                    else;
                        if isempty(IDstrokeOther) == 1;
                            SectionSD(lap,pos) = NaN;
                            SectionSDbis(lap,pos) = NaN;
                        else;
                            SectionSD(lap,pos) = (StDist2 - StDist1) ./ (length(IDstroke)-1);
                            SectionSD(lap,pos) = roundn(SectionSD(lap,pos) .* 2, -2);
%                             SectionSD(lap,pos) = SectionSD(lap,pos) .* 2;
                            SectionSDbis(lap,pos) = (StDist2 - StDist1) ./ (length(IDstroke)-1);
                            SectionSDbis(lap,pos) = roundn(SectionSD(lap,pos) .* 2, -2);
%                             SectionSDbis(lap,pos) = SectionSD(lap,pos) .* 2;
                        end;
                        SectionNb(lap,pos) = length(IDstroke);
                        SectionNbbis(lap,pos) = length(IDstroke);
                    end;
                                                        
                else;
                    SectionSR(lap,pos) = NaN;
                    SectionSD(lap,pos) = NaN;
                    SectionNb(lap,pos) = length(liStrokeSecRef);

                    SectionSRbis(lap,pos) = NaN;
                    SectionSDbis(lap,pos) = NaN;
                    SectionNbbis(lap,pos) = length(liStrokeSecRef);
                end;
            else;
                %BF and BR
                if length(liStrokeSecRef) <= 1;
                    SectionSR(lap,pos) = NaN;
                    SectionSD(lap,pos) = NaN;
                    SectionNb(lap,pos) = NaN;

                    SectionSRbis(lap,pos) = NaN;
                    SectionSDbis(lap,pos) = NaN;
                    SectionNbbis(lap,pos) = NaN;

                elseif length(liStrokeSecRef) > 1 & length(liStrokeSecRef) < 2;
                    
%                                         ########################
                    
                else;
                    IDstroke = [];
                    IDstrokeOther = [];
                    for stro = 1:length(liStrokeSecRef);
                        IDstroke = [IDstroke liStrokeSecRef(stro)];
                    end;
                    stro1 = stro;
                    
                    for stro = 1:length(liStrokeSecOther);
                        IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
                    end;
                    if length(IDstrokeOther) <= 1;
                        IDstrokeOther = 0; %error not enough strokes
                    elseif length(IDstrokeOther) == 2;
                        IDstrokeOther = IDstroke;
    %                     index = find(IDstroke == IDstrokeOther(1));
    %                     if index == 1;
    %                         index = find(IDstroke == IDstrokeOther(end));
    %                         if length(IDstroke) == index;
    %                             %no other stroke available
    %                             IDstrokeOther = IDstroke;
    %                         else;
    %                             %use the previous stroke available
    %                             IDstrokeOther = [IDstrokeOther IDstroke(index+1)];
    %                         end;
    %                     else;
    %                         %use the next stroke available
    %                         IDstrokeOther = [IDstroke(index-1) IDstrokeOther];
    %                     end;
                    end;

%                     if lap ~= 1;
%                         IDstrokeStroke = [];
%                         for stro = 1:length(liStrokeSecStroke);
%                             IDstrokeStroke = [IDstrokeStroke liStrokeSecStroke(stro)];
%                         end;
%                     else;
%                         IDstrokeStroke = [];
%                         for stro = 1:length(liStrokeSecStroke);
%                             IDstrokeStroke = [IDstrokeStroke liStrokeSecStroke(stro)];
%                         end;
%                     end;
                    
                    StTime1 = (IDstroke(1)-listart)./framerate;
                    StTime2 = (IDstroke(end)-listart)./framerate;
    %                 StTime1Stroke = (IDstrokeStroke(1)-listart)./framerate;
    %                 StTime2Stroke = (IDstrokeStroke(end)-listart)./framerate;
                    StrDuration = (StTime2 - StTime1);
                    SectionSR(lap,pos) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
                    SectionSRbis(lap,pos) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
%                     SectionSR(lap,pos) = ((length(IDstroke)-1).*60)./StrDuration;
%                     SectionSRbis(lap,pos) = ((length(IDstroke)-1).*60)./StrDuration;
%                     VelEC = SectionVel(lap,pos);

                    %position at the beginning and end
                    StTime1 = (IDstroke(1)-listart)./framerate;
                    StTime2 = (IDstroke(end)-listart)./framerate;
                    if lap >= 2;
%                         if zone == 1;
%                             SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                         else;
                            SegTime1 = (liIniRef-listart)/framerate;
%                         end;
                    else;
                        SegTime1 = (liIniRef-listart)/framerate;
                    end;
                    SegTime2 = (liEndRef-listart)/framerate;
                    
                    PosTime1 = (StTime1 - SegTime1) .* VelEC;
                    PosTime2 = (StTime2 - SegTime2) .* VelEC;

                    if lap >= 2;
%                         if zone == 1;
    %                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist2 = DistEndRef + PosTime2;
                            
%                         elseif zone == length(pos);
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
%                         end;
                    else;
    %                         if zone == 5;
    %                             StDist1 = DistIniRef + PosTime1;
    %                             StDist2 = DistEndStroke;
    %                         else;
                            StDist1 = DistIniRef + PosTime1;
                            StDist2 = DistEndRef + PosTime2;
    %                         end;
                    end;
                    
                    indexZoneSD = find(posSD == pos);
                    if isempty(indexZoneSD) == 1;
                        SectionSD(lap,pos) = NaN;
                        SectionSDbis(lap,pos) = NaN;
                        SectionNb(lap,pos) = length(IDstroke);
                        SectionNbbis(lap,pos) = length(IDstroke);
                    else;
    %                         if isempty(IDstrokeOther) == 0;
                            if isempty(IDstrokeOther) == 1;
                                SectionSD(lap,pos) = NaN;
                                SectionSDbis(lap,pos) = NaN;
                                
                            else;
                                SectionSD(lap,pos) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
                                SectionSDbis(lap,pos) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
%                                 SectionSD(lap,pos) = (StDist2 - StDist1) ./ (length(IDstroke)-1);
%                                 SectionSDbis(lap,pos) = (StDist2 - StDist1) ./ (length(IDstroke)-1);
                            end;
                            SectionNb(lap,pos) = length(IDstroke);
                            SectionNbbis(lap,pos) = length(IDstroke);
    %                         else;
    %                             SectionSD(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
    %                             SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
    %                             SectionNb(lap,pos(zone)) = length(IDstroke);
    %                             SectionNbbis(lap,pos(zone)) = length(IDstroke);
    %                         end;
                    end;
                end;
            end;

        else;
            if length(liStrokeSecRef) >= 2;
                
                IDstroke = [];
                IDstrokeOther = [];
                for stro = 1:length(liStrokeSecRef);
                    IDstroke = [IDstroke liStrokeSecRef(stro)];
                end;
                stro1 = stro;

                for stro = 1:length(liStrokeSecOther);
                    IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
                end;
                if length(IDstrokeOther) <= 1;
                    IDstrokeOther = 0; %error not enough strokes
                elseif length(IDstrokeOther) == 2;
                    IDstrokeOther = IDstroke;
%                     index = find(IDstroke == IDstrokeOther(1));
%                     if index == 1;
%                         index = find(IDstroke == IDstrokeOther(end));
%                         if length(IDstroke) == index;
%                             %no other stroke available
%                             IDstrokeOther = IDstroke;
%                         else;
%                             %use the previous stroke available
%                             IDstrokeOther = [IDstrokeOther IDstroke(index+1)];
%                         end;
%                     else;
%                         %use the next stroke available
%                         IDstrokeOther = [IDstroke(index-1) IDstrokeOther];
%                     end;
                end;

%                 if lap ~= 1;
%                     IDstrokeStroke = [];
%                     for stro = 1:length(liStrokeSecStroke);
%                         IDstrokeStroke = [IDstrokeStroke liStrokeSecStroke(stro)];
%                     end;
%                 else;
%                     IDstrokeStroke = [];
%                     for stro = 1:length(liStrokeSecStroke);
%                         IDstrokeStroke = [IDstrokeStroke liStrokeSecStroke(stro)];
%                     end;
%                 end;

                StTime1 = (IDstroke(1)-listart)./framerate;
                StTime2 = (IDstroke(end)-listart)./framerate;
                if stro1 + 1 < length(liStrokeLap);
                    indexStrokeNew = find(liStrokeLap == IDstroke(end)) + 1;
                    if indexStrokeNew > length(indexStrokeNew);
                        %just in case
                        indexStrokeNew = find(liStrokeLap == IDstroke(end)) - 1;
                        liStrokeNew = liStrokeLap(indexStrokeNew);
                        StTime3 = (liStrokeNew-listart)./framerate;
                    else;
                        liStrokeNew = liStrokeLap(indexStrokeNew);
                        StTime3 = (liStrokeNew-listart)./framerate;
                    end;
                else;
                    indexStrokeNew = find(liStrokeLap == IDstroke(end)) - 1;
                    liStrokeNew = liStrokeLap(indexStrokeNew);
                    StTime3 = (liStrokeNew-listart)./framerate;
                end;

%                 StTime1Stroke = (IDstrokeStroke(1)-listart)./framerate;
%                 StTime2Stroke = (IDstrokeStroke(end)-listart)./framerate;
                
%                 if zone == 1;
%                     indexStrokeNew = find(liStrokeLap == IDstroke(end)) + 1;
%                     liStrokeNew = liStrokeLap(indexStrokeNew);
%                     StTime3Stroke = (liStrokeNew-listart)./framerate;
%                 else;
%                     indexStrokeNew = find(liStrokeLap == IDstrokeStroke(end)) - 1;
%                     liStrokeNew = liStrokeLap(indexStrokeNew);
%                     StTime3Stroke = (liStrokeNew-listart)./framerate;
%                 end;

                if length(liStrokeSecStroke) == 2;
                    StrDuration = abs((StTime3Stroke - StTime1));
                    SectionSR(lap,pos) = ((length(IDstroke)).*60)./StrDuration;
                    SectionSRbis(lap,pos) = ((length(IDstroke)).*60)./StrDuration;
                else;
                    StrDuration = (StTime2 - StTime1);
                    SectionSR(lap,pos) = ((length(IDstroke)-1).*60)./StrDuration;
                    SectionSRbis(lap,pos) = ((length(IDstroke)-1).*60)./StrDuration;
                end;
                SectionSR(lap,pos) = roundn(SectionSR(lap,pos)./2,-1);
                SectionSRbis(lap,pos) = roundn(SectionSRbis(lap,pos)./2,-1);
%                     SectionSR(lap,pos) = SectionSR(lap,pos)./2;
%                     SectionSRbis(lap,pos) = SectionSRbis(lap,pos)./2;
%                     VelEC = SectionVel(lap,pos);                 
%                 VelEC = SectionVel(lap,pos);

                %position at the beginning and end
                StTime1 = (IDstroke(1)-listart)./framerate;
                StTime2 = (IDstroke(end)-listart)./framerate;
                if lap >= 2;
%                     if zone == 1;
%                         SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                     else;
                        SegTime1 = (liIniRef-listart)/framerate;
%                     end;
                else;
                    SegTime1 = (liIniRef-listart)/framerate;
                end;
                SegTime2 = (liEndRef-listart)/framerate;
                
                PosTime1 = (StTime1 - SegTime1) .* VelEC;
                PosTime2 = (StTime2 - SegTime2) .* VelEC;
                
                if lap >= 2;
%                     if zone == 1;
%                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                        StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
                        StDist2 = DistEndRef + PosTime2;
                        
%                     elseif zone == length(pos);
%                         StDist1 = DistIniRef + PosTime1;
%                         StDist2 = DistEndStroke;
%                     else;
%                         StDist1 = DistIniRef + PosTime1;
%                         StDist2 = DistEndRef + PosTime2;
%                     end;
                else;
%                         if zone == 5;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
                        StDist1 = DistIniRef + PosTime1;
                        StDist2 = DistEndRef + PosTime2;
%                         end;
                end;
                
                indexZoneSD = find(posSD == pos);
                if isempty(indexZoneSD) == 1;
                    SectionSD(lap,pos) = NaN;
                    SectionSDbis(lap,pos) = NaN;
                    SectionNb(lap,pos) = length(IDstroke);
                    SectionNbbis(lap,pos) = length(IDstroke);
                else;
                    if isempty(IDstrokeOther) == 1;
                        SectionSD(lap,pos) = NaN;
                        SectionSDbis(lap,pos) = NaN;
                    else;
                        SectionSD(lap,pos) = (StDist2 - StDist1) ./ (length(IDstroke)-1);
                        SectionSD(lap,pos) = roundn(SectionSD(lap,pos) .* 2, -2);
%                             SectionSD(lap,pos) = SectionSD(lap,pos) .* 2;
                        SectionSDbis(lap,pos) = (StDist2 - StDist1) ./ (length(IDstroke)-1);
                        SectionSDbis(lap,pos) = roundn(SectionSD(lap,pos) .* 2, -2);
%                             SectionSDbis(lap,pos) = SectionSD(lap,pos) .* 2;
                    end;
                    SectionNb(lap,pos) = length(IDstroke);
                    SectionNbbis(lap,pos) = length(IDstroke);
                end;

            else;
                SectionSR(lap,pos) = NaN;
                SectionSD(lap,pos) = NaN;
                SectionNb(lap,pos) = NaN;

                SectionSRbis(lap,pos) = NaN;
                SectionSDbis(lap,pos) = NaN;
                SectionNbbis(lap,pos) = NaN;
            end;
        end;
    else;
        SectionSR(lap,pos) = NaN;
        SectionSD(lap,pos) = NaN;
        SectionNb(lap,pos) = NaN;

        SectionSRbis(lap,pos) = NaN;
        SectionSDbis(lap,pos) = NaN;
        SectionNbbis(lap,pos) = NaN;
    end;
end;     
DistIni = DistEnd;
DistIniStroke = DistIni;


% end;
liSplitIni = SplitsAll(lap,3) + 1;

SectionVel_long = SectionVel;
isInterpolatedVel_long = isInterpolatedVel;
SectionSplitTime_long = SectionSplitTime;
SectionCumTime_long = SectionCumTime;
isInterpolatedSplits_long = isInterpolatedSplits;

SectionSR_long = SectionSR;
SectionSD_long = SectionSD;
SectionNb_long = SectionNb;
isInterpolatedSR_long = isInterpolatedSR;
isInterpolatedSD_long = isInterpolatedVel;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Do the same thing with the 100m segments
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if lap == 1;
%     DistIni = keydist;
%     DistIniStroke = keydist;
% else;
%     DistIniOther = keydist + 10;
%     DistIni = keydist;
% end;
% 
% if lap == 1;
%     SectionSRbis = [];
%     SectionSDbis = [];
%     SectionNbbis = [];
%     SectionVelbis = [];
%     SectionSplitTimebis = [];
%     SectionCumTimebis = [];
% 
%     isInterpolatedSRbis = zeros(NbLap,10);
%     isInterpolatedSDbis = zeros(NbLap,10);
%     isInterpolatedSplitsbis = zeros(NbLap,10);
%     isInterpolatedVelbis = zeros(NbLap,10);
% end;
% pos = [3 5 7 9 10];
% for zone = 1:5;
%     if zone == 1;
%         if lap == 1;
%             %segment 0-15m after dive
%             DistEnd = DistIni + 15;
%             DistEndStroke = DistIni + 15;
%         else;
%             %segment 50-65m after turn (from 60 to 65m)
%             DistIniOther = DistIni + 10;
%             DistEndOther = DistIniOther + 5;
%             DistEnd = DistIni + 15;
%         end;
%         DistIniOri = DistIni;
%     elseif zone == 5;
%         DistEnd = DistIni + 5;
%         DistEndStroke = DistIni + 5;
%     else;
%         DistEnd = DistIni + 10;
%         DistEndStroke = DistIni + 10;
%     end;
%     
%     indexIni = find(liDistLap(:,5) == DistIni);
%     liIni = liDistLap(indexIni,4);   
%     TimeIni = (liIni - listart)./framerate;
% 
%     if lap ~= 1;
%         if zone == 1
%             indexIniOther = find(liDistLap(:,5) == DistIniOther);
%             liIniOther = liDistLap(indexIniOther,4);   
%             TimeIniOther = (liIniOther - listart)./framerate;
%         end;
%     end;
% 
%     indexEnd = find(liDistLap(:,5) == DistEnd);
%     liEnd = liDistLap(indexEnd,4);
%     TimeEnd = (liEnd - listart)./framerate;
% 
%     if BOAll(lap,1)+RaceStart > liEnd;
%         SectionSRbis(lap,pos(zone)) = NaN;
%         SectionSDbis(lap,pos(zone)) = NaN;
%         SectionNbbis(lap,pos(zone)) = NaN;
%         SectionVelbis(lap,pos(zone)) = NaN;
%         SectionSplitTimebis(lap,pos(zone)) = NaN;
%         SectionCumTimebis(lap,pos(zone)) = NaN;
%     else;
%         
%         if zone == 5;
%             SectionVelbis(lap,pos(zone)) = NaN;
%         else;
%             if lap ~= 1;
%                 if zone == 1;
%                     if isnan(liDistLap(indexIniOther,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
%                         isInterpolatedVelbis(lap,pos(zone)) = 1;
%                     end;
%                     SectionVelbis(lap,pos(zone)) = roundn((DistEnd-DistIniOther) ./ (TimeEnd-TimeIniOther),-2);
%                 else;
%                     if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
%                         isInterpolatedVelbis(lap,pos(zone)) = 1;
%                     end;
%                     SectionVelbis(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
%                 end;
%             else;
%                 liIniBO = BOAll(lap,1)+RaceStart;
%                 DistIniBO = BOAll(lap,3);
%                 TimeIniBO = (liIniBO - listart)./framerate;
%                 if DistIniBO > DistIni;
%                     if BOAll(lap,4) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
%                         isInterpolatedVelbis(lap,pos(zone)) = 1;
%                     end;
%                     SectionVelbis(lap,pos(zone)) = roundn((DistEnd-DistIniBO) ./ (TimeEnd-TimeIniBO),-2);
%                 else;
%                     if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
%                         isInterpolatedVelbis(lap,pos(zone)) = 1;
%                     end;
%                     SectionVelbis(lap,pos(zone)) = roundn((DistEnd-DistIni) ./ (TimeEnd-TimeIni),-2);
%                 end;
%             end;
%         end;
%         if isnan(liDistLap(indexIni,3)) == 1 | isnan(liDistLap(indexEnd,3)) == 1;
%             isInterpolatedSplitsbis(lap,pos(zone)) = 1;
%         end;
%         SectionSplitTimebis(lap,pos(zone)) = TimeEnd-TimeIni;
%         SectionCumTimebis(lap,pos(zone)) = TimeEnd;
% 
%         indexStrokeSec = find(liStrokeLap >= liIni & liStrokeLap < liEnd);
%         liStrokeSec = liStrokeLap(indexStrokeSec);
% 
%         if lap ~= 1;
%             if zone == 1;
%                 indexStrokeSecOther = find(liStrokeLap >= liIniOther & liStrokeLap < liEnd);
%                 liStrokeSecOther = liStrokeLap(indexStrokeSecOther);
%             end;
%         end;
%         
%         if lap >= 2;
%             liStrokeSecRef = liStrokeSec;
%             liIniRef = liIni;
%             liEndRef = liEnd;
% 
%             if zone == 1;
%                 if BOAll(lap,3) < DistIni;
%                     DistIniRef = DistIni;
%                 else;
%                     DistIniRef = BOAll(lap,3); 
%                     liIniRef = BOAll(lap,1)+RaceStart;
%                 end;
%                 DistEndRef = DistEnd;
%             elseif zone == 5;
%                 liStrokeSecRef = liStrokeSec;
%                 liIniRef = liIni;
%                 liEndRef = liEnd;
%                 DistIniRef = DistIni;
%             else;
%                 DistIniRef = DistIni;
%                 DistEndRef = DistEnd;
%                 
%             end;
%         else;
%             liStrokeSecRef = liStrokeSec;
%             liIniRef = liIni;
%             liEndRef = liEnd;
% 
%             if zone == 1;
%                 liIniRef = BOAll(lap,1)+RaceStart;
%                 DistIniRef = BOAll(lap,3);
%                 DistEndRef = DistEnd;
%             elseif zone == 5;
%                 liStrokeSecRef = liStrokeSec;
%                 liIniRef = liIni;
%                 liEndRef = liEnd;
%                 DistIniRef = DistIni;
%             else;
%                 DistIniRef = DistIni;
%                 DistEndRef = DistEnd;
%             end;
%         end;
% 
%         if isempty(liStrokeSecRef) == 0;
%             if strcmpi(StrokeType, 'Breaststroke') | strcmpi(StrokeType, 'Butterfly');
%                 if length(liStrokeSecRef) <= 1;
%                     SectionSRbis(lap,pos(zone)) = NaN;
%                     SectionSDbis(lap,pos(zone)) = NaN;
%                     SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
% 
%                 elseif length(liStrokeSecRef) > 1 & length(liStrokeSecRef) < 2;
% 
%                     if zone == 1;
%                         indexPlusStrokes = find(liStrokeLap > liStrokeSecRef(end));
%                         IDstroke = [liStrokeSecRef(1) liStrokeSecRef(2) liStrokeLap(indexPlusStrokes(1))];
%                     elseif zone == 5;
%                         indexMinusStrokes = find(liStrokeLap < liStrokeSecRef(end-1));
%                         IDstroke = [liStrokeLap(indexMinusStrokes(end)) liStrokeSecRef(1) liStrokeSecRef(2)];
%                     else;
%                         indexPlusStrokes = find(liStrokeLap > liStrokeSecRef(end));
%                         IDstroke = [liStrokeSecRef(1) liStrokeSecRef(2) liStrokeLap(indexPlusStrokes(1))];
%                     end;
%                     li = find(IDstroke > 1);
%                     IDstroke = IDstroke(li);
%                     
%                     StTime1 = IDstroke(1);
%                     StTime2 = IDstroke(end);
%                     StrDuration = (StTime2 - StTime1)./framerate;
%                     SectionSRbis(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
%                     
%                     %position at the beginning and end
%                     VelEC = SectionVelbis(lap,pos(zone));
%                     
%                     StTime1 = (IDstroke(1)-listart)./framerate;
%                     StTime2 = (IDstroke(end)-listart)./framerate;
%                     
%                     if lap >= 2;
%                         if zone == 1;
%                             SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                         else;
%                             SegTime1 = (liIniRef-listart)/framerate;
%                         end;
%                     else;
%                         SegTime1 = (liIniRef-listart)/framerate;
%                     end;
%                     SegTime2 = (liEndRef-listart)/framerate;
%                     
%                     PosTime1 = (StTime1 - SegTime1) .* VelEC;
%                     PosTime2 = (StTime2 - SegTime2) .* VelEC;
%                     
%                     if lap >= 2;
%                         if zone == 1;
%                             StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist2 = DistEndRef + PosTime2;
%                         elseif zone == 5;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndRef + PosTime2;
%                         end;
%                     else;
%                         if zone == 5;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndRef + PosTime2;
%                         end;
%                     end;
%                     
%                     if zone == 5;
%                         SectionSDbis(lap,pos(zone)) = NaN;
%                     else;
%                         SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
%                     end;
%                     SectionNbbis(lap,pos(zone)) = 1;
%                     
%                 else;
% 
%                     IDstroke = [];
%                     IDstrokeOther = [];
%                     for stro = 1:length(liStrokeSecRef);
%                         IDstroke = [IDstroke liStrokeSecRef(stro)];
%                     end;
%                     if lap ~= 1;
%                         if zone == 1;
%                             for stro = 1:length(liStrokeSecOther);
%                                 IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
%                             end;
%                             if length(IDstrokeOther) <= 1;
%                                 IDstrokeOther = 0; %error not enough strokes
%                             elseif length(IDstrokeOther) == 2;
% %                                                     indexextra = find(liStrokeLap == IDstrokeOther(end));
%                                 IDstrokeOther = IDstroke;
%                             end;
%                         end;
%                     end;
%                     
%                     StTime1 = (IDstroke(1)-listart)./framerate;
%                     StTime2 = (IDstroke(end)-listart)./framerate;
%                     StrDuration = (StTime2 - StTime1);
%                     SectionSRbis(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
%                     VelEC = SectionVelbis(lap,pos(zone));
% 
%                     %position at the beginning and end
%                     if isempty(IDstrokeOther) == 0;
%                         StTime1 = (IDstrokeOther(1)-listart)./framerate;
%                         StTime2 = (IDstrokeOther(end)-listart)./framerate;
%                     else;
%                         StTime1 = (IDstroke(1)-listart)./framerate;
%                         StTime2 = (IDstroke(end)-listart)./framerate;
%                     end;
% 
%                     if lap >= 2;
%                         if zone == 1;
% %                                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                             SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                         else;
%                             SegTime1 = (liIniRef-listart)/framerate;
%                         end;
%                     else;
%                         SegTime1 = (liIniRef-listart)/framerate;
%                     end;
%                     SegTime2 = (liEndRef-listart)/framerate;
%                     
%                     PosTime1 = (StTime1 - SegTime1) .* VelEC;
%                     PosTime2 = (StTime2 - SegTime2) .* VelEC;
%                 
%                     if lap >= 2;
%                         if zone == 1;
% %                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist2 = DistEndRef + PosTime2;
%                             
%                         elseif zone == 5;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndRef + PosTime2;
%                         end;
%                     else;
%                         if zone == 5;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndRef + PosTime2;
%                         end;
%                     end;
%                     
%                     if zone == 5;
%                         SectionSDbis(lap,pos(zone)) = NaN;
%                         SectionNbbis(lap,pos(zone)) = length(IDstroke);
%                     else;
%                         if isempty(IDstrokeOther) == 0;
%                             if IDstrokeOther == 0;
%                                 SectionSDbis(lap,pos(zone)) = NaN;
%                             else;
%                                 SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstrokeOther)-1), -2);
%                             end;
%                             SectionNbbis(lap,pos(zone)) = length(IDstrokeOther);
%                         else;
%                             SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
%                             SectionNbbis(lap,pos(zone)) = length(IDstroke);
%                         end;
%                     end;
%                 end;
% 
%             elseif strcmpi(StrokeType, 'Medley');
%                 if isempty(lilap) == 1;
%                     %BK and FS
%                     if length(liStrokeSecRef) >= 2;
%                         IDstroke = [];
%                         IDstrokeOther = [];
%                         for stro = 1:length(liStrokeSecRef);
%                             IDstroke = [IDstroke liStrokeSecRef(stro)];
%                         end;
%                         if lap ~= 1;
%                             if zone == 1;
%                                 for stro = 1:length(liStrokeSecOther);
%                                     IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
%                                 end;
%                                 if length(IDstrokeOther) <= 1;
%                                     IDstrokeOther = 0; %error not enough strokes
%                                 elseif length(IDstrokeOther) == 2;
% %                                                     indexextra = find(liStrokeLap == IDstrokeOther(end));
%                                     IDstrokeOther = IDstroke;
%                                 end;
%                             end;
%                         end;
% 
%                         StTime1 = (IDstroke(1)-listart)./framerate;
%                         StTime2 = (IDstroke(end)-listart)./framerate;
% 
%                         if length(IDstroke) == 2;
%                             StrDuration = abs((StTime2 - StTime1));
%                             SectionSRbis(lap,pos(zone)) = (((length(IDstroke)).*60)./StrDuration)./2;
%                         else;
%                             StrDuration = (StTime2 - StTime1);
%                             SectionSRbis(lap,pos(zone)) = ((length(IDstroke)-1).*60)./StrDuration;
%                         end;
%                         SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone))./2,-1);
%                         
% 
%                         %position at the beginning and end
%                         VelEC = SectionVelbis(lap,pos(zone));
% 
%                         if isempty(IDstrokeOther) == 0;
%                             StTime1Other = (IDstrokeOther(1)-listart)./framerate;
%                             StTime2Other = (IDstrokeOther(end)-listart)./framerate;
% 
%                             StTime1 = (IDstroke(1)-listart)./framerate;
%                             StTime2 = (IDstroke(end)-listart)./framerate;
%                         else;
%                             StTime1 = (IDstroke(1)-listart)./framerate;
%                             StTime2 = (IDstroke(end)-listart)./framerate;
%                         end;
% 
%                         if lap >= 2;
%                             if zone == 1;
% %                                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                                 SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                             else;
%                                 SegTime1 = (liIniRef-listart)/framerate;
%                             end;
%                         else;
%                             SegTime1 = (liIniRef-listart)/framerate;
%                         end;
%                         SegTime2 = (liEndRef-listart)/framerate;
%                         
%                         PosTime1 = (StTime1 - SegTime1) .* VelEC;
%                         PosTime2 = (StTime2 - SegTime2) .* VelEC;
%                         
%                         if lap >= 2;
%                             if zone == 1;
% %                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                                 StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                                 StDist2 = DistEndRef + PosTime2;
%                                 
%                             elseif zone == 5;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndStroke;
%                             else;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndRef + PosTime2;
%                             end;
%                         else;
%                             if zone == 5;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndStroke;
%                             else;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndRef + PosTime2;
%                             end;
%                         end;
% 
%                         if length(IDstroke) == 2;
%                             SectionSDbis(lap,pos(zone)) = roundn((abs((StDist2 - StDist1)) ./ (length(IDstroke))).*4,-2);
%                         else;
%                             SectionSDbis(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(IDstroke)-1)).*2,-2);
%                         end;
%                         SectionNbbis(lap,pos(zone)) = length(IDstroke);
% 
%                     else;
%                         SectionSRbis(lap,pos(zone)) = NaN;
%                         SectionSDbis(lap,pos(zone)) = NaN;
%                         SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
%                     end;
%                 else;
%                     %BF and BR
%                     if length(liStrokeSecRef) <= 1;
%                         SectionSRbis(lap,pos(zone)) = NaN;
%                         SectionSDbis(lap,pos(zone)) = NaN;
%                         SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
% 
%                     elseif length(liStrokeSecRef) > 1 & length(liStrokeSecRef) < 2;
% 
%                         if zone == 1;
%                             indexPlusStrokes = find(liStrokeLap > liStrokeSecRef(end));
%                             IDstroke = [liStrokeSecRef(1) liStrokeSecRef(2) liStrokeLap(indexPlusStrokes(1))];
%                         elseif zone == 5;
%                             indexMinusStrokes = find(liStrokeLap < liStrokeSecRef(end-1));
%                             IDstroke = [liStrokeLap(indexMinusStrokes(end)) liStrokeSecRef(1) liStrokeSecRef(2)];
%                         else;
%                             indexPlusStrokes = find(liStrokeLap > liStrokeSecRef(end));
%                             IDstroke = [liStrokeSecRef(1) liStrokeSecRef(2) liStrokeLap(indexPlusStrokes(1))];
%                         end;
%                         li = find(IDstroke > 1);
%                         IDstroke = IDstroke(li);
%                         
%                         StTime1 = IDstroke(1);
%                         StTime2 = IDstroke(end);
%                         StrDuration = (StTime2 - StTime1)./framerate;
%                         SectionSRbis(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
%                         
%                         %position at the beginning and end
%                         VelEC = SectionVelbis(lap,pos(zone));
%                         
%                         StTime1 = (IDstroke(1)-listart)./framerate;
%                         StTime2 = (IDstroke(end)-listart)./framerate;
%                         
%                         if lap >= 2;
%                             if zone == 1;
%                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                             else;
%                                 SegTime1 = (liIniRef-listart)/framerate;
%                             end;
%                         else;
%                             SegTime1 = (liIniRef-listart)/framerate;
%                         end;
%                         SegTime2 = (liEndRef-listart)/framerate;
%                         
%                         PosTime1 = (StTime1 - SegTime1) .* VelEC;
%                         PosTime2 = (StTime2 - SegTime2) .* VelEC;
%                         
%                         if lap >= 2;
%                             if zone == 1;
%                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                                 StDist2 = DistEndRef + PosTime2;
%                             elseif zone == 5;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndStroke;
%                             else;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndRef + PosTime2;
%                             end;
%                         else;
%                             if zone == 5;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndStroke;
%                             else;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndRef + PosTime2;
%                             end;
%                         end;
%                         
%                         if zone == 5;
%                             SectionSDbis(lap,pos(zone)) = NaN;
%                         else;
%                             SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
%                         end;
%                         SectionNbbis(lap,pos(zone)) = 1;
%                         
%                     else;
%                         IDstroke = [];
%                         IDstrokeOther = [];
%                         for stro = 1:length(liStrokeSecRef);
%                             IDstroke = [IDstroke liStrokeSecRef(stro)];
%                         end;
%                         if lap ~= 1;
%                             if zone == 1;
%                                 for stro = 1:length(liStrokeSecOther);
%                                     IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
%                                 end;
%                                 if length(IDstrokeOther) <= 1;
%                                     IDstrokeOther = 0; %error not enough strokes
%                                 elseif length(IDstrokeOther) == 2;
% %                                                     indexextra = find(liStrokeLap == IDstrokeOther(end));
%                                     IDstrokeOther = IDstroke;
%                                 end;
%                             end;
%                         end;
%                         
%                         StTime1 = (IDstroke(1)-listart)./framerate;
%                         StTime2 = (IDstroke(end)-listart)./framerate;
%                         StrDuration = (StTime2 - StTime1);
%                         SectionSRbis(lap,pos(zone)) = roundn(((length(IDstroke)-1).*60)./StrDuration, -1);
%                         VelEC = SectionVelbis(lap,pos(zone));
% 
%                         %position at the beginning and end
%                         if isempty(IDstrokeOther) == 0;
%                             StTime1 = (IDstrokeOther(1)-listart)./framerate;
%                             StTime2 = (IDstrokeOther(end)-listart)./framerate;
%                         else;
%                             StTime1 = (IDstroke(1)-listart)./framerate;
%                             StTime2 = (IDstroke(end)-listart)./framerate;
%                         end;
% 
%                         if lap >= 2;
%                             if zone == 1;
% %                                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                                 SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                             else;
%                                 SegTime1 = (liIniRef-listart)/framerate;
%                             end;
%                         else;
%                             SegTime1 = (liIniRef-listart)/framerate;
%                         end;
%                         SegTime2 = (liEndRef-listart)/framerate;
%                         
%                         PosTime1 = (StTime1 - SegTime1) .* VelEC;
%                         PosTime2 = (StTime2 - SegTime2) .* VelEC;
%                     
%                         if lap >= 2;
%                             if zone == 1;
% %                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                                 StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                                 StDist2 = DistEndRef + PosTime2;
%                                 
%                             elseif zone == 5;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndStroke;
%                             else;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndRef + PosTime2;
%                             end;
%                         else;
%                             if zone == 5;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndStroke;
%                             else;
%                                 StDist1 = DistIniRef + PosTime1;
%                                 StDist2 = DistEndRef + PosTime2;
%                             end;
%                         end;
%                         
%                         if zone == 5;
%                             SectionSDbis(lap,pos(zone)) = NaN;
%                             SectionNbbis(lap,pos(zone)) = length(IDstroke);
%                         else;
%                             if isempty(IDstrokeOther) == 0;
%                                 if IDstrokeOther == 0;
%                                     SectionSDbis(lap,pos(zone)) = NaN;
%                                 else;
%                                     SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstrokeOther)-1), -2);
%                                 end;
%                                 SectionNbbis(lap,pos(zone)) = length(IDstrokeOther);
%                             else;
%                                 SectionSDbis(lap,pos(zone)) = roundn((StDist2 - StDist1) ./ (length(IDstroke)-1), -2);
%                                 SectionNbbis(lap,pos(zone)) = length(IDstroke);
%                             end;
%                         end;
%                     end;
%                 end;
% 
%             else;
%                 %FS AND BK
%                 if length(liStrokeSecRef) >= 2;
%                     
%                     IDstroke = [];
%                     IDstrokeOther = [];
%                     for stro = 1:length(liStrokeSecRef);
%                         IDstroke = [IDstroke liStrokeSecRef(stro)];
%                     end;
%                     if lap ~= 1;
%                         if zone == 1;
%                             for stro = 1:length(liStrokeSecOther);
%                                 IDstrokeOther = [IDstrokeOther liStrokeSecOther(stro)];
%                             end;
%                             if length(IDstrokeOther) <= 1;
%                                 IDstrokeOther = 0; %error not enough strokes
%                             elseif length(IDstrokeOther) == 2;
% %                                                     indexextra = find(liStrokeLap == IDstrokeOther(end));
%                                 IDstrokeOther = IDstroke;
%                             end;
%                         end;
%                     end;
% 
%                     StTime1 = (IDstroke(1)-listart)./framerate;
%                     StTime2 = (IDstroke(end)-listart)./framerate;
% 
%                     if length(IDstroke) == 2;
%                         StrDuration = abs((StTime2 - StTime1));
%                         SectionSRbis(lap,pos(zone)) = (((length(IDstroke)).*60)./StrDuration)./2;
%                     else;
%                         StrDuration = (StTime2 - StTime1);
%                         SectionSRbis(lap,pos(zone)) = ((length(IDstroke)-1).*60)./StrDuration;
%                     end;
%                     SectionSRbis(lap,pos(zone)) = roundn(SectionSRbis(lap,pos(zone))./2,-1);
%                     
% 
%                     %position at the beginning and end
%                     VelEC = SectionVelbis(lap,pos(zone));
% 
%                     if isempty(IDstrokeOther) == 0;
%                         StTime1Other = (IDstrokeOther(1)-listart)./framerate;
%                         StTime2Other = (IDstrokeOther(end)-listart)./framerate;
% 
%                         StTime1 = (IDstroke(1)-listart)./framerate;
%                         StTime2 = (IDstroke(end)-listart)./framerate;
%                     else;
%                         StTime1 = (IDstroke(1)-listart)./framerate;
%                         StTime2 = (IDstroke(end)-listart)./framerate;
%                     end;
% 
%                     if lap >= 2;
%                         if zone == 1;
% %                                                 SegTime1 = (liIni-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                             SegTime1 = (liIniOther-listart)/framerate; %take the 40m mark (not liIniRef) to extrapolate the position
%                         else;
%                             SegTime1 = (liIniRef-listart)/framerate;
%                         end;
%                     else;
%                         SegTime1 = (liIniRef-listart)/framerate;
%                     end;
%                     SegTime2 = (liEndRef-listart)/framerate;
%                     
%                     PosTime1 = (StTime1 - SegTime1) .* VelEC;
%                     PosTime2 = (StTime2 - SegTime2) .* VelEC;
%                     
%                     if lap >= 2;
%                         if zone == 1;
% %                                                 StDist1 = DistIni + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist1 = DistIniOther + PosTime1; %take the 40m mark (not DistIniRef) to extrapolate the position
%                             StDist2 = DistEndRef + PosTime2;
%                             
%                         elseif zone == 5;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndRef + PosTime2;
%                         end;
%                     else;
%                         if zone == 5;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndStroke;
%                         else;
%                             StDist1 = DistIniRef + PosTime1;
%                             StDist2 = DistEndRef + PosTime2;
%                         end;
%                     end;
% 
%                     if length(IDstroke) == 2;
%                         SectionSDbis(lap,pos(zone)) = roundn((abs((StDist2 - StDist1)) ./ (length(IDstroke))).*4,-2);
%                     else;
%                         SectionSDbis(lap,pos(zone)) = roundn(((StDist2 - StDist1) ./ (length(IDstroke)-1)).*2,-2);
%                     end;
%                     SectionNbbis(lap,pos(zone)) = length(IDstroke);
% 
%                 else;
%                     SectionSRbis(lap,pos(zone)) = NaN;
%                     SectionSDbis(lap,pos(zone)) = NaN;
%                     SectionNbbis(lap,pos(zone)) = length(liStrokeSecRef);
%                 end;
%             end;
%         else;
%             SectionSRbis(lap,pos(zone)) = NaN;
%             SectionSDbis(lap,pos(zone)) = NaN;
%             SectionNbbis(lap,pos(zone)) = NaN;
%         end;
%     end;     
%     DistIni = DistEnd;
% %                         DistIniStroke = DistEndStroke;DistIni = DistEnd;
% end;
% isInterpolatedSDbis = isInterpolatedVelbis;

liSplitIni = SplitsAll(lap,3) + 1;