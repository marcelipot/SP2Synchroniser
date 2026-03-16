function [] = filterpoppool_synchroniser(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_pool_sync, 'value');
if val == handles.SearchPoolType;
    return;
end;

if val == 1;
    handles.SearchPoolType = [];
else;
    handles.SearchPoolType = val;
end;


% handles2 = create_AMSExportOption_synchroniser;


handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);
