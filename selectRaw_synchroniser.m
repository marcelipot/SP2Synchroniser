function [] = selectRaw_synchroniser(hObject,callbackdata);


handles = guidata(gcf);

StatusColDBDisp = handles.StatusColDBDisp;
StatusColDBFull = handles.StatusColDBFull;
FullDBTab = handles.FullDBTab;
FullDBSort = handles.FullDBSort;
index = handles.SortingIndex_database;

jScrollpane = findjobj(handles.databasemain_table_sync);  % get the handle of the table
scroll = jScrollpane.getVerticalScrollBar.getValue;  % get the scroll position

Select = callbackdata.Indices(1);

%---change the selection
if Select == 1;
    li = find(StatusColDBDisp == 1);

    if length(li) >= length(StatusColDBDisp(:,1))./2;
        %majority is on so put it off
        for i = 1:length(StatusColDBDisp(:,1));
            StatusColDBDisp(i,1) = 0;
            FullDBTab{i,1} = false;
        end;
        for i = 1:length(FullDBTab(:,1))-1;
            if handles.selectionDisplayResults ~= length(handles.displaylist);
                %adjust for page number
                Select2 = i + ((handles.selectionDisplayResults-1)*50);
            else;
                Select2 = i;
            end;
            StatusColDBFull(index(Select2), 1) = 0;
        end;
    else;
        %majority is off so put it on
        for i = 1:length(StatusColDBDisp(:,1));
            StatusColDBDisp(i,1) = 1;
            FullDBTab{i,1} = true;
        end;
        for i = 1:length(FullDBTab(:,1))-1;
            if handles.selectionDisplayResults ~= length(handles.displaylist);
                %adjust for page number
                Select2 = i + ((handles.selectionDisplayResults-1)*50);
            else;
                Select2 = i;
            end;
            StatusColDBFull(index(Select2), 1) = 1;
        end;
    end;

else;
    
    if StatusColDBDisp(Select,1) == 1;
        %unselect
        if handles.selectionDisplayResults ~= length(handles.displaylist);
            %adjust for page number
            Select2 = Select + ((handles.selectionDisplayResults-1)*50);
        else;
            Select2 = Select;
        end;
    
        StatusColDBDisp(Select,1) = 0;
        FullDBTab{Select,1} = false;
        StatusColDBFull(index(Select2-1), 1) = 0;
    else;
        %select
        if handles.selectionDisplayResults ~= length(handles.displaylist);
            %adjust for page number
            Select2 = Select + ((handles.selectionDisplayResults-1)*50);
        else;
            Select2 = Select;
        end;
        
        StatusColDBDisp(Select,1) = 1;
        FullDBTab{Select,1} = true;
        StatusColDBFull(index(Select2-1), 1) = 1;

        %---throw error
        if isempty(handles.uidDB{index(Select2-1),14}) == 0;
            txterror = handles.uidDB{index(Select2-1),14};
            warnwindow = warndlg(txterror, 'Warning');
            if ispc == 1;
                MDIR = getenv('USERPROFILE');
                jFrame = get(handle(warnwindow), 'javaframe');
                jicon = javax.swing.ImageIcon([MDIR '\SP2Synchroniser\SpartaSynchroniser_IconSoftware.png']);
                jFrame.setFigureIcon(jicon);
                clc;
            end;
        end;
    end;
    
%     nameID = handles.uidDB{index(Select2-1),3}
%     jsonID = handles.uidDB{index(Select2-1),13}
    raw = index(Select2-1);
    matID = handles.uidDB{index(Select2-1),1};
    

    
    
    rawfullDB = index(Select2-1) + 1



    
%     %find the equivalent raw in the sp1 database
    fileID = handles.FullDB(rawfullDB,1);
    classifier = handles.FullDB_SP1;
    lisearch = strcmpi(classifier, fileID);
    likeep = find(lisearch == 1)





    index = strfind(matID, '-');
    matID(index) = '_';
    matID = ['A' matID 'A'];



    
    jsonID = handles.uidDB{raw,13}



end;

set(handles.databasemain_table_sync, 'data', FullDBTab);
drawnow;
pause(0.1);
jScrollpane.getVerticalScrollBar.setValue(scroll);

handles.StatusColDBDisp = StatusColDBDisp;
handles.StatusColDBFull = StatusColDBFull;
handles.FullDBTab = FullDBTab;

guidata(handles.hf_w1_welcome, handles);

