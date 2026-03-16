function dataTxt = dataToStr(dataraw, decimalNumber);


%get decimal
dataraw = roundn(dataraw,-decimalNumber);
if dataraw < 0;
    getCore = ceil(dataraw);
    getDecimal = ceil(dataraw) - dataraw;
else;
    getCore = floor(dataraw);
    getDecimal = dataraw - floor(dataraw);
end;


txtCore = num2str(getCore);
txtDecimal = num2str(getDecimal);
index = strfind(txtDecimal, '.');

if isempty(index) == 1;
    if decimalNumber == 0;
        txtDecimal = '';
    elseif decimalNumber == 1;
        txtDecimal = '.0';
    elseif decimalNumber == 2;
        txtDecimal = '.00';
    elseif decimalNumber == 3;
        txtDecimal = '.000';
    end;
    dataTxt = [txtCore txtDecimal];

else;
    if decimalNumber == 0;
        txtDecimal = '';
    elseif decimalNumber == 1;
        %Good
    elseif decimalNumber == 2;
        if length(txtDecimal) == 3;
            txtDecimal = [txtDecimal '0'];
        end;
        
    end;
    dataTxt = [txtCore txtDecimal(index:end)];
end;


% 
% if dataraw < 10 & dataraw >= 0;
%     dataTxt = num2str(dataraw);
%     while length(dataTxt) < 4;
%         if length(dataTxt) == 1;
%             dataTxt = [dataTxt '.0'];
%         else;
%             dataTxt = [dataTxt '0'];
%         end;
%     end;
% elseif dataraw < 0;
%     dataTxt = num2str(dataraw);
%     li = findstr(dataTxt, '.');
%     if isempty(li) == 1;
%         dataTxt = [dataTxt '.00'];
%     else;
%         while length(dataTxt) < 5;
%             if length(dataTxt) == 2;
%                 dataTxt = [dataTxt '.0'];
%             else;
%                 dataTxt = [dataTxt '0'];
%             end;
%         end;
%     end;
% else;
%     dataTxt = num2str(dataraw);
%     while length(dataTxt) < 5;
%         if length(dataTxt) == 3;
%             dataTxt = [dataTxt '.0'];
%         else;
%             dataTxt = [dataTxt '0'];
%         end;
%     end;
% end;
