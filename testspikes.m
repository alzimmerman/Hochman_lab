%function calculates spike properties from current clamp mode
function [AMP,AHPMAG,FREQ,k,current]=testspikes(filename)
file=readabf(filename);

time=(file.data.time');
Vm= file.data.c_clamp./10;
Iwaveform=file.waveform.yPoints;
Swaveform=file.waveform.xPoints;  %gives sample number

[R,C]=size(Vm);
Fs=1/time(2);

leg= {}; leg2={};
AMP=[]; DUR= []; AHPDUR=[]; AHPMAG= []; VTH=[]; FREQ=[];
current=[]; VTH=[];

%for initial calculation of clamp times
j=find(Iwaveform(:,1)~=0,1);
clampon=Swaveform(j,1);
clampoff=Swaveform(j+1,1);

time_previous=0;
injection=-30;

for i=1:C
    current(i)=Iwaveform(j,i);
    name=strcat(num2str(current(i)),' pA');
    leg=strvcat(leg, name);
    
    base_start(i)=time(2)+time_previous+(i-1).*time(R);
    base_end(i)= time(clampon)+time_previous +(i-1).*time(R);
    
    %Vm_ss is mean value of Vm during 2nd half of current clamp
    Vm_ss(i)=mean(Vm(round((clampoff-clampon)./2):clampoff,i));
    Vm_base(i)=mean(Vm(1:clampon));
   
    figure(i); plot(time,Vm(:,i),'-'); hold all
    
   [amp,dur,AHPdur,AHPmag,Vth,spikes2]=spikeparams(time,Vm(:,i),clampon,clampoff);
    % figure(i); plot(time(spikes2),Vth,'*', time(first),Vth(1:length(first)),'>',time(last),Vth(1:length(last)),'<'); hold all;
      
   [mean_amp,mean_dur,mean_AHPdur,mean_AHPmag,mean_Vth,freq]= meanparameters(amp,dur,AHPdur,AHPmag,Vth,spikes2,Fs);

     %adds current value of parameters to parameter vectors
    AMP=[AMP mean_amp];
    DUR=[DUR mean_dur];
    AHPDUR=[AHPDUR mean_AHPdur];
    AHPMAG=[AHPMAG mean_AHPmag];
    VTH=[VTH mean_Vth];  
    FREQ=[FREQ freq]

    if (length(spikes2)>=1 && current(i)>injection)
        spike(i)=(spikes2(1)-clampon)./Fs;
    else
        spike(i)=0;
    end
       
end

for i=1:length(current)
    k=find(FREQ~=0);
end


end

