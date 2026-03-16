if ispc == 1;
    font1 = 12;
    font2 = 11;
    font3 = 9.5;
    font4 = 10;
    font5 = 8.5;
elseif ismac == 1;
    font1 = 15;
    font2 = 14;
    font3 = 12.5
    font4 = 13;
    font5 = 11.5;
end;

%---Create line on the top
handles.lineTop_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [0, 680, 1280, 1], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);

%---create logo_aargos
handles.logo_aargos_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [10, 15, 130, 35], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.logo_AARGOS);

%---create SA logo
handles.logo_sa_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1090, 10, 150, 50], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.logo_SAL);

% % set(handles.txtpage, 'string', 'Database');
% %---create question icone
% handles.Question_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [10, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
% imshow(handles.icones.question_offb);
% 
% %---create download data icone
% handles.Downloaddata_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [45, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
% imshow(handles.icones.downloaddata_offb);
% 
% %---create download raw icone
% handles.Downloadraw_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [80, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
% imshow(handles.icones.downloadraw_offb);
% 
% %---create download benchmark benchmark icon
% handles.Downloadbenchmark_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [115, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
% imshow(handles.icones.downloadbenchmark_offb);
% 
% %---create download AMS icon
% handles.DownloadAMS_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [150, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
% imshow(handles.icones.AMS_offb);

%---Delete entry database
handles.DeleteDB_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [10, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.deleteDB_offb);

%---Show duplicate entries database
handles.DuplicateDB_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [45, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.duplicate_offb);

%---Show open JSON
handles.OpenJSON_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [80, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.OpenJSON_offb);

%---Show open JSON
handles.OpenMAT_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [115, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.OpenMAT_offb);




%---GreenEye database
handles.DownloadGE_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1000, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.GE_offb);

%---SP1 database
handles.DownloadSP1_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1035, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.SP1_offb);

%---Swimmer database
handles.Downloadpeople_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1070, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.people_offb);




%---create download timer
handles.Downloadtimer_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1105, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.cloudTimer_offb);

%---create download all
handles.Downloadall_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1140, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.cloudall_offb);

%---create download new
handles.Downloadnew_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1175, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.cloudnew_offb);

%---create download selected
handles.Downloadselect_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1210, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.cloudselect_offb);

%---create arrow back icone
handles.Arrowback_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1245, 685, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.arrow_back_offb);


%---database display options
handles.databasedisplayoptions_sync = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 455, 150, 220], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Display Options', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.databasedisplayoptions_sync, 'fontunits', 'normalized');

handles.txtColumn_sync = uicontrol('parent', handles.databasedisplayoptions_sync, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 182, 145, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, ...
    'String', 'Column Selection:');
set(handles.txtColumn_sync, 'fontunits', 'normalized');


listDrop = {'Name', 'Distance', 'Stroke', 'Gender', 'Round', 'Meet', 'Year', 'Lane', 'Course', 'Type', 'Category', 'Age Group', 'Race Time', 'Skill Time', ...
    'Swim Time', 'Drop-off Time', 'Max. Speed', 'Max. SR', 'Max. DPS', 'Block', 'Start Time', ...
    'Entry Distance', 'Start UW Speed', 'Start BO. Distance', 'Start BO. Skill', 'Turn Time', 'Turn App. Skill', 'Turn BO. Distance', 'Turn BO. Skill'};
jList = java.util.ArrayList;
for i = 1:length(listDrop);
    jList.add(i-1, listDrop{i});
end;
handles.listDropCol = listDrop;

jCBList = com.mathworks.mwswing.checkboxlist.CheckBoxList(jList);
c = mat2cell([0.2 0.2 0.2], 1, [1,1,1]);
jCBList.setBackground(java.awt.Color(c{:}));
c = mat2cell([1 1 1], 1, [1,1,1]);
jCBList.setForeground(java.awt.Color(c{:}));
jCBList.setFont(java.awt.Font('TimesRoman',java.awt.Font.ITALIC, 14));

jScrollPane = com.mathworks.mwswing.MJScrollPane(jCBList);
[jhCBList, hContainer] = javacomponent(jScrollPane, [10, 60, 130, 120], handles.databasedisplayoptions_sync);
handles.jhCBList_database = jhCBList;

jCBModel = jCBList.getCheckModel;
jCBModel.checkAll;
handles.checkedColDisp = ones(length(listDrop),1);

jhCBModel = handle(jCBModel, 'CallbackProperties');
set(jhCBModel, 'ValueChangedCallback', @DBDisplayColumn_synchroniser);
handles.jCBModel = jCBModel;
handles.jCBList = jCBList;
% jCBModel.uncheckIndex(1);
% jCBModel.uncheckIndex(3);

handles.txtSort_sync = uicontrol('parent', handles.databasedisplayoptions_sync, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 35, 145, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, ...
    'String', 'Sort by:');
set(handles.txtSort_sync, 'fontunits', 'normalized');

if ismac == 1;
    handles.popSort_sync = uicontrol('parent', handles.databasedisplayoptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', 'position', [10, 10, 130, 20], ...
        'String', listDrop, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @sortby_synchroniser);
elseif ispc == 1;
    handles.popSort_sync = uicontrol('parent', handles.databasedisplayoptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', 'position', [10, 10, 130, 20], ...
        'String', listDrop, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], 'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @sortby_synchroniser);
end;
handles.sortbyCurrentSelection = 1;
handles.sortbyPreviousSelection = 1;
handles.sortbyExceptionSelection = 1;
set(handles.popSort_sync, 'fontunits', 'normalized');


%---database filter options
handles.databasefilteroptions_sync = uipanel('parent', handles.hf_w1_welcome, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 100, 150, 350], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Filter Options', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles.databasefilteroptions_sync, 'fontunits', 'normalized');

handles.txtfilter_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [5, 310, 145, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, ...
    'String', 'Filter by:');
set(handles.txtfilter_sync, 'fontunits', 'normalized');

handles.filteredit_meet_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 285, 130, 20], 'Callback', @filtereditmeet_synchroniser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font3, 'String', 'Meet', ...
    'tooltipstring', ['Use ' '''' ';' '''' ' to add multiple strings']);
set(handles.filteredit_meet_sync, 'fontunits', 'normalized');

handles.filteredit_year_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 260, 130, 20], 'Callback', @filteredityear_synchroniser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font3, 'String', 'Year', ...
    'tooltipstring', ['Use ' '''' ';' '''' ' to add multiple strings']);
set(handles.filteredit_year_sync, 'fontunits', 'normalized');

handles.filteredit_name_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Edit', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 235, 130, 20], 'Callback', @filtereditname_synchroniser, ...
    'BackgroundColor', [0.4 0.4 0.4], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font3, 'String', 'Name', ...
    'tooltipstring', ['Use ' '''' ';' '''' ' to add multiple strings']);
set(handles.filteredit_name_sync, 'fontunits', 'normalized');

listpopGender = {'Gender', 'Male', 'Female'};
listpopType = {'Swim Type', 'Final', 'SemiFinal', 'Heat', 'SwimOff', 'TimeTrial'};
listpopStroke = {'Stroke Type', 'Butterfly', 'Backstroke', 'Breaststroke', 'Freestyle', 'Medley'};
listpopDistance = {'Distance', '50m', '100m', '200m', '400m', '800m', '1500m', '4x50m', '4x100m', '4x200m'};
listpopPool = {'Pool Type', 'SCM', 'LCM'};
listpopGroup = {'Category', 'Able', 'Para'};
listpopRelay = {'Race Type', 'Flat', 'Relay'};
listpopAge = {'Age Group', 'Open', 'Under18', 'Under17', 'Under16', 'Under15',  'Under14'};
listpopTime = {'All times', 'PBs only'};

handles.listpopGender = listpopGender;
handles.listpopType = listpopType;
handles.listpopStroke = listpopStroke;
handles.listpopDistance = listpopDistance;
handles.listpopPool = listpopPool;
handles.listpopGroup = listpopGroup;
handles.listpopRelay = listpopRelay;
handles.listpopAge = listpopAge;
handles.listpopTime = listpopTime;

if ismac == 1;
    handles.filterpop_gender_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 210, 130, 20], 'String', listpopGender, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopgender_synchroniser);

    handles.filterpop_type_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 185, 130, 20], 'String', listpopType, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpoptype_synchroniser);

    handles.filterpop_stroke_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 160, 130, 20], 'String', listpopStroke, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopstroke_synchroniser);

    handles.filterpop_distance_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 135, 130, 20], 'String', listpopDistance, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopdistance_synchroniser);

    handles.filterpop_pool_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 110, 130, 20], 'String', listpopPool, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpoppool_synchroniser);

    handles.filterpop_category_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 85, 130, 20], 'String', listpopGroup, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopgroup_synchroniser);

    handles.filterpop_relay_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 60, 130, 20], 'String', listpopRelay, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpoprelay_synchroniser);

    handles.filterpop_group_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 35, 130, 20], 'String', listpopAge, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopgroup_synchroniser);

    handles.filterpop_time_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 10, 130, 20], 'String', listpopTime, 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpoptime_synchroniser);
    
elseif ispc == 1;
    handles.filterpop_gender_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 210, 130, 20], 'String', listpopGender, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopgender_synchroniser);

    handles.filterpop_type_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 185, 130, 20], 'String', listpopType, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpoptype_synchroniser);

    handles.filterpop_stroke_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 160, 130, 20], 'String', listpopStroke, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopstroke_synchroniser);

    handles.filterpop_distance_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 135, 130, 20], 'String', listpopDistance, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopdistance_synchroniser);

    handles.filterpop_pool_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 110, 130, 20], 'String', listpopPool, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpoppool_synchroniser);

    handles.filterpop_category_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 85, 130, 20], 'String', listpopGroup, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopgroup_synchroniser);

    handles.filterpop_relay_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 60, 130, 20], 'String', listpopRelay, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpoprelay_synchroniser);

    handles.filterpop_group_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 35, 130, 20], 'String', listpopAge, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpopagegroup_synchroniser);

    handles.filterpop_time_sync = uicontrol('parent', handles.databasefilteroptions_sync, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', ...
        'position', [10, 10, 130, 20], 'String', listpopTime, 'ForegroundColor', [1 1 1], 'BackgroundColor', [0 0 0], ...
        'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font3, 'Callback', @filterpoptime_synchroniser);
end;
handles.SearchMeet = [];
handles.SearchYear = [];
handles.SearchName = [];
handles.SearchMeet = [];
handles.SearchGender = [];
handles.SearchSwimType = [];
handles.SearchStrokeType = [];
handles.SearchDistance = [];
handles.SearchPoolType = [];
handles.SearchCategory = [];
handles.SearchRaceType = [];
handles.SearchAgeGroup = [];
handles.SearchPB = [];

set(handles.filterpop_gender_sync, 'fontunits', 'normalized');
set(handles.filterpop_type_sync, 'fontunits', 'normalized');
set(handles.filterpop_stroke_sync, 'fontunits', 'normalized');
set(handles.filterpop_distance_sync, 'fontunits', 'normalized');
set(handles.filterpop_pool_sync, 'fontunits', 'normalized');
set(handles.filterpop_category_sync, 'fontunits', 'normalized');
set(handles.filterpop_relay_sync, 'fontunits', 'normalized');
set(handles.filterpop_group_sync, 'fontunits', 'normalized');
set(handles.filterpop_time_sync, 'fontunits', 'normalized');

%---create validate icone
handles.Validate_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [52, 65, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.validate_offb);

%---create clear icone
handles.Redcross_button_sync = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [88, 65, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.redcross_offb);


%---create summary table
handles.databasemain_table_sync = uitable('parent', handles.hf_w1_welcome, 'Visible', 'on', 'units', 'pixels', 'FontName', 'Antiqua', 'FontSize', font4, ...
    'FontWeight', 'Bold', 'position', [170 65 1100 610], 'ColumnEditable', false, 'ColumnName', [], 'RowName', [], 'RowStriping', 'on');
% set(handles.SummaryData_table_analyser, 'fontunits', 'normalized');

%---Edit display table
handles.tabledisplaytxt1_sync = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [175, 37, 100, 20], 'HorizontalAlignment', 'left', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font5, ...
    'String', 'Display Results :');
set(handles.tabledisplaytxt1_sync, 'fontunits', 'normalized');

if ismac == 1;
    handles.popDisplayResults_sync = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', 'position', [270, 40, 200, 20], ...
        'String', 'None', 'ForegroundColor', [0 0 0], 'BackgroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font5, 'Callback', @displayresults_synchroniser, 'enable', 'off');
elseif ispc == 1;
    handles.popDisplayResults_sync = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Popupmenu', 'Visible', 'on', 'units', 'pixels', 'position', [270, 40, 150, 20], ...
        'String', 'None', 'ForegroundColor', [1 1 1], 'BackgroundColor', [0.2 0.2 0.2], 'FontName', 'Book Antiqua', 'FontWeight', 'Bold', 'Fontsize', font5, 'Callback', @displayresults_synchroniser, 'enable', 'off');
end;
set(handles.popDisplayResults_sync, 'fontunits', 'normalized');


%---hide axes
% set(allchild(handles.Question_button_sync), 'Visible', 'off');
% set(allchild(handles.Downloaddata_button_sync), 'Visible', 'off');
% set(allchild(handles.Downloadraw_button_sync), 'Visible', 'off');
% set(allchild(handles.Downloadbenchmark_button_sync), 'Visible', 'off');
% set(allchild(handles.Downloadpeople_button_sync), 'Visible', 'off');
% set(allchild(handles.Downloadall_button_sync), 'Visible', 'off');
% set(allchild(handles.Downloadnew_button_sync), 'Visible', 'off');
% set(allchild(handles.Downloadselect_button_sync), 'Visible', 'off');
% set(allchild(handles.DownloadAMS_button_sync), 'Visible', 'off');
% set(allchild(handles.Arrowback_button_sync), 'Visible', 'off');
% set(allchild(handles.Validate_button_sync), 'Visible', 'off');
% set(allchild(handles.Redcross_button_sync), 'Visible', 'off');

%---reset the units
set(handles.lineTop_sync, 'units', 'normalized');
set(handles.logo_aargos_sync, 'units', 'normalized');
set(handles.logo_sa_sync, 'units', 'normalized');
% set(handles.Question_button_sync, 'units', 'normalized');
% set(handles.Downloaddata_button_sync, 'units', 'normalized');
% set(handles.Downloadraw_button_sync, 'units', 'normalized');
% set(handles.Downloadbenchmark_button_sync, 'units', 'normalized');
set(handles.DownloadSP1_button_sync, 'units', 'normalized');
set(handles.DownloadGE_button_sync, 'units', 'normalized');
% set(handles.DownloadAMS_button_sync, 'units', 'normalized');
set(handles.Downloadpeople_button_sync, 'units', 'normalized');
set(handles.Downloadtimer_button_sync, 'units', 'normalized');
set(handles.Downloadall_button_sync, 'units', 'normalized');
set(handles.Downloadnew_button_sync, 'units', 'normalized');
set(handles.Downloadselect_button_sync, 'units', 'normalized');
set(handles.DeleteDB_button_sync, 'units', 'normalized');
set(handles.DuplicateDB_button_sync, 'units', 'normalized');
set(handles.OpenJSON_button_sync, 'units', 'normalized');
set(handles.OpenMAT_button_sync, 'units', 'normalized');
set(handles.Arrowback_button_sync, 'units', 'normalized');
set(handles.databasedisplayoptions_sync, 'units', 'normalized');
set(handles.txtColumn_sync, 'units', 'normalized');
set(hContainer, 'Units', 'norm');
set(handles.txtSort_sync, 'units', 'normalized');
set(handles.popSort_sync, 'units', 'normalized');
set(handles.databasefilteroptions_sync, 'units', 'normalized');
set(handles.txtfilter_sync, 'units', 'normalized');
set(handles.filteredit_meet_sync, 'units', 'normalized');
set(handles.filteredit_year_sync, 'units', 'normalized');
set(handles.filteredit_name_sync, 'units', 'normalized');
set(handles.filterpop_gender_sync, 'units', 'normalized');
set(handles.filterpop_type_sync, 'units', 'normalized');
set(handles.filterpop_stroke_sync, 'units', 'normalized');
set(handles.filterpop_distance_sync, 'units', 'normalized');
set(handles.filterpop_pool_sync, 'units', 'normalized');
set(handles.filterpop_category_sync, 'units', 'normalized');
set(handles.filterpop_relay_sync, 'units', 'normalized');
set(handles.filterpop_group_sync, 'units', 'normalized');
set(handles.filterpop_time_sync, 'units', 'normalized');
set(handles.Validate_button_sync, 'units', 'normalized');
set(handles.Redcross_button_sync, 'units', 'normalized');
set(handles.databasemain_table_sync, 'units', 'normalized');
set(handles.tabledisplaytxt1_sync, 'units', 'normalized');
set(handles.popDisplayResults_sync, 'units', 'normalized');

