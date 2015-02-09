% Function finds spike times and Vths for spikes that exceed -10mV

function [spikes2, VTH]= findspikes(time,Vm,Fs,clampon)

spikes2=[]; VTH=[]; 
spikemin=.01;   %time from threshold detection to beginning to look for peak, in seconds
transient=.38; %time to ignore at beginning of signal, in seconds (default 0.008)

spikes=find(Vm>0);
length(spikes);
k=find(spikes>(clampon+transient.*Fs),1);

if (isempty(k)~=1)
   temp=clampon+transient.*Fs;
   [samplemax,Vth, Vprime]=phasespace_derivative(time(temp:spikes(k)),Vm(temp:spikes(k)),Fs);
   spikes2=[samplemax+temp-1];
   VTH=[Vth];
  
   for (j=(k+1):length(spikes))
        if (time(spikes(j))-time(spikes(j-1)) > spikemin)
            temp=spikes(j)-spikemin.*Fs;
           [samplemax,Vth, Vprime]=phasespace_derivative(time(temp:spikes(j)),Vm(temp:spikes(j)),Fs);
            spikes2=[spikes2 (samplemax+temp)];
            VTH=[VTH Vth];

        end
   end

end
