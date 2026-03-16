function handles2 = create_AMSExportOption_database;


resolution = get(0,'ScreenSize');
resolution = resolution(1,3:4);
hdef = figure('units', 'pixels', 'position', [(resolution(1)-200)./2 (resolution(2)-100)./2 400 230], ...
    'Color', [0.1 0.1 0.1], 'resize', 'on', 'NumberTitle', 'off', 'name', 'Export Options', ...
    'menubar', 'none', 'toolbar', 'none', 'windowstyle', 'normal');
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    jFrame=get(handle(hdef), 'javaframe');
    jicon = javax.swing.ImageIcon([MDIR '\SP2Viewer\SpartaViewer_IconSoftware.png']);
    jFrame.setFigureIcon(jicon);
    clc;
end;

if ispc == 1;
    font1 = 13;
    font2 = 12;
elseif ismac == 1;
    font1 = 16;
    font2 = 14;
end;

handles2.AMSExportType = 1;
handles2.AMSExportHeader = 2;
handles2.AMSExportPath = [];


%---create the header selection panel
handles2.headerSelect_AMS = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 160, 380, 60], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Header format', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.headerSelect_AMS, 'fontunits', 'normalized', 'units', 'normalized');

handles2.radioHeader1Select_AMS = uicontrol('parent', handles2.headerSelect_AMS, 'Style', 'radiobutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, 5, 150, 40], 'string', '1 raw-header', 'callback', @radioHeader1_AMS, 'Value', 0, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
set(handles2.radioHeader1Select_AMS, 'fontunits', 'normalized', 'units', 'normalized');

handles2.radioHeader2Select_AMS = uicontrol('parent', handles2.headerSelect_AMS, 'Style', 'radiobutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [220, 5, 150, 40], 'string', '2 raws-header', 'callback', @radioHeader2_AMS, 'Value', 1, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
set(handles2.radioHeader2Select_AMS, 'fontunits', 'normalized', 'units', 'normalized');


%---create the segment length panel
handles2.segmentSelect_AMS = uipanel('parent', hdef, 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 90, 380, 60], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', ...
    'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'Title', 'Segment size (200m races and above)', 'ShadowColor', [0.7 0.7 0.7], ...
    'bordertype', 'etchedin');
set(handles2.segmentSelect_AMS, 'fontunits', 'normalized', 'units', 'normalized');

handles2.segment15Select_AMS = uicontrol('parent', handles2.segmentSelect_AMS, 'Style', 'radiobutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [30, 5, 150, 40], 'string', '15m segments', 'callback', @radioSegment1_AMS, 'Value', 1, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
set(handles2.radioHeader1Select_AMS, 'fontunits', 'normalized', 'units', 'normalized');

handles2.segment25Select_AMS = uicontrol('parent', handles2.segmentSelect_AMS, 'Style', 'radiobutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [220, 5, 150, 40], 'string', '25m segments', 'callback', @radioSegment2_AMS, 'Value', 0, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2);
set(handles2.radioHeader2Select_AMS, 'fontunits', 'normalized', 'units', 'normalized');



%---create export path
handles2.browse_txt_AMS = uicontrol('parent', hdef, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', ...
    'position', [10, 50, 280, 30], 'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], ...
    'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2-2, 'String', 'No path selected');
set(handles2.browse_txt_AMS, 'fontunits', 'normalized', 'units', 'normalized');

%---Browse button
handles2.browse_button_AMS = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [300, 50, 90, 30], 'callback', @browseExport_AMS, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2, 'String', 'Browse');
set(handles2.browse_button_AMS, 'fontunits', 'normalized', 'units', 'normalized');



%---create remove all and validate icons
%---clear button
handles2.cancel_button_AMS = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [40, 10, 150, 30], 'callback', @cancelfilter_AMS, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2, 'String', 'Cancel');
set(handles2.cancel_button_AMS, 'fontunits', 'normalized', 'units', 'normalized');

%---Validate button
handles2.validate_button_AMS = uicontrol('parent', hdef, 'Style', 'Pushbutton', 'Visible', 'on', 'units', 'pixels', ...
    'position', [220, 10, 150, 30], 'callback', @validatefilter_AMS, ...
    'BackgroundColor', [0.2 0.2 0.2], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', ...
    'Fontsize', font2, 'String', 'Validate');
set(handles2.validate_button_AMS, 'fontunits', 'normalized', 'units', 'normalized');

drawnow;



fh = findobj(0,'type','figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);

uiwait(gcf);
fh = findobj(0,'type','figure');

if length(fh) > 1;
    set(0, 'CurrentFigure', fh(1).Number);

    handles2 = guidata(gcf);
    try;
        guidata(gcf, handles2);
        close(gcf);
    catch;
        handles2.AMSExportType = [];
        handles2.AMSExportHeader = [];
        handles2.AMSExportPath = [];
        guidata(gcf, handles2);
    end;
end;



