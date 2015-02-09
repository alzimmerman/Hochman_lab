%function calculates spike properties from current clamp mode
function [amp,dur,AHPdur,AHPmag,Vth,spikes2,firstnew,lastnew]=findspikes(time,Vm,clampon,clampoff)

%User defined variables
Fs=1/time(2);   %calculates sample frequency
cutoff=1000;    %cutoff freq in hz
s2thresh=1e6;   %threshold for 2nd derivative to check for spikes
spikemin=.020;   %minimum amount of time between spikes, in seconds
transient=.005; %time to ignore at beginning of signal, in seconds
timeon=time(clampon);

% Calculates slope by approximating the first derivative, declares
% Vthreshold
slope = diff(Vm)./diff(time);

%filters first derivative using 5th order butterworth filter

Wn=cutoff./Fs;  %cutoff normalized to sampling frequency
[b,a] = butter(3,Wn) ;
fslope=filter(b,a,slope);


% subplot(3,1,1); plot(time,Vm); title('original trace'); axis([time(clampon)-.1,time(clampoff)+.1,-Inf,Inf]);
% subplot(3,1,2); plot(time(2:length(time)),fslope); title('Filtered slope 1'); axis([time(clampon)-.1,time(clampoff)+.1,-Inf,Inf]);
slope2= diff(fslope)./diff(time(2:length(time)));
% subplot(3,1,3); plot(time(3:length(time)),slope2); title('slope 2'); axis([time(clampon)-.1,time(clampoff)+.1,-Inf,Inf]);

%Low-pass filters to determine baseline values
Wn= 8./Fs;
[b2,a2]=butter(3,Wn);
fVm=filter(b2,a2,Vm);
% figure(2); plot(time,fVm); axis([.1,2,-Inf,Inf]); hold all;

spikes=[];
spikes2=[];
amp=[];
dur=[];
AHPdur=[];
AHPmag=[];
Vth=[];

%Finds spikes in 2nd derivative
spikes=find(slope2>s2thresh);

k=find(spikes>(clampon+transient.*Fs),1);

% If there are spikes after the transient
if (isempty(k)~=1)
    spikes2=spikes(k);  %sample number of first spike
    
    for (j=(k+1):length(spikes))
        if (time(spikes(j))-time(spikes(j-1)) > spikemin);
           spikes2=[spikes2 spikes(j)];
        end
    end
    
    Vth=Vm(spikes2)';  % determines threshold voltage for each spike
    Vbase=fVm(spikes2)'; % determines baseline voltage at the time of each spike
    [Rth,Cth]=size(Vth);
    [Rvm,CVm]=size(Vm);
    [Rsp,Csp]=size(spikes2);
    
    for (i=1:Cth)
        if ((i+1)<length(spikes2))  % For repeated spiking, ignores end of train
            endpoint=spikes2(i+1);
        else
            endpoint=clampoff;    % For end of train or single spike
        end
        
        AP=(find(Vm(spikes2(i):endpoint)>Vth(i)))';
        APnew=AP+spikes2(i)-1;
                
        if (isempty(APnew)~=1)
            dur(i)=length(APnew)*time(2);  %defines duration as time spent over threshold
            [Vmax(i),samplemax(i)]=max(Vm(spikes2(i):(endpoint-1)));
            [Vmin(i),samplemin(i)]=min(Vm(spikes2(i):(endpoint-1)));
            smax(i)=samplemax(i)+spikes2(i)-1;
            smin(i)=samplemin(i)+spikes2(i)-1;
        
            % defines first and last sample when signal is below threshold for preceding spike
            first(i)= find(Vm(smax:endpoint) < Vth(i),1,'first')  ;
            last(i)= find(Vm(smax:endpoint) < Vth(i),1,'last')  ;  
            firstnew(i)=first(i)+smax(i);
            lastnew(i)=last(i)+smax(i);
        
            if (isempty(first)~=1)
                AHPdur(i)=(lastnew(i)-firstnew(i))./Fs;
                amp(i)=Vmax(i)-Vth(i);
                AHPmag(i)=Vmin(i)-Vth(i);
            end
        end
    end
    
      
end

   
end