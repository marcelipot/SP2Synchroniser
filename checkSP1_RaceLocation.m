%remove distances used to interpolate
divLocation = RaceLocation(:,5)./5;
remLocation = rem(divLocation, 1);
indexrem = find(remLocation == 0);
RaceLocation = RaceLocation(indexrem,:);

if Course == 50;
    if RaceDist == 50;
        perfectDist = [0 15 25 35 45 50];
    elseif RaceDist == 150;
        perfectDist = [0 15 25 35 45 50 ...
            40 35 25 15 5 0 ...
            10 15 25 35 45 50];
    else;
        perfectDist = [0 15 25 35 45 50 40 35 25 15 5 0];
        if RaceDist > 100;
            for lap100 = 2:((RaceDist./Course)./2);
                perfectDist = [perfectDist 10 15 25 35 45 50 40 35 25 15 5 0];
            end;
        end;
    end;
else;
    if RaceDist == 50;
        perfectDist = [0 15 20 25 15 5 0];
    elseif RaceDist == 150;
        perfectDist = [0 15 20 25 15 5 0 ...
            10 15 20 25 15 5 0 ...
            15 20 25 15 5 0];
    else;
        perfectDist = [0 15 20 25 15 5 0 10 20 25 15 5 0];
        if RaceDist > 100;
            for lap100 = 2:((RaceDist./Course)./4);
                perfectDist = [perfectDist 10 20 25 15 5 0 10 20 25 15 5 0];
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
                distEndLapSave = distEndLap;
                distEndLap = distIniLap;
                distIniLap = distEndLapSave;

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
            rawTot = sort([rawIni; rawEnd], 'Ascend');
            rawIni = rawTot(lapEC);
            rawEnd = rawTot(lapEC+1);

            frameIni = RaceLocation(rawIni,4);
            frameEnd = RaceLocation(rawEnd,4);

            distEC = perfectDist(perfectDistEC);
            indexFrame = find(RaceLocation(:,4) >= frameIni & RaceLocation(:,4) <= frameEnd);
            index = find(RaceLocation(indexFrame(1):indexFrame(end),5) == distEC);
            if isempty(index) == 1;
                %missing dist
                if rem(lapEC,2) == 1;
                    %odd lap
                    diffDist = distEC - RaceLocation(indexFrame(1):indexFrame(end),5);
                else;
                    %even lap
                    diffDist = RaceLocation(indexFrame(1):indexFrame(end),5) - distEC;
                end;
                indexPre = indexFrame(1) + find(diffDist > 0) - 1;
                indexPost = indexFrame(1) + find(diffDist < 0) - 1;
                RaceLocation = [RaceLocation(1:indexPre(end),:); [NaN NaN NaN NaN distEC]; RaceLocation(indexPost(1):end,:)];
            end;

            if distEC == distEndLap;
                distEndLapSave = distEndLap;
                distEndLap = distIniLap;
                distIniLap = distEndLapSave;

                lapEC = lapEC + 1;
            end;
        end;

        if length(perfectDist) < length(RaceLocation(:,5));
            a=raceEC
            e=e
        elseif length(perfectDist) > length(RaceLocation(:,5));
            b=raceEC
            e=e
        else;
            indexNaN = find(isnan(RaceLocation(:,4)) == 1);
            if isempty(indexNaN) == 0;

                diffNaN = diff(indexNaN);
                if isempty(find(diffNaN < 2)) == 1;
                    %only 1 NaN between 2 good distance -->
                    %Can be interpolated
                    %need to interpolated
                    missingDistRaw = find(isnan(RaceLocation(:,4)) == 1);
                    
                    AllDistAvai = RaceLocation(:,4:5);
                    for BOlist = 1:length(isBO);
                        BOEC = AnnotationsEC(isBO(BOlist),4:5);
                        indexPre = find(AllDistAvai(:,1) < BOEC(1,1));
                        indexPost = find(AllDistAvai(:,1) >= BOEC(1,1));
                        AllDistAvai = [AllDistAvai(1:indexPre(end),:); BOEC; AllDistAvai(indexPost(1):end,:)];
                    end;

                    if Course == 50;
                        indexLap = find(RaceLocation(:,5) == 0 | RaceLocation(:,5) == 50);
                    else;
                        indexLap = find(RaceLocation(:,5) == 0 | RaceLocation(:,5) == 25);
                    end;
                    limLap = [];
                    for lec = 2:length(indexLap);
                        limLap = [limLap; [RaceLocation(indexLap(lec-1),4) RaceLocation(indexLap(lec),4)]];
                    end;
                    for missingDistEC = 1:length(missingDistRaw);
                        rawEC = missingDistRaw(missingDistEC);
                        missingDist = RaceLocation(rawEC,5);

%                                         indexLap = find(AllDistAvai(:,2) == 0 | AllDistAvai(:,2) == 50);
%         %                                 indexLap = indexLap(1:end-1); %last one is end of race
%                                         frameLap = AllDistAvai(indexLap,1);
                        lapEC = 0;
                        for lapTest = 1:length(limLap(:,1));
                            index = RaceLocation(rawEC-1,4) >= limLap(lapTest,1) & RaceLocation(rawEC-1,4) <= limLap(lapTest,2);
                            if isempty(find(index ~= 1)) == 1;
                                lapEC = lapTest;
                            end;
                        end;

                        framelapIni = limLap(lapEC,1);
                        framelapEnd = limLap(lapEC,2);
                        indexRawLapEC = find(RaceLocation(:,4) >= framelapIni & RaceLocation(:,4) <= framelapEnd);
                        
                        if rem(lapEC,2) == 1;
                            %odd lap
                            diffDist = missingDist - RaceLocation(indexRawLapEC,5);
                        else;
                            %even lap
                            diffDist = RaceLocation(indexRawLapEC,5) - missingDist;
                        end;
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
                        RaceLocation(rawEC,3) = 5;
                    end;
                else;
                    %more than 1 NaN between 2 good distance -->
                    %Cannot be interpolated
                    isMissingDist = 1;
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