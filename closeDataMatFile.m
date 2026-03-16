function [] = closeDataMatFile(varargin);


fileECout = varargin{3};
fileECin = varargin{4};

if ispc == 1;
    command = ['del /Q ' fileECout];
else;
    ee=ee
end;
[status, out] = system(command);

close(gcf);