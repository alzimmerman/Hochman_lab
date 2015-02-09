function [files,injection,groups]=start_files
%inputs files and injections grouped by row, with groups the cell array of
%labels

%0815
% files={{'07815004.abf','07815004.abf'};{'07815005.abf','07815006.abf'}};
% injection={[0 0];[0 0]};
% groups={'-80 mV','-60 mV'};

%0920
% files={{'07920006.abf','07920006.abf'};{'07920010.abf','07920010.abf'};{'07920019.abf','07920019.abf'}}
% injection={[0 0];[0 0];[0 0]};
% groups={'control','DA?','NE?'}

%1106
%files={{'07n06009.abf','07n06009.abf'};{'07n06012_adj.abf', '07n06012_adj.abf'};{'07n06015_adj.abf','07n06015_adj.abf'};{'07n06019_adj.abf','07n06019_adj.abf'};{'07n06022_adj.abf','07n06022_adj.abf'};{'07n06025_adj.abf','07n06025_adj.abf'}; {'07n06028_adj.abf','07n06028_adj.abf'}};
%injection={[-124.5 -124.5];[-63.8 -63.8];[-42.3 -42.3];[-160.5 -160.5];[-103 -103]; [-115 -115];[0 0]};
%injection={[0 0];[0 0];[0 0];[0 0];[0 0]; [0 0];[0 0]};
%groups={'control','10 uM DA','wash','100 uM DA','wash','2uM DA','wash'};

%1109

% files={{'08320029.abf','08320029.abf'};{'08320031.abf','08320031.abf'}};
% injection={[-56.9 -56.9];[-56.9 -56.9]};
% groups={'Control','10uM DA'};

%---------------------------------------  0327 cell 4
% files={{'08327101.abf','08327101.abf'};{'08327103.abf','08327103.abf'};{'08327105.abf','08327105.abf'};{'08327107.abf','08327107.abf'};{'08327109.abf','08327109.abf'};{'08327111.abf','08327111.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','NE1','NE2','wash1','wash2','wash3'};

% files={{'08327111.abf','08327111.abf'};{'08327113.abf','08327113.abf'};{'08327115.abf','08327115.abf'};{'08327117.abf','08327117.abf'};{'08327119.abf','08327119.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','DA','wash1','wash2','wash3'};

% files={{'08327119.abf','08327119.abf'};{'08327121.abf','08327121.abf'};{'08327123.abf','08327123.abf'};{'08327125.abf','08327125.abf'};{'08327127.abf','08327127.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','5HT','wash1','wash2','wash3'};

%---------------------------------------  0327 cell2 -------------------
% files={{'08327016.abf','08327016.abf'};{'08327018.abf','08327018.abf'};{'08327020.abf','08327020.abf'};{'08327022.abf','08327022.abf'};{'08327024.abf','08327024.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','NE1','NE2','wash1','wash2'};

% files={{'08327024.abf','08327024.abf'};{'08327026.abf','08327026.abf'};{'08327029.abf','08327029.abf'};{'08327031.abf','08327031.abf'};{'08327033.abf','08327033.abf'};{'08327035.abf','08327035.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]; [0 0]};
% groups={'base','DA1','DA2','wash1','wash2','wash3'};

% files={{'08327035.abf','08327035.abf'};{'08327037.abf','08327037.abf'};{'08327040.abf','08327040.abf'};{'08327042.abf','08327042.abf'};{'08327044.abf','08327044.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','5HT1','5HT2','wash1','wash2'};

%---------------------------------------  0327 cell3
% files={{'08327053.abf','08327053.abf'};{'08327055.abf','08327055.abf'};{'08327057.abf','08327057.abf'};{'08327059.abf','08327059.abf'};{'08327061.abf','08327061.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','NE1','NE2','wash1','wash2'};

% files={{'08327061.abf','08327061.abf'};{'08327064.abf','08327064.abf'};{'08327066.abf','08327066.abf'};{'08327068.abf','08327068.abf'};{'08327070.abf','08327070.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','DA1','DA2','wash1','wash2'};

% files={{'08327070.abf','08327070.abf'};{'08327073.abf','08327073.abf'};{'08327075.abf','08327075.abf'};{'08327077.abf','08327077.abf'};{'08327079.abf','08327079.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','5HT1','5HT2','wash1','wash2'};

% files={{'08327079.abf','08327079.abf'};{'08327082.abf','08327082.abf'};{'08327084.abf','08327084.abf'};{'08327086.abf','08327086.abf'};{'08327088.abf','08327088.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','DA+NE','DA+NE2','wash1','wash2'};

%---------------------------------------  0325 cell 1
% files={{'08325002.abf','08325003.abf'};{'08325006.abf','08325007.abf'};{'08325008.abf','08325009.abf'};{'08325011.abf','08325013.abf'};{'08325015.abf','08325015.abf'}};
% injection={[-61.9 -61.9];[-61.9 -61.9];[-120.7 -120.7];[-120.7 -120.7];[-120.7 -120.7]};
% groups={'Initial','DA ?','Control','DA','Wash'};

%---------------------------------------  0422
% files={{'08422010.abf','08422010.abf'};{'08422012.abf','08422012.abf'};{'08422015.abf','08422015.abf'};{'08422018.abf','08422018.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0]};
% groups={'base','DA','wash1','wash2'};

% files={{'08422022.abf','08422022.abf'};{'08422013.abf','08422013.abf'};{'08422016.abf','08422016.abf'};{'08422019.abf','08422019.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0]};
% groups={'base?','DA','wash1','wash2'};

% files={{'08422022.abf','08422022.abf'};{'08422024.abf','08422024.abf'};{'08422027.abf','08422027.abf'};{'08422030.abf','08422030.abf'};{'08422033.abf','08422033.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','NE','wash1','wash2','wash3'};

% files={{'08422019.abf','08422019.abf'};{'08422025.abf','08422025.abf'};{'08422028.abf','08422028.abf'};{'08422031.abf','08422031.abf'};{'08422034.abf','08422034.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base?','NE','wash1','wash2','wash3'};

% files={{'08422037.abf','08422037.abf'};{'08422040.abf','08422040.abf'};{'08422043.abf','08422043.abf'};{'08422046.abf','08422046.abf'};{'08422049.abf','08422049.abf'};{'08422052.abf','08422052.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','5HT','wash1','wash2','wash3','wash4'};

% files={{'08422038.abf','08422038.abf'};{'08422041.abf','08422041.abf'};{'08422044.abf','08422044.abf'};{'08422047.abf','08422047.abf'};{'08422050.abf','08422050.abf'};{'08422053.abf','08422053.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','5HT','wash1','wash2','wash3','wash4'};

% files={{'08422038.abf','08422038.abf'};{'08422041.abf','08422041.abf'};{'08422044.abf','08422044.abf'};{'08422047.abf','08422047.abf'};{'08422050.abf','08422050.abf'};{'08422053.abf','08422053.abf'}};
% injection={[0 0];[0 0];[0 0];[0 0];[0 0];[0 0]};
% groups={'base','5HT','wash1','wash2','wash3','wash4'};



%---------------------------------------  0325 cell3
% files={{'08325023.abf','08325023.abf'};{'08325025.abf','08325025.abf'};{'08325027.abf','08325027.abf'}};
% injection={[-106.2 -106.2];[-106.2 -106.2];[-106.2 -106.2]};
% groups={'Control','DA','Wash'};

% -------------------------------------HORIZONTAL/VERTICAL
files={{'08107002.abf','08107083.abf','08109004.abf','08115001.abf','08116001.abf','08122002.abf','08122046.abf','08122054.abf'};
    {'07815005.abf','07815015.abf','07829013.abf','07n06001.abf','07n09002.abf','08306001.abf','08423055.abf','08423091.abf','08506031.abf'};
    {'07d17016.abf','07d18004.abf'};
    {'07815004.abf','07815014.abf','07829000.abf','07920006.abf','07927014.abf','07o24002.abf','08320003.abf','08320029.abf','08327003.abf','08327016.abf','08327053.abf','08327101.abf','08422010.abf','08423054.abf','08423090.abf','08430003.abf','08430035.abf','08506030.abf'}};

injection={[0 0 0 0 0 0 0 0];[0 0 0 0 0 0 0 0 0];[0 0]; zeros(1,18)};
groups={'h-60','t-60','h-80','t-80'};

% %all
% files={{'08107002.abf','08107083.abf','08109004.abf','08115001.abf','08116001.abf','08122002.abf','08122046.abf','08122054.abf','07815005.abf','07815015.abf','07829013.abf','07n06001.abf','07n09002.abf','08306001.abf','08423055.abf','08423091.abf','08506031.abf','07d17016.abf','07d18004.abf','07815004.abf','07815014.abf','07829000.abf','07920006.abf','07927014.abf','07o24002.abf','08320003.abf','08320029.abf','08327003.abf','08327016.abf','08327053.abf','08327101.abf','08422010.abf','08423054.abf','08423090.abf','08430003.abf','08430035.abf','08506030.abf'}};
% injection={zeros(1,length(files{1}))};
% groups= {'all'};
end