% IV_files={'08o21004.abf','08o21006.abf','08o21008.abf','08o21010.abf','08o21012.abf','08o21014.abf','08o21016.abf'};
% names={'base3','base4','base5','base6','KAI','wash1','wash2'};
% IV_files={'08o21016.abf','08o21018.abf','08o21020.abf','08o21022.abf'};
% names={'base','KAI+DA','wash1','wash2'};
% IV_files={'08107000.abf','08107081.abf','08109000.abf','08115000.abf','08116000.abf','08122001.abf','08122045.abf','08122053.abf'};
% names={'1/7/08 c1','1/7/08 c2','1/9/08','1/15/08','1/16/08','1/22/08 c1','1/22/08 c2','1/22/08 c3'};
IV_files={'07815012.abf','07829001.abf','07927015.abf','08320001.abf','08320028.abf','08327001.abf','08327014.abf','08327050.abf','08327100.abf','08422009.abf','08423114.abf','08523088.abf','08626005.abf','08626038.abf','08710085.abf','08805048.abf'};
%names={'1/7/08 c1','1/7/08 c2','1/9/08','1/15/08','1/16/08','1/22/08 c1','1/22/08 c2','1/22/08 c3'};


[IV]=compareiv(IV_files);
traces=[5:1:7]; %traces to fit for Rin

for j=2:2 %:length(IV_files)
     voltage=IV(j).voltage;
    avg=IV(j).avg; peak=IV(j).peak;
   [fit1,S]=polyfit(voltage(traces),avg(traces),1);
   IV(j).fit1=fit1;
   IV(j).Rm1=10^9/fit1(1);
   Rm(j)=IV(j).Rm1;
   [estimate,error]=polyval(fit1,voltage(traces),S)
   figure(10); plot(voltage(traces),avg(traces),'*'); hold all; c=get(findobj('Type','line'),'Color'); 
        if(iscell(c)==0)
            c={c};
        end
        figure(10); plot(voltage(traces),estimate,'-','Color',c{1});
%    figure(10);  plot(voltage,avg,'*-'); hold all;
%    figure(20); plot(voltage,peak,'*-'); hold all
end
figure(10); title('Steady State Current'); 
xlabel('Vm (mV)')
ylabel('Current (pA)'); %legend([names,names]);
% figure(20); title('Peak Inward Current'); xlabel('Vm (mV)'); ylabel('Current (pA)'); legend(names)
figure(2); plot(Rm,'-*'); xlabel('Time point'); ylabel('Input Resistance (ohm)');