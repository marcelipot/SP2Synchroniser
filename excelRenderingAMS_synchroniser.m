
for k = 1:getCount;
    distEC = specSheet{k,1};
    strokeEC = specSheet{k,2};
    courseEC = specSheet{k,3};
    NbTurns = NbTurnsTot(k);
    
    if courseEC == 50;
        if str2num(distEC) == 50;
            %--------------------------50m Races---------------------------
            %--------------------------------------------------------------
            if k == 1;
                iter = 0;
            else;
                iter = length(properties(:,1));
            end;
            properties{iter+1,1} = ['Sheet' num2str(k)];
            properties{iter+1,2} = 'whole';
            properties{iter+1,3} = 'fontname';
            properties{iter+1,4} = 'Antiqua';
            properties{iter+1,5} = 'fontsize';
            properties{iter+1,6} = 9;
            properties{iter+1,7} = 'verticalalignment';
            properties{iter+1,8} = 'middle';
        
            iter = length(properties(:,1));
            properties{iter+1,1} = ['Sheet' num2str(k)];
            if AMSExportHeader == 1;
                properties{iter+1,2} = ['A1:AS1'];
            else;
                properties{iter+1,2} = ['A1:AS2'];
            end;
            properties{iter+1,3} = 'fontweight';
            properties{iter+1,4} = 'bold';
                    
            rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'AN:AN';...
                'AO:AO';'AP:AP'}; 
            widthCell = [18;18;12;14;14;14;14;14];
            [NbCells, ~] = size(rangeCell);
            iter = length(properties(:,1));
            
            for tt = 1:NbCells;
                properties{iter+tt,1} = ['Sheet' num2str(k)];
                properties{iter+tt,2} = rangeCell{tt};
                properties{iter+tt,3} = 'columnwidth';
                properties{iter+tt,4} = widthCell(tt);
            end;
           
            if AMSExportHeader == 2;

                rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                    'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'AM1:AM2';'AN1:AN2';'AO1:AO2';'AP1:AP2';...
                    'AQ1:AQ2';'AR1:AR2';'AS1:AS2'}; 
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));

                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'mergecells';
                    properties{iter+tt,4} = 1;
                end;

                rangeCell = {'N1:R1';'S1:W1';'X1:AB1';'AC1:AG1';'AH1:AL1'}; 
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'mergecells';
                    properties{iter+tt,4} = 1;
                end;
            end;

        elseif str2num(distEC) == 100;
    
            %-------------------------100m Races---------------------------
            %--------------------------------------------------------------
            if k == 1;
                iter = 0;
            else;
                iter = length(properties(:,1));
            end;

            properties{iter+1,1} = ['Sheet' num2str(k)];
            properties{iter+1,2} = 'whole';
            properties{iter+1,3} = 'fontname';
            properties{iter+1,4} = 'Antiqua';
            properties{iter+1,5} = 'fontsize';
            properties{iter+1,6} = 9;
            properties{iter+1,7} = 'verticalalignment';
            properties{iter+1,8} = 'middle';
        
            iter = length(properties(:,1));
            properties{iter+1,1} = ['Sheet' num2str(k)];
            if AMSExportHeader == 1;
                properties{iter+1,2} = ['A1:BX1'];
            else;
                properties{iter+1,2} = ['A1:BX2'];
            end;
            properties{iter+1,3} = 'fontweight';
            properties{iter+1,4} = 'bold';
                    
            rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'BM:BM';...
                'BN:BN';'BO:BO';'BP:BP'}; 
            widthCell = [18;18;12;14;14;14;14;14;14];
            [NbCells, ~] = size(rangeCell);
            iter = length(properties(:,1));
            
            for tt = 1:NbCells;
                properties{iter+tt,1} = ['Sheet' num2str(k)];
                properties{iter+tt,2} = rangeCell{tt};
                properties{iter+tt,3} = 'columnwidth';
                properties{iter+tt,4} = widthCell(tt);
            end;

            if AMSExportHeader == 2;

                rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                    'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'BL1:BL2';'BM1:BM2';'BN1:BN2';'BO1:BO2';...
                    'BP1:BP2';'BQ1:BQ2';'BX1:BX2'}; 
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));

                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'mergecells';
                    properties{iter+tt,4} = 1;
                end;

                rangeCell = {'N1:W1';'X1:AG1';'AH1:AQ1';'AR1:BA1';'BB1:BK1'}; 
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'mergecells';
                    properties{iter+tt,4} = 1;
                end;

                rangeCell = {'BR1:BW1'}; 
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'mergecells';
                    properties{iter+tt,4} = 1;
                end;
            end;
            
        elseif str2num(distEC) == 150;

            properties = {};

        elseif str2num(distEC) == 200;
            
            %-------------------------200m Races---------------------------
            %--------------------------------------------------------------
            if AMSExportType == 2;

                if k == 1;
                    iter = 0;
                else;
                    iter = length(properties(:,1));
                end;
                properties{iter+1,1} = ['Sheet' num2str(k)];
                properties{iter+1,2} = 'whole';
                properties{iter+1,3} = 'fontname';
                properties{iter+1,4} = 'Antiqua';
                properties{iter+1,5} = 'fontsize';
                properties{iter+1,6} = 9;
                properties{iter+1,7} = 'verticalalignment';
                properties{iter+1,8} = 'middle';
            
                iter = length(properties(:,1));
                properties{iter+1,1} = ['Sheet' num2str(k)];
                if AMSExportHeader == 1;
                    properties{iter+1,2} = ['A1:BZ1'];
                else;
                    properties{iter+1,2} = ['A1:BZ2'];
                end;
                properties{iter+1,3} = 'fontweight';
                properties{iter+1,4} = 'bold';
                        
                rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'BC:BC';...
                    'BD:BD';'BE:BE';'BF:BF'}; 
                widthCell = [18;18;12;14;14;14;14;14;14];
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'columnwidth';
                    properties{iter+tt,4} = widthCell(tt);
                end;
                
                if AMSExportHeader == 2;
                    rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                        'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'BB1:BB2';'BC1:BC2';'BD1:BD2';'BE1:BE2';...
                        'BF1:BF2';'BG1:BG2';'BZ1:BZ2'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
    
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                    
                    rangeCell = {'N1:U1';'V1:AC1';'AD1:AK1';'AL1:AS1';'AT1:BA1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
    
                    rangeCell = {'BH1:BM1';'BN1:BS1';'BT1:BY1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                end;

            else;

                if k == 1;
                    iter = 0;
                else;
                    iter = length(properties(:,1));
                end;

                properties{iter+1,1} = ['Sheet' num2str(k)];
                properties{iter+1,2} = 'whole';
                properties{iter+1,3} = 'fontname';
                properties{iter+1,4} = 'Antiqua';
                properties{iter+1,5} = 'fontsize';
                properties{iter+1,6} = 9;
                properties{iter+1,7} = 'verticalalignment';
                properties{iter+1,8} = 'middle';
            
                iter = length(properties(:,1));
                properties{iter+1,1} = ['Sheet' num2str(k)];
                if AMSExportHeader == 1;
                    properties{iter+1,2} = ['A1:EH1'];
                else;
                    properties{iter+1,2} = ['A1:EH2'];
                end;
                properties{iter+1,3} = 'fontweight';
                properties{iter+1,4} = 'bold';
                        
                rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'DK:DK';...
                    'DL:DL';'DM:DM';'DN:DN'}; 
                widthCell = [18;18;12;14;14;14;14;14;14];
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'columnwidth';
                    properties{iter+tt,4} = widthCell(tt);
                end;
                
                if AMSExportHeader == 2;

                    rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                        'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'DJ1:DJ2';'DK1:DK2';'DL1:DL2';'DM1:DM2';...
                        'DN1:DN2';'DO1:DO2';'EH1:EH2'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
    
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;

                    rangeCell = {'N1:AG1';'AH1:BA1';'BB1:BU1';'BV1:CO1';'CP1:DI1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;

                    rangeCell = {'DP1:DU1';'DV1:EA1';'EB1:EG1'};
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                end;
            end;

        elseif str2num(distEC) == 400;
    
            %-------------------------400m Races---------------------------
            %--------------------------------------------------------------
            if AMSExportType == 2;

                if k == 1;
                    iter = 0;
                else;
                    iter = length(properties(:,1));
                end;

                properties{iter+1,1} = ['Sheet' num2str(k)];
                properties{iter+1,2} = 'whole';
                properties{iter+1,3} = 'fontname';
                properties{iter+1,4} = 'Antiqua';
                properties{iter+1,5} = 'fontsize';
                properties{iter+1,6} = 9;
                properties{iter+1,7} = 'verticalalignment';
                properties{iter+1,8} = 'middle';
                
                iter = length(properties(:,1));
                properties{iter+1,1} = ['Sheet' num2str(k)];
                if AMSExportHeader == 1;
                    properties{iter+1,2} = ['A1:EL1'];
                else;
                    properties{iter+1,2} = ['A1:EL2'];
                end;
                properties{iter+1,3} = 'fontweight';
                properties{iter+1,4} = 'bold';
                        
                rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'CQ:CQ';...
                    'CR:CR';'CS:CS';'CT:CT'}; 
                widthCell = [18;18;12;14;14;14;14;14;14];
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'columnwidth';
                    properties{iter+tt,4} = widthCell(tt);
                end;
                
                if AMSExportHeader == 2;
                    rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                        'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'CP1:CP2';'CQ1:CQ2';'CR1:CR2';'CS1:CS2';...
                        'CT1:CT2';'CU1:CU2';'EL1:EL2'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
    
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
    
                    rangeCell = {'N1:AC1';'AD1:AS1';'AT1:BI1';'BJ1:BY1';'BZ1:CO1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;

                    rangeCell = {'CV1:DA1';'DB1:DG1';'DH1:DM1';'DN1:DS1';'DT1:DY1';...
                        'DZ1:EE1';'Ef1:EK1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                end;
                
            else;

                if k == 1;
                    iter = 0;
                else;
                    iter = length(properties(:,1));
                end;

                properties{iter+1,1} = ['Sheet' num2str(k)];
                properties{iter+1,2} = 'whole';
                properties{iter+1,3} = 'fontname';
                properties{iter+1,4} = 'Antiqua';
                properties{iter+1,5} = 'fontsize';
                properties{iter+1,6} = 9;
                properties{iter+1,7} = 'verticalalignment';
                properties{iter+1,8} = 'middle';
            
                iter = length(properties(:,1));
                properties{iter+1,1} = ['Sheet' num2str(k)];
                if AMSExportHeader == 1;
                    properties{iter+1,2} = ['A1:JB1'];
                else;
                    properties{iter+1,2} = ['A1:JB2'];
                end;
                properties{iter+1,3} = 'fontweight';
                properties{iter+1,4} = 'bold';
                        
                rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'HG:HG';...
                    'HH:HH';'HI:HI';'HJ:HJ'}; 
                widthCell = [18;18;12;14;14;14;14;14;14];
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'columnwidth';
                    properties{iter+tt,4} = widthCell(tt);
                end;
                
                if AMSExportHeader == 2;
                    rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                        'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'HF1:HF2';'HG1:HG2';'HH1:HH2';'HI1:HI2';...
                        'HJ1:HJ2';'HK1:HK2';'JB1:JB2'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
    
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                    
                    rangeCell = {'N1:BA1';'BB1:CO1';'CP1:EC1';'ED1:FQ1';'FR1:HE1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;

                    rangeCell = {'HL1:HQ1';'HR1:HW1';'HX1:IC1';'ID1:II1';'IJ1:IO1';...
                        'IP1:IU1'; 'IV1:JA1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                end;
            end;

        elseif str2num(distEC) == 800;
            
            %-------------------------800m Races---------------------------
            %--------------------------------------------------------------
            if AMSExportType == 2;
                if k == 1;
                    iter = 0;
                else;
                    iter = length(properties(:,1));
                end;

                properties{iter+1,1} = ['Sheet' num2str(k)];
                properties{iter+1,2} = 'whole';
                properties{iter+1,3} = 'fontname';
                properties{iter+1,4} = 'Antiqua';
                properties{iter+1,5} = 'fontsize';
                properties{iter+1,6} = 9;
                properties{iter+1,7} = 'verticalalignment';
                properties{iter+1,8} = 'middle';
            
                iter = length(properties(:,1));
                properties{iter+1,1} = ['Sheet' num2str(k)];
                if AMSExportHeader == 1;
                    properties{iter+1,2} = ['A1:JJ1'];
                else;
                    properties{iter+1,2} = ['A1:JJ2'];
                end;
                properties{iter+1,3} = 'fontweight';
                properties{iter+1,4} = 'bold';
                        

                rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'FS:FS';...
                    'FT:FT';'FU:FU';'FV:FV'}; 
                widthCell = [18;18;12;14;14;14;14;14;14];
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'columnwidth';
                    properties{iter+tt,4} = widthCell(tt);
                end;
                
                if AMSExportHeader == 2;
                    rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                        'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'FR1:FR2';'FS1:FS2';'FT1:FT2';'FU1:FU2';...
                        'FV1:FV2';'FW1:FW2';'JJ1:JJ2'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
    
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
    
                    rangeCell = {'N1:AS1';'AT1:BY1';'BZ1:DE1';'DF1:EK1';'EL1:FQ1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;

                    rangeCell = {'FX1:GC1';'GD1:GI1';'GJ1:GO1';'GP1:GU1';'GV1:HA1';...
                        'HB1:HG1';'HH1:HM1';'HN1:HS1';'HT1:HY1';'HZ1:IE1';'IF1:IK1';...
                        'IL1:IQ1';'IR1:IW1';'IX1:JC1';'JD1:JI1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                end;
                
            else;

                if k == 1;
                    iter = 0;
                else;
                    iter = length(properties(:,1));
                end;

                properties{iter+1,1} = ['Sheet' num2str(k)];
                properties{iter+1,2} = 'whole';
                properties{iter+1,3} = 'fontname';
                properties{iter+1,4} = 'Antiqua';
                properties{iter+1,5} = 'fontsize';
                properties{iter+1,6} = 9;
                properties{iter+1,7} = 'verticalalignment';
                properties{iter+1,8} = 'middle';
            
                iter = length(properties(:,1));
                properties{iter+1,1} = ['Sheet' num2str(k)];
                if AMSExportHeader == 1;
                    properties{iter+1,2} = ['A1:SP1'];
                else;
                    properties{iter+1,2} = ['A1:SP2'];
                end;
                properties{iter+1,3} = 'fontweight';
                properties{iter+1,4} = 'bold';
                        
                rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'OY:OY';...
                    'OZ:OZ';'PA:PA';'PB:PB'}; 
                widthCell = [18;18;12;14;14;14;14;14;14];
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'columnwidth';
                    properties{iter+tt,4} = widthCell(tt);
                end;
                
                if AMSExportHeader == 2;
                    rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                        'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'OX1:OX2';'OY1:OY2';'OZ1:OZ2';'PA1:PA2';...
                        'PB1:PB2';'PC1:PC2';'SP1:SP2'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
    
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                    
                    rangeCell = {'N1:CO1';'CP1:FQ1';'FR1:IS1';'IT1:LU1';'LV1:OW1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;

                    rangeCell = {'PD1:PI1';'PJ1:PO1';'PP1:PU1';'PV1:QA1';'QB1:QG1';...
                        'QH1:QM1';'QN1:QS1';'QT1:QY1';'QZ1:RE1';'RF1:RK1';'RL1:RQ1';...
                        'RR1:RW1';'RX1:SC1';'SD1:SI1';'SJ1:SO1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                end;
            end;

        elseif str2num(distEC) == 1500;

            %------------------------1500m Races---------------------------
            %--------------------------------------------------------------
            if AMSExportType == 2;
                
                if k == 1;
                    iter = 0;
                else;
                    iter = length(properties(:,1));
                end;

                properties{iter+1,1} = ['Sheet' num2str(k)];
                properties{iter+1,2} = 'whole';
                properties{iter+1,3} = 'fontname';
                properties{iter+1,4} = 'Antiqua';
                properties{iter+1,5} = 'fontsize';
                properties{iter+1,6} = 9;
                properties{iter+1,7} = 'verticalalignment';
                properties{iter+1,8} = 'middle';
                
                iter = length(properties(:,1));
                properties{iter+1,1} = ['Sheet' num2str(k)];
                if AMSExportHeader == 1;
                    properties{iter+1,2} = ['A1:RZ1'];
                else;
                    properties{iter+1,2} = ['A1:RZ2'];
                end;
                properties{iter+1,3} = 'fontweight';
                properties{iter+1,4} = 'bold';
                

                rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'LC:LC';...
                    'LD:LD';'LE:LE';'LF:LF'}; 
                widthCell = [18;18;12;14;14;14;14;14;14];
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'columnwidth';
                    properties{iter+tt,4} = widthCell(tt);
                end;

                
                if AMSExportHeader == 2;
                    rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                        'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'LB1:LB2';'LC1:LC2';'LD1:LD2';'LE1:LE2';...
                        'LF1:LF2';'LG1:LG2';'RZ1:RZ2'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
    
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                    
                    rangeCell = {'N1:BU1';'BV1:EC1';'ED1:GK1';'GL1:IS1';'IT1:LA1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;

                    rangeCell = {'LH1:LM1';'LN1:LS1';'LT1:LY1';'LZ1:ME1';'MF1:MK1'; ...
                        'ML1:MQ1'; 'MR1:MW1'; 'MX1:NC1'; 'ND1:NI1'; 'NJ1:NO1'; ...
                        'NP1:NU1'; 'NV1:OA1'; 'OB1:OG1'; 'OH1:OM1'; 'ON1:OS1'; ...
                        'OT1:OY1'; 'OZ1:PE1'; 'PF1:PK1'; 'PL1:PQ1'; 'PR1:PW1'; ...
                        'PX1:QC1'; 'QD1:QI1'; 'QJ1:QO1'; 'QP1:QU1'; 'QV1:RA1'; ...
                        'RB1:RG1'; 'RH1:RM1'; 'RN1:RS1'; 'RT1:RY1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                end;
            else;
                
                if k == 1;
                    iter = 0;
                else;
                    iter = length(properties(:,1));
                end;

                properties{iter+1,1} = ['Sheet' num2str(k)];
                properties{iter+1,2} = 'whole';
                properties{iter+1,3} = 'fontname';
                properties{iter+1,4} = 'Antiqua';
                properties{iter+1,5} = 'fontsize';
                properties{iter+1,6} = 9;
                properties{iter+1,7} = 'verticalalignment';
                properties{iter+1,8} = 'middle';
                                
                iter = length(properties(:,1));
                properties{iter+1,1} = ['Sheet' num2str(k)];
                if AMSExportHeader == 1;
                    properties{iter+1,2} = ['A1:AJH1'];
                else;
                    properties{iter+1,2} = ['A1:AJH2'];
                end;
                properties{iter+1,3} = 'fontweight';
                properties{iter+1,4} = 'bold';
                
                rangeCell = {'A:A';'B:B';'E:E';'H:H';'M:M';'ACK:ACK';...
                    'ACL:ACL';'ACM:ACM';'ACN:ACN'}; 
                widthCell = [18;18;12;14;14;14;14;14;14];
                [NbCells, ~] = size(rangeCell);
                iter = length(properties(:,1));
                
                for tt = 1:NbCells;
                    properties{iter+tt,1} = ['Sheet' num2str(k)];
                    properties{iter+tt,2} = rangeCell{tt};
                    properties{iter+tt,3} = 'columnwidth';
                    properties{iter+tt,4} = widthCell(tt);
                end;
                
                if AMSExportHeader == 2;
                    rangeCell = {'A1:A2';'B1:B2';'C1:C2';'D1:D2';'E1:E2';'F1:F2';'G1:G2';'H1:H2';...
                        'I1:I2';'J1:J2';'K1:K2';'L1:L2';'M1:M2';'ACJ1:ACJ2';'ACK1:ACK2';'ACL1:ACL2';'ACM1:ACM2';...
                        'ACN1:ACN2';'ACO1:ACO2';'AJH1:AJH2'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
    
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;
                    
                    rangeCell = {'N1:FG1';'FH1:LA1';'LB1:QU1';'QV1:WO1';'WP1:ACI1'}; 
                    [NbCells, ~] = size(rangeCell);
                    iter = length(properties(:,1));
                    for tt = 1:NbCells;
                        properties{iter+tt,1} = ['Sheet' num2str(k)];
                        properties{iter+tt,2} = rangeCell{tt};
                        properties{iter+tt,3} = 'mergecells';
                        properties{iter+tt,4} = 1;
                    end;

                    NbTurns = 29;
                    rangeCell = {'ACP1:ACU1';'ACV1:ADA1';'ADB1:ADG1';'ADH1:ADM1';'ADN1:ADS1'; ...
                        'ADT1:ADY1'; 'ADZ1:AEE1'; 'AEF1:AEK1'; 'AEL1:AEQ1'; 'AER1:AEW1'; ...
                        'AEX1:AFC1'; 'AFD1:AFI1'; 'AFJ1:AFO1'; 'AFP1:AFU1'; 'AFV1:AGA1'; ...
                        'AGB1:AGG1'; 'AGH1:AGM1'; 'AGN1:AGS1'; 'AGT1:AGY1'; 'AGZ1:AHE1'; ...
                        'AHF1:AHK1'; 'AHL1:AHQ1'; 'AHR1:AHW1'; 'AHX1:AIC1'; 'AID1:AII1'; ...
                        'AIJ1:AIO1'; 'AIP1:AIU1'; 'AIV1:AJA1'; 'AJB1:AJG1'}; 
                    for tt = 1:NbTurns;
                        iter = length(properties(:,1));
                        for k = 1:getCount;
                            properties{iter+1,1} = ['Sheet' num2str(k)];
                            properties{iter+1,2} = rangeCell{tt};
                            properties{iter+1,3} = 'mergecells';
                            properties{iter+1,4} = 1;
                        end;
                    end;
                end;
            end;
        end;
    else;
        %Short Course
    
    end;
end;


% properties{iter,1} = 'Sheet1';
% properties{iter,2} = '1:1';
% properties{iter,3} = 'horizontalalignment';
% properties{iter,4} = 'center';
% iter = iter + 1;
% properties{iter,1} = 'Sheet1';
% properties{iter,2} = '2:2';
% properties{iter,3} = 'horizontalalignment';
% properties{iter,4} = 'center';
% iter = iter + 1;

%-----------------------------------Apply----------------------------------
% sheetnames = {'Key Events'; 'Tracking'};
% xlsProperties([pathname '\' filename], properties, sheetnames);
xlsProperties(AMSExportPath, properties, nameSheet);


