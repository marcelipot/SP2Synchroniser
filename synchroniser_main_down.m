% P1 = get(handles.Question_button_sync, 'position');
% P2 = get(handles.Downloaddata_button_sync, 'position');
% P3 = get(handles.Downloadraw_button_sync, 'position');
% P4 = get(handles.Downloadbenchmark_button_sync, 'position');
P5 = get(handles.Downloadall_button_sync, 'position');
P6 = get(handles.Downloadnew_button_sync, 'position');
P7 = get(handles.Downloadselect_button_sync, 'position');
P8 = get(handles.Arrowback_button_sync, 'position');
P9 = get(handles.Validate_button_sync, 'position');
P10 = get(handles.Redcross_button_sync, 'position');
P11 = get(handles.Downloadpeople_button_sync, 'position');
% P12 = get(handles.DownloadAMS_button_sync, 'position');
P13 = get(handles.DownloadSP1_button_sync, 'position');
P14 = get(handles.DownloadGE_button_sync, 'position');
P15 = get(handles.Downloadtimer_button_sync, 'position');
P16 = get(handles.DeleteDB_button_sync, 'position');
P17 = get(handles.DuplicateDB_button_sync, 'position');
P18 = get(handles.OpenJSON_button_sync, 'position');
P19 = get(handles.OpenMAT_button_sync, 'position');

%---Question button down
% if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
%     axes(handles.Question_button_sync); imshow(handles.icones.question_onb);
% %     drawnow;
% end;

%---create download data icone
% if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
%     axes(handles.Downloaddata_button_sync); imshow(handles.icones.downloaddata_onb);
% %     drawnow;
% end;

%---create download raw icone
% if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
%     axes(handles.Downloadraw_button_sync); imshow(handles.icones.downloadraw_onb);
% %     drawnow;
% end;

%---create download benchmark benchmark icon
% if pt(1,1) >= P4(1,1) & pt(1,1) <= (P4(1,1)+P4(1,3)) & pt(1,2) >= P4(1,2) & pt(1,2) <= (P4(1,2)+P4(1,4));
%     axes(handles.Downloadbenchmark_button_sync); imshow(handles.icones.downloadbenchmark_onb);
% %     drawnow;
% end;

%---create download benchmark benchmark icon
% if pt(1,1) >= P12(1,1) & pt(1,1) <= (P12(1,1)+P12(1,3)) & pt(1,2) >= P12(1,2) & pt(1,2) <= (P12(1,2)+P12(1,4));
%     axes(handles.DownloadAMS_button_sync); imshow(handles.icones.AMS_onb);
% %     drawnow;
% end;


%---create download all
if pt(1,1) >= P5(1,1) & pt(1,1) <= (P5(1,1)+P5(1,3)) & pt(1,2) >= P5(1,2) & pt(1,2) <= (P5(1,2)+P5(1,4));
    axes(handles.Downloadall_button_sync); imshow(handles.icones.cloudall_onb);
%     drawnow;
end;

%---create download new
if pt(1,1) >= P6(1,1) & pt(1,1) <= (P6(1,1)+P6(1,3)) & pt(1,2) >= P6(1,2) & pt(1,2) <= (P6(1,2)+P6(1,4));
    axes(handles.Downloadnew_button_sync); imshow(handles.icones.cloudnew_onb);
%     drawnow;
end;

%---create download selected
if pt(1,1) >= P7(1,1) & pt(1,1) <= (P7(1,1)+P7(1,3)) & pt(1,2) >= P7(1,2) & pt(1,2) <= (P7(1,2)+P7(1,4));
    axes(handles.Downloadselect_button_sync); imshow(handles.icones.cloudselect_onb);
%     drawnow;
end;

%---create arrow back icone
if pt(1,1) >= P8(1,1) & pt(1,1) <= (P8(1,1)+P8(1,3)) & pt(1,2) >= P8(1,2) & pt(1,2) <= (P8(1,2)+P8(1,4));
    axes(handles.Arrowback_button_sync); imshow(handles.icones.arrow_back_onb);
%     drawnow;
end;

%---create validate icone
if pt(1,1) >= P9(1,1) & pt(1,1) <= (P9(1,1)+P9(1,3)) & pt(1,2) >= P9(1,2) & pt(1,2) <= (P9(1,2)+P9(1,4));
    axes(handles.Validate_button_sync); imshow(handles.icones.validate_onb);
%     drawnow;
end;

%---create clear icone
if pt(1,1) >= P10(1,1) & pt(1,1) <= (P10(1,1)+P10(1,3)) & pt(1,2) >= P10(1,2) & pt(1,2) <= (P10(1,2)+P10(1,4));
    axes(handles.Redcross_button_sync); imshow(handles.icones.redcross_onb);
%     drawnow;
end;

%---create download people icon
if pt(1,1) >= P11(1,1) & pt(1,1) <= (P11(1,1)+P11(1,3)) & pt(1,2) >= P11(1,2) & pt(1,2) <= (P11(1,2)+P11(1,4));
    axes(handles.Downloadpeople_button_sync); imshow(handles.icones.people_onb);
    
end;

%---create download SP1 icon
if pt(1,1) >= P13(1,1) & pt(1,1) <= (P13(1,1)+P13(1,3)) & pt(1,2) >= P13(1,2) & pt(1,2) <= (P13(1,2)+P13(1,4));
    axes(handles.DownloadSP1_button_sync); imshow(handles.icones.SP1_onb);
    
end;

%---create download GE icon
if pt(1,1) >= P14(1,1) & pt(1,1) <= (P14(1,1)+P14(1,3)) & pt(1,2) >= P14(1,2) & pt(1,2) <= (P14(1,2)+P14(1,4));
    axes(handles.DownloadGE_button_sync); imshow(handles.icones.GE_onb);
    
end;

%---create download Timer icon
if pt(1,1) >= P15(1,1) & pt(1,1) <= (P15(1,1)+P15(1,3)) & pt(1,2) >= P15(1,2) & pt(1,2) <= (P15(1,2)+P15(1,4));
    axes(handles.Downloadtimer_button_sync); imshow(handles.icones.cloudTimer_onb);

end;

%---create delete DB icon
if pt(1,1) >= P16(1,1) & pt(1,1) <= (P16(1,1)+P16(1,3)) & pt(1,2) >= P16(1,2) & pt(1,2) <= (P16(1,2)+P16(1,4));
    axes(handles.DeleteDB_button_sync); imshow(handles.icones.deleteDB_onb);

end;

%---create duplicate DB icon
if pt(1,1) >= P17(1,1) & pt(1,1) <= (P17(1,1)+P17(1,3)) & pt(1,2) >= P15(1,2) & pt(1,2) <= (P17(1,2)+P17(1,4));
    axes(handles.DuplicateDB_button_sync); imshow(handles.icones.duplicate_onb);

end;

%---create Open JSON icon
if pt(1,1) >= P18(1,1) & pt(1,1) <= (P18(1,1)+P18(1,3)) & pt(1,2) >= P18(1,2) & pt(1,2) <= (P18(1,2)+P18(1,4));
    axes(handles.OpenJSON_button_sync); imshow(handles.icones.OpenJSON_onb);

end;

%---create Open MAT icon
if pt(1,1) >= P19(1,1) & pt(1,1) <= (P19(1,1)+P19(1,3)) & pt(1,2) >= P19(1,2) & pt(1,2) <= (P19(1,2)+P19(1,4));
    axes(handles.OpenMAT_button_sync); imshow(handles.icones.OpenMAT_onb);

end;