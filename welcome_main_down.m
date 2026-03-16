
P1 = get(handles.start_analyser_main, 'position');
P2 = get(handles.start_database_main, 'position');
P3 = get(handles.start_benchmark_main, 'position');


%---Start analyser button down
if pt(1,1) >= P1(1,1) & pt(1,1) <= (P1(1,1)+P1(1,3)) & pt(1,2) >= P1(1,2) & pt(1,2) <= (P1(1,2)+P1(1,4));
    axes(handles.start_analyser_main); imshow(handles.icones.start_onb);
%     drawnow;
end;

%---Start database button down
if pt(1,1) >= P2(1,1) & pt(1,1) <= (P2(1,1)+P2(1,3)) & pt(1,2) >= P2(1,2) & pt(1,2) <= (P2(1,2)+P2(1,4));
    axes(handles.start_database_main); imshow(handles.icones.start_onb);
%     drawnow;
end;

%---Start database button down
if pt(1,1) >= P3(1,1) & pt(1,1) <= (P3(1,1)+P3(1,3)) & pt(1,2) >= P3(1,2) & pt(1,2) <= (P3(1,2)+P3(1,4));
    axes(handles.start_benchmark_main); imshow(handles.icones.start_onb);
%     drawnow;
end;