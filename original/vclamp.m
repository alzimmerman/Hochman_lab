% Function reads in filename of abf file, plots IV for peak inward and
% steady state values
% Data input is in ms, mV, and pA

function [voltage,avg,peak]= vclamp(filename)

file=readabf(filename);

holding=-80;    % in mV, holding potential
time=file.data.time;
Im= file.data.v_clamp./10;
Vm=file.waveform.yPoints+holding;       %waveform has fewer time points and y values
Twaveform=file.waveform.xPoints;    % gives sample number
  
[R,C]=size(Im);

leg= {};

% for initial run calculates clamp on and off times, also calculates time of capacitive peak; requires first
% voltage step to be less than holding
    j=find(Vm(:,1)~=holding,1);
    clampon=Twaveform(j,1);
    clampoff=Twaveform(j+1,1);
    [cap,capindex]=max(Im(:,1));
    
for i=1:C
    voltage(i)=Vm(j,i);
        
    figure(1); hold all
    if (rem(i,2)==0)
        plot(time,Im(:,i));
        name=strcat(num2str(voltage(i)),' mV');
        leg=strvcat(leg, name);
    end
    avg(i)=mean(Im((clampoff-clampon)./2:clampoff,i));  %takes mean from second half of voltage step  
    peak(i)=min(Im(capindex:length(Im),i));         %calculates peak inward current
end

legend(char(leg))
xlabel('Time(ms)')
ylabel('Current (pA)')
hold off

% figure(2)
% subplot(2,1,1); plot(voltage,avg,'*',voltage,peak,'*')
% xlabel('Vm (mV)')
% ylabel('Current (pA)')
% legend('Steady state','Peak Inward Current')
% subplot(2,1,2); plot(voltage,(10e9*voltage./avg),'*')
% xlabel('Vm (mV)');
% ylabel('Resistance (ohms)')


end
