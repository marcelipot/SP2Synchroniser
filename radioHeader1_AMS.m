function [] = radioHeader1_AMS(varargin);


handles2 = guidata(gcf);

val = get(handles2.radioHeader1Select_AMS, 'Value');
if val == 1;
    set(handles2.radioHeader2Select_AMS, 'Value', 0);
    handles2.AMSExportHeader = 1;
else;
    set(handles2.radioHeader2Select_AMS, 'Value', 1);
    handles2.AMSExportHeader = 2;
end;

guidata(gcf, handles2);