if ispc == 1;
    [filename, pathname] = uiputfile({'*.xlsx', 'Excel File'}, 'Save Benchmark As', handles.lastPath_sync);
elseif ismac == 1;
    [filename, pathname] = uiputfile({'*.xls', 'Excel File'}, 'Save Benchmark As', handles.lastPath_sync);
end;

if isempty(pathname) == 1;
    return;
end;
if pathname == 0;
    return;
end;
handles.lastPath_sync = pathname;
name = [pathname filename];

%Current colmn limit is 29... To change is adding more column to the export
dataTable = handles.FullDB(1,2:30);
dataTable(2:length(handles.FullDBSort(:,1))+1,:) = handles.FullDBSort(:,2:end);

if ispc == 1;
    exportstatusSheet1 = xlswrite(name, dataTable, 1);
elseif ismac == 1;
    javaaddpath('poi-3.8-20120326.jar');
    javaaddpath('poi-ooxml-3.8-20120326.jar');
    javaaddpath('poi-ooxml-schemas-3.8-20120326.jar');
    javaaddpath('xmlbeans-2.3.0.jar');
    javaaddpath('dom4j-1.6.1.jar');
    javaaddpath('stax-api-1.0.1.jar');

    xlwrite(name, dataTable, 'Benchmarks', 'A1');
    
end;
clc;