%Function separates interrupted voltage clamp data
function [sample_inject,sample_noinject]=separateVM(time,Vwaveform,Swaveform,base_volt)

[inject_SW]=find(Vwaveform~=base_volt);
injection= Vwaveform(inject_SW);

sample_inject=[Swaveform(inject_SW(1)):1:(Swaveform(inject_SW(length(inject_SW))+1)+8000)];
sample_noinject=[1:1:Swaveform(inject_SW(1)), (Swaveform(inject_SW(length(inject_SW)))+8000):1:length(time)];
       

end