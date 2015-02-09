%function inputs current clamp data from series and exports average firing properties and IV relationship for
%current clamp protocols

function [VTH,AMP,DUR,AHPMAG,AHPDUR,FREQ,k,current]=currclamp_forseries(file)

time=(file.data.time');
Vm= file.data.c_clamp./10;
Iwaveform=file.waveform.yPoints;
Swaveform=file.waveform.xPoints;  %gives sample number

[R,C]=size(Vm);
Fs=1/time(2);

leg= {}; leg2={};
AMP=[]; DUR= []; AHPDUR=[]; AHPMAG= []; VTH=[]; FREQ=[];
current=[];

%for initial calculation of clamp times
j=find(Im(:,1)~=0,1);
clampon=Swaveform(j,1);
clampoff=Swaveform(j+1,1);

for i=1:C
    current(i)=Im(j,i);
    name=strcat(num2str(current(i)),' pA');
    leg=strvcat(leg, name);
    
    [Vm_ss,Gm_ss,Im_ss]=calc_conduct(Swaveform,Iwaveform,Vm);
    
   if (current(i)~=0)
      [amp,dur,AHPdur,AHPmag,Vth,spikes2]=findspikes(time,Vm(:,i),clampon,clampoff);
      
   else
      dur=0; AHPdur=0; AHPmag=0; amp=0; Vth=0; spikes2=0;
   end
   
   if (spikes2~=0)
        temp= current(i).*ones(length(spikes2),1);
%         figure(1); subplot(2,1,1); plot(time(spikes2),temp,'*'); hold all
%         leg2=strvcat(leg2,name);        
%         figure(1); subplot(2,1,2); plot(time,Vm(:,i)); hold all
   end
   
   % calculates average parameters for each trace, ignoring first spike
   % unless it's the only spike and ignoring last value for AHPdur
   if (length(dur)>7)
        dur=mean(dur(2:6));
        AHPdur=mean(AHPdur(2:6));
        amp=mean(amp(2:6));
        AHPmag=mean(AHPmag(2:6));
        Vth=mean(Vth(2:6));
        
    elseif (length(dur)<=6 && length(dur)>=2)   % ignores last value for AHPdur
        dur=mean(dur(2:length(dur)));
        AHPdur=mean(AHPdur(2:(length(AHPdur)-1)));
        amp=mean(amp(2:length(amp)));
        AHPmag=mean(AHPmag(2:length(AHPmag)));
        Vth=mean(Vth(2:length(Vth)));
        
   elseif (isempty(dur)==1)
       dur=0; AHPdur=0; amp=0; AHPmag=0; Vth=0;
   end
   
   if (length(spikes2)>2)
       frequency=Fs./diff(spikes2(2:length(spikes2)));
       freq=mean(frequency);
   else
       freq=0;
   end
    
        %adds current value of parameters to parameter vectors
    AMP=[AMP amp];
    DUR=[DUR dur];
    AHPDUR=[AHPDUR AHPdur];
    AHPMAG=[AHPMAG AHPmag];
    VTH=[VTH Vth];  
    FREQ=[FREQ freq];
       
end

%only plots nonzero values for active properties
for i=1:length(current)
    k=find(FREQ~=0);
end


end
    