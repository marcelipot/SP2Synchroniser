%---Sort by column
if handles.sortbyCurrentSelection == 1;
    %sort by name
    classifier = uidDB(:,2);    
else;
    classifier = database(:,handles.sortbyCurrentSelection);
end;
sortbyCurrentSelectionRaw = get(handles.popSort_sync, 'value');

charCol = [1 3 4 5 6 8 10 11 12];
timeCol = [13 14 15];
otherCol = [16 17 18 19];
li = find(charCol == sortbyCurrentSelectionRaw);
if isempty(li) == 0;
    %characters
    [output, index] = sort(classifier);
else;
    li2 = find(timeCol == sortbyCurrentSelectionRaw);
    if isempty(li2) == 0;
        %time
        timeEC = [];
        for i = 1:length(database(:,1));
            val = classifier{i,1};
            liSec = strfind(val, 's');
            if isempty(liSec) == 0;
                timeEC(i,1) = str2num(val(1:5));
            else;
                lidot = strfind(val, ':');
                min = str2num(val(1:lidot-1)).*60;
                sec = str2num(val(lidot+1:lidot+3));
                hun = str2num(['0.' val(end-1:end)]);
                timeEC(i,1) = min+sec+hun;
            end;
        end;
        classifier = timeEC;
        [output, index] = sort(classifier, 'ascend');

    else;
        li3 = find(otherCol == sortbyCurrentSelectionRaw);
        if isempty(li3) == 0;
           %other columns
           if sortbyCurrentSelectionRaw == 16;
               timeEC = [];
               for i = 1:length(database(:,1));
                   val = classifier{i,1};
                   if strcmpi(val, 'na');
                       timeEC(i) = 10000;
                   else;
                       if strcmpi(val(1), '+');
                           timeEC(i) = str2num(val(2:end));
                       else;
                           timeEC(i) = str2num(val);
                       end;
                   end;
               end;
               classifier = timeEC;
               [output, index] = sort(classifier, 'ascend');

           elseif sortbyCurrentSelectionRaw == 17;
               speedEC = [];
               for i = 1:length(database(:,1));
                   val = classifier{i,1};
                   if strcmpi(val, 'na');
                       speedEC(i) = 0;
                   else;
                       lislash = strfind(val, '/');
                       speedEC(i) = str2num(val(lislash+2:lislash+5));
                   end;
               end;
               classifier = speedEC;
               [output, index] = sort(classifier, 'descend');

           elseif sortbyCurrentSelectionRaw == 18;
               SREC = [];
               for i = 1:length(database(:,1));
                   val = classifier{i,1};
                   if strcmpi(val, 'na');
                       SREC(i) = 0;
                   else;
                       lislash = strfind(val, '/');
                       SREC(i) = str2num(val(lislash+2:lislash+6));
                   end;
               end;
               classifier = SREC;
               [output, index] = sort(classifier, 'descend');

           elseif sortbyCurrentSelectionRaw == 19;
               DPSEC = [];
               for i = 1:length(database(:,1));
                   val = classifier{i,1};
                   if strcmpi(val, 'na');
                       DPSEC(i) = 0;
                   else;
                       lislash = strfind(val, '/');
                       DPSEC(i) = str2num(val(lislash+2:lislash+5));
                   end;
               end;
               classifier = DPSEC;
               [output, index] = sort(classifier, 'descend');

           end;
        else;
           %number
           %isolate the number
           if sortbyCurrentSelectionRaw+1 == 30 | sortbyCurrentSelectionRaw+1 == 26;
               BOeff = [];
               for i = 1:length(database(:,1));
                   val = classifier{i,1};
                   if strcmpi(val, 'na');
                       BOeff(i) = -1000;
                   else;
                       lislash = strfind(val, '/');
                       lislash = lislash(end);
                       librack = strfind(val, ']');
                       content = val(lislash+1:librack-1);
                       if strcmpi(content, 'NaN00') == 1;
                           BOeff(i) = -1000;
                       else;
                           if findstr(content, 'NaN') == 1;
                               BOeff(i) = NaN;
                           else;
                               BOeff(i) = str2num(content);
                           end;
                       end;
                   end;
               end;
               classifier = BOeff;
           elseif sortbyCurrentSelectionRaw+1 == 28;
               Appeff = [];
               for i = 1:length(database(:,1));
                   val = classifier{i,1};
                   if strcmpi(val, 'na');
                       Appeff(i) = -1000;
                   else;
                       lislash = strfind(val, ' ');
                       lislash = lislash(1);
                       content = val(1:lislash-1);
                       if strcmpi(content, 'NaN00') == 1;
                           Appeff(i) = -1000;
                       else;
                           Appeff(i) = str2num(content);
                       end;
                   end;
               end;
               classifier = Appeff;
           else;
               if sortbyCurrentSelectionRaw == 2 ...
                       | sortbyCurrentSelectionRaw == 20 | sortbyCurrentSelectionRaw == 21 ...
                       | sortbyCurrentSelectionRaw == 22 | sortbyCurrentSelectionRaw == 23 ...
                       | sortbyCurrentSelectionRaw == 24 | sortbyCurrentSelectionRaw == 26 ...
                       | sortbyCurrentSelectionRaw == 28;
                   val = [];
                   for i = 1:length(database(:,1));
                       if strcmpi(classifier{i}, 'na');
                           if sortbyCurrentSelectionRaw == 26;
                               val(i,1) = 1000;
                           end;
                       else;

                           txt = classifier{i};
                           index = strfind(txt, ' ');
                           txt = txt(1:index-1);

                           if isempty(txt) == 1;
                               val(i,1) = 1000;
                           else;
                               val(i,1) = str2num(txt);
                           end;
                       end;
                   end;
                   classifier = val;
               else;
                   classifier = cell2mat(classifier);
               end;
           end;
           
           if sortbyCurrentSelectionRaw == 22 | ...
                   sortbyCurrentSelectionRaw == 23 | ...
                   sortbyCurrentSelectionRaw == 24 | ...
                   sortbyCurrentSelectionRaw == 25 | ...
                   sortbyCurrentSelectionRaw == 27 | ...
                   sortbyCurrentSelectionRaw == 28 | ...
                   sortbyCurrentSelectionRaw == 29;

               [output, index] = sort(classifier, 'descend');
           else;
               [output, index] = sort(classifier, 'ascend');
           end;
        end;
    end;
end;
% handles.SortingIndex_database = index;

for i = 1:length(index);
    uidsearch = database(index(i),1);
    liuid = find(strcmpi(handles.uidDB(:,1), uidsearch) == 1);
    handles.SortingIndex_database(i) = liuid(1);
end;
database = database(index,:);


% [nRaw, nCol] = size(handles.FullDB(:,liColSelect));
% database2 = {};
% database2(1,:) = handles.FullDB(1,liColSelect);
% database2(2:nRaw,:) = database;
[nRaw, nCol] = size(database);
database2 = {};
database2(1,:) = handles.FullDB(1,liColSelect);
database2(2:nRaw+1,:) = database;


