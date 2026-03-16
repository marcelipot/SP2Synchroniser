function [] = startsynchTimer_synchroniser(varargin);


handles2 = guidata(gcf);

status = get(handles2.pushStart_main, 'String');
if strcmpi(status, 'Start') == 1;
    set(handles2.pushStart_main, 'String', 'Stop');
    set(handles2.pushCancel_main, 'Enable', 'off');
    start(handles2.TimerStart_main);
else;
    set(handles2.pushStart_main, 'String', 'Start');
    set(handles2.pushCancel_main, 'Enable', 'on');
    stop(handles2.TimerStart_main);
end;
drawnow;
