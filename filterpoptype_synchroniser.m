function [] = filterpoptype_synchroniser(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_type_sync, 'value');
if val == handles.SearchSwimType;
    return;
end;

if val == 1;
    handles.SearchSwimType = [];
else;
    handles.SearchSwimType = val;
end;

handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);
