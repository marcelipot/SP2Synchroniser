%remove distances used to interpolate
divLocation = RaceLocation(:,5)./5;
remLocation = rem(divLocation, 1);
indexrem = find(remLocation == 0);
RaceLocation = RaceLocation(indexrem,:);

lapDist = SplitsAll(2:end,1);
if Course == 50;
    if RaceDist == 50;
        perfectDist = [0 15 25 35 45 50];
    elseif RaceDist == 150;
        perfectDist = [0 15 25 35 45 50 ...
            60 65 75 85 95 100 ...
            110 115 125 135 145 150];
    else;
        perfectDist = [0 15 25 35 45 50 60 65 75 85 95 100];
        if RaceDist > 100;
            for lap100 = 2:((RaceDist./Course)./2);
                distRef = perfectDist(end);
                perfectDist = [perfectDist distRef+10 distRef+15 distRef+25 distRef+35 distRef+45 distRef+50 ...
                    distRef+60 distRef+65 distRef+75 distRef+85 distRef+95 distRef+100];
            end;
        end;
    end;
elseif Course == 25;
    if RaceDist == 50;
        perfectDist = [0 15 20 25 35 45 50];
    elseif RaceDist == 150;
        perfectDist = [0 15 20 25 35 45 50 ...
            60 70 75 85 95 100 ...
            110 120 125 135 145 150];
    else;
        perfectDist = [0 15 20 25 35 45 50 60 70 75 85 95 100];
        if RaceDist > 100;
            for lap100 = 2:((RaceDist./Course)./4);
                distRef = perfectDist(end);
                perfectDist = [perfectDist distRef+10 distRef+20 distRef+25 ...
                    distRef+35 distRef+45 distRef+50 ...
                    distRef+60 distRef+70 distRef+75 ...
                    distRef+85 distRef+95 distRef+100];
            end;
        end;
    end;
end;

if invalidRace == 0;
    isMissingDist = 0;
    perfectDist = perfectDist';
    perfectDistSave = perfectDist;
    if isempty(RaceLocation) == 1;
        %no race location at all
        isMissingDist = 1;
    else;
        %remove all unnecessary distance
        lapEC = 1;
        distIniLap = 0;
        distEndLap = Course;
        for raceDistEC = 1:length(RaceLocation(:,5));
            rawIni = find(perfectDist(:,1) == distIniLap);
            rawEnd = find(perfectDist(:,1) == distEndLap);

            distEC = RaceLocation(raceDistEC,5);
            index = find(perfectDist(rawIni(1):rawEnd(1),1) == distEC);

            if isempty(index) == 1;
                %extra distance not required
                RaceLocation(raceDistEC,5) = NaN;
            end;
               
            if distEC == distEndLap;
                distIniLap = distEndLap;
                distEndLap = distIniLap + Course;

                lapEC = lapEC + 1;
                perfectDist(rawIni:rawEnd-1) = [];
            end;
        end;
        perfectDist = perfectDistSave;
        index = find(isnan(RaceLocation(:,5)) == 1);
        RaceLocation(index,:) = [];

        %check all RaceLocation missing;
        lapEC = 1;
        distIniLap = 0;
        distEndLap = Course;
        for perfectDistEC = 1:length(perfectDist);
            rawIni = find(RaceLocation(:,5) == distIniLap);
            rawEnd = find(RaceLocation(:,5) == distEndLap);
%             rawTot = sort([rawIni; rawEnd], 'Ascend');
%             rawIni = rawTot(lapEC);
%             rawEnd = rawTot(lapEC+1);

            frameIni = RaceLocation(rawIni,4);
            frameEnd = RaceLocation(rawEnd,4);

            distEC = perfectDist(perfectDistEC);
            
            if frameEnd <= frameIni;
                %error in frame number
                RaceLocation(rawEnd,1:4) = NaN;
            else;
                indexFrame = find(RaceLocation(:,4) >= frameIni & RaceLocation(:,4) <= frameEnd);
                indexNaN = find(isnan(RaceLocation(indexFrame(1):indexFrame(end),4)) == 1); 
                if isempty(indexNaN) == 0;
                    locNaN = indexNaN+indexFrame(1)-1;
                    indexFrame = sort([indexFrame;locNaN]);
                end;            
                index = find(RaceLocation(indexFrame,5) == distEC);
                if isempty(index) == 1;
                    %missing dist or the frame for that distance is wrong
                    index = find(RaceLocation(indexFrame(1):indexFrame(end),5) == distEC);
                    if isempty(index) == 1;
                        %distance is missing
                        diffDist = distEC - RaceLocation(indexFrame,5);
                        indexPre = indexFrame(1) + find(diffDist > 0) - 1;
                        indexPost = indexFrame(1) + find(diffDist < 0) - 1;
                        RaceLocation = [RaceLocation(1:indexPre(end),:); [NaN NaN NaN NaN distEC]; RaceLocation(indexPost(1):end,:)];
                    else;
                        %distance is wrong
                        RaceLocation(index,1:4) = NaN;
                    end;
                end;
            end;
            
            if distEC == distEndLap;
                distIniLap = distEndLap;
                distEndLap = distIniLap + Course;

                lapEC = lapEC + 1;
            end;
        end;

        %Check if a frame number is doubled
%         diffDist = diff(RaceLocation(:,4));
%         indexNeg = find(diffDist <= 0);
%         checkLap1 = find(lapDist == RaceLocation(indexNeg,5));
%         checkLap2 = find(lapDist == RaceLocation(indexNeg+1,5));
%         RaceLocation(indexNeg:indexNeg+1,4) = NaN;


        if length(perfectDist) < length(RaceLocation(:,5));
            a=raceEC
            e=e
        elseif length(perfectDist) > length(RaceLocation(:,5));
            b=raceEC
            e=e
        else;
            indexNaN = find(isnan(RaceLocation(:,4)) == 1);
            %check if missing are 15m
            missingVal15 = [];
            for missingVal = 1:length(indexNaN);
                distEC = RaceLocation(indexNaN(missingVal),5);
                if distEC == 15;
                    time15 = roundn(raceDataMetaNew{1,19},-2);
                    if isempty(time15) == 0;
                        frame15 = roundn(time15*framerate,0);
                        RaceLocation(indexNaN(missingVal),1) = 0;
                        RaceLocation(indexNaN(missingVal),2) = 0;
                        RaceLocation(indexNaN(missingVal),3) = 0;
                        RaceLocation(indexNaN(missingVal),4) = frame15;
                        RaceLocation(indexNaN(missingVal),5) = 15;
                        missingVal15 = missingVal;
                    end;
                end;
            end;
            if isempty(missingVal15) == 0;
                indexNaN(missingVal) = [];
            end;

            if isempty(indexNaN) == 0;
                diffNaN = diff(indexNaN);
                if isempty(find(diffNaN <= 1)) == 1;
                    %only 1 NaN between 2 good distance -->
                    %Can be interpolated
                    %need to be interpolated
                    missingDistRaw = find(isnan(RaceLocation(:,4)) == 1);
                    
                    AllDistAvai = RaceLocation(:,4:5);
                    for BOlist = 1:length(BOAll(:,4));
                        BOEC = [BOAll(BOlist,1) BOAll(BOlist,3)];
                        indexPre = find(AllDistAvai(:,1) < BOEC(1,1));
                        indexPost = find(AllDistAvai(:,1) >= BOEC(1,1));
                        AllDistAvai = [AllDistAvai(1:indexPre(end),:); BOEC; AllDistAvai(indexPost(1):end,:)];
                    end;

                    limLap = [];
                    for lapEC = 1:nbLap+1;
                        keydist = (lapEC-1).*Course;
                        indexLap = find(RaceLocation(:,5) == keydist);
                        limLap = [limLap; RaceLocation(indexLap,4)];
                    end;
                    for missingDistEC = 1:length(missingDistRaw);
                        rawEC = missingDistRaw(missingDistEC);
                        missingDist = RaceLocation(rawEC,5);

%                                         indexLap = find(AllDistAvai(:,2) == 0 | AllDistAvai(:,2) == 50);
%         %                                 indexLap = indexLap(1:end-1); %last one is end of race
%                                         frameLap = AllDistAvai(indexLap,1);
                        lapEC = 0;
                        for lapTest = 1:length(limLap(:,1))-1;
                            index = RaceLocation(rawEC-1,4) >= limLap(lapTest,1) & RaceLocation(rawEC-1,4) <= limLap(lapTest+1,1);
                            if isempty(find(index ~= 1)) == 1;
                                lapEC = lapTest;
                            end;
                        end;

                        framelapIni = limLap(lapEC,1);
                        framelapEnd = limLap(lapEC+1,1);
                        indexRawLapEC = find(RaceLocation(:,4) >= framelapIni & RaceLocation(:,4) <= framelapEnd);
                        
                        diffDist = missingDist - RaceLocation(indexRawLapEC,5);
                        preDistRaw = find(diffDist > 0);
                        preDist = RaceLocation(indexRawLapEC(1)+preDistRaw(end)-1,5);
                        preFrame = RaceLocation(indexRawLapEC(1)+preDistRaw(end)-1,4);
                        postDistRaw = find(diffDist < 0) + 1;
                        postDist = RaceLocation(indexRawLapEC(1)+postDistRaw(1)-1,5);
                        postFrame = RaceLocation(indexRawLapEC(1)+postDistRaw(1)-1,4);

                        diffDist = postDist - preDist;
                        diffTime = (postFrame - preFrame)./framerate;
                        speedInterp = diffDist./diffTime;
                        gapDist = missingDist - preDist;
                        gapFrame = roundn((gapDist./speedInterp).*framerate,0);
                        RaceLocation(rawEC,4) = preFrame + gapFrame;
%                         RaceLocation(rawEC,3) = 5;
                    end;
                else;
                    %more than 1 NaN between 2 good distance -->
                    missingDistRaw = find(isnan(RaceLocation(:,4)) == 1);
                    limLap = [];
                    for lapEC = 1:nbLap+1;
                        keydist = (lapEC-1).*Course;
                        indexLap = find(RaceLocation(:,5) == keydist);
                        limLap = [limLap; RaceLocation(indexLap,4)];
                    end;

                    proceed = 1;
                    iter = 1;
                    while proceed == 1;

                        missingDistEC = missingDistRaw(iter);
                        if length(missingDistRaw) > 1;
                            pt2remove = 1;
                            if missingDistRaw(iter+1) == missingDistEC + 1;
                                %next point is also missing
                                pt2remove = 2;
                            end;
                            if length(missingDistRaw) > 2;
                                if missingDistRaw(iter+2) == missingDistEC + 2;
                                    %next 2 points are also missing
                                    pt2remove = 3;
                                end;
                            end;
                            if length(missingDistRaw) > 3;
                                if missingDistRaw(iter+3) == missingDistEC + 3;
                                    %next 2 points are also missing
                                    pt2remove = 4;
                                end;
                            end;
                            missingDistEC = [missingDistEC:missingDistRaw(iter+(pt2remove-1))];
                        else;
                            pt2remove = 1;
                        end;
                        missingDist = RaceLocation(missingDistEC,5);

%                                         indexLap = find(AllDistAvai(:,2) == 0 | AllDistAvai(:,2) == 50);
%         %                                 indexLap = indexLap(1:end-1); %last one is end of race
%                                         frameLap = AllDistAvai(indexLap,1);
                        lapEC = 0;
                        for lapTest = 1:length(limLap(:,1))-1;
                            index = RaceLocation(missingDistEC(1)-1,4) >= limLap(lapTest,1) & RaceLocation(missingDistEC(1)-1,4) <= limLap(lapTest+1,1);
                            if isempty(find(index ~= 1)) == 1;
                                lapEC = lapTest;
                            end;
                        end;

                        framelapIni = limLap(lapEC,1);
                        framelapEnd = limLap(lapEC+1,1);
                        indexRawLapEC = find(RaceLocation(:,4) >= framelapIni & RaceLocation(:,4) <= framelapEnd);
                        
                        diffDist = missingDist(1) - RaceLocation(indexRawLapEC,5);
                        preDistRaw = find(diffDist > 0);
                        preDist = RaceLocation(indexRawLapEC(1)+preDistRaw(end)-1,5);
                        preFrame = RaceLocation(indexRawLapEC(1)+preDistRaw(end)-1,4);
                        
                        diffDist = missingDist(end) - RaceLocation(indexRawLapEC,5);
                        postDistRaw = find(diffDist < 0) + 1;
                        if pt2remove == 1;
                            postDist = RaceLocation(indexRawLapEC(1)+postDistRaw(1)-1,5);
                            postFrame = RaceLocation(indexRawLapEC(1)+postDistRaw(1)-1,4);
                        elseif pt2remove == 2;
                            postDist = RaceLocation(indexRawLapEC(1)+postDistRaw(1),5);
                            postFrame = RaceLocation(indexRawLapEC(1)+postDistRaw(1),4);
                        elseif pt2remove == 3;
                            postDist = RaceLocation(indexRawLapEC(1)+postDistRaw(1)+1,5);
                            postFrame = RaceLocation(indexRawLapEC(1)+postDistRaw(1)+1,4);
                        elseif pt2remove == 4;
                            postDist = RaceLocation(indexRawLapEC(1)+postDistRaw(1)+2,5);
                            postFrame = RaceLocation(indexRawLapEC(1)+postDistRaw(1)+2,4);
                        end;

                        diffDist = postDist - preDist;
                        diffTime = (postFrame - preFrame)./framerate;
                        speedInterp = diffDist./diffTime;
                        gapDist = missingDist - preDist;
                        gapFrame = roundn((gapDist./speedInterp).*framerate,0);
                        RaceLocation(missingDistEC,4) = preFrame + gapFrame;
%                         RaceLocation(rawEC,3) = 5;

                        if pt2remove == 1;
                            missingDistRaw(iter) = [];
                        else;
                            missingDistRaw(iter:iter+(pt2remove-1)) = [];
                        end;

                        if isempty(missingDistRaw) == 1;
                            proceed = 0;
                        end;
                    end;

                    isMissingDist = 1;
%                     eee=eee
                end;
            else;
                diffDist = perfectDist - RaceLocation(:,5);
                index = find(diffDist ~= 0);
                if isempty(index) == 0;
                    %error to check
                    c=raceEC
                    e=e
                else;
                    %No need to do anything
                end;
            end;
        end;
    end;
end;


