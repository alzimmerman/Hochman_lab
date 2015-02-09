[R,C]=size(params);
norm_params=zscore(params);
% norm_params=params;
for i=2:10
    [idx,cent,sumdist,D] = kmeans(norm_params,i,'distance','cityblock','replicates',20);
    avgdist(i)=mean(sumdist);
%     for j=1:i
%         cluster_dist(j)=mean(D(find(idx~=j),j));
%     end
%     avg_cluster_dist(i)=mean(cluster_dist);
    [avg,stdev] = grpstats(params,idx,{'mean','std'});
    cell(i).idx=idx;
    cell(i).cent=cent;
    cell(i).avg=avg;
    cell(i).stdev=stdev;
   
end

[R2,P2]=corrcoef(params);
[i,j]=find(P2<0.055); temp=find(i<j);
% for k=1:length(temp)
% figure; gscatter(params(:,i(temp(k))),params(:,j(temp(k))),cell(4).idx,'bkgrmc','^sod',6); xlabel(name(i(temp(k))+1),'fontsize',14); ylabel(name(j(temp(k))+1),'fontsize',14);
% set(gca,'FontSize',12,'LineWidth',1); set(gcf,'Color','w');
% end

% for m=1:C
%     figure; boxplot(params(:,m),cell(3).idx); title(name(m+1));
% end

% scatter3(params(:,1),params(:,4),params(:,5),100,cell(4).idx,'filled'); xlabel(names(1)); ylabel(names(4)); zlabel(names(5));
% figure; scatter3(params(:,1),params(:,2),params(:,3),100,cell(4).idx,'filled'); xlabel(names(1)); ylabel(names(2)); zlabel(names(3));
figure; plot([1:1:length(avgdist)],avgdist,[1:1:length(avgdist)],.3679*max(avgdist)*ones(1,length(avgdist))); xlabel('Number of clusters'); ylabel('Average normalized distance ');
% slope=diff(avgdist); subplot(2,1,2); plot([1:1:length(avgdist)-1],slope)