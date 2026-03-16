function [] = displayresults_synchroniser(varargin);


handles = guidata(gcf);
handles.selectionDisplayResults = get(handles.popDisplayResults_sync, 'value');

%display database
handles.sortbyExceptionSelection = 0;

if strcmpi(handles.sourceFilter, 'FilterDouble') == 1;
    source = 'FilterDouble';
else;
    source = 'Filter';
end;
Disp_synchroniser;
handles.sortbyExceptionSelection = 1;

guidata(handles.hf_w1_welcome, handles);
