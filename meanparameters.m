% Function calculates average parameters for each trace, ignoring first spike
% unless it's the only spike and ignoring last value for AHPdur

function [AMP,OVERSHOOT, DUR,AHPDUR,AHPMAG,VTH,FREQ,frequency,first]= meanparameters(amp,peak,dur,AHPdur,AHPmag,Vth,spikes2,Fs)
  
if (length(Vth)>=1)  
        DUR=nanmean(dur(1:length(dur)));
        AHPDUR=nanmean(AHPdur(1:length(AHPdur)));
        AMP=nanmean(amp(1:length(amp)));
        OVERSHOOT=nanmean(amp(1:length(amp))+Vth(1:length(amp)));
        AHPMAG=nanmean(AHPmag(1:length(AHPmag)));
        VTH=nanmean(Vth(1:length(Vth)));
        if (length(amp)>=1)
            first=[Vth(1) amp(1) dur(1) AHPmag(1) AHPdur(1)];
        else
            first=zeros(1,5);
        end
else
       DUR=0; AHPDUR=0; AMP=0; OVERSHOOT=0; AHPMAG=0; VTH=0;  first=zeros(1,5);
end
   
if (length(spikes2)>=2)
       frequency=Fs./diff(peak(1:length(peak)));
       FREQ=mean(frequency);
% elseif (length(spikes2)==2)
%        FREQ=Fs./diff(spikes2(1:2));
else
       FREQ=0; frequency=0;
end
    
   