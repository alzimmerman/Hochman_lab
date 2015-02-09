[R2,P2]=corrcoef(params);
[i,j]=find(P2<0.07); temp=find(i<j);
for k=1:length(temp)
figure; gscatter(params(:,i(temp(k))),params(:,j(temp(k))),group,'bkgrmc','^sod',6); xlabel(name(i(temp(k))+1),'fontsize',14); ylabel(name(j(temp(k))+1),'fontsize',14);
set(gca,'FontSize',12,'LineWidth',1); set(gcf,'Color','w');
end

for m=1:length(name)
    figure; boxplot(params(:,m),cell(3).idx); title(name(m+1));
end


