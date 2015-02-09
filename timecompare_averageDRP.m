% function for use when comparing time responses, averaging avgnum sweeps
% Function inputs array of file names, and outputs cell array with DRP, VRP, and
%field potential stats for averaged and baseline adjusted traces for all
%files
%each matrix returns columns for potential onset, amplitude, time2max,
%offset,integrateup,and integratedown; all times are in reference to start

function [meanDRPstats]=timecompare_averageDRP(files,numrun,avgnum)
[~,C]=size(files);
meanDRPstats=cell(2,1);
fdata_full=cell(2,1);
fdata_averaged=cell(2,1);
[num,sweeps,sampletimeon,time,fdata,~]=read_and_adjustDRP(files{1});
%num=2;  %remove if want EFP for analysis
timeon=zeros(num,1); timeoff=zeros(num,1); 
Fs=1./time(2);


%uses average for first file to find onset and offset times
for j=1:num
    %  Returns statistics for each channel mean
    [onset, amplitude,time2max,offset,~,~]= potential_statistics(time,fdata(:,j*(sweeps+1)),Fs, sampletimeon);
    timeon(j)=onset;
    timeoff(j)=offset;
    peaktime(j)=time2max;
    meanamp(j)=amplitude;
   % figure(numrun); subplot(num,1,j); plot(time, fdata(:,j*(sweeps+1))/-meanamp(j),time2max,1,'*',timeon(j),0,'<');  hold all
end

for i=1:C
    [~,sweeps,~,time,fdata,~]=read_and_adjustDRP(files{i});
    index=(i-1)*sweeps+1;
    for j=1:num
        sweepstart=(j-1)*(sweeps+1)+1; sweepend=sweepstart+sweeps-1;
        fdata_full{j,1}(:,index:(index+sweeps-1))= fdata(:,sweepstart:sweepend);
      %         [amplitude,time2max,integrateup,integratedown]= potential_statistics_with_limits(fdata(:,j*(sweeps+1)),Fs, timeon(j), timeoff(j),peaktime(j));
%         meanDRPstats{j,1}(i,:)=[timeon(j),amplitude,time2max,timeoff(j),integrateup,integratedown];
    figure(numrun); subplot(num,1,j); plot(time, fdata(:,j*(sweeps+1))/-meanamp(j),peaktime(j),1,'*',timeon(j),0,'<'); hold all;
    end
      
end

for j=1:num
     fdata_averaged{j,1}(:,:)=average_data(fdata_full{j,1}(:,:),avgnum);
     [amplitude,time2max,integrateup,integratedown]= potential_statistics_with_limits(fdata_averaged{j,1}(:,:),Fs, timeon(j), timeoff(j),peaktime(j));
     meanDRPstats{j,1}(:,:)=[timeon(j).*ones(length(amplitude),1),amplitude,time2max,timeoff(j).*ones(length(amplitude),1),integrateup,integratedown];

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

   