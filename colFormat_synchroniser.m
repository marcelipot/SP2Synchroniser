ColWidth{1} = 20; %CheckBox
ColWidth{2} = 150; %Name
ColWidth{3} = 50; %Distance
ColWidth{4} = 70; %Stroke
ColWidth{5} = 50; %Gender
ColWidth{6} = 80; %Round
ColWidth{7} = 160; %Meet
if ispc == 1;
    ColWidth{8} = 30; %Year
    ColWidth{9} = 40; %Lane
elseif ismac == 1;
    ColWidth{8} = 40; %Year
    ColWidth{9} = 45; %Lane
end;

ColWidth{10} = 40; %Course
ColWidth{11} = 65; %Type
ColWidth{12} = 50; %Category
ColWidth{13} = 60; %Age Group
ColWidth{14} = 60; %Race Time
if ispc == 1;
    ColWidth{15} = 45; %Skills
    ColWidth{16} = 70; %Free Swim
    ColWidth{17} = 65; %Drop-off
    ColWidth{18} = 130; %Max. Speed
    ColWidth{19} = 155; %Av. SR
    ColWidth{20} = 133; %Av. DPS
elseif ismac == 1;
    ColWidth{15} = 55; %Skills
    ColWidth{16} = 80; %Free Swim
    ColWidth{17} = 75; %Drop-off
    ColWidth{18} = 140; %Max. Speed
    ColWidth{19} = 165; %Av. SR
    ColWidth{20} = 143; %Av. DPS
end;
ColWidth{21} = 50; %Block
ColWidth{22} = 50; %Start
if ispc == 1;
    ColWidth{23} = 75; %Entry Dist
    ColWidth{24} = 115; %Start UW Speed
elseif ismac == 1;
    ColWidth{23} = 85; %Entry Dist
    ColWidth{24} = 125; %Start UW Speed
end;
ColWidth{25} = 110; %Start BO Dist
if ispc == 1;
    ColWidth{26} = 110; %Start BO Skill
elseif ismac == 1;
    ColWidth{26} = 120; %Start BO Skill
end;
ColWidth{27} = 65; %Av. Turn
ColWidth{28} = 110; %Turn App Skill
ColWidth{29} = 90; %Turn BO Dist
if ispc == 1;
    ColWidth{30} = 130; %Turn BO Skill
elseif ismac == 1;
     ColWidth{30} = 150; %Turn BO Skill
end;
ColWidthDisp = ColWidth(liColSelect);

ColFormat{1} = 'logical';
ColEdit(1) = true;
nCol = length(ColWidthDisp(1,:));
for col = 2:nCol;
    ColFormat{col} = 'char';
    ColEdit(col) = false;
end;