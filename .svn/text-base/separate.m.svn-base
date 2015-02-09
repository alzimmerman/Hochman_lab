%Function separates hyperpolarizing current pules from continuous cclamp
%recordings

function [sample_inject,sample_noinject]=separate(time,Im,Swaveform,base_inject)

[inject_SW]=find(Im~=base_inject);
injection= Im(inject_SW);

sample_inject=[Swaveform(inject_SW(1)):1:(Swaveform(inject_SW(length(inject_SW))+1)+8000)];
sample_noinject=[1:1:Swaveform(inject_SW(1)), (Swaveform(inject_SW(length(inject_SW)))+8000):1:length(time)];
       

end