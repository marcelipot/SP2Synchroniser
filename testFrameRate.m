
part1 = 'aws configure set aws_access_key_id AKIARMARPY3XJ6R7X7OV';
part2 = 'aws configure set aws_secret_access_key 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';
part3 = 'aws configure set default.region ap-southeast-2';
command = [part1 ' & ' part2 ' & ' part3];
[status, out] = system(command);

command = 'aws s3 ls s3://sparta2-prod/ --recursive';
[status, out] = system(command);
liSP2 = findstr(out,'sparta2');
liJSON = findstr(out,'.json');
fileList = {};
for line = 1:length(liJSON);
    valEC = liJSON(line);
    li1 = find(liSP2 - valEC < 0);
    sortSP2 = liSP2(li1(end));
    fileList{line,1} = ['s3://sparta2-prod/' out([sortSP2:valEC+4])];
end;
fileListAWSNew = fileList;
              

flag_TimeIssue = {};

for count = 1:length(fileListAWSNew);
    flagFR = [];

    fileECin = fileListAWSNew{count};
    index = strfind(fileECin, '/');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        fileECout = [MDIR '\SP2Synchroniser\' fileECin(index(end)+1:end)];
    elseif ismac == 1;
        fileECout = ['/Applications/SP2Synchroniser/' fileECin(index(end)+1:end)];
    end;
    command = ['aws s3 cp ' fileECin ' ' fileECout];
    [status, out] = system(command);
    dataEC = jsondecode(fileread(fileECout));
    
    Annotations = dataEC.annotations;
    Time = [];
    Frame = [];
    Distance = [];
    Velocity = [];
    VelocityTrend = [];
    Breath = [];
    Stroke = [];
    Breakout = [];
    Kick = [];
    
    % startFrame = dataEC.startFrame;
    for i =  1:length(Annotations);
        setEC = Annotations(i);
        Time(i) = setEC.time;
        Frame(i) = setEC.frame;
        Distance(i) = setEC.distance;
        Breath(i) = setEC.breath;
        Stroke(i) = setEC.stroke;
        Breakout(i) = setEC.breakout;
        Kick(i) = setEC.kick;
    end;
    
    
    FrameRate = roundn(1/(Time(2)-Time(1)), 0);
    
    if dataEC.relayLeg == 0;
        relayleg = 'Flat';
    elseif dataEC.relayLeg == 1;
        relayleg = 'Relay';
    elseif dataEC.relayLeg == 2;
        relayleg = 'Relay';
    elseif dataEC.relayLeg == 3;
        relayleg = 'Relay';
    elseif dataEC.relayLeg == 4;
        relayleg = 'Relay';
    end;
    
    if strcmpi(relayleg, 'Flat');
        if Time(1) < 0;
            Time(1) = 0;
        end;
        TimeExtra = 0:1/FrameRate:Time(1)-(1/FrameRate);
        Time = [TimeExtra Time];
        Distance = [zeros(1, length(TimeExtra)) Distance];
        Breath = [zeros(1, length(TimeExtra)) Breath];
        Stroke = [zeros(1, length(TimeExtra)) Stroke];
        Breakout = [zeros(1, length(TimeExtra)) Breakout];
        Kick = [zeros(1, length(TimeExtra)) Kick];
    end;
    
    %---check for framerate errors
    for i = 2:length(Time);
        ValEC = Time(i);
        modulus = mod(ValEC, 1);
        if modulus ~= 0;
            if roundn(rem(modulus*100, 2),-2) == 1;
                if i ~= length(Time);
                    ValBefore = Time(i-1);
                    ValAfter = Time(i+1);
                    if ValEC - ValBefore < (1./FrameRate);
                        ValEC = ValEC + 0.01;
                    elseif ValAfter - ValEC < (1./FrameRate);
                        ValEC = ValEC - 0.01;
                    else;
                        ValEC = ValEC - 0.01;
                    end;
                else;
                    ValEC = ValEC - 0.01;
                end;
                Time(i) = ValEC;
                flagFR = [flagFR '/1'];
            end;
        end;
    end;
    if Time(end-1) == Time(end);
        Time(end) = Time(end-1) + (1./FrameRate);
        flagFR = [flagFR '/2'];
    end;
    
    difftime = roundn(diff(Time), -2);
    liDiff = find(difftime > 1./FrameRate);
    if isempty(liDiff) == 0;
        proceedSub = 1;
        while proceedSub == 1;
            li = liDiff(1);
            if li == 1;
                if Time(li) < (1./FrameRate);
                    TimeExtra = [0 : (1./FrameRate) : Time(li+1)-(1./FrameRate)];
                    ini = 1;
                else;
                    TimeExtra = [Time(li)+(1./FrameRate) : (1./FrameRate) : Time(li+1)-(1./FrameRate)];
                    ini = 0;
                end;
            else;
                TimeExtra = [Time(li)+(1./FrameRate) : (1./FrameRate) : Time(li+1)-(1./FrameRate)];
                ini = 0;
            end;
            
            if isempty(TimeExtra) == 0;
                if ini == 0;
                    Time = [Time(1:li) TimeExtra Time(li+1:end)];
                    Distance = [Distance(1:li) zeros(1, length(TimeExtra)) Distance(li+1:end)];
                    Breath = [Breath(1:li) zeros(1, length(TimeExtra)) Breath(li+1:end)];
                    Stroke = [Stroke(1:li) zeros(1, length(TimeExtra)) Stroke(li+1:end)];
                    Breakout = [Breakout(1:li) zeros(1, length(TimeExtra)) Breakout(li+1:end)];
                    Kick = [Kick(1:li) zeros(1, length(TimeExtra)) Kick(li+1:end)];
                    flagFR = [flagFR '/3'];
                else;
                    Time = [TimeExtra Time(li+1:end)];
                    Distance = [zeros(1, length(TimeExtra)) Distance(li+1:end)];
                    Breath = [zeros(1, length(TimeExtra)) Breath(li+1:end)];
                    Stroke = [zeros(1, length(TimeExtra)) Stroke(li+1:end)];
                    Breakout = [zeros(1, length(TimeExtra)) Breakout(li+1:end)];
                    Kick = [zeros(1, length(TimeExtra)) Kick(li+1:end)];
                    flagFR = [flagFR '/4'];
                end;
    
                difftime = roundn(diff(Time), -2);  
                liDiff = find(difftime > 1./FrameRate);
            else;
                liDiff = liDiff(2:end);
            end;
            if isempty(liDiff) == 1;
                proceedSub = 0;
            end;
        end;
    end;
    
    if Distance(end) == 0;
        Distance = Distance(1:end-1);
    end;
    
    splitEC = dataEC.splits(end);
    RaceTime = splitEC.time;
    
    if (RaceTime-Time(end)) < (1/FrameRate);
        TimeExtra = Time(end)+(1/FrameRate) : 1/FrameRate : RaceTime;
        Time = [Time TimeExtra];
        Distance = [Distance zeros(1, length(TimeExtra))];
        Breath = [Breath zeros(1, length(TimeExtra))];
        Stroke = [Stroke zeros(1, length(TimeExtra))];
        Breakout = [Breakout zeros(1, length(TimeExtra))];
        Kick = [Kick zeros(1, length(TimeExtra))];
        flagFR = [flagFR '/5'];
    end;
    
    
    if Time(1) == (1/FrameRate);
        Time = [0 Time];
        Distance = [0 Distance];
        Breath = [0 Breath];
        Stroke = [0 Stroke];
        Breakout = [0 Breakout];
        Kick = [0 Kick];
        flagFR = [flagFR '/6'];
        
    elseif Time(1) > 0 & Time(1) < (1/FrameRate);
        Time = 0 : 1/FrameRate : Time(end);
        Distance = [0 Distance];
        Breath = [0 Breath];
        Stroke = [0 Stroke];
        Breakout = [0 Breakout];
        Kick = [0 Kick];
        flagFR = [flagFR '/7'];
    end;

    flag_TimeIssue{count,1} = fileECin;
    flag_TimeIssue{count,1} = flagFR;


    [num2str(count) '  /  ' num2str(length(fileListAWS))]
end;

%save flags
save('C:\Users\cramm\flagsFR.mat', 'flag_TimeIssue');





