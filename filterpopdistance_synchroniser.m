function [] = filterpopdistance_synchroniser(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_distance_sync, 'value');
if val == handles.SearchDistance;
    return;
end;

if val == 1;
    handles.SearchDistance = [];
else;
    handles.SearchDistance = val;
end;

handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);
