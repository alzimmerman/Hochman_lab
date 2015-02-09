file=readabf(cell(1).name);

time=(file.data.time');
Vm= file.data.c_clamp./10;
Iwaveform=file.waveform.yPoints;
Swaveform=file.waveform.xPoints;

for i=1
temp=log(sqrt(time(2:end)).*diff(Vm(:,i))./time(2));
plot(time(2:end),temp)
end