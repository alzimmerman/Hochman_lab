%Function inputs array of file names, and outputs cell array with DRP, VRP, and
%field potential stats for baseline adjusted traces for each file
%each matrix returns columns for potential onset, amplitude, time2max,
%offset,integrateup,and integratedown; all times are in reference to start

function [DRPstats,baselines,num]=timecompareDRP(files)
[~,C]=size(files);
DRPstats=cell(C,2);
name=files{1}
%uses first file mean to find onset and offset times
[num,sweeps,sampletimeon,time,fdata,baselinevalues]=read_and_adjustDRP(files{1});
%num=2;  %hardcodes code to ignore EFP
timeon=zeros(num,1); timeoff=zeros(num,1); sampleon=zeros(num,1);
Fs=1./time(2);
baselines=baselinevalues;

for j=1:num
    %  Returns statistics for each channel mean
    [onset,~,time2max,offset,~,~]= potential_statistics(time,fdata(:,j*(sweeps+1)),Fs, sampletimeon);
    timeon(j)=onset;
    timeoff(j)=offset;
    peaktime(j)=time2max;
    counter=(j-1).*(sweeps+1)+1;
    [amplitude,time2max,integrateup,integratedown]= potential_statistics_with_limits(fdata(:,counter:(counter+sweeps-1)),Fs, timeon(j), timeoff(j),peaktime(j));
    DRPstats{1,j}=[timeon(j)*ones(sweeps,1),amplitude,time2max,timeoff(j)*ones(sweeps,1),integrateup,integratedown];
    figure(1); subplot(num,1,j); plot(time, fdata(:,counter:(counter+sweeps-1))./-DRPstats{1,j}(1,2),time2max,amplitude./DRPstats{1,j}(1,2),'*',timeon(j),0,'<');  hold all   
end

for i=2:C
    name=files{i}
    [~,sweeps,~,~,fdata,baselinevalues]=read_and_adjustDRP(files{i});
    baselines=[baselines;baselinevalues];
    
    for j=1:num
      %  Returns statistics for each filtered trace sent, using onset and
      %  offset times from first file
      counter=(j-1).*(sweeps+1)+1;
      [amplitude,time2max,integrateup,integratedown]= potential_statistics_with_limits(fdata(:,counter:(counter+sweeps-1)),Fs, timeon(j), timeoff(j),peaktime(j));
      DRPstats{i,j}=[timeon(j)*ones(sweeps,1),amplitude,time2max,timeoff(j)*ones(sweeps,1),integrateup,integratedown];
      sampleon(j)=find(time>timeon(j),1,'first');
      figure(i); subplot(num,1,j); plot(time, fdata(:,counter:(counter+sweeps-1))./-DRPstats{1,j}(1,2),time2max,amplitude./DRPstats{1,j}(1,2),'*',timeon(j),0,'<'); 
      hold all
    end
end

for i=1:C
    for j=1:num
        if j==1
            titleadd=' DRP';
        elseif j==2
            titleadd=' VRP';
        else
            titleadd=' EFP';
        end
    name=files{i};
    titlename=strcat(name, titleadd);
    figure(i); subplot(num,1,j); title(titlename); xlabel('Time (s)'); ylabel('Normalized Amplitude'); 
    axis([time(sampletimeon) max(timeoff) -.5 1.3]);  %(min(timeon)-.1)
    end
end

      
  
end
   