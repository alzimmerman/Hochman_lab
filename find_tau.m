% Function calculates time constant tau from discharge time
function [Vm_ss,Vm_base,tau]=find_tau(time,Vm,clampon,clampoff,R,current,injection)

%Vm_ss is mean value of Vm during 2nd half of current clamp, base is
    %baseline recording
    Vm_ss=mean(Vm((clampon+round(clampoff-clampon)/2):clampoff));
    Vm_base=mean(Vm(1:clampon));
    l=[]; tau=[];
    
%     if current>injection
%         l=find(Vm(clampoff:R)<((exp(-1)*(Vm_ss-Vm_base))+Vm_base),1);
%     elseif current<injection
%         l=find(Vm(clampoff:R)>((exp(-1)*(Vm_ss-Vm_base))+Vm_base),1);
%     end
    

    if (isempty(l)~=1)
        tau=time(l);
    else
        tau=0;
    end
    
end