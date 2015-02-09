% function inputs array of baseline and drug recorded files, outputs stats
% on each with cell number of data sets long; percentage gives
function [drugstats,percentage]=comparedrug_DRP(baseline,drug)
numruns=length(baseline);
drugstats=cell(numruns,3);    %defines cell size as the number of runs, with columns for DRP and VRP
percentage=cell(1,3);
for i=1:numruns
    files=[baseline(i),drug(i)];
    [DRPstats]=comparemeanDRP(files,i);
    [num,~]=size(DRPstats);
    
    for j=1:num
    drugstats{i,j}=DRPstats{j,1};
    
    %normalizes DRP and VRP amplitude based on initial file for each run
    percentage{1,j}(i,:)=DRPstats{j,1}(2,:)./DRPstats{j,1}(1,:);
    end
    
       
end

% figure(100); bar([mean(percentage{1,1}(:,2));mean(percentage{1,2}(:,2))]);   hold all
%    errorbar([mean(percentage{1,1}(:,2)),mean(percentage{1,2}(:,2))],[std(percentage{1,1}(:,2)),std(percentage{1,2}(:,2))],'.')
%     set(gca,'LineWidth',2,'FontSize',12);

end
