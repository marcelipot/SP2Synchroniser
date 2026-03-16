function [] = sortby_synchroniser(varargin);


handles = guidata(gcf);

% if get(handles.popSort_database, 'value') == handles.sortbyCurrentSelection;
%     return;
% end;

sortbyPreviousSelection = handles.sortbyCurrentSelection;
% handles.sortbyCurrentSelection = get(handles.popSort_database, 'value');

li = find(handles.checkedColDisp == 1);
liColSelect = [1; (li + 1)];

titleColAll = handles.FullDB(1, liColSelect);
titleColSelect = handles.FullDB(1, get(handles.popSort_sync, 'value')+1);
handles.sortbyCurrentSelection = find(contains(titleColAll, titleColSelect));

if strcmpi(handles.sortbyPreviousSelection, sortbyPreviousSelection) == 0
    handles.sortbyPreviousSelection = sortbyPreviousSelection;
end;

guidata(handles.hf_w1_welcome, handles);


% jCBModel.uncheckIndex(1);
% jCBModel.uncheckIndex(3);




