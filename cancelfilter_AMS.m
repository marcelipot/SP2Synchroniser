function [] = cancelfilter_AMS(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2.AMSExportType = [];
handles2.AMSExportHeader = [];
handles2.AMSExportPath = [];
guidata(gcf, handles2);

uiresume(gcf);
