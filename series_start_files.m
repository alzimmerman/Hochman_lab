function [spikingparameters,IV,firstparams, constrained_firstparams, meanfirstparams]=series_start_files

%07813
% ccstep_files={'07813011.abf','07813012.abf'};
% IV_files={'07813013.abf','07813014.abf'};
% names={'base1','base2'};

%07815 cell1
% ccstep_files={'07815005.abf','07815006.abf','07815004.abf'};
% IV_files={'07815003.abf','07815008.abf'};
% names={'base1','base2','-80 hold'};

%07815 cell2
% ccstep_files={'07815015.abf','07815014.abf'};
% IV_files={'07815012.abf','07815017.abf'};
% names={'base1','base2'};

%07920 cell4
% ccstep_files={'07920006.abf'};
% IV_files={'07920015.abf'};
% names={'base'}

%07o24009   
% ccstep_files={'07o24002.abf','07o24009.abf'};
% IV_files={'07o24003.abf','07o24008.abf'};
% names={'base1','base2'};

%07d18 DA
% ccstep_files={'07d18001.abf','07d18004.abf','07d18006.abf','07d18008.abf','07d18010.abf','07d18012.abf'};
% names={'base1','base2','DA1','DA2','wash1','wash2'};

%baseline horizontal -60
% ccstep_files={'08107002.abf','08107083.abf','08115001.abf','08116001.abf','08122002.abf','08122054.abf'};
% IV_files={'08107000.abf','08107081.abf','08115000.abf','08116000.abf','08122001.abf','08122053.abf'};
% names={'1/7/08 c1','1/7/08 c2','1/15/08','1/16/08','1/22/08 c1','1/22/08 c3'};

%baseline transverse -60 until September 08
% ccstep_files={'07815005.abf','07815015.abf','07829013.abf','07n06001.abf','07n09002.abf','08306001.abf','08415024.abf','08423035.abf','08423055.abf','08423116.abf','08423091.abf','08523021.abf','08523089.abf','08529016.abf','08529050.abf','08529064.abf','08529115.abf','08529150.abf','08612007.abf','08616010.abf','08626004.abf','08626040.abf','08708008.abf','08710091.abf'}; %'08805008.abf'};
% IV_files={'07815003.abf', '07815012.abf','07829014.abf','07n06000.abf','07n09001.abf','08306000.abf','08415020.abf','08423033.abf','08423053.abf','08423114.abf','08423089.abf','08523020.abf','08523088.abf','08529017.abf','08529047.abf','08529061.abf','08529109.abf','08529148.abf','08612006.abf','08616009.abf','08626005.abf','08626038.abf','08708007.abf','08710085.abf','08805009.abf'};
% names={'8/15/07 c1','8/15/07 c2','08/28/07','11/6/07','11/9/07','3/6/08','4/15/08','4/23/08 c1','4/23/08 c2','4/23/08 c3','4/23/08 c4','5/23/08 c1','523/08 c2','5/29/08 c1','5/29/08 c2','5/29/08 c3','5/29/08 c5','5/29/08 c6','6/12/08','6/16/08','6/26/08 c1','6/26/08 c2','7/8/08','7/10/08','8/5/08'};

%baseline full for correlations, -60 hold
% ccstep_files={'07815005.abf','07815015.abf','07829013.abf','07n06001.abf','08306001.abf','08415024.abf','08423035.abf','08423055.abf','08423116.abf','08423091.abf','08523021.abf','08523089.abf','08529016.abf','08529050.abf','08529064.abf','08529115.abf','08529150.abf','08612007.abf','08616010.abf','08626004.abf','08626040.abf','08708008.abf','08710091.abf','08805004.abf','08107002.abf','08107083.abf','08115001.abf','08116001.abf','08122002.abf','08122054.abf'};
% %IV_files={'07815003.abf', '07815012.abf','07829014.abf','07n06000.abf','07n09001.abf','08306000.abf','08415020.abf','08423033.abf','08423053.abf','08423114.abf','08423089.abf','08523020.abf','08523088.abf','08529017.abf','08529047.abf','08529061.abf','08529109.abf','08529148.abf','08612006.abf','08616009.abf','08626005.abf','08626038.abf','08708007.abf','08710085.abf','08805009.abf'};
% names={'8/15/07 c1','8/15/07 c2','08/29/07','11/6/07','3/6/08','4/15/08','4/23/08 c1','4/23/08 c2','4/23/08 c4','4/23/08 c3','5/23/08 c1','5/23/08 c2','5/29/08 c1','5/29/08 c2','5/29/08 c3','5/29/08 c5','5/29/08 c6','6/12/08','6/16/08','6/26/08 c1','6/26/08 c2','7/8/08','7/10/08','8/5/08','1/7/08 c1','1/7/08 c2','1/15/08','1/16/08','1/22/08 c1','1/22/08 c2','1/22/08 c3'};

%     {'07d17016.abf','07d18004.abf'};
%baseline transverse -80 until September 08
% ccstep_files={'07815014.abf','07829000.abf','07920006.abf','07927014.abf','07d18004.abf','07o24009.abf','08320003.abf','08320029.abf','08327003.abf','08327016.abf','08327053.abf','08327101.abf', '08422010.abf','08423034.abf','08423054.abf','08423090.abf','08423115.abf','08523087.abf','08626003.abf','08626039.abf','08710090.abf','08805047.abf'};
% IV_files={'07815012.abf','07829001.abf','07927015.abf','08320001.abf','08320028.abf','08327001.abf','08327014.abf','08327050.abf','08327100.abf','08422009.abf','08423114.abf','08523088.abf','08626005.abf','08626038.abf','08710085.abf','08805048.abf'};
% names={'8/15/07','8/29/07','9/20/07','9/27/07','12/18/07','10/24/07','3/20/08 c1','3/20/08 c3','3/27/08 c1','3/27/08 c2','3/27/08 c3','3/27/08 c4','4/22/08','4/23/08 c1','4/23/08 c2','4/23/08 c3','4/23/08 c4','5/23/08','6/26/08 c1','6/26/08 c2','7/10/08','8/5/08'};

%08107 cell 1 2uM DA
% ccstep_files={'08107002.abf','08107004.abf','08107006.abf','08107008.abf','08107010.abf','08107012.abf','08107014.abf','08107016.abf','08107018.abf'};
% names={'base1','base2','base3','DA1','DA2','wash1','wash2','wash3','wash4'};

%08107 cell1 100uM DA- all over
% ccstep_files={'08107024.abf','08107026.abf','08107028.abf','08107030.abf','08107032.abf','08107034.abf','08107036.abf','08107038.abf'};
% names={'base1','base2','DA1','DA2','wash1','wash2','wash3','wash4'};

%08107 cell3 2uM DA- 
% ccstep_files={'08107083.abf','08107085.abf','08107087.abf','08107089.abf','08107091.abf','08107093.abf','08107095.abf','08107097.abf','08107099.abf'};
% names={'base1','base2','DA1','DA2','wash1','wash2','wash3','wash4','wash5'};

%08107 cell3 100uM DA
% ccstep_files={'08107105.abf','08107107.abf','08107109.abf','08107111.abf','08107113.abf','08107115.abf','08107117.abf','08107119.abf'};
% names={'base2','DA1','DA2','wash1','wash2','wash3','wash4'};

% %08107 cell1 2uM try 2
% ccstep_files={'08107047.abf','08107049.abf','08107051.abf','08107053.abf','08107055.abf','08107057.abf','08107059.abf'};
% names={'base','DA1','DA2','wash1','wash2','wash3','wash4'};

%1/16/08 cell1 10uM
% ccstep_files={'08116003.abf','08116007.abf','08116009.abf','08116011.abf','08116013.abf','08116015.abf','08116017.abf'};  %,'08116019.abf','08116021.abf','08116024.abf','08116027.abf'
% names={'base','DA1','DA2','wash1','wash2','wash3','wash4'};  %'wash5','wash6','wash7','wash8'

%08523 cell 2 DA
% ccstep_files={'08523025.abf','08523029.abf','08523031.abf','08523033.abf'}; %'08523035.abf','08523039.abf'
% names={'base','DA','wash1','wash2'}; %'wash3','wash4'

%08523 cell 2 ril
% ccstep_files={'08523039.abf','08523041.abf','08523043.abf','08523045.abf','08523047.abf','08523049.abf','08523052.abf'};
% names={'base','Riluzole','wash1','wash2','wash3','wash4','wash5?'};

%08523 cell 2 NE
ccstep_files={'08523052.abf','08523054.abf','08523056.abf','08523058.abf','08523061.abf','08523064.abf'};
names={'base','NE','wash1','wash2','wash3','wash4'};

%08523 cell 2 5HT
% ccstep_files={'08523064.abf','08523066.abf','08523068.abf','08523070.abf','08523072.abf','08523074.abf','08523076.abf'};
% names={'base','5HT','wash1','wash2','wash3','wash4','wash5'};

%08523 cell4 DA -60
% ccstep_files={'08523089.abf','08523093.abf','08523096.abf','08523099.abf','08523103.abf'};
% names={'base','DA','wash1','wash2','wash3'};

%08523 cell4 DA -80
% ccstep_files={'08523090.abf','08523092.abf','08523095.abf','08523098.abf','08523102.abf'};
% names={'base','DA','wash1','wash2','wash3'};

%08523 cell4 Riluzole
% ccstep_files={'08523103.abf','08523107.abf','08523110.abf','08523113.abf'};
% names={'base?','Riluzole','wash1','wash2'};

%08415 cell2
% ccstep_files={'08415024.abf','08415025.abf'};
% names={'base1','base2'};

%08422 cell 1 DA -80
% ccstep_files={'08422010.abf','08422012.abf','08422015.abf','08422018.abf','08422022.abf'};
% names={'baseline','during DA','1 min after wash','2 min after wash','3 min after wash'};

%08327 cell2 NE 
% ccstep_files={'08327016.abf','08327018.abf','08327020.abf','08327022.abf','08327024.abf'};
% names={'baseline','NE','NE2','1 min after wash','2 min after wash'};

% %08327 cell2 DA
% ccstep_files={'08327024.abf','08327026.abf','08327029.abf','08327031.abf','08327033.abf','08327035.abf'};
% names={'baseline','DA','DA2','1 min after wash','2 min after wash',' 3 min after wash'};

% %08327 cell2 5HT
%  ccstep_files={'08327035.abf','08327037.abf','08327040.abf','08327042.abf','08327044.abf'}; %'08327047.abf'
%  names={'baseline','5HT','5HT2','1 min after wash','2 min after wash'}; %' 3 min after wash'

%08327 cell 3 NE
% ccstep_files={'08327053.abf','08327055.abf','08327057.abf','08327059.abf','08327061.abf'};
% names={'baseline','NE','NE2','1 min after wash','2 min after wash'};

%08327 cell 3 DA- inconsistent holding potential
% ccstep_files={'08327061.abf','08327064.abf','08327066.abf','08327068.abf','08327070.abf'};
% names={'baseline','DA','DA2','1 min after wash','2 min after wash'};

%08327 cell3 5HT
% ccstep_files={'08327070.abf','08327073.abf','08327075.abf','08327077.abf','08327079.abf'};
% names={'baseline','5HT','5HT2','1 min after wash','2 min after wash'};

%08327 cell3 DA+ NE
% ccstep_files={'08327079.abf','08327082.abf','08327084.abf','08327086.abf','08327088.abf'};
% names={'baseline','DA + NE','DA+ NE 2','1 min after wash','2 min after wash'};

%08327 cell3 DA+ 5HT
% ccstep_files={'08327088.abf','08327091.abf','08327093.abf','08327095.abf','08327097.abf'};
% names={'baseline','DA + 5HT','DA+ 5HT 2','1 min after wash','2 min after wash'};

%08327 cell 4 NE
% ccstep_files={'08327101.abf','08327103.abf','08327105.abf','08327107.abf','08327109.abf','08327111.abf'};
% names={'baseline','NE','NE 2','1 min after wash','2 min after wash','3 min after wash'};
% % 

%08327 cell4 DA
% ccstep_files={'08327111.abf','08327113.abf','08327115.abf','08327117.abf','08327119.abf'};
% names={'baseline','DA','1 min after wash','2 min after wash','3 min after wash'};

%08327 cell4 5HT
% ccstep_files={'08327119.abf','08327121.abf','08327123.abf','08327125.abf','08327127.abf','08327131.abf'};
% names={'baseline','5HT','5HT2','1 min after wash','2 min after wash','after hold -80'};

%08422 cell 1 DA -80
% ccstep_files={'08422010.abf','08422012.abf','08422015.abf','08422018.abf'};'08422022.abf'
% names={'baseline','DA','1 min after wash','2 min after wash'}; %'3 min after wash'

%08422 cell 1 NE -80
% ccstep_files={'08422022.abf','08422024.abf','08422027.abf','08422030.abf','08422033.abf','08422037.abf'};
% names={'baseline','NE','1 min after wash','2 min after wash','3 min after wash','rebridge'};

%08422 cell 1 NE -60
% ccstep_files={'08422019.abf','08422025.abf','08422028.abf','08422031.abf','08422034.abf','08422038.abf'};
% names={'baseline?','NE','1 min after wash','2 min after wash','3 min after wash','rebridge'};
% % 
%08422 cell1 5HT
% ccstep_files={'08422037.abf','08422040.abf','08422041.abf','08422046.abf','08422049.abf','08422052.abf'};
% names={'baseline','5HT','1 min after wash','2 min after wash','3 min after wash','4 min after wash'};
% ccstep_files={'08422038.abf','08422041.abf','08422044.abf','08422047.abf','08422050.abf','08422053.abf'};
% names={'baseline','5HT','1 min after wash','2 min after wash','3 min after wash','4 min after wash'};

%08430 cell1 base -80
% ccstep_files={'08430002.abf','08430003.abf','08430005.abf','08430007.abf','08430009.abf','08430011.abf'};
% names={'base1','base2','base3','base4','base5','base6'};

%08430 cell1 DA -80- no bridge balance
% ccstep_files={'08430014.abf','08430016.abf','08430019.abf','08430022.abf','08430025.abf','08430028.abf'};
% names={'base','DA','wash2','wash3','wash4','wash5'};

%08529 cell 1
% ccstep_files={'08529013.abf','08529016.abf','08529019.abf','08529022.abf','08529025.abf'};
% names={'base1','base2','DA','wash1','wash2'};

%08529 cell 3
% ccstep_files={'08529064.abf','08529066.abf','08529069.abf','08529072.abf','08529075.abf'};%,'08529078.abf','08529081.abf'};
% names={'base','DA','wash1','wash2','wash3'}; %,'wash4','wash5'};
% IV_files={'08529061.abf','08529067.abf','08529070.abf','08529073.abf','08529076.abf'};
%injection=[-12.6 -12.6 -13.9 -17.1 -17.7];

%08529 cell 5
% ccstep_files={'08529115.abf','08529117.abf','08529120.abf','08529123.abf','08529126.abf','08529129.abf'};
% names={'base','DA','wash1','wash2','wash3','wash4'};
% IV_files={'08529109.abf','08529118.abf','08529121.abf','08529124.abf','08529127.abf','08529130.abf'};

%08529 cell 6 DA
% ccstep_files={'08529150.abf','08529153.abf','08529156.abf','08529159.abf','08529162.abf','08529165.abf','08529168.abf'};
% names={'base','DA','wash1','wash2','wash3','wash4','wash5'};
% IV_files={'08529148.abf','08529154.abf','08529157.abf','08529160.abf','08529163.abf','08529166.abf','08529169.abf'};

%08529 cell 6 NE- files 93,96, and 99 lost patch
% ccstep_files={'08529188.abf','08529190.abf','08529202.abf','08529205.abf'};  %'08529193.abf','08529196.abf','08529199.abf'
% names={'base','NE','wash4','wash5'}; % 'wash1','wash2','wash3',
% IV_files={'08529187.abf','08529191.abf','08529194.abf','08529197.abf','08529200.abf','08529203.abf','08529206.abf'};

%08603 cell 4
% ccstep_files={'08603066.abf','08603070.abf','08603073.abf','08603075.abf','08603079.abf','08603083.abf'};
% names={'base1','base2','base3','DA','wash1','wash2'};

% %08612 cell2
% ccstep_files={'08612012.abf','08612016.abf','08612020.abf','08612024.abf','08612028.abf'}; %'08612011.abf',
% names={'base3','DA','wash1','wash2','wash3'}; %'base2'
% IV_files={'08612013.abf','08612014.abf','08612017.abf','08612018.abf','08612021.abf','08612022.abf','08612025.abf','08612026.abf','08612029.abf','08612030.abf'};

%08616
% ccstep_files={'08616032.abf','08616034.abf','08616038.abf','08616042.abf','08616046.abf'};
% names={'base2','ril','wash1','wash3','wash4'};
% IV_files={'08616025.abf','08616026.abf','08616035.abf','08616036.abf','08616039.abf','08616040.abf','08616043.abf','08616044.abf','08616047.abf','08616048.abf'};

%08626 cell4 tyramine 1 -80
% ccstep_files={'08626039.abf','08626042.abf','08626045.abf','08626048.abf','08626051.abf'};
% names={'base','tyr','wash 1 min','wash 2 min','wash 3 min'};

%08626 cell4 tyramine 1 -60
% ccstep_files={'08626040.abf','08626043.abf','08626046.abf','08626049.abf','08626052.abf'};
% names={'base','tyr','wash 1 min','wash 2 min','wash 3 min'};

%08626 cell4 tyramine long -60
% ccstep_files={'08626052.abf','08626055.abf','08626058.abf','08626061.abf','08626066.abf','08626069.abf','08626072.abf'}; %,'08626075.abf'};
% names={'base','tyr1','tyr2','tyr3','wash 1 min','wash 2 min','wash 3 min'}; %,'wash 4 min'};

%08710 cell1 NE -60
% ccstep_files={'08710006.abf','08710010.abf','08710013.abf','08710016.abf','08710019.abf','08710022.abf'};
% names={'base','NE','wash1','wash2','wash3','wash4'};

%08710 cell1 NE -80
% ccstep_files={'08710004.abf','08710009.abf','08710012.abf','08710015.abf','08710018.abf','08710021.abf'};
% names={'base','NE','wash1','wash2','wash3','wash4'};

%08710 cell1 5HT -80
% ccstep_files={'08710021.abf','08710024.abf','08710027.abf','08710030.abf','08710033.abf','08710036.abf','08710039.abf'};
% names={'base','5HT','wash1','wash2','wash3','wash4','wash5'};

%08710 cell1 5HT -60
% ccstep_files={'08710022.abf','08710025.abf','08710028.abf','08710031.abf','08710034.abf','08710037.abf','08710040.abf'};
% names={'base','5HT','wash1','wash2','wash3','wash4','wash5'};

%08710 cell4 DA -60
% ccstep_files={'08710091.abf','08710095.abf','08710098.abf','08710101.abf'};
% names={'base','5HT','wash1','wash2'};

%08710 cell4 NE -60
% ccstep_files={'08710104.abf','08710108.abf','08710111.abf','08710114.abf','08710117.abf'};  %'08710120.abf','08710123.abf'
% names={'base','5HT','wash1','wash2','wash3'};  %'wash4','wash5'

%08710 cell4 NE -80
% ccstep_files={'08710105.abf','08710107.abf','08710110.abf','08710113.abf','08710116.abf','08710119.abf','08710122.abf'};
% names={'base','5HT','wash1','wash2','wash3','wash4','wash5'};

%08805 DA -60
% ccstep_files={'08805008.abf','08805011.abf','08805014.abf','08805017.abf'};  %'08805020.abf','08805023.abf'
% names={'base2','DA','wash1','wash2'};  %,'wash3','wash4'
% IV_files={'08805009.abf', '08805012.abf','08805015.abf','08805018.abf','08805021.abf','08805024.abf'};

%08805 DA -80
ccstep_files={'08805047.abf','08805050.abf','08805053.abf','08805056.abf','08805059.abf','08805062.abf'};  %'08805065.abf','08805067.abf'
names={'base','DA','wash1','wash2','wash3','wash4'};  %'wash5','wash6'
% IV_files={'08805048.abf','08805051.abf','08805054.abf','08805057.abf','08805060.abf','08805063.abf','08805066.abf'};

%08805 NE -60
% ccstep_files={'08805026.abf','08805029.abf','08805032.abf','08805035.abf','08805038.abf'};  %'08805041.abf','08805044.abf'
% names={'base','NE','wash1','wash2','wash3'};  %,'wash4','wash5'
% IV_files={'08805027.abf','08805030.abf','08805033.abf','08805036.abf','08805039.abf','08805042.abf','08805045.abf'};

% %08805 NE -80
% ccstep_files={'08805067.abf','08805070.abf','08805073.abf','08805076.abf','08805079.abf','08805082.abf','08805085.abf'};
% names={'base','NE','wash1','wash2','wash3','wash4','wash5'};
% IV_files={'08805066.abf','08805071.abf','08805074.abf','08805077.abf','08805080.abf','08805083.abf','08805086.abf'};

%08805 5HT -60
% ccstep_files={'08805087.abf','08805089.abf','08805092.abf','08805095.abf','08805098.abf','08805101.abf'};
% names={'base','5HT','wash1','wash2','wash3','wash4'};
% IV_files={'08805086.abf','08805090.abf','08805093.abf','08805096.abf','08805099.abf','08805102.abf'};

%09324 cell1
% ccstep_files={'09324005.abf','09324006.abf','09324007.abf'};
% names={'5','6','7'};
% IV_files={'09324001.abf','09324008.abf'};

%09324 cell2
% ccstep_files={'09324017.abf'};
% names={'17'};
%IV_files={'09324018.abf','09324019.abf'};

%09325 cell 2
% ccstep_files={'09325011.abf','09325017.abf','09325022.abf', '09325025.abf','09325026.abf','09325033.abf'};
% names={'base1','base2','NE','wash1','wash1b','wash2'};
% IV_files={'09325009.abf','09325032.abf'};

%09325 cell2 DA
% ccstep_files={'09325033.abf','09325034.abf','09325037.abf', '09325038.abf','09325042.abf','09325043.abf'};
% names={'base1','base2','DA1','DA2','wash1','wash2'};
% IV_files={'09325009.abf','09325032.abf'};


%09325 cell3
% ccstep_files={'09325058.abf'};
% names={'base1','base2'};
% IV_files={'09325054.abf','09325059.abf'};

%09325 cell4
% ccstep_files={'09325070.abf', '09325071.abf'};
% names={'base1','base2'};
% IV_files={'09325068.abf'};

%baseline adults
% ccstep_files={'09325071.abf','09325011.abf','09n18010.abf'};
% names={'09325_c2','09325_c1','09n18'};
L=length(ccstep_files);
firstparams=zeros(L,5); 
injection=zeros(1,L);
[spikingparameters,constrained_firstparams]=comparecurr(ccstep_files,injection);
IV=0; meanfirstparams=zeros(L,5);
%[IV]=compareiv(IV_files);
%  Rm=zeros(1,L);
% half=floor(length(IV_files)./2);
% 
% for j=1:length(IV_files)
%      voltage=IV(j).voltage;
% %      avg= mean([IV(2*j).avg; IV(2*j-1).avg]);
% %      peak= mean([IV(2*j).peak; IV(2*j-1).peak]);
%     avg=IV(j).avg; peak=IV(j).peak;
%    [fit1,S]=polyfit(avg(1:6),voltage(1:6),1);
%    IV(j).fit1=fit1;
%    IV(j).Rm1=10^9*fit1(1);
%    [estimate,error]=polyval(fit1,avg(1:6),S)
%    figure(10);  plot(voltage,avg,'*'); hold all;
%    figure(20); plot(voltage,peak,'*-'); hold all
% end
% figure(10); title('Steady State Current'); legend(names);
% xlabel('Vm (mV)')
% ylabel('Current (pA)')
% figure(20); title('Peak Inward Current'); xlabel('Vm (mV)'); ylabel('Current (pA)'); legend(names)

% %     

for i=1:L
% AHP(i,1)=cell(i).AHPmag(1);
% AHP(i,2)=cell(i).AHPdur(1);
if i==1
    first=spikingparameters(i).j(1)+2;
end
    k=spikingparameters(i).k; j=spikingparameters(i).j;
    figure(1); plot(spikingparameters(i).current(k),spikingparameters(i).freq,'-*'); hold all
    figure(2); plot(spikingparameters(i).current(j),spikingparameters(i).Vth(j),'-*'); hold all
    figure(3); plot(spikingparameters(i).current(j),abs(spikingparameters(i).AHPmag(j)),'-*'); hold all
    figure(4); plot(spikingparameters(i).current(j),spikingparameters(i).AHPdur(j),'-*'); hold all
   figure(5); plot(spikingparameters(i).current(j),spikingparameters(i).amp(j),'-*'); hold all
    figure(6); plot(spikingparameters(i).current(j),spikingparameters(i).dur(j),'-*'); hold all
    figure(8); plot(spikingparameters(i).current(j),spikingparameters(i).first_spike(j),'-*'); hold all
   Rm(i)=spikingparameters(i).Rm;
    firstparams(i,:)=spikingparameters(i).firstparams;
  meanfirstparams(i,:)=[spikingparameters(i).Vth(first) spikingparameters(i).amp(first) spikingparameters(i).dur(first) spikingparameters(i).AHPmag(first) spikingparameters(i).AHPdur(first)];
%    
% % figure(3); plot(spikingparameters(i).current(1:5),spikingparameters(i).Rm(1:5),'-*'); hold all
% %    for j=1:5
% %     Rm(i,j)=spikingparameters(i).Rm(j);
% % %     Cm(j,i)=spikingparameters(i).Cm(j);
% %    end
end

figure(1); legend(names); xlabel('Current (pA)'); ylabel('Frequency (Hz)'); title('fI plot'); 
figure(2); xlabel('Current (pA)'); ylabel('Vth (mV)'); title('Threshold Voltage'); legend(names);
figure(3); xlabel('Current (pA)'); ylabel('Magnitude (mV)'); title('AHP magnitude'); legend(names);
figure(4); xlabel('Current (pA)'); ylabel('Duration (s)'); title('AHP duration'); legend(names);
figure(6); xlabel('Current (pA)'); ylabel('Duration (s)'); title('AP duration'); legend(names);
figure(5); xlabel('Current (pA)'); ylabel('Amplitude (mv)'); title('AP amplitude'); legend(names);
figure(7);  plot(Rm,'-*'); hold all; xlabel('Time (minutes)');  title('Input Resistance'); ylabel('Resistance (ohms)'); legend('2:4','1:5','1:4','1:3','2:5'); %xlabel('Current (pA)'); 
figure(8); xlabel('Current (pA)'); ylabel('Latency (s)'); title('First Spike Latency'); legend(names);

end