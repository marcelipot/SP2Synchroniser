function [] = filterpopgender_synchroniser(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_gender_sync, 'value');
if val == handles.SearchGender;
    return;
end;

if val == 1;
    handles.SearchGender = [];
else;
    handles.SearchGender = val;
end;

handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);


% jCBModel.uncheckIndex(1);
% jCBModel.uncheckIndex(3);