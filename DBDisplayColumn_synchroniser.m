function [] = DBDisplayColumn_synchroniser(varargin);


handles = guidata(gcf);

checkedColDisp = ones(length(handles.listDropCol),1);
checked = handles.jCBModel.getCheckedIndicies;

for i = 1:length(checkedColDisp);
    if isempty(find(checked == i-1)) == 1;
        checkedColDisp(i, 1) = 0;
    else;
        checkedColDisp(i, 1) = 1;
    end;
end;

sortbyPreviousSelection = handles.sortbyCurrentSelection;
li = find(checkedColDisp == 1);
liColSelect = [1; (li + 1)];
titleColAll = handles.FullDB(1, liColSelect);
titleColSelect = handles.FullDB(1, get(handles.popSort_sync, 'value')+1);
handles.sortbyCurrentSelection = find(contains(titleColAll, titleColSelect));

if strcmpi(sortbyPreviousSelection, handles.sortbyPreviousSelection) == 0;
    handles.sortbyPreviousSelection = sortbyPreviousSelection;
end;

handles.checkedColDisp = checkedColDisp;
guidata(handles.hf_w1_welcome, handles);


% jCBModel.uncheckIndex(1);
% jCBModel.uncheckIndex(3);