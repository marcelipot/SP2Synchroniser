function [] = radioSegment2_AMS(varargin);


handles2 = guidata(gcf);

val = get(handles2.segment25Select_AMS, 'Value');
if val == 1;
    set(handles2.segment15Select_AMS, 'Value', 0);
    handles2.AMSExportType = 2;
else;
    set(handles2.segment15Select_AMS, 'Value', 1);
    handles2.AMSExportType = 1;
end;

guidata(gcf, handles2);