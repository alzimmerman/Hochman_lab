% Function inputs abf filename in string format and a bias injection (when
% in doubt, use zero, and plots response with Vth marked

function [C]=plotcurr(filename,injection)

file=readabf(filename);
time=(file.data.time');
Vm= file.data.c_clamp./10;
Iwaveform=file.waveform.yPoints+injection;
Swaveform=file.waveform.xPoints; 
[~,C]=size(Vm);
%Vmax=[];

leg= cell(1,C); 
current=zeros(1,C);
j=find(Iwaveform(:,1)~=injection,1);
clampon=Swaveform(j,1);
clampoff=Swaveform(j+1,1);

for i=1:C
    current(i)=Iwaveform(j,i);
    name=strcat(num2str(current(i)),' pA');
    leg{i}=name;
   
    [~,~,~,~,~,~,Vth,spikes2]=spikeparams(time,Vm(:,i),clampon,clampoff);
    plot(time,Vm(:,i),'-'); hold all; c=get(findobj('Type','line'),'Color'); 
        if(iscell(c)==0)
            c={c};
        end
        %index=find(peak>0); nanpeak=peak(index);
        %Vmax=Vm(nanpeak,i);
    
    plot(time(spikes2),Vth,'*','MarkerEdgeColor',c{1},'MarkerFaceColor',c{1}); hold all;

end

title(['File ',filename])
xlabel('Time (s)'); ylabel('Vm (mV)'); 
C=legend(leg)    ;
