FigPos = [50 50 1280 720];
Fig = figure('position', FigPos, 'units', 'pixels', 'color', [0 0 0], 'Visible', 'off', ...
    'MenuBar', 'none', 'NumberTitle', 'off');
set(Fig, 'Name', 'FullScreen Display: Pacing color-graph');

GraphPos = [130./FigPos(3), 50./FigPos(4), 1130./FigPos(3), 570./FigPos(4)];
axessplits_analyser = axes('parent', Fig, 'units', 'normalized', 'Position', GraphPos, 'Visible', 'on');
set(axessplits_analyser, 'units', 'Normalized');

% handles.CurrentvalueRaceLapPacing = get(handles.popupRaceLap_analyser, 'value');
% handles.CurrentvalueDistSplitsPacing = get(handles.popupDistrance_analyser, 'value');
% handles.CurrentSplitsTimePacing = get(handles.splitsTime_check_analyser, 'Value');
% handles.CurrentSplitsPercentagePacing = get(handles.splitsPercentage_check_analyser, 'Value');
% handles.CurrentSplitsOffPacing = get(handles.splitsOff_check_analyser, 'Value');
% handles.CurrentvalueSplitsPacing = get(handles.showsplits_check_analyser, 'Value');

dataMatCumSplitsPacingFullRace = dataMatCumSplitsPacing;
dataMatSplitsPacingFullRace = dataMatSplitsPacing;

RaceDist = str2num(RaceDistList{1});
Course = CourseList{1};
NbLap = RaceDist./Course;

% if isempty(handles.CurrentvalueDistSplitsPacing) == 1;
%     if RaceDist <= 100;
%         handles.CurrentvalueDistSplitsPacing = 1; %5m
%         DistSplits = 5;
%     elseif RaceDist > 100 & RaceDist < 400;
%         handles.CurrentvalueDistSplitsPacing = 1; %10m
%         DistSplits = 10;
%     elseif RaceDist >= 400 & RaceDist <= 800;
%         handles.CurrentvalueDistSplitsPacing = 1; %25m
%         DistSplits = 25;
%     elseif RaceDist > 800;
%         handles.CurrentvalueDistSplitsPacing = 1; %50m
%         DistSplits = 50;
%     end;
% else;
    %full race only
%     if handles.CurrentvalueRaceLapPacing == 1;
        %full race
        if RaceDist == 50;
            %5m only
%             if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 5;
%             elseif handles.CurrentvalueDistSplitsPacing == 2;
%                 DistSplits = 10;
%             elseif handles.CurrentvalueDistSplitsPacing == 3;
%                 DistSplits = 25;
%             end;
        elseif RaceDist == 100;
%             if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 5;
%             elseif handles.CurrentvalueDistSplitsPacing == 2;
%                 DistSplits = 10;
%             elseif handles.CurrentvalueDistSplitsPacing == 3;
%                 DistSplits = 25;
%             elseif handles.CurrentvalueDistSplitsPacing == 4;
%                 DistSplits = 50;
%             end;
        elseif RaceDist == 200;
%             if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 10;
%             elseif handles.CurrentvalueDistSplitsPacing == 2;
%                 DistSplits = 25;
%             elseif handles.CurrentvalueDistSplitsPacing == 3;
%                 DistSplits = 50;
%             elseif handles.CurrentvalueDistSplitsPacing == 4;
%                 DistSplits = 100;
%             end;
        elseif RaceDist == 400;
%             if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 25;
%             elseif handles.CurrentvalueDistSplitsPacing == 2;
%                 DistSplits = 50;
%             elseif handles.CurrentvalueDistSplitsPacing == 3;
%                 DistSplits = 100;
%             elseif handles.CurrentvalueDistSplitsPacing == 4;
%                 DistSplits = 200;
%             end;
        elseif RaceDist == 800
%             if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 25;
%             elseif handles.CurrentvalueDistSplitsPacing == 2;
%                 DistSplits = 50;
%             elseif handles.CurrentvalueDistSplitsPacing == 3;
%                 DistSplits = 100;
%             elseif handles.CurrentvalueDistSplitsPacing == 4;
%                 DistSplits = 200;
%             elseif handles.CurrentvalueDistSplitsPacing == 5;
%                 DistSplits = 400;
%             end;
        elseif RaceDist == 1500;
%             if handles.CurrentvalueDistSplitsPacing == 1;
                DistSplits = 50;
%             elseif handles.CurrentvalueDistSplitsPacing == 2;
%                 DistSplits = 100;
%             elseif handles.CurrentvalueDistSplitsPacing == 3;
%                 DistSplits = 200;
%             elseif handles.CurrentvalueDistSplitsPacing == 4;
%                 DistSplits = 500;
%             end;
        end;
%     else;
%         %Lap
%         if handles.CurrentvalueDistSplitsPacing == 1;
%             DistSplits = 5;
%         elseif handles.CurrentvalueDistSplitsPacing == 2;
%             DistSplits = 10;
%         elseif handles.CurrentvalueDistSplitsPacing == 3;
%             DistSplits = 25;
%         end;
%     end;
% end;

% if handles.CurrentvalueRaceLapPacing == 1;
    DistIni = DistSplits;
    DistEnd = RaceDist;
% else;
%     DistIni = (Course.*(handles.CurrentvalueRaceLapPacing-2)) + DistSplits;
%     DistEnd = Course.*(handles.CurrentvalueRaceLapPacing-1);
% end;
keyDist = DistIni:DistSplits:DistEnd;
keyDistFullRace = DistSplits:DistSplits:RaceDist;

%trim splits matices
dataMatCumSplitsPacingTRIM = dataMatCumSplitsPacing;
dataMatSplitsPacingTRIM = dataMatSplitsPacingTRIM;
dataMatCumSplitsPacingTRIMFullRace = dataMatCumSplitsPacingFullRace;
dataMatSplitsPacingTRIMFullRace = dataMatCumSplitsPacingTRIMFullRace;

% if handles.CurrentvalueRaceLapPacing == 1;
%     for race = 1:nbRaces;
%         dataMatSplitsPacingTRIM(:,race+1) = [dataMatCumSplitsPacingTRIM(1,race+1); diff(dataMatCumSplitsPacingTRIM(:,race+1))];
%     end;
%     for race = 1:nbRaces;
%         dataMatSplitsPacingTRIMFullRace(:,race+1) = [dataMatCumSplitsPacingTRIMFullRace(1,race+1); diff(dataMatCumSplitsPacingTRIMFullRace(:,race+1))];
%     end;
% else;
% 	lapEC = handles.CurrentvalueRaceLapPacing-1;
%     for race = 1:nbRaces;
%         if lapEC == 1;
%             LapTime = 0;
%         else;
%             eval(['SplitsAll = handles.SplitsAllR' num2str(race) ';']);
%             LapTime = SplitsAll(lapEC-1,2);
%         end;
%         dataMatSplitsPacingTRIM(:,race+1) = [dataMatCumSplitsPacingTRIM(1,race+1)-LapTime; diff(dataMatCumSplitsPacingTRIM(:,race+1))];
%         dataMatSplitsPacingTRIMFullRace(:,race+1) = [dataMatCumSplitsPacingTRIMFullRace(1,race+1); diff(dataMatCumSplitsPacingTRIMFullRace(:,race+1))];
%     end;
% end;

% if handles.CurrentvalueRaceLapPacing == 1;
    lapDist = Course:Course:RaceDist;
    nbLap = RaceDist./Course;
% else;
%     lapDist = Course:Course:DistEnd;
%     nbLap = 1;
% end;
if DistSplits < 25;
    linan = find(isnan(dataMatSplitsPacing(:,2)) == 1);
    keep = [];
    iter = 1;
    for i = 1:length(linan);
        if dataMatSplitsPacing(linan(i),1) >= 50;
            keep(iter) = linan(i);
            iter = iter + 1;
        end;
    end;
    
    for lap = 2:nbLap;
        liInf = find(dataMatSplitsPacing(:,1) == lapDist(lap-1));
        liSup = find(dataMatSplitsPacing(:,1) == lapDist(lap));
        li = find(keep >= liInf & keep <= liSup);

        keepLap = keep(li(end));
        distmax = dataMatSplitsPacing(keepLap,1);
        
        lidistmax = find(dataMatSplitsPacingTRIM(:,1) == distmax);
        if isempty(lidistmax) == 1;
            distmax = distmax + 5;
            lidistmax = find(dataMatSplitsPacingTRIM(:,1) == distmax);
        end;
        dataMatSplitsPacingTRIM(lidistmax,2:end) = NaN;
    end;
end;

%---convert to Percentage
dataMatSplitsPacingTRIMPerc = dataMatSplitsPacingTRIM(:,1);
for race = 1:nbRaces;
    eval(['SplitsAll = handles.SplitsAllR' num2str(race) ';']);
    raceTime = SplitsAll(end,2);
    
    for split = 1:length(dataMatSplitsPacingTRIM(:,1));
        splitEC = dataMatSplitsPacingTRIM(split,race+1);
        if isnan(splitEC) == 1;
            dataMatSplitsPacingTRIMPerc(split, race+1) = NaN;
        else;
            dataMatSplitsPacingTRIMPerc(split, race+1) = (splitEC./raceTime).*100;
        end;
    end;
end;
handles.dataMatSplitsPacingTRIMPerc = dataMatSplitsPacingTRIMPerc;

dataMatCumSplitsPacingTRIMPerc = dataMatCumSplitsPacingTRIM(:,1);
for race = 1:nbRaces;
    eval(['SplitsAll = handles.SplitsAllR' num2str(race) ';']);
    raceTime = SplitsAll(end,2);
    
    for split = 1:length(dataMatCumSplitsPacingTRIM(:,1));
        splitEC = dataMatCumSplitsPacingTRIM(split,race+1);
        if isnan(splitEC) == 1;
            dataMatCumSplitsPacingTRIMPerc(split, race+1) = NaN;
        else;
            dataMatCumSplitsPacingTRIMPerc(split, race+1) = (splitEC./raceTime).*100;
        end;
    end;
end;
handles.dataMatCumSplitsPacingTRIMPerc = dataMatCumSplitsPacingTRIMPerc;


if RaceDist == 50 | RaceDist == 100;
    fontsizeAxe = 0.0252;
    fontsizeCol = 10;
elseif RaceDist == 200;
    fontsizeAxe = 0.0252;
    fontsizeCol = 10;
elseif RaceDist == 400;
    fontsizeAxe = 0.02;
    fontsizeCol = 10;
elseif RaceDist == 800;
    fontsizeAxe = 0.02;
    fontsizeCol = 7.5;
elseif RaceDist == 1500;
    fontsizeAxe = 0.02;
    fontsizeCol = 7.5;
end;

minY = 10000;
maxY = 0;

%find  min and max in Time/Perc
if handles.CurrentSplitsTimePacing == 1;
    for race = 1:nbRaces;
        linan = find(isnan(dataMatSplitsPacingTRIM(:,race+1)) == 1);
    %     linan = sort([linan; linan+1]);
        linanOpp = [];
        for lineMat = 1:length(dataMatSplitsPacingTRIM(:,1));
            li = find(linan == lineMat);
            if  isempty(li) == 1;
                linanOpp = [linanOpp; lineMat];
            end;
        end;
        minEC = min(dataMatSplitsPacingTRIM(linanOpp,race+1));

        if minEC < minY;
            minY = minEC;
        end;
        maxEC = max(dataMatSplitsPacingTRIM(linanOpp,race+1));
        if maxEC > maxY;
            maxY = maxEC;
        end;
    end;
end;
if handles.CurrentSplitsPercentagePacing == 1;
    for race = 1:nbRaces;
        linan = find(isnan(dataMatSplitsPacingTRIMPerc(:,race+1)) == 1);
    %     linan = sort([linan; linan+1]);
        linanOpp = [];
        for lineMat = 1:length(dataMatSplitsPacingTRIMPerc(:,1));
            li = find(linan == lineMat);
            if  isempty(li) == 1;
                linanOpp = [linanOpp; lineMat];
            end;
        end;
        minEC = min(dataMatSplitsPacingTRIMPerc(linanOpp,race+1));

        if minEC < minY;
            minY = minEC;
        end;
        maxEC = max(dataMatSplitsPacingTRIMPerc(linanOpp,race+1));
        if maxEC > maxY;
            maxY = maxEC;
        end;
    end;
end;

offset = 0.1.*(maxY - minY);
minY = minY-offset;
maxY = maxY+offset;
if minY < 0;
    maxY = maxY + minY;
    minY = 0;
end;

dataMatSplitsPacingTRIM(end+1,1) = keyDist(end)+DistSplits;
dataMatSplitsPacingTRIM(end,2:end) = NaN;
dataMatSplitsPacingTRIMPerc(end+1,1) = keyDist(end)+DistSplits;
dataMatSplitsPacingTRIMPerc(end,2:end) = NaN;
keyDist(end+1) = keyDist(end)+DistSplits;

if handles.CurrentSplitsTimePacing == 1;
    DataToPlot = [];
    Ypos = [];
    raceEC = 1;
    for race = 1:nbRaces;
        Ypos = [Ypos; raceEC; raceEC+1];
        raceEC = raceEC + 1.25;
        DataToPlot = [DataToPlot; dataMatSplitsPacingTRIM(:,race+1)'; zeros(1,length(keyDist)).*NaN];
    end;
end;
if handles.CurrentSplitsPercentagePacing == 1;
    DataToPlot = [];
    Ypos = [];
    raceEC = 1;
    for race = 1:nbRaces;
        Ypos = [Ypos; raceEC; raceEC+1];
        raceEC = raceEC + 1.25;
        DataToPlot = [DataToPlot; dataMatSplitsPacingTRIMPerc(:,race+1)'; zeros(1,length(keyDist)).*NaN];
    end;
end;
graph_splits1D = pcolor(axessplits_analyser, keyDist, Ypos, DataToPlot);
colormap(Fig, 'parula');
caxis([minY maxY]);

%---Colorbar
offsetLeftXtitle = 100./FigPos(3);
offsetBottomXtitle = 5./FigPos(4);
widthColBar = 1130./FigPos(3);
heightColBar = 60./FigPos(4);
widthXtitle = 1130./FigPos(3);
offsetBottomColBar = 630./FigPos(4);
offsetLeftColBar = 100./FigPos(3);
heightXtitle = 20./FigPos(4);
posaxecolbar = [offsetLeftXtitle, offsetBottomColBar, widthXtitle, 0.07];
poscolbar = [offsetLeftColBar, offsetBottomColBar, widthColBar, heightColBar];

rangeTime = maxY-minY;
if rangeTime <= 0.5;
    jump = 0.02;
elseif rangeTime > 0.5 & rangeTime <= 1;
    jump = 0.06;
elseif rangeTime > 1 & rangeTime <= 2.5;
    jump = 0.1;
elseif rangeTime > 2.5 & rangeTime <= 3;
    jump = 0.15;
elseif rangeTime > 3 & rangeTime <= 4;
    jump = 0.2;
elseif rangeTime > 4 & rangeTime <= 5;
    jump = 0.25;
elseif rangeTime > 5 & rangeTime <= 6;
    jump = 0.3;
elseif rangeTime > 6 & rangeTime <= 7;
    jump = 0.35;
elseif rangeTime > 7 & rangeTime <= 8;
    jump = 0.4;
elseif rangeTime > 8 & rangeTime <= 9;
    jump = 0.45;
elseif rangeTime > 9 & rangeTime <= 10;
    jump = 0.5;
elseif rangeTime > 10 & rangeTime <= 20;
    jump = 1;
else
    jump = 2;
end;
tickTime = roundn([minY:jump:maxY],-2);
tickColor = (tickTime-minY)/rangeTime;
tickTimeTXT = [];
if handles.CurrentSplitsTimePacing == 1;
    for i = 1:length(tickTime);
        TXT = timeSecToStr(tickTime(i));
        tickTimeTXT{i} = TXT;
    end;
    titleColorBar = 'Time';
end;
if handles.CurrentSplitsPercentagePacing == 1;
    for i = 1:length(tickTime);
        TXT = dataToStr(tickTime(i),2);
        tickTimeTXT{i} = [TXT ' %'];
    end;
    titleColorBar = 'Percentage';
end;
axescolbar = axes('parent', Fig, 'Position', posaxecolbar, 'units', 'Normalized', ...
        'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
        'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', [], ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', fontsizeCol);
colbar = colorbar(axescolbar, 'location', 'northoutside', 'Ticks', tickColor,...
         'TickLabels',tickTimeTXT, 'color', [1 1 1], 'visible', 'on');
colbar.Label.String = titleColorBar;
colbar.Label.FontUnits = 'normalized'; 
colbar.Label.FontSize = 2.6667;
% colbar.Label.FontSize = 10;
colbar.Label.FontWeight = 'bold';
colbar.Label.FontName = 'Antiqua';
colbar.Limits = [0 1];
axescolbarSplits = axescolbar;
colbarSplits = colbar;
axescolbar_Splits = axescolbar;
colbar_Splits = colbar;

for split = 1:length(dataMatSplitsPacingTRIM(:,1));
    posx = dataMatSplitsPacingTRIM(split,1);
    line(axessplits_analyser, [posx posx], [Ypos(1) Ypos(end)], 'linewidth', 1, 'linestyle', '--', 'color', [0.8 0.8 0.8]);
end;

lapDist = 0:Course:RaceDist;
for i = 1:length(lapDist);
    posx = lapDist(i) + DistSplits;
    line(axessplits_analyser, [posx posx], [Ypos(1) Ypos(end)], 'linewidth', 2, 'color', [1 0 0]);
end;

xticklabelValue = [];
for i = 1:length(keyDist);
    xticklabelValue{i} = num2str(keyDist(i)-DistSplits);
end;
xlim(axessplits_analyser, [keyDist(1)-2 keyDist(end)+2]);
ylim(axessplits_analyser, [Ypos(1) Ypos(end)]);

for race = 1:nbRaces;
    posx = keyDist(1);
    if handles.CurrentvalueRaceLapPacing == 1;
    %all race
        if RaceDist == 50;
            if DistSplits == 5;
                offsetx = 0.7.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 10;
                offsetx = 1.5.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 25;
                offsetx = 3.5.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 10.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 100;
            if DistSplits == 5;
                offsetx = 0.6.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 10;
                offsetx = 1.2*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 25;
                offsetx = 3.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 6.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 200;
            if DistSplits == 10;
                offsetx = 1.2.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 25;
                offsetx = 3.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 6.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 12.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 24.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 400;
            if DistSplits == 25;
                offsetx = 3.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 6.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 12.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 24.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 800;
            if DistSplits == 25;
                offsetx = 2.8.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 50;
                offsetx = 5.6.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 11.2.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 22.4.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 400;
                offsetx = 44.8.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        elseif RaceDist == 1500;
            if DistSplits == 50;
                offsetx = 6.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 100;
                offsetx = 12.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 200;
                offsetx = 24.*((keyDist(end)-keyDist(1))./DistSplits);
            elseif DistSplits == 500;
                offsetx = 60.*((keyDist(end)-keyDist(1))./DistSplits);
            end;
        end;
    else;
    %only 1 lap
        if DistSplits == 5;
            offsetx = 0.7.*((keyDist(end)-keyDist(1))./DistSplits);
        elseif DistSplits == 10;
            offsetx = 1.5.*((keyDist(end)-keyDist(1))./DistSplits);
        elseif DistSplits == 25;
            offsetx = 3.5.*((keyDist(end)-keyDist(1))./DistSplits);
        end;
    end;
    storeTitleBis = handles.storeTitleBis;
    posy = Ypos((race*2)-1) + ((Ypos((race*2)) - Ypos((race*2)-1))./2);

    racetitleEC{race} = text(posx-offsetx, posy, storeTitleBis{race}, 'horizontalalignment', 'Left', 'verticalalignment', 'middle', ...
        'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'Normalized', 'Fontsize', 0.0252, 'color', [1 1 1], 'parent', axessplits_analyser, 'visible', 'on');
    set(racetitleEC{race}, 'units', 'Normalized');
end;
set(axessplits_analyser, 'Visible', 'on', 'color', [0 0 0], ...
    'xcolor', [1 1 1], 'xtick', keyDist, 'xticklabel', xticklabelValue, ...
    'ytick', [], 'yticklabel', [], 'FontUnits', 'Normalized', 'fontsize', fontsizeAxe);

axesXTitle = axes('parent', Fig, 'Position', [offsetLeftXtitle, offsetBottomXtitle, widthXtitle, heightXtitle], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesXTitle, [0 1]);
ylim(axesXTitle, [0 1]);
XTitle = text(0.5, 0.5, 'Distance (m)', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'normalized', 'Fontsize', 0.667, ...
    'color', [1 1 1], 'parent', axesXTitle, 'visible', 'on');
set(XTitle, 'units', 'Normalized');
axesXTitleSplits = axesXTitle;

iter = 1;
for race = 1:nbRaces;
    posy = Ypos((race*2)-1) + ((Ypos((race*2)) - Ypos((race*2)-1))./2);
    for i = 1:length(dataMatSplitsPacingTRIM(:,1));
        if isnan(dataMatSplitsPacingTRIM(i,race+1)) ~= 1;
            posx = dataMatSplitsPacingTRIM(i,1) + ((dataMatSplitsPacingTRIM(i+1,1) - dataMatSplitsPacingTRIM(i,1))./2);
            TXTsplit = timeSecToStr(roundn(dataMatSplitsPacingTRIM(i,race+1),-2));
            TXTsplitcum = timeSecToStr(roundn(dataMatCumSplitsPacingTRIM(i,race+1),-2));
            if nbRaces <= 4;
                TXT = [TXTsplit ' / ' TXTsplitcum];
            else;
                TXT = {TXTsplit; TXTsplitcum};
            end;

            lilap = find(lapDist == (posx-DistSplits));
            if isempty(lilap) == 1;
                DispSplits(iter) = text(posx, posy, TXT, 'horizontalalignment', 'center', 'verticalalignment', 'Middle', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [0.85 0.85 0.85], 'rotation', 270, 'parent', axessplits_analyser, 'visible', 'off');
            else;
                DispSplits(iter) = text(posx, posy, TXT, 'horizontalalignment', 'center', 'verticalalignment', 'Bottom', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [0.85 0.85 0.85], 'rotation', 270, 'parent', axessplits_analyser, 'visible', 'off');
            end;
            set(DispSplits, 'FontUnits', 'normalized');
            iter = iter + 1;
        end;
    end;
end;

iter = 1;
for race = 1:nbRaces;
    posy = Ypos((race*2)-1) + ((Ypos((race*2)) - Ypos((race*2)-1))./2);
    for i = 1:length(dataMatSplitsPacingTRIMPerc(:,1));
        if isnan(dataMatSplitsPacingTRIMPerc(i,race+1)) ~= 1;
            posx = dataMatSplitsPacingTRIMPerc(i,1) + ((dataMatSplitsPacingTRIMPerc(i+1,1) - dataMatSplitsPacingTRIMPerc(i,1))./2);
            TXTsplit = dataToStr(dataMatSplitsPacingTRIMPerc(i,race+1),2);
            TXTsplitcum = dataToStr(dataMatCumSplitsPacingTRIMPerc(i,race+1),2);
            if strcmpi(TXTsplitcum, '10000');
                TXTsplitcum = '100';
            end;
            if nbRaces <= 4;
                TXT = [TXTsplit ' % / ' TXTsplitcum ' %'];
            else;
                 TXT = {[TXTsplit ' %']; [TXTsplitcum ' %']};
            end;

            lilap = find(lapDist == (posx-DistSplits));
            if isempty(lilap) == 1;
                DispSplitsPerc(iter) = text(posx, posy, TXT, 'horizontalalignment', 'center', 'verticalalignment', 'Middle', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [0.85 0.85 0.85], 'rotation', 270, 'parent', axessplits_analyser, 'visible', 'off');
            else;
                DispSplitsPerc(iter) = text(posx, posy, TXT, 'horizontalalignment', 'center', 'verticalalignment', 'Bottom', ...
                    'FontWeight', 'bold', 'FontName', 'Antiqua', 'Fontsize', 10, 'color', [0.85 0.85 0.85], 'rotation', 270, 'parent', axessplits_analyser, 'visible', 'off');
            end;
            set(DispSplitsPerc, 'FontUnits', 'normalized');
            iter = iter + 1;
        end;
    end;
end;

if handles.CurrentvalueSplitsPacing == 1;
    if get(handles.splitsPercentage_check_analyser, 'Value') == 1;
        set(DispSplitsPerc, 'Visible', 'on');
    end;
    if get(handles.splitsTime_check_analyser, 'Value') == 1;
        set(DispSplits, 'Visible', 'on');
    end;
end;


axesFigTitle = axes('parent', Fig, 'Position', [offsetLeftXtitle, 690./FigPos(4), widthXtitle, 30./FigPos(4);], 'units', 'Normalized', ...
    'Visible', 'on', 'color', [0 0 0], 'xcolor', [0 0 0], 'ycolor', [0 0 0], ...
    'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
xlim(axesFigTitle, [0 1]);
ylim(axesFigTitle, [0 1]);
FigTitle = text(0.5, 0.5, 'Pacing Strategy', 'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
    'FontWeight', 'bold', 'FontName', 'Antiqua', 'FontUnits', 'normalized', 'Fontsize', 0.69, ...
    'color', [1 1 1], 'parent', axesFigTitle, 'visible', 'on');
set(FigTitle, 'units', 'Normalized');


Fig.Visible = 'on';
if strcmpi(origin, 'save');
    Fig.Visible = 'off';
    Fig.InvertHardcopy = 'off';
    saveas(Fig, [pathname '\' filename]);
    clear_figures;
else;
    resolution = get(0,'ScreenSize');
    if length(resolution(:,1)) > 1;
        FigPos = [resolution(2,1) resolution(2,2) FigPos(3) FigPos(4)];
        set(Fig, 'position', FigPos);
            
        set(Fig, 'units', 'Normalized');
        posNorm = get(Fig, 'Position');
        set(Fig, 'position', [posNorm(1) posNorm(2) 1 1], 'SizeChangedFcn', {@resizefullscreenSkill, Data_table, fontTable});
        
    else;
        set(Fig, 'units', 'Normalized');
    end;
    if ispc == 1;
        jFrame = get(handle(Fig), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    Fig.Visible = 'on';
end;
