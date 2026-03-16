
P1 = get(handles.start_analyser_main, 'position');
P2 = get(handles.start_database_main, 'position');
P3 = get(handles.start_benchmark_main, 'position');

%---Start analyser button down
if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
    axes(handles.start_analyser_main); imshow(handles.icones.start_offb);
%     drawnow;
    
    %---Hide axes welcome
    set(allchild(handles.logo_sparta_main), 'Visible', 'off');
    set(allchild(handles.logo_analyser_main), 'Visible', 'off');
    set(allchild(handles.logo_database_main), 'Visible', 'off');
    set(allchild(handles.logo_benchmark_main), 'Visible', 'off');
    set(allchild(handles.start_analyser_main), 'Visible', 'off');
    set(allchild(handles.start_database_main), 'Visible', 'off');
    set(allchild(handles.start_benchmark_main), 'Visible', 'off');
    
    %---Hide uicontrols welcome
    set(handles.txtlasupdate_main, 'Visible', 'off');
    set(handles.txtsoftwareversion_main, 'Visible', 'off');
    set(handles.txtwelcome_main, 'Visible', 'off');
    set(handles.txtlogo_analyser_main, 'Visible', 'off');
    set(handles.txtlogo_database_main, 'Visible', 'off');
    set(handles.txtlogo_benchmark_main, 'Visible', 'off');
    set(handles.tasktodo_main, 'Visible', 'off');
    
    
    
    %---show axes analyser
    set(allchild(handles.Question_button_analyser), 'Visible', 'on');
    set(handles.Question_button_analyser, 'XTick', [], 'YTick', []);
    set(allchild(handles.Save_button_analyser), 'Visible', 'on');
    set(handles.Save_button_analyser, 'XTick', [], 'YTick', []);
    set(allchild(handles.Download_button_analyser), 'Visible', 'on');
    set(handles.Download_button_analyser, 'XTick', [], 'YTick', []);
    set(allchild(handles.Fullscreen_button_analyser), 'Visible', 'on');
    set(handles.Fullscreen_button_analyser, 'XTick', [], 'YTick', []);
    set(allchild(handles.Reportpdf_button_analyser), 'Visible', 'on');
    set(handles.Reportpdf_button_analyser, 'XTick', [], 'YTick', []);
%     set(allchild(handles.Search_button_analyser), 'Visible', 'on');
%     set(handles.Search_button_analyser, 'XTick', [], 'YTick', []);
%     set(allchild(handles.Reset_button_analyser), 'Visible', 'on');
%     set(handles.Reset_button_analyser, 'XTick', [], 'YTick', []);
    set(allchild(handles.Arrowback_button_analyser), 'Visible', 'on');
    set(handles.Arrowback_button_analyser, 'XTick', [], 'YTick', []);
    set(allchild(handles.AddFile_button_analyser), 'Visible', 'on');
    set(handles.AddFile_button_analyser, 'XTick', [], 'YTick', []);
    set(allchild(handles.RemoveFile_button_analyser), 'Visible', 'on');
    set(handles.RemoveFile_button_analyser, 'XTick', [], 'YTick', []);
    set(allchild(handles.RemoveAllFile_button_analyser), 'Visible', 'on');
    set(handles.RemoveAllFile_button_analyser, 'XTick', [], 'YTick', []);

    
    %---show uicontrols analyser
    set(handles.Question_button_analyser, 'Visible', 'on');
    set(handles.Save_button_analyser, 'Visible', 'on');
    set(handles.Download_button_analyser, 'Visible', 'on');
    set(handles.Search_athletename_analyser, 'Visible', 'on');
    set(handles.Search_racename_analyser, 'Visible', 'on');
    set(handles.Arrowback_button_analyser, 'Visible', 'on');
    set(handles.AddFile_button_analyser, 'Visible', 'on');
    set(handles.RemoveFile_button_analyser, 'Visible', 'on');
    set(handles.RemoveAllFile_button_analyser, 'Visible', 'on');
    set(handles.AthleteName_list_analyser, 'Visible', 'on');
    set(handles.AthleteRace_list_analyser, 'Visible', 'on');
    set(handles.FileAdded_list_analyser, 'Visible', 'on');
    set(handles.display_button_analyser, 'Visible', 'on');
    set(handles.DataPanel_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.PacingDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SkillDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    set(handles.SplitsDisplay_toggle_analyser, 'Visible', 'on', 'Value', 0);
    
    if ismac == 1;
        set(handles.hf_w1_welcome, 'ResizeFcn', @Resize_SP2viewerMac_analyser);
        load /Applications/SP2Viewer/SP2viewerDB.mat;
    elseif ispc == 1;
        MDIR = getenv('USERPROFILE');
        set(handles.hf_w1_welcome, 'ResizeFcn', @Resize_SP2viewerPC_analyser);
        load([MDIR '\SP2Viewer\SP2viewerDB.mat']);
    end;
    handles.AthletesDB = AthletesDB;
    handles.ParaDB = ParaDB;
    handles.uidDB = uidDB;
    handles.FullDB = FullDB;
    handles.PBsDB = PBsDB;
    handles.LastUpdate = LastUpdate;

    %---Initialise
    handles.AthleteNamelistDisp_analyser = handles.AthleteNamelist_analyser(2:end);
    handles.AthleteRacelistDisp_analyser = [];
    set(handles.AthleteName_list_analyser, 'string', handles.AthleteNamelistDisp_analyser, 'value', 1);
    set(handles.AthleteRace_list_analyser, 'string', '');
    set(handles.FileAdded_list_analyser, 'String', []);
    handles.filelistAdded = [];

    handles.UpdateListGraph = 1;
    handles.dataTableSummary = [];
    handles.dataTableStroke = [];
    handles.dataTablePacing = [];
    handles.dataTableSkill = [];
    
    set(handles.DataPanel_toggle_analyser, 'Value', 0);
    set(handles.PacingDisplay_toggle_analyser, 'Value', 0);
    set(handles.SkillDisplay_toggle_analyser, 'Value', 0);

    set(handles.DPS_check_analyser, 'value', 0);
    set(handles.SR_check_analyser, 'value', 0);
    set(handles.Breath_check_analyser, 'value', 0);
    set(handles.Splits_check_analyser, 'value', 1);
    set(handles.Distance_check_analyser, 'value', 1);
    set(handles.Time_check_analyser, 'value', 0);
    set(handles.Smooth_check_analyser, 'value', 0);

    handles.CurrentstatusSR = 0;
    handles.CurrentstatusDPS = 0;
    handles.CurrentstatusSplits = 1;
    handles.CurrentstatusDistance = 0;
    handles.CurrentstatusBreath = 0;
    handles.CurrentstatusTime = 0;
    handles.CurrentstatusSmooth = 0;
    handles.CurrentstatusOverlayNo = 1;
    handles.CurrentvalueXmin = [];
    handles.CurrentvalueXmax = [];
    handles.CurrentvalueYLeftmin = [];
    handles.CurrentvalueYLeftmax = [];
    handles.CurrentvalueYRightmin = [];
    handles.CurrentvalueYRightmax = [];
    handles.RaceDistList = [];
    handles.StrokeList = [];
    handles.GenderList = [];
    handles.CourseList = [];
    
    %-graph pacing positions
    handles.GraphPosA1 = [245./1280, 50./720, 760./1280, 490./720];
    handles.GraphPosB1 = [235./1280, 320./720, 760./1280, 220./720];
    handles.GraphPosB2 = [235./1280, 50./720, 760./1280, 220./720];
    handles.GraphPosC1 = [230./1280, 405./720, 765./1280, 145./720];
    handles.GraphPosC2 = [230./1280, 220./720, 765./1280, 145./720];
    handles.GraphPosC3 = [230./1280, 40./720, 765./1280, 145./720];
    handles.GraphPosD1 = [225./1280, 451./720, 770./1280, 102./720];
    handles.GraphPosD2 = [225./1280, 314./720, 770./1280, 102./720];
    handles.GraphPosD3 = [225./1280, 177./720, 770./1280, 102./720];
    handles.GraphPosD4 = [225./1280, 40./720, 770./1280, 102./720];
    handles.GraphPosE1 = [225./1280, 482./720, 770./1280, 88./720];
    handles.GraphPosE2 = [225./1280, 369./720, 770./1280, 88./720];
    handles.GraphPosE3 = [225./1280, 256./720, 770./1280, 88./720];
    handles.GraphPosE4 = [225./1280, 143./720, 770./1280, 88./720];
    handles.GraphPosE5 = [225./1280, 35./720, 770./1280, 88./720];
    handles.GraphPosF1 = [220./1280, 510./720, 780./1280, 70./720];
    handles.GraphPosF2 = [220./1280, 415./720, 780./1280, 70./720];
    handles.GraphPosF3 = [220./1280, 320./720, 780./1280, 70./720];
    handles.GraphPosF4 = [220./1280, 225./720, 780./1280, 70./720];
    handles.GraphPosF5 = [220./1280, 130./720, 780./1280, 70./720];
    handles.GraphPosF6 = [220./1280, 35./720, 780./1280, 70./720];
    handles.GraphPosG1 = [215./1280, 513./720, 785./1280, 54./720];
    handles.GraphPosG2 = [215./1280, 435./720, 785./1280, 54./720];
    handles.GraphPosG3 = [215./1280, 356./720, 785./1280, 54./720];
    handles.GraphPosG4 = [215./1280, 277./720, 785./1280, 54./720];
    handles.GraphPosG5 = [215./1280, 198./720, 785./1280, 54./720];
    handles.GraphPosG6 = [215./1280, 119./720, 785./1280, 54./720];
    handles.GraphPosG7 = [215./1280, 40./720, 785./1280, 54./720];
    handles.GraphPosH1 = [215./1280, 530./720, 790./1280, 45./720];
    handles.GraphPosH2 = [215./1280, 460./720, 790./1280, 45./720];
    handles.GraphPosH3 = [215./1280, 390./720, 790./1280, 45./720];
    handles.GraphPosH4 = [215./1280, 330./720, 790./1280, 45./720];
    handles.GraphPosH5 = [215./1280, 250./720, 790./1280, 45./720];
    handles.GraphPosH6 = [215./1280, 180./720, 790./1280, 45./720];
    handles.GraphPosH7 = [215./1280, 110./720, 790./1280, 45./720];
    handles.GraphPosH8 = [215./1280, 40./720, 790./1280, 45./720];
    
    set(handles.overlayyes_check_analyser, 'value', 0);
    set(handles.overlayno_check_analyser, 'value', 1);
    handles.CurrentstatusOverlayYes = 0;
    handles.CurrentstatusOverlayNo = 1;
    
    handles.CurrentvalueSplitsPacing = 0;
    set(handles.showsplits_check_analyser, 'Value', 0);
    handles.CurrentvalueSplits1D = 1;
    set(handles.splits1D_check_analyser, 'Value', 1);
    handles.CurrentvalueSplits2D = 0;
    set(handles.splits2D_check_analyser, 'Value', 0);
    handles.CurrentvalueSplits3D = 0;
    set(handles.splits3D_check_analyser, 'Value', 0);
    handles.CurrentvalueDistSplitsPacing = [];
    handles.CurrentvalueRaceLapPacing = 1;
    handles.CurrentSplitsPercentagePacing = 1;
    handles.CurrentSplitsTimePacing = 0;
    handles.CurrentSplitsOffPacing = 0;
    set(handles.splitsPercentage_check_analyser, 'Value', 1);
    set(handles.splitsTime_check_analyser, 'Value', 0);
    set(handles.splitsOff_check_analyser, 'Value', 0);
    
    set(handles.txtpage, 'string', 'Analyser_main');
%     drawnow;
end;

%---Start database button down
if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
    axes(handles.start_database_main); imshow(handles.icones.start_offb);
%     drawnow;

    %---Hide axes welcome
    set(allchild(handles.logo_sparta_main), 'Visible', 'off');
    set(allchild(handles.logo_analyser_main), 'Visible', 'off');
    set(allchild(handles.logo_database_main), 'Visible', 'off');
    set(allchild(handles.logo_benchmark_main), 'Visible', 'off');
    set(allchild(handles.start_analyser_main), 'Visible', 'off');
    set(allchild(handles.start_database_main), 'Visible', 'off');
    set(allchild(handles.start_benchmark_main), 'Visible', 'off');
    
    %---Hide uicontrols welcome
    set(handles.txtlasupdate_main, 'Visible', 'off');
    set(handles.txtsoftwareversion_main, 'Visible', 'off');
    set(handles.txtwelcome_main, 'Visible', 'off');
    set(handles.txtlogo_analyser_main, 'Visible', 'off');
    set(handles.txtlogo_database_main, 'Visible', 'off');
    set(handles.txtlogo_benchmark_main, 'Visible', 'off');
    set(handles.tasktodo_main, 'Visible', 'off');
    
    %---Show elements
    set(allchild(handles.Question_button_database), 'Visible', 'on');
    set(handles.Question_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Downloaddata_button_database), 'Visible', 'on');
    set(handles.Downloaddata_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Downloadraw_button_database), 'Visible', 'on');
    set(handles.Downloadraw_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Downloadbenchmark_button_database), 'Visible', 'on');
    set(handles.Downloadbenchmark_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.DownloadAMS_button_database), 'Visible', 'on');
    set(handles.DownloadAMS_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Downloadall_button_database), 'Visible', 'on');
    set(handles.Downloadpeople_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Downloadpeople_button_database), 'Visible', 'on');
    set(handles.Downloadall_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Downloadnew_button_database), 'Visible', 'on');
    set(handles.Downloadnew_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Downloadselect_button_database), 'Visible', 'on');
    set(handles.Downloadselect_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Arrowback_button_database), 'Visible', 'on');
    set(handles.Arrowback_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Validate_button_database), 'Visible', 'on');
    set(handles.Validate_button_database, 'XTick', [], 'YTick', []);
    set(allchild(handles.Redcross_button_database), 'Visible', 'on');
    
    set(handles.tabledisplaytxt1_database, 'Visible', 'on');
    set(handles.popDisplayResults_database, 'Visible', 'on');
    set(handles.databasedisplayoptions_database, 'Visible', 'on');
    set(handles.databasefilteroptions_database, 'Visible', 'on');
    set(handles.databasefilteroptions_database, 'Visible', 'on');

    set(handles.hf_w1_welcome, 'ResizeFcn', '');

    %---Display database
    source = 'Disp';
    Disp_Database;
    handles.sortbyExceptionSelection = 0;
    
    %---page
    set(handles.txtpage, 'string', 'Database_main');
end;



%---Start benchmark button down
if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
    axes(handles.start_benchmark_main); imshow(handles.icones.start_offb);

    %---Hide axes welcome
    set(allchild(handles.logo_sparta_main), 'Visible', 'off');
    set(allchild(handles.logo_analyser_main), 'Visible', 'off');
    set(allchild(handles.logo_database_main), 'Visible', 'off');
    set(allchild(handles.logo_benchmark_main), 'Visible', 'off');
    set(allchild(handles.start_analyser_main), 'Visible', 'off');
    set(allchild(handles.start_database_main), 'Visible', 'off');
    set(allchild(handles.start_benchmark_main), 'Visible', 'off');
    
    %---Hide uicontrols welcome
    set(handles.txtlasupdate_main, 'Visible', 'off');
    set(handles.txtsoftwareversion_main, 'Visible', 'off');
    set(handles.txtwelcome_main, 'Visible', 'off');
    set(handles.txtlogo_analyser_main, 'Visible', 'off');
    set(handles.txtlogo_database_main, 'Visible', 'off');
    set(handles.txtlogo_benchmark_main, 'Visible', 'off');
    set(handles.tasktodo_main, 'Visible', 'off');
    
    
    %---Show elements
    set(allchild(handles.Question_button_benchmark), 'Visible', 'on');
    set(handles.Question_button_benchmark, 'XTick', [], 'YTick', []);
    set(allchild(handles.Save_button_benchmark), 'Visible', 'on');
    set(handles.Save_button_benchmark, 'XTick', [], 'YTick', []);
    set(allchild(handles.Arrowback_button_benchmark), 'Visible', 'on');
    set(handles.Arrowback_button_benchmark, 'XTick', [], 'YTick', []);
    set(allchild(handles.ClearSearchRanking_benchmark), 'Visible', 'on');
    set(handles.ClearSearchRanking_benchmark, 'XTick', [], 'YTick', []);
    set(allchild(handles.ValidateSearchRanking_benchmark), 'Visible', 'on');
    set(handles.ValidateSearchRanking_benchmark, 'XTick', [], 'YTick', []);
    
    set(handles.ranking_toggle_benchmark, 'Visible', 'on');
    set(handles.profile_toggle_benchmark, 'Visible', 'on');
    set(handles.trend_toggle_benchmark, 'Visible', 'on');
    set(handles.SelectRaceRanking_benchmark, 'Visible', 'on');
    set(handles.SelectDataRanking_benchmark, 'Visible', 'on');
    set(handles.SelectSwimmerRanking_benchmark, 'Visible', 'on');
    
    
    %---Initialise
    set(handles.SelectGenderRanking_benchmark, 'Value', 1);
    set(handles.SelectStrokeRanking_benchmark, 'Value', 1);
    set(handles.SelectDistanceRanking_benchmark, 'Value', 1);
    set(handles.SelectPoolRanking_benchmark, 'Value', 1);
    set(handles.SelectCategoryRanking_benchmark, 'Value', 1);
    set(handles.SelectAgeRanking_benchmark, 'Value', 1);
    set(handles.SelectDatasetRanking_benchmark, 'Value', 1);
    set(handles.SelectPBRanking_benchmark, 'Value', 1);
    set(handles.SelectAthleteRanking_benchmark, 'Value', 1);
    set(handles.SelectAthleteProfile_benchmark, 'Value', 1);
    set(handles.SelectDistanceProfile_benchmark, 'Value', 1);
    set(handles.SelectStrokeRanking_benchmark, 'Value', 1);
    set(handles.SelectPoolRanking_benchmark, 'Value', 1);
    set(handles.SelectPerfProfile_benchmark, 'Value', 1);
    set(handles.SelectAgeProfile_benchmark, 'Value', 1);
    set(handles.SelectCountryRanking_benchmark, 'Value', 1);
    set(handles.SelectSeasonRanking_benchmark, 'Value', 1);
    set(handles.salRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.finaRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.strictAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.belowAgeRanking_benchmark, 'Value', 0, 'enable', 'off');

    handles.existRankings = 0;
    handles.existProfile = 0;
    handles.currentBenchmarkToggle = 1;
    set(handles.ranking_toggle_benchmark, 'Value', 1);
    set(handles.profile_toggle_benchmark, 'Value', 0);
    set(handles.trend_toggle_benchmark, 'Value', 0);
    
    handles.selectAgeLimRanking_benchmark = 0;
    handles.selectAgeRulesRanking_benchmark = 0;
    set(handles.SearchAthleteRanking_benchmark, 'String', '');
    set(allchild(handles.MainRanking_benchmark), 'Visible', 'off');
    set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'off');
    set(allchild(handles.MainProfile_benchmark), 'Visible', 'off');
    handles.AthleteNamesListDispRanking = handles.AthleteNamesList;
    handles.AthleteNamesListDispProfile = handles.AthleteNamesList;
    handles.AthleteNamesListDispTrend = handles.AthleteNamesList;
    set(handles.SelectAgeRanking_benchmark, 'String', handles.SelectAgeRankingList_benchmark, 'Value', 1);
    set(handles.SelectAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
    set(handles.SelectAthleteProfile_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
    
    handles.selectAgeLimProfile_benchmark = 0;
    handles.selectAgeRulesProfile_benchmark = 0;
    set(handles.SearchAthleteProfile_benchmark, 'String', '');
    set(handles.SelectAgeProfile_benchmark, 'String', handles.SelectAgeProfileList_benchmark, 'Value', 1);
    handles.addPerfRanking = [];
    handles.addPerfProfile = [];
        
    %---page
    set(handles.txtpage, 'string', 'Benchmark_main');
    
end;

% set(allchild(handles.hf_question_main),'visible','off');

