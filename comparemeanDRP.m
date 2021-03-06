% function for use when comparing mean statistics only
% Function inputs array of file names, and outputs cell array with DRP, VRP, and
%field potential stats for mean baseline adjusted traces for each file
%each matrix returns columns for potential onset, amplitude, time2max,
%offset,integrateup,and integratedown; all times are in reference to start

function [meanDRPstats,baselinevalues]=comparemeanDRP(files,numrun)
[~,C]=size(files);
meanDRPstats=cell(2,1);

[num,sweeps,sampletimeon,time,fdata,baseline]=read_and_adjustDRP(files{1});
num=2;  %remove if want EFP for analysis
timeon=zeros(num,1); timeoff=zeros(num,1); 
Fs=1./time(2);
baselinevalues(1,:)=mean(baseline);

for j=1:num
    %  Returns statistics for each channel mean
    [onset, amplitude,time2max,offset,integrateup,integratedown]= potential_statistics(time,fdata(:,j*(sweeps+1)),Fs, sampletimeon);
    timeon(j)=onset;
    timeoff(j)=offset;
    peaktime(j)=time2max;
    meanDRPstats{j,1}(1,:)=[timeon(j),amplitude,time2max,timeoff(j),integrateup,integratedown];
    figure(numrun); subplot(num,1,j); plot(time, fdata(:,j*(sweeps+1))/-meanDRPstats{j,1}(1,2),time2max,amplitude/meanDRPstats{j,1}(1,2),'*',timeon(j),0,'<');  hold all
end

for i=2:C
    [~,sweeps,~,time,fdata,baseline]=read_and_adjustDRP(files{i});
    baselinevalues(i,1:length(mean(baseline)))=mean(baseline);
    for j=1:num
        [amplitude,time2max,integrateup,integratedown]= potential_statistics_with_limits(fdata(:,j*(sweeps+1)),Fs, timeon(j), timeoff(j),peaktime(j));
        meanDRPstats{j,1}(i,:)=[timeon(j),amplitude,time2max,timeoff(j),integrateup,integratedown];
        figure(numrun); subplot(num,1,j); plot(time, fdata(:,j*(sweeps+1))/-meanDRPstats{j,1}(1,2),time2max,amplitude/meanDRPstats{j,1}(1,2),'*',timeon(j),0,'<');  hold all
    end
      
end


for j=1:num
    if j==1
        titleadd=' DRP';
    elseif j==2
        titleadd=' VRP';
    else
        titleadd=' EFP';
    end
    
    titlename=strcat('run', num2str(numrun), titleadd);
    figure(numrun); subplot(num,1,j); title(titlename); xlabel('Time (s)'); ylabel('Normalized Amplitude'); 
    axis([time(sampletimeon) max(timeoff) -.5 1.3]);  %(min(timeon)-.1)
end
end

   