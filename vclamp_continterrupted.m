% function plots vclamp constant
function [time_continuous,fIm_cont]=vclamp_continterrupted(filename, base_volt)

file=readabf(filename);
cutoff=20;
time=(file.data.time');
Im= file.data.v_clamp;
Vwaveform=file.waveform.yPoints(:,1)+base_volt; % only need first column
Swaveform=file.waveform.xPoints(:,1);  % gives sample number

[R,C]=size(Im);
Fs=1/time(2);

time_continuous=[];
Im_continuous=[];
leg={};

Fs=1/time(2);

[sample_inject,sample_noinject]=separateVm(time,Vwaveform,Swaveform,base_volt);

for i=1:C
    i
    time_continuous=[time_continuous; (((i-1).*time(length(time)))+time(sample_noinject))];
    Im_continuous=[Im_continuous; Im(sample_noinject,i)];
    leg=strvcat(leg, num2str(i), [num2str(i),' fit']);
   
end

Wn=cutoff./Fs;  %cutoff normalized to sampling frequency
[b,a] = cheby2(8,20,Wn) ;
fIm_cont=filter(b,a,Im_continuous);

figure(2); plot(time_continuous,fIm_cont); hold all
xlabel('Time(s)')
ylabel('Im (pA)')
title(['vClamp Continuous Recording, File ',filename]) 


end