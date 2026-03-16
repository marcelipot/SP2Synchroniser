function [] = saveDataMatFile(varargin);


fileECout = varargin{3};
fileECin = varargin{4};
[rootFolder, filename, fileext] = fileparts(fileECout);

assignin('base', 'fileECout', fileECout);
assignin('base', 'filename', filename);
% command = ['save(fileECout, ' '''' 'loadMatFile.' filename '''' ', ' '''' 'loadMatFile.' '''' ', ' '''' 'loadMatFile.' '''' ', ' '''' 'loadMatFile.' '''' ', ' '''' 'loadMatFile.' '''' ', ' '''' 'loadMatFile.' '''' ');'];

evalin('base', [filename ' = loadMatFile.' filename ';']);
evalin('base', ['graph1PacingAxes = loadMatFile.graph1PacingAxes;']);
evalin('base', ['graph1_Distance = loadMatFile.graph1_Distance;']);
evalin('base', ['graph1_gtit = loadMatFile.graph1_gtit;']);
evalin('base', ['axescolbar = loadMatFile.axescolbar;']);
evalin('base', ['colbar = loadMatFile.colbar;']);

command = ['save(' 'fileECout' ', ' 'filename' ', ' '''' 'graph1PacingAxes' '''' ', ' '''' 'graph1_Distance' '''' ', ' '''' 'graph1_gtit' '''' ', ' '''' 'axescolbar' '''' ', ' '''' 'colbar' '''' ');'];
evalin('base', command);

%upload data file to the cloud
command = ['aws s3 cp ' fileECout ' ' fileECin];
[status, out] = system(command);

if status ~= 0;
    errordlg('Error', 'File not uploaded');
    return;
end;

if ispc == 1;
    command = ['del /Q ' fileECout];
else;
    ee=ee
end;
[status, out] = system(command);

close(gcf);