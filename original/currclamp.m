%function inputs current clamp data and exports average firing properties for
%current clamp protocols

function [VTH,AMP,DUR,AHPMAG,AHPDUR,FREQ,k,current]=currclamp(filename)

file=readabf(filename);

time=(file.data.time');
Vm= file.data.c_clamp./10;
Im=file.waveform.yPoints;
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
%     figure(1); hold all
    name=strcat(num2str(current(i)),' pA');
    leg=strvcat(leg, name);
    
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
   % unless it's the only spike
   if (length(dur)>6)
        dur=mean(dur(2:5));
        AHPdur=mean(AHPdur(2:5));
        amp=mean(amp(2:5));
        AHPmag=mean(AHPmag(2:5));
        Vth=mean(Vth(2:5));
        
    elseif (length(dur)<=5 && length(dur)>=2)
        dur=mean(dur(2:length(dur)));
        AHPdur=mean(AHPdur(2:length(AHPdur)));
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


% [AX,H1,H2]= plotyy(current,DUR, current,AHPDUR,'plot');
% set(get(AX(1),'Ylabel'),'String','AP Duration (ms)')
% set(get(AX(2),'Ylabel'),'String','AHP Duration (ms)')


% figure(1); subplot(2,1,1); legend(leg2); 
% xlabel('Time (s)')
% ylabel('Spikes')
% axis([(time(clampon)-.05),(time(clampoff)+.1),-Inf,Inf]);
% subplot(2,1,2); xlabel('Time (s)'); ylabel('Vm (mV)'); 
% axis([(time(clampon)-.05),(time(clampoff)+.1),-Inf,Inf]);
end
    