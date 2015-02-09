%function inputs current clamp data from series and exports average firing properties and IV relationship for
%current clamp protocols

function [AMP,AHPMAG,FREQ,k,current,Vm_ss,Vm_base,tau,base_start,base_end,end_time,spike]=currclamp_forseries(file,time_previous,injection)

time=(file.data.time');
Vm= file.data.c_clamp./10;
Iwaveform=file.waveform.yPoints+injection;
Swaveform=file.waveform.xPoints;  %gives sample number

[R,C]=size(Vm);
Fs=1/time(2);


AMP=zeros(1,C); 
DUR=zeros(1,C);
AHPDUR=zeros(1,C); 
AHPMAG= zeros(1,C);
VTH=zeros(1,C);
FREQ=zeros(1,C);
current=zeros(1,C);
Vm_ss=zeros(1,C);
Vm_base=zeros(1,C);
tau=zeros(1,C);

%for initial calculation of clamp times
j=find(Iwaveform(:,1)~=injection,1);
clampon=Swaveform(j,1);
clampoff=Swaveform(j+1,1);

for i=1:C
    current(i)=Iwaveform(j,i);
    
    base_start(i)=time(2)+time_previous+(i-1).*time(R);
    base_end(i)= time(clampon)+time_previous +(i-1).*time(R);
    
   [Vm_ss(i),Vm_base(i),tau(i)]=find_tau(time,Vm(:,i),clampon,clampoff);
   [amp,dur,AHPdur,AHPmag,Vth,spikes2]=spikeparams(time,Vm(:,i),clampon,clampoff);   
   [mean_amp,mean_dur,mean_AHPdur,mean_AHPmag,mean_Vth,freq]= meanparameters(amp,dur,AHPdur,AHPmag,Vth,spikes2,Fs);

     %adds current value of parameters to parameter vectors
    AMP(i)=mean_amp;
    DUR(i)=mean_dur;
    AHPDUR(i)= mean_AHPdur;
    AHPMAG(i)= mean_AHPmag;
    VTH(i)=mean_Vth;  
    FREQ(i)=freq;

    if (length(spikes2)>=1 && current(i)>injection)
        spike(i)=(spikes2(1)-clampon)./Fs;
    else
        spike(i)=0;
    end
       
end

%only plots nonzero values for active properties
for i=1:length(current)
    k=find(FREQ~=0);
end


end
    