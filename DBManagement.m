%Remove doubles and others from the FullDB and uidDB
for nameIter = 1:length(AthletesDB.Names);

    FullDB2 = [];
    uidDB2 = [];
    nameEC = [AthletesDB.Names{nameIter,1} ' ' AthletesDB.Names{nameIter,2}];

    if strcmpi(lower(nameEC), lower('-- unknown athlete --'));
        %do nothing
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('-- unknown athlete 1 --'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('-- unknown athlete 2 --'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('-- unknown athlete 3 --'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('-- unknown athlete 4 --'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('AIS Admin'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin1'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin2'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin3'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin4'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin5'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin6'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin7'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin8'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin9'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin10'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin11'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin12'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin13'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin14'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin15'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin16'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin17'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin18'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin19'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin20'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin21'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin22'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin23'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin24'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin25'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin26'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin27'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin28'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin29'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('women dolphin30'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin1'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin2'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin1'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin2'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin3'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin4'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin5'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin6'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin7'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin8'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin9'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin10'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin11'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin12'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin13'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin14'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin15'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin16'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin17'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin18'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin19'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin20'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin21'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin21'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin22'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin23'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin24'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin25'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin26'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin27'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin28'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin29'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('men dolphin30'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe1'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe2'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe3'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe4'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe5'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe6'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe7'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe8'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe9'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe10'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe11'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe12'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe13'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe14'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe15'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe16'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe17'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe18'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe19'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('John Doe20'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe1'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe2'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe3'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe4'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe5'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe6'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe7'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe8'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe9'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe10'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe11'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe12'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe13'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe14'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe15'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe16'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe17'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe18'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe19'));
        %remove all entries
        proceed = 'remove';

    elseif strcmpi(lower(nameEC), lower('Jane Doe20'));
        %remove all entries
        proceed = 'remove';

    else;
        %remove all entries
        proceed = 'double';

    end;
        

    if strcmpi(proceed, 'double');
        IndexNonDouble = [];
        IndexDouble = [];
        Index = find(contains(FullDB(:,2),nameEC));
        process = 1;
        if isempty(Index) == 0;
            if length(Index) ~= 1;
                while process == 1;
                    distanceName = FullDB{Index(1),3};
                    strokeName = FullDB{Index(1),4};
                    genderName = FullDB{Index(1),5};
                    roundName = FullDB{Index(1),6};
                    meetName = FullDB{Index(1),7};
                    yearName = FullDB{Index(1),8};
                    laneName = FullDB{Index(1),9};
                    courseName = FullDB{Index(1),10};
                    typeName = FullDB{Index(1),11};
                    categoryName = FullDB{Index(1),12};
                    relayName = FullDB{Index(1),53};
                    raceTime = FullDB{Index(1),14};
                    li = strfind(raceTime, 's');
                    if isempty(li) == 1;
                        %minute format
                        li = strfind(raceTime, ':');
                        minutestr = raceTime(1:li(1)-1);
                        secondstr = raceTime(li(1)+1:end);
                        secondformat = (str2num(minutestr).*60) + str2num(secondstr);
                    else;
                        %second format;
                        li = strfind(raceTime, 's');
                        secondformat = str2num(raceTime(1:li(1)-2));
                    end;
                    skillTime = FullDB{Index(1),15};
                    li = strfind(skillTime, 's');
                    if isempty(li) == 1;
                        %minute format
                        li = strfind(skillTime, ':');
                        minutestr = skillTime(1:li(1)-1);
                        secondstr = skillTime(li(1)+1:end);
                        secondformatskill = (str2num(minutestr).*60) + str2num(secondstr);
                    else;
                        %second format;
                        li = strfind(skillTime, 's');
                        secondformatskill = str2num(skillTime(1:li(1)-2));
                    end;
        
                    statusDouble = 'no';
                    for i = 2:length(Index);
                        rawSearch = FullDB(Index(i),:);
                        IndexSearch = find(contains(rawSearch(:,3),distanceName) & ...
                            strcmpi(rawSearch(:,4),strokeName) & ...
                            strcmpi(rawSearch(:,5),genderName) & ...
                            strcmpi(rawSearch(:,6),roundName) & ...
                            strcmpi(rawSearch(:,7),meetName) & ...
                            strcmpi(rawSearch(:,8),yearName) & ...
                            strcmpi(rawSearch(:,9),laneName) & ...
                            strcmpi(rawSearch(:,10),courseName) & ...
                            strcmpi(rawSearch(:,11),typeName) & ...
                            strcmpi(rawSearch(:,12),categoryName) & ...
                            strcmpi(rawSearch(:,53),relayName));
        
                        if isempty(IndexSearch) == 0;
                            %Final check is race time
                            raceTimeCheck = rawSearch{1,14};
                            li = strfind(raceTimeCheck, 's');
                            if isempty(li) == 1;
                                %minute format
                                li = strfind(raceTimeCheck, ':');
                                minutestr = raceTimeCheck(1:li(1)-1);
                                secondstr = raceTimeCheck(li(1)+1:end);
                                secondformatCheck = (str2num(minutestr).*60) + str2num(secondstr);
                            else;
                                %second format;
                                li = strfind(raceTimeCheck, 's');
                                secondformatCheck = str2num(raceTimeCheck(1:li(1)-2));
                            end;
                            if secondformatCheck <= secondformat+0.01 & secondformatCheck >= secondformat-0.01;
                                %times are the same... same race
                                
                                skillTimeCheck = rawSearch{1,15};
                                li = strfind(skillTimeCheck, 's');
                                if isempty(li) == 1;
                                    %minute format
                                    li = strfind(skillTimeCheck, ':');
                                    minutestr = skillTimeCheck(1:li(1)-1);
                                    secondstr = skillTimeCheck(li(1)+1:end);
                                    secondformatCheck = (str2num(minutestr).*60) + str2num(secondstr);
                                else;
                                    %second format;
                                    li = strfind(skillTimeCheck, 's');
                                    secondformatCheck = str2num(skillTimeCheck(1:li(1)-2));
                                end;

                                if secondformatCheck <= secondformatskill+0.01 & secondformatCheck >= secondformatskill-0.01;
                                    i
                                    statusDouble = 'yes';
                                end;
                            end;
                        end;
                    end;
                    if strcmpi(statusDouble, 'no');
                        IndexNonDouble = [IndexNonDouble Index(1)];
                    else;
                        Index(1)
                        IndexDouble = [IndexDouble Index(1)];
                    end;
                    if length(Index) == 2;
                        process = 0;
                        IndexNonDouble = [IndexNonDouble Index(end)];
                    else;
                        Index = Index(2:end);
                    end;
                end;

                keepraw = [];
                for i = 1:length(FullDB(:,1));
	                findIndex = find(IndexDouble == i);
	                if isempty(findIndex) == 1;
		                keepraw = [keepraw i];
                    else;
                        FullDB(i,1:15)
	                end;
                end;
                FullDB2 = FullDB(keepraw,:);
                FullDB = FullDB2;
        
                IndexDouble2 = IndexDouble-1;
                keepraw = [];
                for i = 1:length(uidDB(:,1));
	                findIndex = find(IndexDouble2 == i);
	                if isempty(findIndex) == 1;
		                keepraw = [keepraw i];
	                end;
                end;
                uidDB2 = uidDB(keepraw,:);
                uidDB = uidDB2;

            end;
        end;

        

        clear ans;
        clear categoryName;
        clear cnameEC;
        clear courseName;
        clear distanceName;
        clear findIndex;
        clear FullDB2;
        clear genderName;
        clear i;
        clear Index;
        clear IndexDouble;
        clear IndexDouble2;
        clear IndexNonDouble;
        clear IndexSearch;
        clear keepraw;
        clear laneName;
        clear meetName;
        clear minutestr;
        clear nameEC;
        clear nameIter;
        clear proceed;
        clear process;
        clear raceTime;
        clear raceTimeCheck;
        clear rawSearch;
        clear relayName;
        clear roundName;
        clear secondformat;
        clear secondformatCheck;
        clear secondstr;
        clear statusDouble;
        clear strokeName;
        clear typeName;
        clear uidDB2;
        clear yearName;

    elseif strcmpi(proceed, 'remove');
        Index = find(contains(FullDB(:,2),nameEC));


        if isempty(Index) == 0
            nameEC

        end;

        keepraw = [];
        for i = 1:length(FullDB(:,1));
	        findIndex = find(Index == i);
	        if isempty(findIndex) == 1;
		        keepraw = [keepraw i];
	        end;
        end;
        FullDB2 = FullDB(keepraw,:);
        FullDB = FullDB2;
        
        Index = Index-1;
        keepraw = [];
        for i = 1:length(uidDB(:,1));
	        findIndex = find(Index == i);
	        if isempty(findIndex) == 1;
		        keepraw = [keepraw i];
	        end;
        end;
        uidDB2 = uidDB(keepraw,:);
        uidDB = uidDB2;

        clear uidDB2;
        clear FullDB2;
        clear keepraw;
        clear proceed;
        clear findIndex;
        clear Index;
        clear i;

    elseif strcmpi(proceed, 'nothing');

    end;
end;



% %Remove meets from AgeGroup
% meet2remove{1,1} = 'A274724_2018A';
% meet2remove{2,1} = 'A274724_2019A';
% meet2remove{3,1} = 'A274725_2019A';
% meet2remove{4,1} = 'A274724_2020A';
% meet2remove{5,1} = 'A274812_2020A';
% meet2remove{6,1} = 'A274725_2020A';
% meet2remove{7,1} = 'A274725_2021A';
% meet2remove{8,1} = 'A274812_2022A';
% meet2remove{9,1} = 'A365146_2023A';
% meet2remove{10,1} = 'A368206_2023A';
% meet2remove{11,1} = 'A368203_2023A';
% meet2remove{12,1} = 'A368205_2023A';
% meet2remove{13,1} = 'A274812_2023A';
% meet2remove{14,1} = 'A368202_2023A';
% 
% 
% meetDBnumber = [];
% meetDBname = {};
% % for i = 1:length(MeetDB);
% %     meetDBnumber(i,1) = MeetDB{i,2};
% %     meetDBname{i,1} = MeetDB{i,1};;
% % end;
% 
% listMeet = fields(AgeGroup);
% AgeGroupNew = struct;
% for i = 1:length(listMeet);
%     meetEC = listMeet{i,1};
%     li = find(contains(meet2remove,meetEC));
%     if isempty(li) == 1;
%         %keep that meet
%         eval(['AgeGroupNew.' meetEC ' = AgeGroup.' meetEC ';']);
%     end;
% end;
% AgeGroup = AgeGroupNew;
% 
% clear AgeGroupNew;
% clear ans;
% clear i;
% clear li;
% clear listMeet;
% clear meet2remove;
% clear meetDBname;
% clear meetDBnumber;
% clear meetEC;




% %Revert onlinefilename for SP1 races
% part1 = 'aws configure set aws_access_key_id AKIARMARPY3XJ6R7X7OV';
% part2 = 'aws configure set aws_secret_access_key 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';
% part3 = 'aws configure set default.region ap-southeast-2';
% command = [part1 ' & ' part2 ' & ' part3];
% [status, out] = system(command);
% 
% command = 'aws s3 ls s3://sparta2-prod/sparta2-data/ --recursive';
% [status, out] = system(command);
% liSP2 = findstr(out,'sparta2');
% liMAT = findstr(out,'.mat');
% fileList = {};
% for line = 1:length(liMAT);
%     valEC = liMAT(line);
%     li1 = find(liSP2 - valEC < 0);
%     sortSP2 = liSP2(li1(end));
%     fileList{line,1} = ['s3://sparta2-prod/' out([sortSP2:valEC+4])];
% end;
% 
% iter = 0;
% for line = 1:length(fileList(:,1));
% 
%     [num2str(line) ' / ' num2str(length(fileList(:,1)))]
% 
% 
%     fileECin = fileList{line};
%     fileECin = fileECin(1:end-1);
%     index = strfind(fileECin, '/');
%     if ispc == 1;
%         MDIR = getenv('USERPROFILE');
%         fileECout = [MDIR '\SP2Synchroniser\' fileECin(index(end)+1:end)];
%     elseif ismac == 1;
%         fileECout = ['/Applications/SP2Synchroniser/' fileECin(index(end)+1:end)];
%     end;
%     command = ['aws s3 cp ' fileECin ' ' fileECout];
%     [status, out] = system(command);
% 
%     load(fileECout);
% 
%     if ispc == 1;
%         command = ['del ' fileECout];
%     else;
%         command = ['rm ' fileECout];
%     end;
%     [status, cmdout] = system(command);
% 
%     onlineName = fileECin(index(end)+1:end-4);
%     eval(['Source = ' onlineName '.Source;']);
%     if Source == 1;
%         eval(['Firstname = ' onlineName '.Firstname;']);
%         eval(['Lastname = ' onlineName '.Lastname;']);
%         athleteName = [Firstname ' ' Lastname];
%         eval(['distanceName = ' onlineName '.RaceDist;']);
%         distanceName = num2str(distanceName);
%         eval(['strokeName = ' onlineName '.StrokeType;']);
%         eval(['genderName = ' onlineName '.Gender;']);
%         eval(['roundName = ' onlineName '.Stage;']);
%         eval(['meetName = ' onlineName '.Meet;']);
%         eval(['yearName = ' onlineName '.Year;']);
%         eval(['laneName = ' onlineName '.Lane;']);
%         eval(['courseName = ' onlineName '.Course;']);
%         courseName = num2str(courseName);
%         eval(['typeName = ' onlineName '.valRelay;']);
%         eval(['relayName = ' onlineName '.detailRelay;']);
%         eval(['SplitsAll = ' onlineName '.SplitsAll;']);
%         raceTime = SplitsAll(end,2);
%         onlineNameSave = onlineName;
% 
%         IndexSearch = find(contains(FullDB(:,3),distanceName) & ...
%             strcmpi(FullDB(:,2),athleteName) & ...
%             contains(FullDB(:,4),strokeName) & ...
%             contains(FullDB(:,5),genderName) & ...
%             strcmpi(FullDB(:,6),roundName) & ...
%             strcmpi(FullDB(:,7),meetName) & ...
%             contains(FullDB(:,8),yearName) & ...
%             contains(FullDB(:,9),laneName) & ...
%             contains(FullDB(:,10),courseName) & ...
%             contains(FullDB(:,11),typeName) & ...
%             contains(FullDB(:,53),relayName));
% 
%         if isempty(IndexSearch) == 0;
%             li = strfind(onlineName,'_');
%             onlineName(li) = '-';
%             FullDB{IndexSearch,1} = onlineName(2:end-1);
%             uidDB{IndexSearch,1} = onlineName(2:end-1);
% 
%             iter = iter + 1;
%         end;
%     end;
%     eval(['clear ' onlineNameSave ';'])
% end;





