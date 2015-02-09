function t=comparecurr(files)

[R,C]=size(files);
leg={};

for i=1:R
    name=files(i,:)
    [Vth,Amp,Dur,AHPmag,AHPdur,freq,k,current]=currclamp(name);
    figure(2); subplot(2,1,1);plot(current(k),freq(k),'*'); hold all
    maxcurr(i)=max(freq(k));
    subplot(2,1,2); plot(current(k),Vth(k),'*'); hold all
      
    figure(3);
    subplot(2,1,1); plot(current(k),AHPmag(k),'*'); hold all
    subplot(2,1,2); plot(current(k), AHPdur(k).*1000,'*'); hold all

    figure(4)
    subplot(2,1,1); plot(current(k),Amp(k),'*'); hold all
    subplot(2,1,2); plot(current(k),Dur(k).*1000,'*'); hold all

    file=readabf(name);
    time=(file.data.time');
    Vm= file.data.c_clamp./10;
    for j=1:length(current)
        name=strcat(num2str(current(j)),' pA');
        leg=strvcat(leg, name);
    end
    
    figure(200+i); plot(time,Vm);  title(name); xlabel('Time (ms)'); ylabel('Vm (mV)'); legend(leg)

end

maxcurr=maxcurr

figure(2); subplot(2,1,1);
xlabel('Current (pA)')
ylabel('Frequency (Hz)')
title('FI')
legend(files);
    
subplot(2,1,2); xlabel('Current (pA)')
ylabel('Voltage (mV)')
title('Threshold Voltage')
legend(files);
    
figure(3); subplot(2,1,1); 
xlabel('Current (pA)')
ylabel('AHP Magnitude (mV)')
title('Afterhyperpolarization Parameters')

subplot(2,1,2);
xlabel('Current (pA)')
ylabel('AHP Duration (ms)');
legend(files);

figure(4); subplot(2,1,1); 
xlabel('Current (pA)')
ylabel('Amplitude (mV)')
title('Action Potential Parameters')
legend(files)
subplot(2,1,2); 
xlabel('Current (pA)')
ylabel('Duration (ms)')
legend(files);

% for i=1:R
%     name=files(i,:);
%     file=readabf(name);
%     time=(file.data.time');
%     Vm= file.data.c_clamp./10;
%     Im=file.waveform.yPoints;
%     Swaveform=file.waveform.xPoints;  %gives sample number
%     
%     figure(i)
%     [R2,C2]=size(Vm);
%     
%     for j=1:C2
%      plot(time,Vm(:,j));
%      hold all
%     end
%     
%     axis([.1,2,-Inf,Inf]);
%     title(name)
%     xlabel('Time (s)')
%     ylabel('Vm (mV)')
% end
