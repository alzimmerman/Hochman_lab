%function inputs filename, outputs number if slow potentials (3 with EFP),
%number of sweeps, sampletimeon, time, and filtered data

function [num,sweeps,sampletimeon,time,fdata,baselinevalues]=read_and_adjustDRP(filename)
    filename
    file=readabf(filename);
    time=file.data.time;
    DRP=file.data.IN_3;
    VRP=file.data.IN_4;
    cutoff=100;
    [~,sweeps]=size(DRP);
    Fs=1/time(2);
    baselinemin=0.35*Fs;  %defaul .3
    baselinemax= 1.7*Fs;  %default 1.7
    
   baselinetimes=[1 baselinemin]; 
   [DRP_adjusted,baseDRP]=baseline_adjust_and_average(DRP,baselinetimes);
   [VRP_adjusted,baseVRP]=baseline_adjust_and_average(VRP,baselinetimes);
    
   if isfield(file.data, 'in2_field')==1
      field=file.data.in2_field; 
      [field_adjusted,baseEFP]=baseline_adjust_and_average(field,baselinetimes);
      baselinevalues=[baseDRP,baseVRP,baseEFP];
      fdata=lowpass_filter(time, [DRP_adjusted,VRP_adjusted, field_adjusted], cutoff); %filters average data at cutoff frequency
      num=3;
   else
      fdata=lowpass_filter(time, [DRP_adjusted,VRP_adjusted], cutoff); %filters average data at cutoff frequency
      baselinevalues=[baseDRP,baseVRP]; 
      num=2;
   end
   
   %finds stimulus onset
   sampletimeon=find(abs(DRP_adjusted(baselinemin:baselinemax,sweeps+1))>15*std(DRP_adjusted(1:baselinemin,sweeps+1)),1)+baselinemin;
   
   if isempty(sampletimeon)>0
       [~,maxindex]=max(abs(DRP(baselinemin:baselinemax,end))); 
       sampletimeon=maxindex+baselinemin-.1*Fs;
   end
  
   
%    figure(1); subplot(2,1,1); plot(time,DRP_adjusted); subplot(2,1,2); plot(time, fdata(:,(sweeps+1)));
%figure(2); subplot(2,1,1); plot(time,VRP_adjusted); subplot(2,1,2); plot(time, fdata(:,2*(sweeps+1)));
end 