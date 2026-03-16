% function [dataMatCumSplitsPacing, isInterpolatedSplits, SectionVel, isInterpolatedVel, dataTableBreath] = create_pacingtable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, ...
%     StrokeType, Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
%     isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, NbLap, ...
%     DistanceEC, VelocityEC, TimeEC, Breath_Frames, Stroke_Frame, Stroke_Time, BOAll, data5m, RaceLocation, ...
%     SectionCumTime, SectionSplitTime, SectionVel, SectionCumTimePDF, SectionSplitTimePDF, SectionVelPDF);

function dataTableBreathAll = create_pacingtable_SP1Report_synchroniser(Athletename, Source, framerate, RaceDist, ...
    StrokeType, Course, Meet, Year, Stage, valRelay, detailRelay, SplitsAll, ...
    isInterpolatedVel, isInterpolatedSplits, isInterpolatedSR, isInterpolatedSD, NbLap, ...
    DistanceEC, VelocityEC, TimeEC, Breath_Frames, Stroke_Frame, Stroke_Time, BOAll, data5m, RaceLocation, ...
    SectionCumTime, SectionSplitTime, SectionVel, SectionCumTimePDF, SectionSplitTimePDF, SectionVelPDF);


% dataTablePacing = {};
% dataTablePacing{1,2} = 'Metadata';
% dataTablePacing{8,2} = 'Pacing';
% dataTablePacing{9,1} = 'Splits / Cumul';
% dataTablePacing{9,2} = ' / Speed';
% dataMatSplitsPacing = [];
% dataMatCumSplitsPacing = [];
% 
% dataTablePacing{2,3} = Athletename;
% RaceDist = roundn(RaceDist,0);
% str = [num2str(RaceDist) '-' StrokeType];
% dataTablePacing{3,3} = str;
% str = [Meet '-' num2str(Year)];
% dataTablePacing{4,3} = str;
% if strcmpi(detailRelay, 'None') == 1;
%     str = Stage;
% else;
%     str = [Stage ' - ' detailRelay ' ' valRelay];
% end;
% dataTablePacing{5,3} = str;
% 
% TT = SplitsAll(end,2);
% TTtxt = timeSecToStr(TT);
% dataTablePacing{6,3} = TTtxt;
% 
% if Source == 1;
%     dataTablePacing{7,3} = 'Sparta 1';
% elseif Source == 2;
%     dataTablePacing{7,3} = 'Sparta 2';
% elseif Source == 3;
%     dataTablePacing{7,3} = 'GreenEye';
% end;
% 
% if Source == 1;
%     graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-SP1']};
%     graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(SplitsAll(end,2)) '  -  SP1']};
% elseif Source == 2;
%     graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-SP2']};
%     graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(SplitsAll(end,2)) '  -  SP2']};
% elseif Source == 3;
%     graphTitle = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage '-GE']};
%     graphTitleBis = {Athletename; [Meet Year]; [num2str(RaceDist) 'm-' StrokeType '-' Stage]; [timeSecToStr(SplitsAll(end,2)) '  -  GE']};
% end;
% storeTitle{1} = graphTitle;
% storeTitleBis{1} = graphTitleBis;
% 
% idx = isstrprop(Meet,'upper');
% MeetShort = Meet(idx);
% if strcmpi(Stage, 'Semi-Final');
%     StageShort = 'SF';
% elseif strcmpi(Stage, 'Semi-final');
%     StageShort = 'SF';
% else;
%     StageShort = Stage;
% end;
% YearShort = Year(3:4);
% graphTitle2 = [Athletename ' ' MeetShort YearShort ' ' StageShort];
% storeTitle2{1} = graphTitle2;
% 
% %---------------------------------Pacing-------------------------------
% colorrow(9,:) = [1 0.9 0.70];
% lineEC = 10;
% lineECmat = 1;
% for lap = 1:NbLap;
%     dataTablePacing{lineEC,1} = ['Lap ' num2str(lap)];
% 
%     if Course == 25;
%         dataTablePacing{lineEC+1,2} = '0m-5m';
%         dataTablePacing{lineEC+2,2} = '5m-10m';
%         dataTablePacing{lineEC+3,2} = '10m-15m';
%         dataTablePacing{lineEC+4,2} = '15m-20m';
%         dataTablePacing{lineEC+5,2} = ['20m-Last arm entry'];
%         dataTablePacing{lineEC+6,2} = 'Last 5m';
%         
%         dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
%         dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
%         dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
%         dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
%         dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;
% 
% %             colorrow(lineEC,:) = [1 0.9 0.60];
% %             colorrow(lineEC+1,:) = [0.9 0.9 0.9];
% %             colorrow(lineEC+2,:) = [0.75 0.75 0.75];
% %             colorrow(lineEC+3,:) = [0.9 0.9 0.9];
% %             colorrow(lineEC+4,:) = [0.75 0.75 0.75];
% %             colorrow(lineEC+5,:) = [0.9 0.9 0.9];
% %             colorrow(lineEC+6,:) = [0.75 0.75 0.75];
% 
%         lineEC = lineEC + 7;
%         lineECmat = lineECmat + 5;
%     else;
%         dataTablePacing{lineEC+1,2} = '0m-5m';
%         dataTablePacing{lineEC+2,2} = '5m-10m';
%         dataTablePacing{lineEC+3,2} = '10m-15m';
%         dataTablePacing{lineEC+4,2} = '15m-20m';
%         dataTablePacing{lineEC+5,2} = '20m-25m';
%         dataTablePacing{lineEC+6,2} = '25m-30m';
%         dataTablePacing{lineEC+7,2} = '30m-35m';
%         dataTablePacing{lineEC+8,2} = '35m-40m';
%         dataTablePacing{lineEC+9,2} = '40m-45m';
%         dataTablePacing{lineEC+10,2} = ['45m-Last arm entry'];
%         dataTablePacing{lineEC+11,2} = 'Last 5m';
%         
%         dataMatSplitsPacing(lineECmat, 1) = (Course*(lap-1)) + 5;
%         dataMatSplitsPacing(lineECmat+1, 1) = (Course*(lap-1)) + 10;
%         dataMatSplitsPacing(lineECmat+2, 1) = (Course*(lap-1)) + 15;
%         dataMatSplitsPacing(lineECmat+3, 1) = (Course*(lap-1)) + 20;
%         dataMatSplitsPacing(lineECmat+4, 1) = (Course*(lap-1)) + 25;
%         dataMatSplitsPacing(lineECmat+5, 1) = (Course*(lap-1)) + 30;
%         dataMatSplitsPacing(lineECmat+6, 1) = (Course*(lap-1)) + 35;
%         dataMatSplitsPacing(lineECmat+7, 1) = (Course*(lap-1)) + 40;
%         dataMatSplitsPacing(lineECmat+8, 1) = (Course*(lap-1)) + 45;
%         dataMatSplitsPacing(lineECmat+9, 1) = (Course*(lap-1)) + 50;
% 
% %             colorrow(lineEC,:) = [1 0.9 0.60];
% %             colorrow(lineEC+1,:) = [0.9 0.9 0.9];
% %             colorrow(lineEC+2,:) = [0.75 0.75 0.75];
% %             colorrow(lineEC+3,:) = [0.9 0.9 0.9];
% %             colorrow(lineEC+4,:) = [0.75 0.75 0.75];
% %             colorrow(lineEC+5,:) = [0.9 0.9 0.9];
% %             colorrow(lineEC+6,:) = [0.75 0.75 0.75];
% %             colorrow(lineEC+7,:) = [0.9 0.9 0.9];
% %             colorrow(lineEC+8,:) = [0.75 0.75 0.75];
% %             colorrow(lineEC+9,:) = [0.9 0.9 0.9];
% %             colorrow(lineEC+10,:) = [0.75 0.75 0.75];
% %             colorrow(lineEC+11,:) = [0.9 0.9 0.9];
% 
%         lineEC = lineEC + 12;
%         lineECmat = lineECmat + 10;
%     end;
% end;
% dataMatCumSplitsPacing = dataMatSplitsPacing;
% 
% 
% %calculate values per 5m-sections
% SplitsAll = SplitsAll(2:end,:);
% 
% if Source == 1 | Source == 3;
%     isInterpolatedBO = BOAll(:,4);
%     BOAll = BOAll(:,1:3);
% else;
%     isInterpolatedBO = zeros(NbLap,1);
% end;
% 
% lengthdata = [length(DistanceEC) length(VelocityEC) length(TimeEC)];
% if isempty(find(diff(lengthdata) ~= 0)) == 0;
%     [minVal, minLoc] = min(lengthdata);
%     if minLoc == 1;
%         %Adjust Vel and Time
%         VelocityEC = VelocityEC(1:length(DistanceEC));
%         TimeEC = TimeEC(1:length(DistanceEC));
%     elseif minLoc == 2;
%         %Adjust Dist and Time
%         DistanceEC = DistanceEC(1:length(VelocityEC));
%         TimeEC = TimeEC(1:length(VelocityEC));
%     elseif minLoc == 3;
%         %Adjust Dist and Vel
%         DistanceEC = DistanceEC(1:length(TimeEC));
%         VelocityEC = VelocityEC(1:length(TimeEC));
%     end;
% end;
% 
% if Course == 25;
%     nbzone = 5;
% else;
%     nbzone = 10;
% end;
% if Source == 2;
% 
%     lapLim = Course:Course:RaceDist;
%     lapEC = 1;
%     updateLap = 0;
%     SectionVel = [];
%         
%     dataZone = [];
%     totZone = NbLap.*(Course./5);
%     distIni = 0;
%     jumDist = 5;
%     for zEC = 1:totZone;
%         dataZone(zEC,:) = [distIni distIni+5];
%         distIni = distIni + 5;
%     end;
%     zoneVel = 1;
% 
%     for zoneEC = 1:totZone;
% 
%         zone_dist_ini = dataZone(zoneEC,1);
%         zone_dist_end = dataZone(zoneEC,2);
% 
%         indexLap = find(lapLim == zone_dist_end);
%         if isempty(indexLap) == 0;
%             %Last zone for a lap, remove 2m
%             zone_dist_end = zone_dist_end-2;
%             updateLap = 1;
%         end;
% 
%         if BOAll(lapEC,3) > zone_dist_end;
%             %BO happened in the following zone
%             VelEC = NaN;
% 
%         elseif BOAll(lapEC,3) <= zone_dist_end & BOAll(lapEC,3) > zone_dist_ini;
%             %BO happened in this zone
%             distBO2End = zone_dist_end-BOAll(lapEC,3);
%             if distBO2End <= 2;
%                 %Less than 2m to end of zone
%                 VelEC = NaN;
% 
%             else;
%                 %more than 2m to calculate the speed
%                 zone_dist_ini = BOAll(lapEC,3);
%                 zone_time_ini = BOAll(lapEC,2);
% 
%                 [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
%                 zone_time_end = TimeEC(minLoc(1));
% 
%                 VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
%             end;
%         else;
%             %BO happened before
%             [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
%             zone_time_ini = TimeEC(minLoc(1));
% 
%             [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
%             zone_time_end = TimeEC(minLoc(1));
%             VelEC = (zone_dist_end-zone_dist_ini)./(zone_time_end-zone_time_ini);
%         end;
%         SectionVel(lapEC,zoneVel) = VelEC;
%         zoneVel = zoneVel + 1;
% 
%         if updateLap == 1;
%             updateLap = 0;
%             lapEC = lapEC + 1;
%             zoneVel = 1;
%         end;
%     end;
% 
%     for lap = 1:NbLap;
%         liSplitEnd = SplitsAll(lap,3);
%         liStrokeLap = Stroke_Frame(lap,:);
%         liInterest = find(liStrokeLap ~= 0);
%         liStrokeLap = liStrokeLap(liInterest);
%         
%         keydist = (lap-1).*Course;
%         DistIni = keydist;
%         
%         for zone = 1:nbzone;
%             DistEnd = DistIni + 5;
%             diffIni = abs(DistanceEC - DistIni);
%             [~, liIni] = min(diffIni);
%             if zone == nbzone;
%                 linan = find(isnan(DistanceEC(liIni:liSplitEnd)) == 0);
%                 linan = linan + liIni - 1;
%                 liEnd = linan(end);
%             else;
%                 diffEnd = abs(DistanceEC - DistEnd);
%                 [~, liEnd] = min(diffEnd);
%             end;
% 
%             if BOAll(lap,1) >= liEnd;
%                 SectionSplitTime(lap,zone) = NaN;
%                 SectionCumTime(lap,zone) = NaN;
%             else;
%                 if BOAll(lap,1) > liIni;
%                     liIni = BOAll(lap,1) + 1;
%                 end;
%                 
%                 interest = VelocityEC(liIni:liEnd);
%                 linonnan = find(isnan(interest) == 0);
%                 interest = interest(linonnan);
%                 SectionSplitTime(lap,zone) = TimeEC(liEnd) - TimeEC(liIni);
%                 SectionCumTime(lap,zone) = TimeEC(liEnd) - TimeEC(1);
%             end;     
%             DistIni = DistEnd;
%         end;
%         liSplitIni = SplitsAll(lap,3) + 1;
%     end;
% 
%     for lap = 1:NbLap
%         index = find(SectionVel(lap,:) == 0);
%         SectionVel(lap,index) = NaN;
% 
%         index = find(SectionCumTime(lap,:) == 0);
%         SectionCumTime(lap,index) = NaN;
% 
%         index = find(SectionSplitTime(lap,:) == 0);
%         SectionSplitTime(lap,index) = NaN;
%     end;
% 
%     SectionVelbis = SectionVel;
%     SectionCumTimebis = SectionCumTime;
%     SectionSplitTimebis = SectionSplitTime;
% 
% else;
%     
%     %load the Section data
% %         eval(['SectionSR = handles.RacesDB.' UID '.SectionSR;']);
% %         eval(['SectionSD = handles.RacesDB.' UID '.SectionSD;']);
% %         eval(['SectionNb = handles.RacesDB.' UID '.SectionNb;']);
% 
%     %fill the gap to get 5m segment
%     for lap = 1:NbLap
%         index = find(SectionVel(lap,:) == 0);
%         SectionVel(lap,index) = NaN;
% 
%         index = find(SectionCumTime(lap,:) == 0);
%         SectionCumTime(lap,index) = NaN;
% 
%         index = find(SectionSplitTime(lap,:) == 0);
%         SectionSplitTime(lap,index) = NaN;
%     end;
%     SectionVelbis = SectionVel;
%     SectionCumTimebis = SectionCumTime;
%     SectionSplitTimebis = SectionSplitTime;
% end;
% 
% SectionVel = roundn(SectionVel,-2);
% SectionCumTime = roundn(SectionCumTime,-2);
% SectionSplitTime = roundn(SectionSplitTime,-2);
% SectionVelbis = roundn(SectionVelbis,-2);
% SectionCumTimebis = roundn(SectionCumTimebis,-2);
% SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
% 
% lineEC = 11;
% for lap = 1:NbLap;
%     countInterpVel = 0;
%     countInterpSplit = 0;
%     DistZoneEC = 5 + ((lap-1)*Course);
%     BODistLap = BOAll(lap,3);
% 
%     addline = 0;
%     for zoneEC = 1:4;
%         AddInterpolationtxt = '';
%         if (SectionVel(lap,zoneEC)) == 0;
%             VELtxt = [];
%         else;
%             if isnan((SectionVel(lap,zoneEC))) == 1;
%                 if BODistLap > DistZoneEC;
%                     VELtxt = '  -  ';
%                 elseif BODistLap+2 > DistZoneEC
%                     VELtxt = '  -  ';
%                 else;
%                     index = find(isnan(SectionVel(lap,:)) == 0);
%                     if isempty(index) == 1;
%                         VELtxt = '  -  ';
%                     else;
%                         indexFirst = find(index >= zoneEC);
%                         indexRef = index(indexFirst(1));    
%                         refVel = SectionVel(lap,indexRef);
%                         SectionVel(lap,zoneEC) = refVel;
%                         isInterpolatedVel(lap,zoneEC) = 1;
%                         VELtxt = [dataToStr(refVel,2) ' m/s !'];
%                         countInterpVel = countInterpVel + 1;
%                     end;
%                 end;
%             else;
%                 if BODistLap > DistZoneEC;
%                     VELtxt = '  -  ';
%                 elseif BODistLap+2 > DistZoneEC
%                     VELtxt = '  -  ';
%                 else;
%                     if Source == 1 | Source == 3;
%                         if isInterpolatedSplits(lap,zoneEC) == 1;
%                             VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s !'];
%                         else;
%                             VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s'];
%                         end;
%                     else;
%                         VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s'];
%                     end;
%                     countInterpVel = 0;
%                 end;
%             end;
%         end;
% 
%         if (SectionSplitTime(lap,zoneEC)) == 0;
%             CTtxt = '  -  ';
%             STtxt = '  -  ';
%         else;
%             if isnan((SectionSplitTime(lap,zoneEC))) == 1;
%                 if BODistLap > DistZoneEC;
%                     CTtxt = '  -  ';
%                     STtxt = '  -  ';
%                 else;
%                     index = find(isnan(SectionSplitTime(lap,:)) == 0);
%                     if isempty(index) == 1;
%                         CTtxt = '  -  ';
%                         STtxt = '  -  ';
%                     else;
%                         indexFirst = find(index >= zoneEC);
%                         indexRef = index(indexFirst(1));
%                         if indexFirst(1) == 1;
%                             indexRefPrev = 0;
%                         else;
%                             indexRefPrev = index(indexFirst(1)-1);
%                         end;
%                         jumpZones = indexRef - indexRefPrev;
% 
%                         refSplit = SectionSplitTime(lap,indexRef)./jumpZones;
%                         refSplit = roundn(refSplit,-2);
%                         refSplitCum = SectionCumTime(lap,indexRef) - refSplit;
%                         SectionSplitTime(lap,zoneEC) = refSplit;
%                         SectionCumTime(lap,zoneEC) = refSplitCum;
%                         isInterpolatedSplits(lap,zoneEC) = 1;
% 
%                         CTtxt = timeSecToStr(refSplitCum);
%                         STtxt = timeSecToStr(refSplit);
%                         countInterpSplit = countInterpSplit + 1;
%                     end;
%                 end;
%             else;
%                 if BODistLap > DistZoneEC;
%                     CTtxt = '  -  ';
%                     STtxt = '  -  ';
%                 else;
%                     CTtxt = timeSecToStr(SectionCumTime(lap,zoneEC));
%                     refSplit = SectionSplitTime(lap,zoneEC)./(countInterpSplit+1);
%                     refSplit = roundn(refSplit,-2);
%                     if lap == 1
%                         addlaptime = 0;
%                     else;
%                         addlaptime = SplitsAll(lap-1,2);
%                     end;
% 
%                     if refSplit+addlaptime == SectionCumTime(lap,zoneEC);
%                         %case: for SP1 and GE on the BO segment
%                         %Check if BO is known to recalculate it
%                         BOTime = BOAll(lap,2);
%                         refSplit = SectionCumTime(lap,zoneEC) - BOTime;
%                         SectionSplitTime(lap,zoneEC) = refSplit;
%                         STtxt = timeSecToStr(refSplit);
%                         if isInterpolatedBO(lap,1) == 1;
%                             AddInterpolationtxt = [' !'];
%                         else;
%                             AddInterpolationtxt = '';
%                         end;
%                     else;
%                         STtxt = timeSecToStr(refSplit);
%                         SectionSplitTime(lap,zoneEC) = refSplit;
%                     end;
%                     countInterpSplit = 0;
%                 end;
%             end;
%         end;
%         if isempty(findstr(VELtxt, '!')) == 1 & isempty(findstr(AddInterpolationtxt, '!')) == 0;
%             data = [STtxt '  /  ' CTtxt '  /  ' VELtxt AddInterpolationtxt];
%         else;
%             data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
%         end;
% 
%         eval(['dataTablePacing{' num2str(lineEC+addline) ',3} = data;']);
%         DistZoneEC = DistZoneEC + 5;
%         addline = addline + 1;
%     end;
% 
% 
%     if Course == 50;
%         for zoneEC = 5:9;
%             AddInterpolationtxt = '';
%             if (SectionVel(lap,zoneEC)) == 0;
%                 VELtxt = [];
%             else;
%                 if isnan((SectionVel(lap,zoneEC))) == 1;
%                     if BODistLap > DistZoneEC;
%                         VELtxt = '  -  ';
%                     elseif BODistLap+2 > DistZoneEC
%                         VELtxt = '  -  ';
%                     else;
%                         index = find(isnan(SectionVel(lap,:)) == 0);
%                         if isempty(index) == 1;
%                             VELtxt = '  -  ';
%                         else;
%                             indexFirst = find(index >= zoneEC);
%                             indexRef = index(indexFirst(1));    
%                             refVel = SectionVel(lap,indexRef);
%                             SectionVel(lap,zoneEC) = refVel;
%                             isInterpolatedVel(lap,zoneEC) = 1;
%                             VELtxt = [dataToStr(refVel,2) ' m/s !'];
%                             countInterpVel = countInterpVel + 1;
%                         end;
%                     end;
%                 else;
%                     if BODistLap > DistZoneEC;
%                         VELtxt = '  -  ';
%                     elseif BODistLap+2 > DistZoneEC
%                         VELtxt = '  -  ';
%                     else;
%                         if Source == 1 | Source == 3;
%                             if isInterpolatedSplits(lap,zoneEC) == 1;
%                                 VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s !'];
%                             else;
%                                 VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s'];
%                             end;
%                         else;
%                             VELtxt = [dataToStr(SectionVel(lap,zoneEC),2) ' m/s'];
%                         end;
%                         countInterpVel = 0;
%                     end;
%                 end;
%             end;
% 
%             if (SectionSplitTime(lap,zoneEC)) == 0;
%                 CTtxt = '  -  ';
%                 STtxt = '  -  ';
%             else;
%                 if isnan((SectionSplitTime(lap,zoneEC))) == 1;
%                     if BODistLap >= DistZoneEC;
%                         CTtxt = '  -  ';
%                         STtxt = '  -  ';
%                     else;
%                         index = find(isnan(SectionSplitTime(lap,:)) == 0);
%                         if isempty(index) == 1;
%                             CTtxt = '  -  ';
%                             STtxt = '  -  ';
%                         else;
%                             indexFirst = find(index >= zoneEC);
%                             indexRef = index(indexFirst(1));
%                             if indexFirst(1) == 1;
%                                 indexRefPrev = 0;
%                             else;
%                                 indexRefPrev = index(indexFirst(1)-1);
%                             end;
%                             jumpZones = indexRef - indexRefPrev;
% 
%                             refSplit = SectionSplitTime(lap,indexRef)./jumpZones;
%                             refSplit = roundn(refSplit,-2);
%                             refSplitCum = SectionCumTime(lap,indexRef) - refSplit;
%                             SectionSplitTime(lap,zoneEC) = refSplit;
%                             SectionCumTime(lap,zoneEC) = refSplitCum;
%                             isInterpolatedSplits(lap,zoneEC) = 1;
%     
%                             CTtxt = timeSecToStr(refSplitCum);
%                             STtxt = timeSecToStr(refSplit);
%                             countInterpSplit = countInterpSplit + 1;
%                         end;
%                     end;
%                 else;
%                     if BODistLap > DistZoneEC;
%                         CTtxt = '  -  ';
%                         STtxt = '  -  ';
%                     else;
%                         CTtxt = timeSecToStr(SectionCumTime(lap,zoneEC));
%                         refSplit = SectionSplitTime(lap,zoneEC)./(countInterpSplit+1);
%                         refSplit = roundn(refSplit,-2);
%                         if lap == 1
%                             addlaptime = 0;
%                         else;
%                             addlaptime = SplitsAll(lap-1,2);
%                         end;
% 
%                         if refSplit+addlaptime == SectionCumTime(lap,zoneEC);
%                             %case: for SP1 and GE on the BO segment
%                             %Check if BO is known to recalculate it
%                             BOTime = BOAll(lap,2);
%                             refSplit = SectionCumTime(lap,zoneEC) - BOTime;
%                             SectionSplitTime(lap,zoneEC) = refSplit;
%                             STtxt = timeSecToStr(refSplit);
%                             if isInterpolatedBO(lap,1) == 1;
%                                 AddInterpolationtxt = [' !'];
%                             else;
%                                 AddInterpolationtxt = '';
%                             end;
%                         else;
%                             STtxt = timeSecToStr(refSplit);
%                             SectionSplitTime(lap,zoneEC) = refSplit;
%                         end;
%                         countInterpSplit = 0;
%                     end;
%                 end;
%             end;
%             if isempty(findstr(VELtxt, '!')) == 1 & isempty(findstr(AddInterpolationtxt, '!')) == 0;
%                 data = [STtxt '  /  ' CTtxt '  /  ' VELtxt AddInterpolationtxt];
%             else;
%                 data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
%             end;
%             eval(['dataTablePacing{' num2str(lineEC+addline) ',3} = data;']);
%             DistZoneEC = DistZoneEC + 5;
%             addline = addline + 1;
%         end;
% 
%         zoneEC = 10; %45-last arm entry 
%         AddInterpolationtxt = '';
%         if Source == 1 | Source == 3; %nothing
%             data = ['  -    /    -    /    -  '];
%             eval(['dataTablePacing{' num2str(lineEC+addline) ',3} = data;']);
%             DistZoneEC = DistZoneEC + 5;
%             addline = addline + 1;
%         else;
%             if (SectionVel(lap,10)) == 0;
%                 data = ['  -    /    -    /    -  '];
%             else;
%                 VELtxt = dataToStr(SectionVel(lap,10),2);
%                 CTtxt = timeSecToStr(SectionCumTime(lap,9)+SectionSplitTime(lap,10));
%                 STtxt = timeSecToStr(SectionSplitTime(lap,10));
%                 data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
%             end;
%             eval(['dataTablePacing{' num2str(lineEC+addline) ',3} = data;']);
%             DistZoneEC = DistZoneEC + 5;
%             addline = addline + 1;
%         end;
% 
%         %Last 5m
%         AddInterpolationtxt = '';
%         if Source == 3;
%             AddInterpolationtxt = ' !';
%         end;
%         dataCheck = SplitsAll(lap,2) - (SectionCumTime(lap,9) + data5m);
%         if dataCheck ~= 0;
%             data5m = data5m+dataCheck;
%         end;
%         STtxt = timeSecToStr(data5m);
%         CTtxt = timeSecToStr(SplitsAll(lap,2));
%         SectionSplitTime(lap,zoneEC) = data5m;
% 
%         if Source == 2;
%             VELtxt = [dataToStr(SectionVel(lap,10),2) ' m/s'];
%         else;
%             VELtxt = '  -  ';
%         end;
%         if isempty(findstr(VELtxt, '!')) == 1 & isempty(findstr(AddInterpolationtxt, '!')) == 0;
%             data = [STtxt '  /  ' CTtxt '  /  ' VELtxt AddInterpolationtxt];
%         else;
%             data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
%         end;
%         eval(['dataTablePacing{' num2str(lineEC+addline) ',3} = data;']);
%         lineEC = lineEC + addline + 2;
% 
%     else;
%         
%         zoneEC = 5; %45-last arm entry 
%         AddInterpolationtxt = '';
%         if Source == 1 | Source == 3; %nothing
%             data = ['  -    /    -    /    -  '];
%             eval(['dataTablePacing{' num2str(lineEC+addline) ',3} = data;']);
%             DistZoneEC = DistZoneEC + 5;
%             addline = addline + 1;
%         else;
%             if (SectionVel(lap,5)) == 0;
%                 data = ['  -    /    -    /    -  '];
%             else;
%                 VELtxt = dataToStr(SectionVel(lap,5),2);
%                 CTtxt = timeSecToStr(SectionCumTime(lap,4)+SectionSplitTime(lap,5));
%                 STtxt = timeSecToStr(SectionSplitTime(lap,5));
%                 data = [STtxt '  /  ' CTtxt '  /  ' VELtxt ' m/s'];
%             end;
%             eval(['dataTablePacing{' num2str(lineEC+addline) ',3} = data;']);
%             DistZoneEC = DistZoneEC + 5;
%             addline = addline + 1;
%         end;
% 
%         %Last 5m
%         AddInterpolationtxt = '';
%         if Source == 3;
%             AddInterpolationtxt = ' !';
%         end;
%         dataCheck = SplitsAll(lap,2) - (SectionCumTime(lap,4) + data5m);
%         if dataCheck ~= 0;
%             data5m = SplitsAll(lap,2) - SectionCumTime(lap,4);
%         end;
%         STtxt = timeSecToStr(data5m);
%         CTtxt = timeSecToStr(SplitsAll(lap,2));
%         SectionSplitTime(lap,zoneEC) = data5m;
% 
%         if Source == 2;
%             VELtxt = [dataToStr(SectionVel(lap,5),2) ' m/s'];
%         else;
%             VELtxt = '  -  ';
%         end;
%         if isempty(findstr(VELtxt, '!')) == 1 & isempty(findstr(AddInterpolationtxt, '!')) == 0;
%             data = [STtxt '  /  ' CTtxt '  /  ' VELtxt AddInterpolationtxt];
%         else;
%             data = [STtxt '  /  ' CTtxt '  /  ' VELtxt];
%         end;
%         eval(['dataTablePacing{' num2str(lineEC+addline) ',3} = data;']);
%         lineEC = lineEC + addline + 2;
% 
%     end;
% end;
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SectionCumTimeMat = SectionCumTime;
% SectionCumTimeMat(:,end) = SplitsAll(:,2);
% SectionSplitTimeMat = SectionSplitTime;
% SectionSplitTimeMat(:,end) = SectionCumTimeMat(:,end) - SectionCumTimeMat(:,end-1);
% 
% dataMatSplitsPacing(:,2) = reshape(SectionSplitTimeMat', nbzone*NbLap, 1);
% dataMatCumSplitsPacing(:,2) = reshape(SectionCumTimeMat', nbzone*NbLap, 1);
% 
% dataMatSplitsPacingbis = [];
% dataMatCumSplitsPacingbis = [];
% if isempty(SectionVelbis) == 0;
%     SectionVelbis = roundn(SectionVelbis,-2);
%     SectionCumTimebis = roundn(SectionCumTimebis,-2);
%     SectionSplitTimebis = roundn(SectionSplitTimebis,-2);
%     
%     SectionCumTimeMatbis = SectionCumTimebis;
%     SectionCumTimeMatbis(:,end) = SplitsAll(:,2);
%     SectionSplitTimeMatbis = SectionSplitTimebis;
%     SectionSplitTimeMatbis(:,end) = SectionCumTimeMatbis(:,end) - SectionCumTimeMatbis(:,end-1);
% 
%     dataMatSplitsPacingbis(:,2) = reshape(SectionSplitTimeMatbis', nbzone*NbLap, 1);
%     dataMatCumSplitsPacingbis(:,2) = reshape(SectionCumTimeMatbis', nbzone*NbLap, 1);
%     dataMatCumSplitsPacingbis(:,1) = dataMatCumSplitsPacing(:,1);
% end;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%---Breath Table
lapLim = Course:Course:RaceDist;

for intervalEC = 1:3;
    dataTableBreath = [];
    dataZone = [];

    if intervalEC == 1;
        %Apply short distance races intervals to all races
        if Course == 25;
            if RaceDist == 50;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
        
            elseif RaceDist == 100;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-20m';
                dataTableAverage{3,1} = '20-25m';
                dataTableAverage{4,1} = '25-35m';
                dataTableAverage{5,1} = '35-45m';
                dataTableAverage{6,1} = '45-50m';
                dataTableAverage{7,1} = '50-60m';
                dataTableAverage{8,1} = '60-70m';
                dataTableAverage{9,1} = '70-75m';
                dataTableAverage{10,1} = '75-85m';
                dataTableAverage{11,1} = '85-95m';
                dataTableAverage{12,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 20];
                dataZone(3,:) = [20 25];
                dataZone(4,:) = [25 35];
                dataZone(5,:) = [35 45];
                dataZone(6,:) = [45 50];
                dataZone(7,:) = [50 60];
                dataZone(8,:) = [60 70];
                dataZone(9,:) = [70 75];
                dataZone(10,:) = [75 85];
                dataZone(11,:) = [85 95];
                dataZone(12,:) = [95 100];
        
            elseif RaceDist >= 150;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-20m';
                dataTableAverage{3,1} = '20-25m';
                dataTableAverage{4,1} = '25-35m';
                dataTableAverage{5,1} = '35-45m';
                dataTableAverage{6,1} = '45-50m';
                dataTableAverage{7,1} = '50-60m';
                dataTableAverage{8,1} = '60-70m';
                dataTableAverage{9,1} = '70-75m';
                dataTableAverage{10,1} = '75-85m';
                dataTableAverage{11,1} = '85-95m';
                dataTableAverage{12,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 20];
                dataZone(3,:) = [20 25];
                dataZone(4,:) = [25 35];
                dataZone(5,:) = [35 45];
                dataZone(6,:) = [45 50];
                dataZone(7,:) = [50 60];
                dataZone(8,:) = [60 70];
                dataZone(9,:) = [70 75];
                dataZone(10,:) = [75 85];
                dataZone(11,:) = [85 95];
                dataZone(12,:) = [95 100];

                extraLap = (RaceDist/Course) - 4;
                locRow = length(dataZone(:,1));
                for lapEC = 1:extraLap;
                    row1 = [dataZone(end,2) dataZone(end,2)+10];
                    row2 = [dataZone(end,2)+10 dataZone(end,2)+20];
                    row3 = [dataZone(end,2)+20 dataZone(end,2)+25];
                    
                    eval(['dataTableAverage{' num2str(locRow+1) ',1} = ' '''' num2str(row1(1,1)) '-' num2str(row1(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+2) ',1} = ' '''' num2str(row2(1,1)) '-' num2str(row2(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+3) ',1} = ' '''' num2str(row3(1,1)) '-' num2str(row3(1,2)) 'm' '''' ';']);
                    dataZone(locRow+1,:) = row1;
                    dataZone(locRow+2,:) = row2;
                    dataZone(locRow+3,:) = row3;

                    locRow = length(dataZone(:,1));
                end;
            end;
        elseif Course == 50;
            if RaceDist == 50;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
        
            elseif RaceDist == 100;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
                dataTableAverage{6,1} = '50-65m';
                dataTableAverage{7,1} = '65-75m';
                dataTableAverage{8,1} = '75-85m';
                dataTableAverage{9,1} = '85-95m';
                dataTableAverage{10,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
                dataZone(6,:) = [50 65];
                dataZone(7,:) = [65 75];
                dataZone(8,:) = [75 85];
                dataZone(9,:) = [85 95];
                dataZone(10,:) = [95 100];
        
            elseif RaceDist >= 150;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
                dataTableAverage{6,1} = '50-65m';
                dataTableAverage{7,1} = '65-75m';
                dataTableAverage{8,1} = '75-85m';
                dataTableAverage{9,1} = '85-95m';
                dataTableAverage{10,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
                dataZone(6,:) = [50 65];
                dataZone(7,:) = [65 75];
                dataZone(8,:) = [75 85];
                dataZone(9,:) = [85 95];
                dataZone(10,:) = [95 100];

                extraLap = (RaceDist/Course) - 2;
                locRow = length(dataZone(:,1));
                for lapEC = 1:extraLap;
                    row1 = [dataZone(end,2) dataZone(end,2)+15];
                    row2 = [dataZone(end,2)+15 dataZone(end,2)+25];
                    row3 = [dataZone(end,2)+25 dataZone(end,2)+35];
                    row4 = [dataZone(end,2)+35 dataZone(end,2)+45];
                    row5 = [dataZone(end,2)+45 dataZone(end,2)+50];
                    
                    eval(['dataTableAverage{' num2str(locRow+1) ',1} = ' '''' num2str(row1(1,1)) '-' num2str(row1(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+2) ',1} = ' '''' num2str(row2(1,1)) '-' num2str(row2(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+3) ',1} = ' '''' num2str(row3(1,1)) '-' num2str(row3(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+4) ',1} = ' '''' num2str(row4(1,1)) '-' num2str(row4(1,2)) 'm' '''' ';']);
                    eval(['dataTableAverage{' num2str(locRow+5) ',1} = ' '''' num2str(row5(1,1)) '-' num2str(row5(1,2)) 'm' '''' ';']);
                    dataZone(locRow+1,:) = row1;
                    dataZone(locRow+2,:) = row2;
                    dataZone(locRow+3,:) = row3;
                    dataZone(locRow+4,:) = row4;
                    dataZone(locRow+5,:) = row5;

                    locRow = length(dataZone(:,1));
                end;
            end;
        end;

    elseif intervalEC == 2;
        %Apply normal intervals to all races
        if Course == 25;
            if RaceDist == 50;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
        
            elseif RaceDist == 100;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-20m';
                dataTableAverage{3,1} = '20-25m';
                dataTableAverage{4,1} = '25-35m';
                dataTableAverage{5,1} = '35-45m';
                dataTableAverage{6,1} = '45-50m';
                dataTableAverage{7,1} = '50-60m';
                dataTableAverage{8,1} = '60-70m';
                dataTableAverage{9,1} = '70-75m';
                dataTableAverage{10,1} = '75-85m';
                dataTableAverage{11,1} = '85-95m';
                dataTableAverage{12,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 20];
                dataZone(3,:) = [20 25];
                dataZone(4,:) = [25 35];
                dataZone(5,:) = [35 45];
                dataZone(6,:) = [45 50];
                dataZone(7,:) = [50 60];
                dataZone(8,:) = [60 70];
                dataZone(9,:) = [70 75];
                dataZone(10,:) = [75 85];
                dataZone(11,:) = [85 95];
                dataZone(12,:) = [95 100];
        
            elseif RaceDist >= 150;
                keyDistEC = 25:25:RaceDist;
                for distEC = 1:length(keyDistEC);
                    if distEC == 1;
                        eval(['dataTableAverage{distEC,1} = ' '''' '0-' num2str(keyDistEC(distEC)) 'm' '''' ';']);
                        dataZone(distEC,:) = [0 keyDistEC(distEC)];
                    else;
                        eval(['dataTableAverage{distEC,1} = ' '''' num2str(keyDistEC(distEC-1)) '-' num2str(keyDistEC(distEC)) 'm' '''' ';']);
                        dataZone(distEC,:) = [keyDistEC(distEC-1) keyDistEC(distEC)];
                    end;
                end;
            end;
        elseif Course == 50;
            if RaceDist == 50;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
        
            elseif RaceDist == 100;
                dataTableAverage{1,1} = '0-15m';
                dataTableAverage{2,1} = '15-25m';
                dataTableAverage{3,1} = '25-35m';
                dataTableAverage{4,1} = '35-45m';
                dataTableAverage{5,1} = '45-50m';
                dataTableAverage{6,1} = '50-65m';
                dataTableAverage{7,1} = '65-75m';
                dataTableAverage{8,1} = '75-85m';
                dataTableAverage{9,1} = '85-95m';
                dataTableAverage{10,1} = '95-100m';
        
                dataZone(1,:) = [0 15];
                dataZone(2,:) = [15 25];
                dataZone(3,:) = [25 35];
                dataZone(4,:) = [35 45];
                dataZone(5,:) = [45 50];
                dataZone(6,:) = [50 65];
                dataZone(7,:) = [65 75];
                dataZone(8,:) = [75 85];
                dataZone(9,:) = [85 95];
                dataZone(10,:) = [95 100];
        
            elseif RaceDist >= 150;
                keyDistEC = 25:25:RaceDist;
                for distEC = 1:length(keyDistEC);
                    if distEC == 1;
                        eval(['dataTableAverage{distEC,1} = ' '''' '0-' num2str(keyDistEC(distEC)) 'm' '''' ';']);
                        dataZone(distEC,:) = [0 keyDistEC(distEC)];
                    else;
                        eval(['dataTableAverage{distEC,1} = ' '''' num2str(keyDistEC(distEC-1)) '-' num2str(keyDistEC(distEC)) 'm' '''' ';']);
                        dataZone(distEC,:) = [keyDistEC(distEC-1) keyDistEC(distEC)];
                    end;
                end;
            end;
        end;

    elseif intervalEC == 3;
        %Apply 5m intervals to all races
        nbZonesTot = (RaceDist./Course) .* (Course./5);
        for zoneEC = 1:nbZonesTot;
            dataZone(zoneEC,:) = [(zoneEC.*5)-5 zoneEC.*5];
            eval(['dataTableAverage{zoneEC,1} = ' '''' num2str(dataZone(zoneEC,1)) '-' num2str(dataZone(zoneEC,2)) 'm' '''' ';']);
        end;
    end;
    nbZones = length(dataZone(:,1));
    

    lapEC = 1;
    for zoneEC = 1:nbZones;
        if zoneEC == 1;
            zone_time_ini = 0;            
            zone_frame_ini = 1;
    
            zone_dist_end = dataZone(zoneEC,2);
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
            zone_frame_end = minLoc(1);
        else;
            zone_dist_ini = dataZone(zoneEC-1,2);
            [minVal, minLoc] = min(abs(DistanceEC-zone_dist_ini));
            zone_frame_ini = minLoc(1);
    
    %             indexLap = find(lapLim == zone_dist_end);
    %             if isempty(indexLap) == 0;
    %                 zone_frame_end = SplitsAll(indexLap,3);
    %             else;
                zone_dist_end = dataZone(zoneEC,2);
                [minVal, minLoc] = min(abs(DistanceEC-zone_dist_end));
                zone_frame_end = minLoc(1);
    %             end;
        end;
        if zoneEC == nbZones;
            indexBreath = find(Breath_Frames(lapEC,:) >= zone_frame_ini & Breath_Frames(lapEC,:) <= zone_frame_end);
        else;
            indexBreath = find(Breath_Frames(lapEC,:) >= zone_frame_ini & Breath_Frames(lapEC,:) < zone_frame_end);
        end;
        dataTableBreath = [dataTableBreath; length(indexBreath)];
    
        indexLap = find(lapLim == zone_dist_end);
    
        if isempty(indexLap) == 0;
            %Last zone for a lap
            lapEC = lapEC + 1;
        end;
    end;

    if intervalEC == 1;
        dataTableBreath1 = dataTableBreath;
        dataZone1 = dataZone;
    elseif intervalEC == 2;
        dataTableBreath2 = dataTableBreath;
        dataZone2 = dataZone;
    elseif intervalEC == 3;
        dataTableBreath3 = dataTableBreath;
        dataZone3 = dataZone;
    end;

end;

dataTableBreathAll = dataTableBreath3;
for rowEC = 1:length(dataTableBreath1(:,1));
    valDistEC = dataZone1(rowEC,2);
    indexDist = find(dataZone3(:,2) == valDistEC);
    dataTableBreathAll(indexDist,2) = dataTableBreath1(rowEC,1);  %---Breath per short dist standard
end;
for rowEC = 1:length(dataTableBreath2(:,1));
    valDistEC = dataZone2(rowEC,2);
    indexDist = find(dataZone3(:,2) == valDistEC);
    dataTableBreathAll(indexDist,3) = dataTableBreath2(rowEC,1);  %---Breath per 200m dist standard
end;

