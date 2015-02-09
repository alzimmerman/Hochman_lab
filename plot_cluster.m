[R2,P2]=corrcoef(params);
[R,C]=size(params);
% for i=1:C
%     stdev(i)=std(params(:,i));
%     norm_params(:,i)=params(:,i)./stdev(i);
% end
% [COEFF,latent,explained] = pcacov(R2);
% figure; biplot(COEFF(:,1:2),'varlabels',name); title('PCA using covariance'); xlabel('Principle Component 1','fontsize',12); ylabel('Principle Component 2','fontsize',12); 
% figure; pareto(100*latent/sum(latent)); title('% variance explained per component, PCA Cov');

% [D,eigvect,eigval,pcorder] = pca_of_data(norm_params',9);
%   D = D';
%   [coefs,scores,variances,t2] = princomp(zscore(params));
%   contributions=abs(coefs)*variances/sum(variances);
%   [values,index]=sort(contributions,'descend');
% %   pareto(values); xticklabel_rotate([],90,name(index));  set(gcf,'Color','w');
%   figure; pareto(100*variances/sum(variances))
%   xlabel('Principal Component')
%   ylabel('Variance Explained (%)')
%   set(gcf,'Color','w'); set(gca,'Box','off')
% 
%     
%   figure; biplot(coefs(:,1:2),'varlabels',name); title('Centered and Scaled PCA');  xlabel('Principle Component 1','fontsize',12); ylabel('Principle Component 2','fontsize',12);
%    set(gcf,'Color','w'); set(gca,'Box','off','XGrid','off','YGrid','off')
%   figure; biplot(coefs(:,3:4),'varlabels',name); title('Centered and Scaled PCA'); xlabel('Principle Component 3','fontsize',12); ylabel('Principle Component 4','fontsize',12);
%   %figure; biplot(eigvect(:,1:2),'varlabels',name); title('Normalized PCA','fontsize',14); 
%   set(gcf,'Color','w'); set(gca,'Box','off','XGrid','off','YGrid','off'); 
%   figure; biplot(coefs(:,1:3),'varlabels',name); title('Centered and Scaled PCA');  xlabel('Principle Component 1','fontsize',12); ylabel('Principle Component 2','fontsize',12);
%   set(gcf,'Color','w'); set(gca,'Box','off')
%   figure; scatter3(scores(:,1),scores(:,2),scores(:,3),50,group,'filled'); xlabel('Principle Component 1','fontsize',12); ylabel('Principle Component 2','fontsize',12); zlabel('Principle Component 3','fontsize',12); 
%   set(gcf,'Color','w'); set(gca,'Box','off')
%   
 % figure; pareto(100*eigval/sum(eigval)); title('% variance explained per component, PCA norm');
%   figure; gscatter(scores(:,1),scores(:,2),group,'bkgr','^sod',6); xlabel('Principle Component 1','fontsize',12); ylabel('Principle Component 2','fontsize',12); title('Clustered data in principle components','fontsize',14);
%   set(gcf,'Color','w'); set(gca,'Box','off')
%   figure; gscatter(scores(:,3),scores(:,4),group,'bkgr','^sod',6); xlabel('Principle Component 3','fontsize',12); ylabel('Principle Component 4','fontsize',12); title('Clustered data in principle components','fontsize',14);
%   set(gcf,'Color','w'); set(gca,'Box','off')

%[i,j]=find(P2<1); temp=find(i==index(1)| i==index(2) | i==index(3)| i==index(4));
%temp=index(1:6);
% for k=1:length(temp)
%     for j=(k+1):length(temp)
%         figure; gscatter(params(:,temp(k)),params(:,temp(j)),group,'bkgrmc','s^od',6); xlabel(name(temp(k)),'fontsize',14); ylabel(name(temp(j)),'fontsize',14);
% set(gca,'FontSize',14,'LineWidth',1); set(gcf,'Color','w');
% end
% end

[i,j]=find(P2<0.1); temp=find(i==3);
for k=1:length(temp)
figure; gscatter(params(:,i(temp(k))),params(:,j(temp(k))),group,'bkgrmc','^sod',8); xlabel(name(i(temp(k))),'fontsize',16); ylabel(name(j(temp(k))),'fontsize',16);
set(gca,'FontSize',14,'LineWidth',1); set(gcf,'Color','w');
end

for i=1:C
    means(1:4,i)=grpstats(params(:,i),group);
    stdevs(1:4,i)=grpstats(params(:,i),group,'std');
    number(i)=length(find(group==i));
    [p,t,st] = anova1(params(:,i),group,'off');   %overall p, table, stats returned per variable
    prob(i)=p;
       if p<0.05
%        figure; bar(means(:,i),0.6,'b'); xlabel('Group number','fontsize',16); hold all; plot(group,params(:,i),'.k'); title(name(i),'fontsize',16);
%        set(gca,'FontSize',14,'Box','off','LineWidth',1,'XTick',[1:1:4]); set(gcf,'Color','w');
%    figure; [c,m] = multcompare(st,'alpha',0.1); title(name(i)')
%         statistics(i).c=c;
%         statistics(i).m=m;
%         statistics(i).st=st;
%         statistics(i).t=t;
    end
end

% j=find(prob<0.055); k=1;
% for i=j
%     norm_means(:,k)=means(:,i)./stdevs(:,i);
%     k=k+1;
% end
% bar(norm_means');
% 
% %C is in the format: [grp1 grp2 lowerCI meandiff upperCI] so if range does not include zero, reject null hypothesis.
% 
% %m has 2 columns, mean and stdev
%     
% % for m=1:length(name)
% %     figure; boxplot(params(:,m),group); title(name(m+1));
% % end
% 

impt_mean=means(:,find(prob<0.05))
impt_stdev=stdevs(:,find(prob<0.05))
