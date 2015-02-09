function t=testcurr(filename)

file=readabf(filename);

time=(file.data.time');
Vm= file.data.c_clamp./10;
Im=file.waveform.yPoints;
Swaveform=file.waveform.xPoints;  %gives sample number

[R,C]=size(Vm);
Fs=1/time(2);

leg= {}; leg2={};
AMP=[]; DUR= []; AHPDUR=[]; AHPMAG= []; VTH=[]; FREQ=[];
current=[];

%for initial calculation of clamp times
j=find(Im(:,1)~=0,1);
clampon=Swaveform(j,1);
clampoff=Swaveform(j+1,1);

for i=7:9
    i=i
    current(i)=Im(j,i);
    [amp,dur,AHPdur,AHPmag,Vth,spikes2,first,last,smax,smin]=findspikes(time,Vm(:,i),clampon,clampoff)
    figure(1); plot(time,Vm(:,i),'-',time(spikes2),Vth,'*',time(first),Vm(first,i),'>',time(last),Vm(last,i),'<'); hold all;  
    % axis([.1,1.6,-Inf,Inf]);
    temp= current(i).*ones(length(spikes2),1);
    
    % figure(1);subplot(2,1,2); plot(time(spikes2),temp,'*'); hold all;  axis([.1,2,-Inf,Inf]);
end

end