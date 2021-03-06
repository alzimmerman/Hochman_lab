function [VTH,AMP,DUR,AHPMAG,AHPDUR,FREQ,k,current,VM_SS,VM_BASE,TAU]=adjust_bridgebal(file,injection,delta_Rp)

time=(file.data.time');
Vm= file.data.c_clamp./10;
Iwaveform=file.waveform.yPoints+injection;
Swaveform=file.waveform.xPoints;  %gives sample number

[R,C]=size(Vm);
Fs=1/time(2);
Vm_adj=zeros(R,C);

AMP=zeros(1,C); 
DUR=zeros(1,C);
AHPDUR=zeros(1,C); 
AHPMAG= zeros(1,C);
VTH=zeros(1,C);
FREQ=zeros(1,C);
current=zeros(1,C);
VM_SS=zeros(1,C);
VM_BASE=zeros(1,C);
TAU=zeros(1,C);
test=0;

%for initial calculation of clamp times
j=find(Iwaveform(:,1)~=injection,1);
clampon=Swaveform(j,1);
clampoff=Swaveform(j+1,1);

for i=1:C
    current(i)=Iwaveform(j,i);
    
    for k=1:R
        if (k>=clampon) && (k<=clampoff)
            Vm_adj(k,i)=Vm(k,i)+current(i).*delta_Rp;
        else
            Vm_adj(k,i)=Vm(k,i)+injection.*delta_Rp;
        end
    end
    
    [Vm_ss,Vm_base,tau]=find_tau(time,Vm_adj(:,i),clampon,clampoff,R,current(i),injection);
    [amp,dur,AHPdur,AHPmag,Vth,spikes2]=spikeparams(time,Vm_adj(:,i),clampon,clampoff);
    [mean_amp,mean_dur,mean_AHPdur,mean_AHPmag,mean_Vth,freq]= meanparameters(amp,dur,AHPdur,AHPmag,Vth,spikes2,Fs);
   
   %adds current value of parameters to parameter vectors
    AMP(i)=mean_amp;
    DUR(i)=mean_dur;
    AHPDUR(i)= mean_AHPdur;
    AHPMAG(i)= mean_AHPmag;
    VTH(i)=mean_Vth;  
    FREQ(i)=freq;
    
    VM_SS(i)=Vm_ss;
    VM_BASE(i)=Vm_base;
    TAU(i)=tau;

end

figure; plot(time,Vm_adj); 
%only plots nonzero values for active properties
for i=1:length(current)
    k=find(FREQ~=0);
end


