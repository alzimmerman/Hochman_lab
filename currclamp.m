%function inputs current clamp data and exports average firing properties and passive properties for
%current clamp protocols
%divides all voltages by 10 due to incorrect gain
function [VTH,AMP,OVERSHOOT,DUR,DUR2,AHPMAG,AHPDUR,FREQ,k,current,VM_SS,VM_BASE,TAU,first_spike,temp,allfirstparams]=currclamp(file,injection)

time=(file.data.time');
Vm= file.data.c_clamp./10;
Iwaveform=file.waveform.yPoints+injection;
Swaveform=file.waveform.xPoints;  %gives sample number

[R,C]=size(Vm);
Fs=1/time(2);

AMP=zeros(1,C); 
OVERSHOOT=zeros(1,C);
DUR=zeros(1,C);
DUR2=zeros(1,C);
AHPDUR=zeros(1,C); 
AHPMAG= zeros(1,C);
VTH=zeros(1,C);
FREQ=zeros(1,C);
current=zeros(1,C);
VM_SS=zeros(1,C);
VM_BASE=zeros(1,C);
TAU=zeros(1,C);
first_spike=zeros(1,C);
allfirstparams=zeros(C,5);
temp={};

%for initial calculation of clamp times
j=find(Iwaveform(:,1)~=injection,1);
clampon=Swaveform(j,1);
clampoff=Swaveform(j+1,1);

for i=1:C
    current(i)=Iwaveform(j,i);
    
    [Vm_ss,Vm_base,tau]=find_tau(time,Vm(:,i),clampon,clampoff,R,current(i),injection);
    TAU(i)=tau;
    VM_SS(i)=Vm_ss;
    VM_BASE(i)=Vm_base;
    delta=Vm_ss-Vm_base;
    

    [amp,peak,dur,dur2,AHPdur,AHPmag,Vth,spikes2]=spikeparams(time,Vm(:,i),clampon,clampoff);
    [mean_amp,mean_overshoot,mean_dur,mean_AHPdur,mean_AHPmag,mean_Vth,mean_freq,frequency_full,firstparams]= meanparameters(amp,peak,dur2,AHPdur,AHPmag,Vth,spikes2,Fs);

   if isempty(spikes2)<1
       first_spike(i)=time(spikes2(1))-time(clampon);
   end
   
   %adds current value of parameters to parameter vectors
    AMP(i)=mean_amp;
    OVERSHOOT(i)=mean_overshoot;
    DUR(i)=mean_dur;
    AHPDUR(i)= mean_AHPdur;
    AHPMAG(i)= mean_AHPmag;
    VTH(i)=mean_Vth;  
    FREQ(i)=mean_freq;
    temp(i).frequency=frequency_full;
    temp(i).firstparams=firstparams;
    temp(i).Vth=Vth; temp(i).amp=amp; temp(i).dur=dur; temp(i).AHPmag=AHPmag; temp(i).AHPdur=AHPdur;
    allfirstparams(i,:)=firstparams;

end

%only plots nonzero values for active properties
for i=1:length(current)
    k=find(FREQ~=0);
end


end
    