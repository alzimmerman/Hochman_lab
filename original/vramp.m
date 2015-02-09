%function reads voltage ramps and creates IV plot, calculates hysteresis if
%present

function vramp(filename)

file=readabf(filename);

holding=-80;    % in mV, holding potential
time=file.data.time;

  
[R,C]=size(file.data.v_clamp);     % C is number of sweeps, r is number of timepoints (samples)
samples=[1:1:R];

leg= {}; leg2= {};
for i=1:C
    Im= file.data.v_clamp(:,i);
    Vm=file.waveform.yPoints(:,i)+holding;
    Swaveform=file.waveform.xPoints(:,i);    % gives sample number
    l=length(Swaveform);
    
    %Shortens waveform data and initializes variables
    Swaveshort= Swaveform(1);
    Vmshort=Vm(1);
    
    for k=2:l
        if (Swaveform(k)~=Swaveform(k-1))
            Swaveshort=[Swaveshort Swaveform(k)];
            Vmshort=[Vmshort Vm(k)];
        end
    end
    
    name=strcat('Sweep ',num2str(i));
    nameup=strcat('Sweep ',num2str(i),' up');
    namedown=strcat('Sweep ',num2str(i),' down');
    
    leg=strvcat(leg, name);
    leg2=strvcat(leg2, nameup, namedown);
    
    j=find(Vmshort~=holding,1)
    ramppeak=Swaveshort(j);
    rampon=Swaveshort(j-1);
    rampoff=Swaveshort(j+1);
    
    voltage = spline(Swaveshort,Vmshort,samples);  % Interpolates command waveform
    subplot(2,1,1); plot(time,Im); hold all
    subplot(2,1,2); plot(voltage(rampon:ramppeak),Im(rampon:ramppeak),voltage(ramppeak:rampoff),Im(ramppeak:rampoff)); hold all

end

subplot(2,1,1); 
xlabel('Time (s)')
ylabel('Current (pA)')
legend(leg)
subplot(2,1,2); 
xlabel('Voltage (mV)')
ylabel('Current (pA)')
legend(leg2)

end




