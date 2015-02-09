function compare_drugs

prefix='08124';
first=[19 27 35];
last=[25 32 39];
timeon=[40 30 70];
timeoff=[286 299.1 324];
holding=-40;
cutoff=100; %low-pass filter, in Hz

files=strvcat('08124017.abf','08124023.abf','08124026.abf','08124029.abf', '08124033.abf','08124036.abf','08124040.abf');
leg=strvcat('baseline','100uM NMDA','wash1','100uM NMDA,50uM DA','wash2','100uM DA','wash3');

compareiv(files); 
figure(1);legend(leg)

for i=1:3
    [time,Im]=vclamp_series(prefix,first(i),last(i),holding);
    
    figure(i*100); plot(time,Im,timeon(i),0,'>',timeoff(i),0,'<'); title(deblank(leg((2*i),:))); xlabel('Time (s)'); ylabel('Current (pA)') ; 
    
end

% figure(1);  legend(leg) ;
% figure(1); plot(timeon,[0,0,0],'>',timeoff,[0,0,0],'<');
end

