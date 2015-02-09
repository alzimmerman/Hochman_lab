% Function takes abf integer file and returns area until peak, area after
% peak, time to peak, and DRP duration

function [area1,area2,peak,time2peak,DRPduration]=forJacob(filename)

start_time=0;   % start time to look, in seconds
end_time=3;  % end time window, in seconds
min_num=4; %number of local maximum/minima
cutoff=200; %cutoff frequency, in hz
percent=0.1;  %percentage to integrate decay to
threshold=1;  %sets crossing to count for local minima/maxima

file=readabf(filename);
Vm=file.data.IN_2;
time=file.data.time;
Fs=1/time(2);  %sampling frequency
first=find(time>start_time,1);
last=find(time>end_time,1);  %shortens time window

%finds crossing for threshold value, then all points under zero after, and
%takes last value as first_new
crossing=find(abs(Vm(first:last))>threshold,1)+first;
first_new=find(Vm(crossing:last)<0,1,'last')+crossing;


%filtering
Wn1=cutoff./Fs;
[b1,a1]=butter(3,Wn1);
fVm = filtfilt(b1,a1,Vm(first_new:last));

[peak,index1]=max(fVm);   %finds maximum peak
index2=find(fVm(index1:length(fVm))<(peak*percent),1)+index1; 
time2peak=time(index1); % finds time of maximum peak in reference to zero-crossing start point
DRPduration=time(index2);  % finds total duration of drp

area1 = trapz(time(1:index1),fVm(1:index1));  %finds area from first zero crossing to peak
area2= trapz(time(index1:index2),fVm(index1:index2));    %finds area from peak to end of decay
figure; plot(time(first:(first_new+index2)),Vm(first:(first_new+index2)),time(first_new),Vm(first_new),'<',time(index1+first_new),peak,'*',time(index2+first_new),Vm(first_new+index2),'>');
end