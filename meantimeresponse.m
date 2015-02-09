%function looks at time dependent response using means for each file, input
%cell a row for each
function [timestats,normalDRPamp,normalVRPamp,normalbaseDRP,normalbaseVRP]=meantimeresponse(inputcell)
[numruns,~]=size(inputcell);
timestats=cell(numruns,3);    %defines cell size as the number of runs, with columns for DRP and VRP and EFP
normalDRPamp=[]; normalVRPamp=[];
time=0:5:(length(inputcell{1,1})-1)*5;

for i=1:numruns
    files=inputcell{i,1};
    [DRPstats, baselinevalues]=comparemeanDRP(files,i);
    [num,~]=size(DRPstats);
    
    for j=1:num
        timestats{i,j}=DRPstats{j,1};
    end
               
    %normalizes DRP and VRP amplitude based on initial file for each run
    normalDRPamp(:,i)=[DRPstats{1,1}(:,2)./DRPstats{1,1}(1,2)];
    normalVRPamp(:,i)=[DRPstats{2,1}(:,2)./DRPstats{2,1}(1,2)];
    normalbaseDRP(:,i)=[(baselinevalues(:,1)-baselinevalues(1,1))./DRPstats{1,1}(1,2)];
    normalbaseVRP(:,i)=[(baselinevalues(:,2)-baselinevalues(1,2))./DRPstats{2,1}(1,2)];   
    
%     if i<2
%         fraction=.1;
%     else
%         fraction=1;
%     end
%     normalbaseDRP(:,i)=(baselinevalues(:,1)-baselinevalues(1,1))/fraction;
%     normalbaseVRP(:,i)=(baselinevalues(:,2)-baselinevalues(1,2))/fraction;
end
figure(100); plot(time,normalDRPamp,'.'); title('Normalized Evoked DRP Amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); 
figure(200); plot(time,normalVRPamp,'.'); title('Normalized Evoked VRP Amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); 
% figure(300); plot(time,normalbaseDRP,'.');title('Normalized Dorsal Root Polarity Shifts'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); 
% figure(400); plot(time,normalbaseVRP,'.');title('Normalized Ventral Root Polarity Shifts'); xlabel('Time (min)'); ylabel('Normalized Amplitude');

if num>2
   normalEFPamp(:,i)=[DRPstats{3,1}(:,2)./DRPstats{3,1}(1,2)];
  % normalbaseEFP(:,i)= [(baselinevalues(:,3)-baselinevalues(1,3))./DRPstats{3,1}(1,2)];
else
   normalEFPamp(:,i)=zeros(length(time),1);
 %  normalbaseEFP(:,i)= zeros(length(time),1);
end
figure(500); plot(time,normalEFPamp,'.');  title('Normalized Evoked EFP amplitude'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); 
%figure(600); plot(time,normalbaseEFP,'.'); title('Normalized EFP Polarity Shifts'); xlabel('Time (min)'); ylabel('Normalized Amplitude'); 

end