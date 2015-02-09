% Function calculates conductances for a series of current steps
function [Vm_ss,Gm,Im]=calc_conduct(Swaveform,Iwaveform,Vm)

Sadjusted=Swaveform+1;
Gm=[]; Im=[]; Vm_ss=[];

for i=2:length(Swaveform)
    if (Sadjusted(i)~=Sadjusted(i-1))
        Shalf=Sadjusted(i-1) +round((Sadjusted(i)-Sadjusted(i-1))/2);
        avgVm=mean(Vm(Shalf:(Sadjusted(i)-1)));
        ind=find(Im==Iwaveform(i));
        
        if (isempty(ind)==1)
            Vm_ss=[Vm_ss avgVm];
            Im=[Im Iwaveform(i)];
            Gm=[Gm,(Iwaveform(i)./avgVm)];
        else
            Vm_ss(ind)=mean([avgVm; Vm_ss(ind)]);
            Gm(ind)=Iwaveform(i)./Vm_ss(ind);
        end
    end
end
       
    
end      
        
