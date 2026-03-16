path = uigetdir;
content = dir(path);

[file, path] = uigetfile('*.xls','Athlete AMS ID');
if file == 0
    return;
end;
[AMSID, Names] = xlsread([path '\' file], 1);
Names = Names(2:end, 7:8);
AMSID = AMSID(:,1);

for i = 3:length(content);
    disp([num2str(i) '/' num2str(length(content))]);
    filename = [content(i).folder '\' content(i).name];
    dataEC = loadjson(filename);
    
    li = find(AMSID == dataEC.athleteId);
    if isempty(li);
        athletename = 'UnknownA';
    else;
        firstname = Names{li,1};
        lastname = Names{li,2};
        athletename = [lastname firstname(1)];
    end;
    
    meet = dataEC.competitionName;
    li = findstr(meet, ' ');
    if isempty(li) == 0;
        liop = [];
        for k = 1:length(meet);
            lik = find(li == k);
            if isempty(lik) == 1;
                liop = [liop k];
            end;
        end;
        meet = meet(liop);
    end;
    
    stage = dataEC.eventType;
    distance = dataEC.distance(1);
    year = dataEC.date;
    year = year(1:4);
    
    if strcmpi(dataEC.strokeType, 'Freestyle');
        stroke = 'FS';
    elseif strcmpi(dataEC.strokeType, 'Butterfly');
        stroke = 'BF';
    elseif strcmpi(dataEC.strokeType, 'Backstroke');
        stroke = 'BK';
    elseif strcmpi(dataEC.strokeType, 'Breaststroke');
        stroke = 'BR';
    end;
    
    lane = ['Lanes' num2str(dataEC.lane)];
    
    filenameNew =  [athletename '_' num2str(distance) stroke '_' stage '_' lane '_' meet year];
    filenameNew = [content(i).folder '\' filenameNew '.json'];
    movefile(filename, filenameNew);
end;


