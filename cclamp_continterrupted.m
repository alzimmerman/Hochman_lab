%function inputs continuous current injection with hyperpolarizing current
%pulses
%inputs baseline injection in pA

function [Vm_continuous, time_continuous]=cclamp_continterrupted(filename,base_inject)

file=readabf(filename);

cutoff=50;
dec_inject=2; %decimate interval
dec_cont=10;
time=(file.data.time');
Vm= file.data.IN_0./10;
Iwaveform=file.waveform.yPoints(:,1)+base_inject; % only need first column
Swaveform=file.waveform.xPoints(:,1);  % gives sample number

[R,C]=size(Vm);
Fs=1/time(2);

time_continuous=[];
Vm_continuous=[];
Gm_fit=[];
leg={};

[sample_inject,sample_noinject]=separate(time,Iwaveform,Swaveform,base_inject);

figure(1); subplot(3,1,1); plot(time(sample_inject),Vm(sample_inject,:)); hold all
    
for i=1:C
    i
    [Vm_ss,Gm,Im]=calc_conduct(Swaveform,Iwaveform,Vm(:,i));
    p(i).fit= polyfit(Vm_ss,Im,1);
    p(i).estimates=polyval(p(i).fit,Vm_ss);
    Gm_fit=[Gm_fit p(i).fit(1)];
    figure(1); subplot(3,1,2); set(gcf,'DefaultAxesColorOrder',[0 0 1;0 0 1;0 .5 0; 0 .5 0;1 0 0; 1 0 0; 0 .75 .75; 0 .75 .75;.75 0 .75; .75 0 .75; .75 .75 0; .75 .75 0;.25 .25 .25; .25 .25 .25]);
    plot(Vm_ss,Im,'.',Vm_ss,p(i).estimates,'-'); hold all
    time_continuous=[time_continuous; (((i-1).*time(length(time)))+time(sample_noinject))];
    Vm_continuous=[Vm_continuous; Vm(sample_noinject,i)];
    leg=strvcat(leg, num2str(i), [num2str(i),' fit']);
   
end

figure(1); subplot(3,1,3); plot([1:C].*time(length(time)),1./Gm_fit,'*'); xlabel('Time (s)'); ylabel('Mean Resistance (G-ohms)');
%filtering protocol
Wn=cutoff./Fs;  %cutoff normalized to sampling frequency
[b,a] = cheby2(6,1,Wn) ;
fVm_cont=filter(b,a,Vm_continuous);


figure(1); subplot(3,1,1); xlabel('Time (s)'); ylabel('Vm (mV)'); title('Hyperpolarizing current pulses');
figure(1); subplot(3,1,2); xlabel('Vm (pA)'); ylabel('Im (pA)'); title('Conductance for current injections');

legend(leg)

figure(2); plot(time_continuous,fVm_cont); hold all
xlabel('Time(s)')
ylabel('Vm (mV)')
title(['Cclamp Continuous Recording, File ',filename]) 

%     plot(time(Swaveform(inject_samples(2*i-1)):Swaveform(inject_samples(2.*i))),Vm(Swaveform(inject_samples(2*i-1)):Swaveform(inject_samples(2.*i))))
% end

end