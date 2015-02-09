%Function returns single value of spike threshold and samplemax and vector
%of first spacial derivative

function [samplemax,Vth,Vprime]=phasespace_derivative(time,Vm,Fs)

cutoff1=1250;
cutoff2=1000;    %cutoff freq in hz

spikes2=[];
Vth=[];

%filters originial signal using zero phase filter
Wn1=cutoff1./Fs;
[b1,a1]=butter(3,Wn1);
fVm = filtfilt(b1,a1,Vm);

[Vprime,V2prime,V3prime]=derivative(fVm,1./Fs);
h=(V3prime.*Vprime-V2prime.^2)./(Vprime.^3);

%reindexing values
pos_Vprime=find(Vprime>0);
[hmax,smax]=max(h(pos_Vprime));
samplemax=pos_Vprime(smax);

% [value,samplemax]=max(h);
Vth=Vm(samplemax);


% figure;
% subplot(3,1,1); plot(Vm,Vprime,Vth,Vprime(samplemax),'*');  title('1st spacial derivative'); xlabel('Vm (mV)'); ylabel('Vprime (dVm/dt)'); hold all
% subplot(3,1,2); plot(Vm,h,Vth,hmax,'*'); title('2nd spacial derivative'); xlabel('Vm (mV)'); ylabel('h'); hold all
% subplot(3,1,3); plot(time,h,time(samplemax),hmax,'*'); title('h vs t'); xlabel('Time (s)'); ylabel('h'); hold all
end