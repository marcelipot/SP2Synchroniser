
% %------------------Create the popup window warming and error---------------
% window_popupwarning;
% %-----------------------------------------------------------------------

if ispc == 1;
    font1 = 12;
    font2 = 18;
    font3 = 22;
    font4 = 10;
    font5 = 11;
elseif ismac == 1;
    font1 = 15;
    font2 = 21;
    font3 = 25;
    font4 = 12;
    font5 = 13.5;
end;
set(handles.txtpage, 'string', 'Welcome');

% %---create question button
% handles.question_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1245, 687, 30, 30], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
% imshow(handles.icones.question_offb);

%---Create line on the top
handles.lineTop_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [0, 680, 1280, 1], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);

%---Txt top last update
handles.txtlasupdate_main = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', 'position', [10, 690, 600, 20], 'String', ['Database last update: ' handles.LastUpdate], ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'HorizontalAlignment', 'Left');
set(handles.txtlasupdate_main, 'fontunits', 'normalized');

%---Txt Software version
handles.txtsoftwareversion_main = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', 'position', [670, 690, 600, 20], 'String', 'Version v01.08', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font1, 'HorizontalAlignment', 'Right');
set(handles.txtsoftwareversion_main, 'fontunits', 'normalized');

%---create logo_aargos
handles.logo_aargos_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [10, 15, 130, 35], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.logo_AARGOS);

%---create SA logo
handles.logo_sa_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [1090, 10, 150, 50], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.logo_SAL);

%---create SPARTA logo
handles.txtwelcome_main = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', 'position', [340, 615, 600, 35], 'String', 'Welcome to SP2 Viewer', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font3, 'HorizontalAlignment', 'Center');
handles.logo_sparta_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [590, 500, 100, 100], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.logo_SPARTA);
set(handles.txtwelcome_main, 'fontunits', 'normalized');


%---create the welcome box
handles.tasktodo_main = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', 'position', [490, 425, 300, 50], 'String', 'Select your module', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font3, 'HorizontalAlignment', 'Center');
set(handles.tasktodo_main, 'fontunits', 'normalized');



%---create the logo_tracker text box
handles.txtlogo_analyser_main = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', 'position', [255, 365, 170, 35], 'String', 'Analyser', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'HorizontalAlignment', 'Center');
handles.logo_analyser_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [278, 230, 125, 125], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.logo_Analyser);
%---create the "start" button for tracker
handles.start_analyser_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [250, 170, 180, 35], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.start_offb);


%---create the logo_processor text box
handles.txtlogo_database_main = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', 'position', [855, 365, 170, 35], 'String', 'Database', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'HorizontalAlignment', 'Center');
handles.logo_database_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [878, 230, 125, 125], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.logo_Database);
%---create the "start" button for processing
handles.start_database_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [850, 170, 180, 35], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.start_offb);


%---create the benchmark text box
handles.txtlogo_benchmark_main = uicontrol('parent', handles.hf_w1_welcome, 'Style', 'Text', 'Visible', 'on', 'units', 'pixels', 'position', [555, 365, 170, 35], 'String', 'Benchmarks', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'FontWeight', 'Bold', 'Fontsize', font2, 'HorizontalAlignment', 'Center');
handles.logo_benchmark_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [577.5, 230, 125, 125], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.logo_Benchmark);
%---create the "start" button for processing
handles.start_benchmark_main = axes('parent', handles.hf_w1_welcome, 'units', 'pixels', 'Position', [550, 170, 180, 35], 'color', [1 1 1], 'Xcolor', [1 1 1], 'XTick', [], 'Ycolor', [1 1 1], 'YTick', []);
imshow(handles.icones.start_offb);






%---Text size for the main title
proceed = 1;
val_ini = 0.8;
while proceed == 1;
    set(handles.txtlogo_analyser_main, 'fontunits', 'Normalized', 'fontsize', val_ini); 
    S1 = get(handles.txtlogo_analyser_main, 'position');
    S2 = get(handles.txtlogo_analyser_main, 'extent');
    D1 = S1(1,3)-S2(1,3);
    D2 = S1(1,4)-S2(1,4);
    if D1 <= 0 | D2 <= 0;
        val_ini = val_ini-0.05;
    else;
        proceed = 0;
    end;
end;
val_ini1 = val_ini;

proceed = 1;
val_ini = 0.8;
while proceed == 1;
    set(handles.txtlogo_database_main, 'fontunits', 'Normalized', 'fontsize', val_ini); 
    S1 = get(handles.txtlogo_database_main, 'position');
    S2 = get(handles.txtlogo_database_main, 'extent');
    D1 = S1(1,3)-S2(1,3);
    D2 = S1(1,4)-S2(1,4);
    if D1 <= 0 | D2 <= 0;
        val_ini = val_ini-0.05;
    else;
        proceed = 0;
    end;
end;
if val_ini1 > val_ini;
    val_ini1 = val_ini;
end;

proceed = 1;
val_ini = 0.8;
while proceed == 1;
    set(handles.txtlogo_benchmark_main, 'fontunits', 'Normalized', 'fontsize', val_ini); 
    S1 = get(handles.txtlogo_benchmark_main, 'position');
    S2 = get(handles.txtlogo_benchmark_main, 'extent');
    D1 = S1(1,3)-S2(1,3);
    D2 = S1(1,4)-S2(1,4);
    if D1 <= 0 | D2 <= 0;
        val_ini = val_ini-0.05;
    else;
        proceed = 0;
    end;
end;
if val_ini1 > val_ini;
    val_ini1 = val_ini;
end;

set(handles.txtlogo_analyser_main, 'fontunits', 'Normalized', 'fontsize', val_ini1-0.05);
set(handles.txtlogo_database_main, 'fontunits', 'Normalized', 'fontsize', val_ini1-0.05);
set(handles.txtlogo_benchmark_main, 'fontunits', 'Normalized', 'fontsize', val_ini1-0.05);




%---reset the units
set(handles.lineTop_main, 'units', 'normalized');
set(handles.txtlasupdate_main, 'units', 'normalized');
set(handles.txtsoftwareversion_main, 'units', 'normalized');
set(handles.logo_aargos_main, 'units', 'normalized');
set(handles.logo_sa_main, 'units', 'normalized');
set(handles.logo_sparta_main, 'units', 'normalized');
set(handles.txtwelcome_main, 'units', 'normalized');
set(handles.txtlogo_analyser_main, 'units', 'normalized');
set(handles.logo_analyser_main, 'units', 'normalized');
set(handles.start_analyser_main, 'units', 'normalized');
set(handles.txtlogo_database_main, 'units', 'normalized');
set(handles.logo_database_main, 'units', 'normalized');
set(handles.start_database_main, 'units', 'normalized');
set(handles.txtlogo_benchmark_main, 'units', 'normalized');
set(handles.logo_benchmark_main, 'units', 'normalized');
set(handles.start_benchmark_main, 'units', 'normalized');
set(handles.tasktodo_main, 'units', 'normalized');


