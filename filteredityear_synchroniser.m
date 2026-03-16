function [] = filteredityear_synchroniser(varargin);


handles = guidata(gcf);

val = get(handles.filteredit_year_sync, 'String');

if strcmpi(val, 'Year');
    return;
end;

li = strfind(val, ',');
if isempty(li) == 0;
    handles.SearchYear = [];
    set(handles.filteredit_year_sync, 'String', 'Year');
    guidata(handles.hf_w1_welcome, handles);
    return;
end;

li = strfind(val, ' ');
if isempty(li) == 0;
    handles.SearchYear = [];
    set(handles.filteredit_year_sync, 'String', 'Year');
    guidata(handles.hf_w1_welcome, handles);
    return;
end;
    
if length(val) <= 1;
    handles.SearchYear = [];
    set(handles.filteredit_year_sync, 'String', 'Year');
    guidata(handles.hf_w1_welcome, handles);
    return;
end;

li = strfind(val, ';');
if isempty(li) == 1;
    %Only 1 search
    valnum = str2num(val);

else;
    %multiple year seach
    valnum = [];
    for i = 1:length(li)+1;
        if i == 1;
            str = val(1:li(i)-1);
        elseif i == length(li)+1;
            str = val(li(end)+1:end);
        else;
            str = val(li(i-1)+1:li(i)-1);
        end;
        
        if strcmpi(str(1), ' ');
            str = str(2:end);
        end;
        if strcmpi(str(end), ' ');
            str = str(1:end-1);
        end;
        
        liCheck = strfind(str, ',');
        if isempty(liCheck) == 0;
            handles.SearchYear = [];
            set(handles.filteredit_year_sync, 'String', 'Year');
            guidata(handles.hf_w1_welcome, handles);
            return;
        end;

        liCheck = strfind(str, ' ');
        if isempty(liCheck) == 0;
            handles.SearchYear = [];
            set(handles.filteredit_year_sync, 'String', 'Year');
            guidata(handles.hf_w1_welcome, handles);
            return;
        end;

        if length(str) <= 1;
            handles.SearchYear = [];
            set(handles.filteredit_year_sync, 'String', 'Year');
            guidata(handles.hf_w1_welcome, handles);
            return;
        end;
        
        try;
            valnum(i,1) = str2num(str);
        catch;
            valnum(i,1) = 0;
        end;
    end;
end;

if isempty(find(valnum == 0)) == 0;
    errorwindow = errordlg('Impossible to apply', 'Error');
    if ispc == 1;
        MDIR = getenv('USERPROFILE');
        jFrame = get(handle(errorwindow), 'javaframe');
        jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
        jFrame.setFigureIcon(jicon);
        clc;
    end;
    handles.SearchYear = [];
    set(handles.filteredit_year_sync, 'String', 'Year');
    guidata(handles.hf_w1_welcome, handles);
    return;
end;


if isempty(valnum) == 1;
    handles.SearchYear = [];
    set(handles.filteredit_year_sync, 'String', 'Year');
    guidata(handles.hf_w1_welcome, handles);
    return;
end;

for i = 1:length(valnum);
    if valnum(i) < 2000;
        errorwindow = errordlg('Enter a value >= 2000', 'Error');
        if ispc == 1;
            MDIR = getenv('USERPROFILE');
            jFrame = get(handle(errorwindow), 'javaframe');
            jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
            jFrame.setFigureIcon(jicon);
            clc;
        end;
        handles.SearchYear = [];
        set(handles.filteredit_year_sync, 'String', 'Year');
        guidata(handles.hf_w1_welcome, handles);
        return;
    end;
end;

valnum = roundn(valnum,0);
nb = length(valnum);
if nb > 1;
    proceed = 1;
    iter = 1;
    while proceed == 1;
        valEC = valnum(iter);
        valnumCheck = valnum;
        
        if length(valnumCheck) == 1;
            proceed = 0;
        else;
            li = find(valnumCheck == valEC);
            
            likeep = find(li ~= iter);
            li = li(likeep);
            if isempty(li) == 0;
                valnum(li) = [];
            end;

            iter = iter + 1;
            if iter > length(valnum);
                proceed = 0;
            end;
        end;
    end;
end;

handles.sortbyExceptionSelection = 1;
handles.SearchYear = valnum;
guidata(handles.hf_w1_welcome, handles);