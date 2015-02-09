%function reads voltage ramps and creates IV plot, calculates hysteresis if
%present

function [cell]=vramp(filename)

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
   % namedown=strcat('Sweep ',num2str(i),' down');
    
    leg=strvcat(leg, name);
   % leg2=strvcat(leg2, nameup, namedown);
    
    j=find(Vmshort~=holding,1);
   ramppeak=Swaveshort(j);
   rampon=Swaveshort(j-1);
   rampoff=Swaveshort(j+1);
    
   voltage = spline(Swaveshort,Vmshort,samples);  % Interpolates command waveform
    figure(1); subplot(2,1,1); plot(time,Im); hold all
    subplot(2,1,2); plot(voltage(rampon:ramppeak),Im(rampon:ramppeak)); hold all %voltage(ramppeak:rampoff),Im(ramppeak:rampoff)
    cell(i).Im=Im; cell(i).Vm=voltage; cell(i).rampon=rampon; cell(i).ramppeak=ramppeak; cell(i).rampoff=rampoff;
    
    [slope]=IV_derivative(voltage(rampon:ramppeak),Im(rampon:ramppeak),1/time(2));
end

figure(1); subplot(2,1,1); 
xlabel('Time (s)')
ylabel('Current (pA)')
legend(leg)
subplot(2,1,2); 
xlabel('Voltage (mV)')
ylabel('Current (pA)')
%legend(leg2)


% j=find(cell(i).Vm(cell(i).rampon:cell(i).ramppeak)<-60 & cell(1).Vm(cell(i).rampon:cell(i).ramppeak)>-75);
% Vm1=cell(i).Vm(cell(1).rampon+j);
% Im1=cell(i).Im(cell(1).rampon+j);
% k= find(cell(i).Vm(cell(i).rampon:cell(i).ramppeak)<-45 & cell(i).Vm(cell(i).rampon:cell(i).ramppeak)>-60);
% Vm2=cell(i).Vm(cell(i).rampon+k);
% Im2=cell(i).Im(cell(i).rampon+k);
% Im1=Im1'; Im2=Im2';
% [fit,S]=polyfit(Vm1,Im1,1)
% [estimate1,error1]=polyval(fit,Vm1,S);
% [estimate2,error2]=polyval(fit,Vm2,S);
% figure(i+1); plot(Vm1,Im1,'k',Vm1,estimate1,'b',Vm2,Im2,'k',Vm2,estimate2,'r')
% cell(i).maxdev=max(abs(error2))

end





