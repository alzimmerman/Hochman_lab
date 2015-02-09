% Function takes a vertical array of strings with various filenames
% Use strvcat to add filenames in string array definition

function compareiv(files)

[R,C]=size(files);
AVG=[]; VOLTAGE=[];

for i=1:R
    name=files(i,:)
    
    file=readabf(name);
    time=file.data.time;
    Im= file.data.v_clamp./10;

    [voltage,avg,peak]= vclamp(name);
    figure(5);  plot(voltage,avg,'*'); hold all
    if length(avg)>12
        avg=avg(3:length(avg)-1);
        voltage=voltage(3:length(voltage)-1);
    end
    
    length(avg)
    AVG=[AVG; avg];
    VOLTAGE=[VOLTAGE; voltage];
   
%     subplot(2,1,2); plot(voltage,peak,'.'); hold all
    
    figure(100+i); plot(time,Im);  title(name); xlabel('Time (ms)'),ylabel('Im(pA)')
   
end

figure(5); 
legend(files);
avgvolt=mean(AVG)
E = std(AVG)
errorbar(voltage,avgvolt,E) ; 
title('Steady State Current')
xlabel('Vm (mV)')
ylabel('Current (pA)')
% subplot(2,1,2);
% title('Peak Inward Current')
% xlabel('Vm (mV)')
% ylabel('Current (pA)')



end