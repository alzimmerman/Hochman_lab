%function looks at time dependent response for each row of data
function [timestats,normalDRPamp,normalVRPamp, baselinevalues]= timeresponse(inputcell)

[numruns,~]=size(inputcell);
timestats=cell(numruns,3);    %defines cell size as the number of runs, with columns for DRP and VRP
normalDRPamp=[]; normalVRPamp=[]; normalEFPamp=[];


for i=1:numruns
    files=inputcell{i,1};
    [DRPstats,baselines,num]=timecompareDRP(files);  %returns stats for all traces
    baselinevalues{i,1}=baselines;
    
    for j=1:num
       counter=1; [row,~]=size(DRPstats);
       for k=1:row
           [sweeps,~]=size(DRPstats{k,j});
           timestats{i,j}(counter:(sweeps+counter-1),:)=DRPstats{k,j}(:,:);
           counter=counter+sweeps;
       end
       
    end
    
   %normalizes DRP and VRP amplitude based on initial file for each run
    normalDRPamp(:,i)=[timestats{i,1}(:,2)./timestats{i,1}(1,2)];
    normalVRPamp(:,i)=[timestats{i,2}(:,2)./timestats{i,2}(1,2)];
%     normalbaseDRP(:,i)=(baselinevalues{i,1}(:,1)-baselinevalues{i,1}(1,1)); %./timestats{i,1}(1,2);
%     normalbaseVRP(:,i)=(baselinevalues{i,1}(:,2)-baselinevalues{i,1}(1,2)); %./timestats{i,2}(1,2);

    time=0:1:(length(normalDRPamp)-1)*1;
    
    if num==3
        normalEFPamp(:,i)=[timestats{i,3}(:,2)./timestats{i,3}(1,2)];
        normalbaseEFP(:,i)=(baselinevalues{i,1}(:,3)-baselinevalues{i,1}(1,3))./timestats{i,3}(1,2);
        %figure(500); plot(time,normalbaseEFP,'.');title('Normalized EFP Baseline'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); hold all;
        figure(600); plot(time,normalEFPamp,'.');title('Normalized EFP Amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); hold all;
    end


figure(100); plot(time,normalDRPamp,'.'); title('Normalized DRP Amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); hold all;
figure(200); plot(time,normalVRPamp,'.'); title('Normalized VRP Amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); hold all;
% figure(300); plot(time,normalbaseDRP,'.');title('DRP Baseline'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); hold all;
% figure(400); plot(time,normalbaseVRP,'.');title('VRP Baseline'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); hold all;

end
end

