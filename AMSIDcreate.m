% Create with data exported from the AMS:
% Cell-column: AMSLastnamenew = {};
% Cell-column: AMSFirstnamenew = {};
% Cell-column: AMSGendernew = {};
% Double-column: AMSIDnew = [];
%
% Create with current AMSID list:
% Double-column: AMSIDcurrent = [];

%remove doubles from raw AMS data
proceed = 1;
iter = 1;
while proceed == 1;
    valEC = AMSIDnew(iter,1);
    index = find(AMSIDnew(:,1) == valEC);
    
    if length(index) ~= 1;
        AMSIDnew(index(2:end),:) = [];
        AMSLastnamenew(index(2:end),:) = [];
        AMSFirstnamenew(index(2:end),:) = [];
        AMSGendernew(index(2:end),:) = [];
    end;
    
    iter = iter + 1;
    if iter > length(AMSIDnew(:,1));
        proceed = 0;
    end;
end;


%check if ID exist in the AMSIDcurrent list
iter = 1;
firstnameToAdd = {};
lastnameToAdd = {};
genderToAdd = [];
AMDIDToAdd = [];
for i = 1:length(AMSIDnew);
    valEC = AMSIDnew(i,1);
    index = find(AMSIDcurrent == valEC);
    if isempty(index) == 1;
        firstnameToAdd{iter,1} = AMSFirstnamenew{i,1};
        lastnameToAdd{iter,1} = AMSLastnamenew{i,1};
        if strcmpi(AMSLastnamenew{i,1}, 'Male');
            genderToAdd(iter,1) = 1;
        else;
            genderToAdd(iter,1) = 2;
        end;
        AMDIDToAdd(iter,1) = valEC;
        
        iter = iter + 1;
    end;
end;


