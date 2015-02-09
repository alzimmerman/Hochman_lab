% Function reads series of continuous current recordings interrupted by
% ccstep protocols

function [cell]=cclamp_series(prefix,firstfile,lastfile,injection)

files=combinefiles(prefix,firstfile,lastfile);

%time perfusion is on during
timeon=15:.1:164;

[R,C]=size(files);
time_previous=0;
time_pts=[];
files_cclamp={};

for i=1:R
    name=files(i,:);
    file=readabf(name);
      
   if(isfield(file.data,'c_clamp')==1)
      files_cclamp=[files_cclamp, name];
      time_pts=[time_pts time_previous];
      [end_time,Vm_base,base_time]=concatenate_ccstep(name,time_previous);
%       figure(3); plot(base_time,Vm_base,'b'); hold on

   elseif(isfield(file.data,'IN0')==1)
        time=(file.data.time')+time_previous;
        Vm= file.data.IN0./10;
        figure(9); plot(time,Vm,'b'); hold on
        end_time=time(length(time));     
   end
    
    clear time; clear Vm;
    time_previous=end_time;
end

injection=injection.*ones(1,length(files_cclamp));
[cell]=comparecurr(files_cclamp,injection);
[Rc,Cc]= size(cell);


for i=1:Cc
figure(8); plot(cell(i).current,cell(i).freq); hold all
end

temp=1.1.*ones(length(timeon),1);
figure(9); title('Constant Current Injection'); xlabel('Time (s)'); ylabel('Vm (mV)');


       