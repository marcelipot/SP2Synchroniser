function [] = browseExport_AMS(varargin);


handles2 = guidata(gcf);

if ispc == 1;
    defaultpath = winqueryreg('HKEY_CURRENT_USER', 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'Desktop');
    [filenameSave, pathnameSave] = uiputfile({'*.xlsx', 'Excel File'}, 'Save Benchmark As', defaultpath);
elseif ismac == 1;
    user_name = char(java.lang.System.getProperty('user.name'));
    [filenameSave, pathnameSave] = uiputfile({'*.xls', 'Excel File'}, 'Save Benchmark As', ['/Users/',user_name,'/Desktop']);
end;

if isempty(pathnameSave) == 1;
    return;
end;
if pathnameSave == 0;
    return;
end;

handles2.AMSExportPath = [pathnameSave filenameSave];

set(handles2.browse_txt_AMS, 'String', [pathnameSave filenameSave]);
pos_Extent = get(handles2.browse_txt_AMS, 'Extent');
pos_Real = get(handles2.browse_txt_AMS, 'Position');
if pos_Extent(3) > pos_Real(3);
    proceed = 1;
else;
    proceed = 0;
end;
if proceed == 1;
    txtDisp = [handles2.AMSExportPath(1:15) ' ... ' handles2.AMSExportPath(end-16:end)];
    set(handles2.browse_txt_AMS, 'String', txtDisp);
end;
drawnow;

guidata(gcf, handles2);
