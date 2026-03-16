if strcmpi(source, 'Synch');
    if ismac == 1;
        load('/Applications/SP2Synchroniser/SP2viewerDB.mat');

    elseif ispc == 1;
        MDIR = getenv('USERPROFILE');
        load([MDIR '\SP2Synchroniser\SP2viewerDB.mat']);
    end;

    handles.uidDB = uidDB;
    handles.FullDB = FullDB;
    handles.PBsDB = PBsDB;
elseif strcmpi(source, 'FilterDouble');
    FullDB = handles.FullDB(handles.selectLanesDouble1+1, :);
    FullDB = FullDB(handles.selectLanesDouble2, :);

    uidDB = handles.uidDB(handles.selectLanesDouble1, :);
    uidDB = uidDB(handles.selectLanesDouble2, :);
else;
    uidDB = handles.uidDB;
    FullDB = handles.FullDB;
    PBsDB = handles.PBsDB;
end;

if isempty(FullDB) == 0;
    set(handles.databasemain_table_sync, 'units', 'pixels');
    posTable = get(handles.databasemain_table_sync, 'position');
    set(handles.databasemain_table_sync, 'units', 'normalized');
    datatable_sync = {};

    %---Select matching trials
    apply_FilterTrials_synchroniser;

    if isempty(database) == 0;
        nCol = length(database(1,:));
        nRaw = length(database(:,1));

        if strcmpi(source, 'Synch') | strcmpi(source, 'Disp');
            %Pop list pages
            displaylist = {};
            for i = 1:ceil(nRaw./50);
                if i == ceil(nRaw./50);
                    displaylist{i,1} = ['Race ' num2str((i*50)-49) ' to ' num2str(nRaw)];
                else;
                    displaylist{i,1} = ['Race ' num2str((i*50)-49) ' to ' num2str((i*50))];
                end;
            end;
            displaylist{i+1,1} = 'All Races';
            handles.selectionDisplayResults = 1;
            handles.displaylist = displaylist;
            set(handles.popDisplayResults_sync, 'enable', 'on', 'String', displaylist, 'Value', 1);

        else;
            if handles.sortbyExceptionSelection == 1;
                %Pop list pages
                displaylist = {};
                for i = 1:ceil(nRaw./50);
                    if i == ceil(nRaw./50);
                        displaylist{i,1} = ['Race ' num2str((i*50)-49) ' to ' num2str(nRaw)];
                    else;
                        displaylist{i,1} = ['Race ' num2str((i*50)-49) ' to ' num2str((i*50))];
                    end;
                end;
                displaylist{i+1,1} = 'All Races';
                handles.selectionDisplayResults = 1;
                handles.displaylist = displaylist;
                set(handles.popDisplayResults_sync, 'enable', 'on', 'String', displaylist, 'Value', 1);
            end;
        end;

        %---Select columns
        li = find(handles.checkedColDisp == 1);
        liColSelect = [1; (li + 1)];
        database = database(:,liColSelect);

        %---apply search and filtering options
        apply_SortByColumn_synchroniser;

        %---Select raws
        reset_raw = 0;
        if handles.sortbyCurrentSelection == handles.sortbyPreviousSelection;
            if handles.sortbyExceptionSelection == 1;
                reset_raw = 1;
            end;
        else;
            reset_raw = 1;
        end;
        
        database3 = {};
        if reset_raw == 1;
            database3(1:nRaw+1,1) = {0};
            database3(:,2:nCol) = database2(:,2:nCol);

            handles.selectionDisplayResults = 1;
            rawIni = ((handles.selectionDisplayResults*50)-49) + 1;
            rawEnd = ((handles.selectionDisplayResults*50));
            if rawEnd > length(database3(:,1));
                rawEnd = length(database3(:,1));
            end;

            databaseTab = database3(1,:);
            databaseTab(2:(rawEnd-rawIni+2),:) = database3(rawIni:rawEnd, :);
            set(handles.popDisplayResults_sync, 'value', 1);

        else;
            database3(1:nRaw+1,1) = {0};
            database3(:,2:nCol) = database2(:,2:nCol);
            if handles.selectionDisplayResults == length(handles.displaylist);
                databaseTab = database3;

            elseif handles.selectionDisplayResults == length(handles.displaylist)-1;
                rawIni = ((handles.selectionDisplayResults*50)-49) + 1;
                rawEnd = length(database3(:,1));
                
                databaseTab = database3(1,:);
                databaseTab(2:(rawEnd-rawIni+2),:) = database3(rawIni:rawEnd, :);

            else;
                rawIni = ((handles.selectionDisplayResults*50)-49) + 1;
                rawEnd = ((handles.selectionDisplayResults*50));

                databaseTab = database3(1,:);
                databaseTab(2:(rawEnd-rawIni+2),:) = database3(rawIni:rawEnd, :);
            end;
        end;
        
        %---Display      
        colFormat_synchroniser;
        colorrow(1,:) = [1 0.9 0.1];
        [nRaw, nCol] = size(databaseTab);    
        for raw = 2:nRaw;
            if rem(raw,2) == 1;
                %odd
                colorrow(raw,:) = [0.75 0.75 0.75];
            else;
                %even
                colorrow(raw,:) = [0.9 0.9 0.9];
            end;
        end;
    
        handles.StatusColDBDisp = zeros(nRaw,1);
        handles.FullDBSort = database;
        handles.FullDBTab = databaseTab;
        [nRaw, nCol] = size(handles.uidDB);
        handles.StatusColDBFull = zeros(nRaw,1);
    
    else;
        
        ColWidth{1} = 20; %empty
        ColWidth{2} = posTable(3)-ColWidth{1}-1; %Message
        ColWidthDisp = ColWidth;
        ColFormat{1} = 'char';
        ColFormat{2} = 'char';
        ColEdit(1) = false;
        ColEdit(2) = false;
        colorrow(1,:) = [1 0.9 0.1];
        colorrow(2,:) = [0.9 0.9 0.9];
        
        databaseTab{2,2} = 'No matching results';
        
        handles.displaylist = '';
        set(handles.popDisplayResults_sync, 'enable', 'on', 'String', ' ', 'Value', 1);
                
        handles.StatusColDBDisp = [];
        handles.FullDBSort = database;
        handles.FullDBTab = databaseTab;
        handles.StatusColDBFull = [];
    end;

    if ismac == 1;
        font = 10;
    elseif ispc == 1;
        font = 8;
    end;
    set(handles.databasemain_table_sync, 'data', databaseTab, ...
        'ColumnWidth', ColWidthDisp, 'backgroundcolor', colorrow, ...
        'ColumnFormat', ColFormat, 'ColumnEditable', ColEdit, ...
        'CellEditCallback', @selectRaw_synchroniser, ...
        'Visible', 'on', 'units', 'pixels', 'rowstriping', 'on', ...
        'FontName', 'Book Antiqua', 'FontAngle', 'Italic', 'Fontsize', font);

    set(handles.databasemain_table_sync, 'Units', 'Normalized');
    
else;
	set(handles.popDisplayResults_sync, 'enable', 'off', 'String', 'None');
end;
