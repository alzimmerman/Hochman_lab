%uses predefined matrix params (columns=variables,
%rows=cycles/observations/cells) and cell array of strings called name with
%each of variable names
[R2,P2]=corrcoef(params,'rows','pairwise');
[row,col]=size(R2);
[i,j]=find(P2<0.055); %star marked if p less than this value
temp=find(j==12); [i2,j2]=find(P2>0.055 & P2<0.1); %? marked if p less than this value, but greater than above value
for k=1:length(temp) %fits line (order 1) to significantly related variables and plots scatter
    index=find(isnan(params(:,i(temp(k))))<1 & isnan(params(:,j(temp(k)))) <1);
    p=polyfit(params(index,i(temp(k))),params(index,j(temp(k))),1);
    f=polyval(p,params(index,i(temp(k))));
figure; plot(params(index,i(temp(k))),params(index,j(temp(k))),'.k',params(index,i(temp(k))),f,'-k','LineWidth',2); xlabel(name(i(temp(k))),'fontsize',16); ylabel(name(j(temp(k))),'fontsize',16);
set(gca,'FontSize',14,'LineWidth',2); set(gcf,'Color','w');
end

% Reindexing for color coded correlation matrix
R=[R2,ones(col,1);ones(1,(col+1))];
ticks=0.5:1:(col+1.5);
ticklabels=[{' '},name,{' '}];
figure; pcolor(R); caxis([-1 1]);  set(gca,'YTick',ticks,'YTickLabel',ticklabels,'FontSize',12);
set(gca,'XDir', 'reverse','YDir','reverse');  %sets direction of variables in reverse order
set(gcf,'Color','w')
text((ticks(i+1)-0.05),(ticks(j+1)+.25),'*','fontsize',18,'fontweight','bold','horizontalalignment','center','color','black','verticalalignment','middle');
text(ticks(i2+1),(ticks(j2+1)),'?','fontsize',10,'fontweight','bold','horizontalalignment','center','color','black','verticalalignment','middle');
xticklabel_rotate(ticks,90,ticklabels);  %rotates xlabel
title('Correlations')
colorbar

summed_corr=sum(abs(R2));
[max_variance,index]=max(summed_corr);
maxfactor=name{index}
maxval=max_variance*100/sum(summed_corr)