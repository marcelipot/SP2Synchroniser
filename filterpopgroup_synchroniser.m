function [] = filterpoppool_synchroniser(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_category_sync, 'value');
if val == handles.SearchCategory;
    return;
end;

if val == 1;
    handles.SearchCategory = [];
else;
    handles.SearchCategory = val;
end;

handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);
