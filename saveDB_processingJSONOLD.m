%---save db processingJSON: saveDB_processingJSON
uidDB = AllDB.uidDB;
FullDB = AllDB.FullDB;
AthletesDB = AllDB.AthletesDB;
ParaDB = AllDB.ParaDB;
PBsDB = AllDB.PBsDB;
PBsDB_SC = AllDB.PBsDB_SC;
BenchmarkEvents = AllDB.BenchmarkEvents;
AgeGroup = AllDB.AgeGroup;
isupdate = AllDB.isupdate;
RoundDB = AllDB.RoundDB;
MeetDB = AllDB.MeetDB;

LastUpdate = datestr(today('datetime'));
if ispc == 1;
    MDIR = getenv('USERPROFILE');
    filenameDB = [MDIR '\SP2viewer\SP2viewerDB.mat'];
elseif ismac == 1;
    filenameDB = '/Applications/SP2Viewer/SP2viewerDB.mat';
end;
save(filenameDB, 'AthletesDB', 'ParaDB', 'LastUpdate', 'uidDB', 'FullDB', 'PBsDB', 'PBsDB_SC', 'AgeGroup', 'BenchmarkEvents', 'isupdate', 'MeetDB', 'RoundDB');

command = ['aws s3 cp ' filenameDB ' s3://sparta2-prod/sparta2-data/SP2viewerDB.mat'];
[status, out] = system(command);

if strcmpi(source, 'cancel');
    if strcmpi(source_user, 'Update');
        set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Interrupted');
        set(handles2.txtNew_main, 'String', 'Adding new races :   Interrupted');
        set(handles2.txtFileName_main, 'String', 'File :');
        set(handles2.updatedfiles_check_analyser, 'enable', 'on');
        
    elseif strcmpi(source_user, 'Select');
        set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Not available');
        set(handles2.txtNew_main, 'String', 'Replacing selected races :   Interrupted');
        set(handles2.txtFileName_main, 'String', 'File :');
        
    elseif strcmpi(source_user, 'All');
        set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Not available');
        set(handles2.txtNew_main, 'String', 'Replacing selected races :   Interrupted');
        set(handles2.txtFileName_main, 'String', 'File :');
    end;

elseif strcmpi(source, 'internet');
    if strcmpi(source_user, 'Update');
        set(handles2.txtUpdated_main, 'String', 'Updating existing races :   No internet connection');
        set(handles2.txtNew_main, 'String', 'Adding new races :   No internet connection');
        set(handles2.txtFileName_main, 'String', 'File :');
        set(handles2.updatedfiles_check_analyser, 'enable', 'on');
        
    elseif strcmpi(source_user, 'Select');
        set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Not available');
        set(handles2.txtNew_main, 'String', 'Replacing selected races :   No internet connection');
        set(handles2.txtFileName_main, 'String', 'File :');
    
    elseif strcmpi(source_user, 'All');
        set(handles2.txtUpdated_main, 'String', 'Updating existing races :   Not available');
        set(handles2.txtNew_main, 'String', 'Replacing selected races :   No internet connection');
        set(handles2.txtFileName_main, 'String', 'File :');
    end;
    
elseif strcmpi(source, 'completed');
    if strcmpi(source_user, 'Update');
        set(handles2.txtNew_main, 'String', 'Adding new races :   Completed');
        set(handles2.txtFileName_main, 'String', 'File :');
        set(handles2.pushCancel_main, 'String', 'Close');
        set(handles2.updatedfiles_check_analyser, 'enable', 'on');
        
    elseif strcmpi(source_user, 'Select');
        set(handles2.txtNew_main, 'String', 'Replacing selected races :   Completed');
        set(handles2.txtFileName_main, 'String', 'File :');
        set(handles2.pushCancel_main, 'String', 'Close');
        
    elseif strcmpi(source_user, 'All');
        set(handles2.txtNew_main, 'String', 'Replacing selected races :   Completed');
        set(handles2.txtFileName_main, 'String', 'File :');
        set(handles2.pushCancel_main, 'String', 'Close');
    end;
    
end;
set(handles2.pushStart_main, 'enable', 'on');
drawnow;





