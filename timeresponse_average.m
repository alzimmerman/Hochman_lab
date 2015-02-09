%function looks at time dependent response using averages of num sweeps,
%each sweep of specified sweeplength
function [timestats,normalDRPamp,normalVRPamp,normalEFPamp,time]=timeresponse_average(inputcell,sweeplength,avgnum)
[numruns,~]=size(inputcell);
timestats=cell(numruns,3);    %defines cell size as the number of runs, with columns for DRP and VRP and EFP
normalDRPamp=[]; normalVRPamp=[];

for i=1:numruns
    files=inputcell{i,1};
    [DRPstats]=timecompare_averageDRP(files,i,avgnum);
    [num,~]=size(DRPstats);
    
    for j=1:num
        timestats{i,j}=DRPstats{j,1};
    end
               
    %normalizes DRP and VRP amplitude based on initial file for each run
    normalDRPamp(:,i)=[DRPstats{1,1}(:,2)./DRPstats{1,1}(1,2)];
    normalVRPamp(:,i)=[DRPstats{2,1}(:,2)./DRPstats{2,1}(1,2)];
    
    
    if num>2
        normalEFPamp(:,i)=[DRPstats{3,1}(:,2)./DRPstats{3,1}(1,2)];
    else
        normalEFPamp(:,i)=zeros(length(normalDRPamp),1);
    end 
end
time=0:(sweeplength.*avgnum):length(normalDRPamp).*(sweeplength.*avgnum)-1;
figure(100); plot(time,normalDRPamp,'.'); title('Normalized Evoked DRP Amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude');
figure(200); plot(time,normalVRPamp,'.'); title('Normalized Evoked VRP Amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); 
figure(300); plot(time,normalEFPamp,'.');  title('Normalized Evoked EFP amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); 
for i=1:numruns
    figure(i*10); plot(time, normalDRPamp(:,i),'.',time, normalVRPamp(:,i),'*',time, normalEFPamp(:,i),'^'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); legend('DRP','VRP','EFP');
end

end