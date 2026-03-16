function [] = filtereditmeet_synchroniser(varargin);


handles = guidata(gcf);
val = get(handles.filteredit_meet_sync, 'String');

if strcmpi(val, 'Meet');
    handles.SearchMeet = [];
    guidata(handles.hf_w1_welcome, handles);
    return;
end;

if length(val) < 3;
    handles.SearchMeet = [];
    set(handles.filteredit_meet_sync, 'String', 'Meet');
    guidata(handles.hf_w1_welcome, handles);
    return;
end;

li = strfind(val, ';');
if isempty(li) == 1;
    %Only 1 search
    SearchMeet = val;
else;
    %multiple meet seach
    SearchMeet = {};
    for i = 1:length(li)+1;
        if i == 1;
            str = val(1:li(i)-1);
        elseif i == length(li)+1;
            str = val(li(end)+1:end);
        else;
            str = val(li(i-1)+1:li(i)-1);
        end;
        
        if isempty(str) == 0;
            if strcmpi(str(1), ' ');
                str = str(2:end);
            end;
            if strcmpi(str(end), ' ');
                str = str(1:end-1);
            end;

            SearchMeet{i,1} = str;
        else;
            SearchName{i,1} = SearchMeet{i-1,1};
        end;
    end;
end;

nb = length(SearchMeet);
if nb > 1;
    proceed = 1;
    iter = 1;
    while proceed == 1;
        valEC = SearchMeet(iter);
        valnumCheck = SearchMeet;
        
        if length(valnumCheck) == 1;
            proceed = 0;
        else;
            li = find(strcmpi(valnumCheck, valEC) == 1);
            
            likeep = find(li ~= iter);
            li = li(likeep);
            if isempty(li) == 0;
                SearchMeet(li) = [];
            end;

            iter = iter + 1;
            if iter > length(SearchMeet);
                proceed = 0;
            end;
        end;
    end;
end;

handles.SearchMeet = SearchMeet;


if length(SearchMeet) > 1;
    SearchMeetNew = [];
    if iscell(SearchMeet) == 1;
        for i = 1:length(SearchMeet);
            SearchMeetNew = [SearchMeetNew SearchMeet{i} ';'];
        end;
        SearchMeetNew = SearchMeetNew(1:end-1);
    else;
        SearchMeetNew = SearchMeet;
    end;
else;
    SearchMeetNew = SearchMeet;
end;

handles.sortbyExceptionSelection = 1;
set(handles.filteredit_meet_sync, 'String', SearchMeetNew);
guidata(handles.hf_w1_welcome, handles);
