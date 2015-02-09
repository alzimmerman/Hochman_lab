function [TIME,IM]=vclamp_series(prefix,firstfile,lastfile,holding)

files=combinefiles(prefix,firstfile,lastfile);
[R,C]=size(files);
time_previous=0;
timeon=[60:.1:185];
time_pts=[]; leg=[];
cutoff=100;
TIME=[]; IM=[]; AVG=[]; VOLTAGE=[]; PEAK=[];

for i=1:R
    name=files(i,:)
    file=readabf(name);
    [R2,C2]=size(file.data.v_clamp);
   
   if(R2~=1)
       [voltage,avg,peak,end_time,base_start,base_end,Im_base]=vclamp(name,-80,time_previous);
% %         figure(1);  plot(voltage,avg,'*'); hold all
% %         figure(2); plot(voltage,peak,'*'); hold all
%         
%        time_pts=[time_pts time_previous];
%          
%      %  figure(100+i); plot(time,Im);  title(name); xlabel('Time (ms)'),ylabel('Im(pA)')
%         
%        name1=strcat(num2str(time_previous),' s');
%        leg=strvcat(leg,name1);
%        
%        AVG=[AVG; avg];
%        PEAK=[PEAK, peak];
%        VOLTAGE=[VOLTAGE; voltage];     
       
   else
        time=(file.data.time')+time_previous;
        Im= file.data.v_clamp./10;
        end_time=time(length(time));  
       
        TIME=[TIME; time];
        IM=[IM Im];
   end
   
   
   
%     figure(3); plot(time,Im,'g'); hold on
    clear time; clear Im;
    time_previous=end_time;
end

temp=1.1.*ones(length(timeon),1);

% figure(1); title('Steady State Current'); xlabel('Vm (mV)'); ylabel('Current (pA)');legend(leg)
% figure(2); title('Peak Inward Current'); xlabel('Vm (mV)'); ylabel('Current (pA)');legend(leg)
% figure(3); xlabel('Time (s)'); ylabel('Current (pA)') ; title('Constant Vclamp'); 
% figure(3); plot(timeon,temp.*max(fIm),'c','LineWidth',2);
end
    