resolution = get(0,'screensize');
resolution = resolution(3:4);

pos = [(resolution(1)-500)./2 (resolution(2)-100)./2 500 160];
handles2.hf_w2_welcome = figure('visible', 'on', 'menubar', 'none', 'toolbar', 'none', ...
    'windowstyle', 'normal', 'color', [0.1 0.1 0.1], 'units', 'pixels', 'position', pos);
%'CloseRequestFcn', 'handles2 = guidata(gcf); uiresume(handles2.hf_w2_welcome)'

set(handles2.hf_w2_welcome, 'Name', 'Synchronisation', 'NumberTitle', 'off');
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame=get(handle(handles2.hf_w2_welcome), 'javaframe');
    jicon=javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;

handles2.proceedprocess_main = uicontrol('parent', handles2.hf_w2_welcome, 'Style', 'Text', 'Visible', 'off', ...
    'String', 'initial', 'position', [1, 1, 10, 10]);

if ismac == 1;
    font1 = 15;
    font2 = 13;
elseif ispc == 1;
    font1 = 12;
    font2 = 10;
end;
handles2.txtProcessing_main = uicontrol('parent', handles2.hf_w2_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [1, 140, 499, 20], 'String', 'Synchronisation', ...
    'BackgroundColor', [0.1 0.1 0.1], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'HorizontalAlignment', 'center');
set(handles2.txtProcessing_main, 'fontunits', 'normalized');

txt = 'Updating Database:   ...';
handles2.txtNew_main = uicontrol('parent', handles2.hf_w2_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 90, 480, 20], 'String', txt, ...
    'BackgroundColor', [0.1 0.1 0.1], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'HorizontalAlignment', 'left');
set(handles2.txtNew_main, 'fontunits', 'normalized');

handles2.txtFileName_main = uicontrol('parent', handles2.hf_w2_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [20, 65, 480, 20], 'String', 'File :   ...', ...
    'BackgroundColor', [0.1 0.1 0.1], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'HorizontalAlignment', 'Left');
set(handles2.txtFileName_main, 'fontunits', 'normalized');

handles2.pushCancel_main = uicontrol('parent', handles2.hf_w2_welcome, 'Style', 'Push', 'Visible', 'on', 'units', 'pixels', ...
    'position', [170, 8, 60, 20], 'String', 'Cancel', 'callback', @cancelsynchTimer_synchroniser, ...
    'BackgroundColor', [0.1 0.1 0.1], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'HorizontalAlignment', 'center');
set(handles2.pushCancel_main, 'fontunits', 'normalized');

currentYear = year(datetime("today"));
for yearEC = 2018:currentYear;
    eval(['AllDB.uidDB_SP2_' num2str(yearEC) ' = handles.uidDB_SP2_' num2str(yearEC) ';']);
    eval(['AllDB.FullDB_SP2_' num2str(yearEC) ' = handles.FullDB_SP2_' num2str(yearEC) ';']);
    eval(['AllDB.AgeGroup_SP2_' num2str(yearEC) ' = handles.AgeGroup_SP2_' num2str(yearEC) ';']);
end;
AllDB.AthletesDB = handles.AthletesDB;
AllDB.ParaDB = handles.ParaDB;
AllDB.PBsDB = handles.PBsDB;
AllDB.PBsDB_SC = handles.PBsDB_SC;
AllDB.BenchmarkEvents = handles.BenchmarkEvents;
AllDB.isupdate = handles.isupdate;
AllDB.MeetDB = handles.MeetDB;
AllDB.RoundDB = handles.RoundDB;

handles2.pushStart_main = uicontrol('parent', handles2.hf_w2_welcome, 'Style', 'Push', 'Visible', 'on', 'units', 'pixels', ...
    'position', [270, 8, 60, 20], 'String', 'Start', 'callback', @startsynchTimer_synchroniser, ...
    'BackgroundColor', [0.1 0.1 0.1], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'HorizontalAlignment', 'center');
set(handles2.pushStart_main, 'fontunits', 'normalized');

handles2.TimerStart_main = timer('TimerFcn', @startsynchTimerMainFunction_synchroniser, 'StartDelay', 0, 'Period', 10, 'Name', 'TimerScan', ...
        'ExecutionMode', 'fixedRate', 'BusyMode', 'drop', 'StopFcn', []);

handles2.source_user = 'Update';
handles2.AllDB = AllDB;
handles2.colorrange = parula(256);
handles2.colorvalue = colormap(handles2.colorrange);

        
drawnow;
guidata(handles2.hf_w2_welcome, handles2);
uiwait(handles2.hf_w2_welcome);