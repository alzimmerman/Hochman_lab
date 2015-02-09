%Function inputs array of file names, and outputs cell array with DRP, VRP, and
%field potential stats baseline adjusted traces for each file, with the
%last line the mean adjusted trace
%each matrix returns columns for potential onset, amplitude, time2max,
%offset,integrateup,and integratedown; all times are in reference to start

function [DRPstats]=compareDRP(files)
[~,C]=size(files);
DRPstats=cell(C,3);

for i=1:C
    name=files{i}
    file=readabf(name);
    time=file.data.time;
    DRP=file.data.IN_3;
    VRP=file.data.IN_4;
    cutoff=100;
    Fs=1/time(2);
    [~,col]=size(DRP);
    baselinemin=10;
    
    %finds stimulus onset
    sampletimeon=find(abs(DRP(baselinemin:end,1))>(mean(DRP(:,1))+5*std(DRP(:,1))),1)+baselinemin;
   
   baselinetimes= [1 sampletimeon];  %denotes sample number of baseline stop and start period
   
    DRP_adjusted=baseline_adjust_and_average(DRP,baselinetimes);
    VRP_adjusted=baseline_adjust_and_average(VRP,baselinetimes);
    
        
    if isfield(file.data, 'in2_field')==1
        field=file.data.in2_field; 
        field_adjusted=baseline_adjust_and_average(field,baselinetimes);
        fdata=lowpass_filter(time, [DRP_adjusted,VRP_adjusted, field_adjusted], cutoff); %filters average data at cutoff frequency
        num=3;
    else
        field=[];
        fdata=lowpass_filter(time, [DRP_adjusted,VRP_adjusted], cutoff); %filters average data at cutoff frequency
        num=2;
    end
     
    for j=1:num
        %  Returns statistics for each average filtered trace sent
           [onset,~,~,offset,~,~]= potential_statistics(time,fdata(:,j*(col+1)),Fs, sampletimeon);
            if onset==0
               searchtimeon=time(sampletimeon);
            else
               searchtimeon=onset;
            end
        
      [amplitude,time2max,integrateup,integratedown]= potential_statistics_with_limits(fdata(:,counter:j*(col+1)),Fs, searchtimeon, offset);
      DRPstats{i,j}=[onset*ones(col+1,1),amplitude,time2max,offset*ones(col+1,1),integrateup,integratedown];
       figure(j*i); plot(time, fdata(:,counter:j*(col+1))); axis([time(sampletimeon) offset(i) -1.5*amplitude(1) 1.5*amplitude(1)]); hold all
    end
    
    
   % plots statistics for each mean trace
%  figure(i); subplot(num,1,1); plot(time,fdata(:,(col+1)),DRPstats{i,1}(1,(col+1)),0,'*');
 %DRPstats{i,1)(3,(col+1)),(-DRPstats{i,1}(2,(col+1))),'o',DRPstats{i,1}(4,(col+1)),-DRPstats{i,1}(2,(col+1))/3,'c+')
   %plot(time,field_adjusted(:,C+1))
%     figure(i); subplot(3,1,1); plot(time,fdata(:,1)); subplot(3,1,2); plot(time,fdata(:,2)); subplot(3,1,3); plot(time,fdata(:,3));
%    subplot(3,1,1); axis([time(sampletimeon) (time(sampletimeon)+ .25) -.15 .15]);
%    subplot(3,1,2); axis([time(sampletimeon) (time(sampletimeon)+ .25) -30 10]);
%    subplot(3,1,3); axis([time(sampletimeon) (time(sampletimeon)+ .25) -50 10]);
    
end
   