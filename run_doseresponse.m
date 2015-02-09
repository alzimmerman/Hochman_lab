%define cell to be the number of drug runs
numruns=1;
doseinput=cell(numruns,2);

%DA
doseinput{1,1}(1,:)=[0 0.25 .5 1 5 10 20 40].*10^-6;
doseinput{1,2}={'11309007_and8_integer.abf', '11309010.abf','11309012_adjustedinteger.abf','11309014.abf','11309016.abf','11309018.abf','11309020.abf','11309022.abf'};
doseinput{2,1}(1,:)=[0 0.1 0.5 1 5 10].*10^-6;
doseinput{2,2}={'11318019_adjusted.abf','11318023_adjusted2.abf','11318025.abf','11318027_adjusted_integer.abf', '11318029.abf', '11318031.abf'};
doseinput{3,1}(1,:)=[0 0.01 0.1 0.5 1 5 10].*10^-6;
doseinput{3,2}={'11413005.abf','11413007.abf','11413009.abf','11413011.abf','11413013.abf','11413015.abf', '11413017.abf'};
doseinput{4,1}(1,:)=[0 .005 .05 .5 2.5 5 10 20].*10^-6;
doseinput{4,2}={'11414005.abf','11414006.abf','11414008.abf','11414010_adjusted3_integer.abf','11414012.abf','11414014.abf', '11414016.abf', '11414018.abf'};
doseinput{5,1}(1,:)=[0 .01 .1 .5 1 5 10 20]*10^-6;
doseinput{5,2}={'2011_09_16_0002.abf','2011_09_16_0004.abf','2011_09_16_0006.abf','2011_09_16_0008.abf','2011_09_16_0010.abf','2011_09_16_0012.abf','2011_09_16_0014.abf','2011_09_16_0016.abf'};

%5HT
% doseinput{1,1}(1,:)=[0 0.1 0.5 1 5 10 20].*10^-6;
% doseinput{1,2}={'11307013.abf', '11307015.abf','11307018.abf','11307020.abf', '11307022.abf','11307024.abf', '11307026.abf'};
% doseinput{2,1}(1,:)=[0 0.1 0.5 1 5].*10^-6;
% doseinput{2,2}={'11315004.abf','11315006.abf','11315008.abf','11315010.abf','11315012.abf'};
% doseinput{3,1}(1,:)= [0 .01 .1 .5 1 5].*10^-6;
% doseinput{3,2}={'11518060.abf', '11518062.abf','11518064.abf','11518066.abf', '11518068.abf', '11518070.abf'};
% doseinput{4,1}(1,:)=[0 0.01 .1 .5 1 5].*10^-6;
% doseinput{4,2}={'11523057.abf','11523059.abf','11523061.abf','11523063.abf','11523065.abf','11523067.abf'};
% doseinput{5,1}(1,:)= [0 .01 .1 .5 1 5 10]*10^-6;
% doseinput{5,2}={'2011_09_12_0002.abf', '2011_09_12_0004.abf','2011_09_12_0006.abf','2011_09_12_0008.abf','2011_09_12_0010.abf', '2011_09_12_0012.abf','2011_09_12_0014.abf'};

% NE
% doseinput{1,1}(1,:)=[0 0.01 0.1 0.5 1 5].*10^-6; %dose run1
% doseinput{1,2}={'11412019.abf','11412021.abf','11412023.abf','11412025.abf','11412027.abf','11412029.abf'};  %files run1
% % doseinput{2,1}(1,:)=[0 0.01 0.1 1 5].*10^-6;
% % doseinput{2,2}={'11428002.abf','11428004.abf','11428006.abf','11428008.abf','11428010.abf'}; 
% doseinput{2,1}(1,:)=[0 0.25 0.5 1 5].*10^-6;
% doseinput{2,2}={'11311016.abf','11311018.abf', '11311021.abf','11311023.abf','11311025.abf'};
% doseinput{3,1}(1,:)=[0 .01 .1 .5 1 5 10].*10^-6;
% doseinput{3,2}={'2011_09_08_13and14andpart15_exported.abf', '2011_09_08_0016_adjusted_exported.abf','2011_09_08_0018_adjusted_exported.abf','2011_09_08_0020_adjusted_exported.abf','2011_09_08_0022_adjusted_exported.abf','2011_09_08_0024_adjusted_exported.abf','2011_09_08_0026_adjusted_exported.abf'};
% doseinput{4,1}(1,:)=[0 .01 .1 .5 1 5 10].*10^-6;
% doseinput{4,2}={'2011_09_16_25to27.abf','2011_09_16_0028_adjusted.abf','2011_09_16_0030_adjusted.abf','2011_09_16_0032_adjusted.abf','2011_09_16_0034_adjusted.abf','2011_09_16_0036_adjusted.abf','2011_09_16_0038_adjusted.abf'};
[dosestats,ICstats,normalDRPamp,normalVRPamp,doselong,baselinevalues,normalbaselines]=doseresponse(doseinput);