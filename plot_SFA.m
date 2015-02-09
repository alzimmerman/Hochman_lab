SFA_index=[];
for i=1:length(cell)
    %figure; leg={};
  %  set(0,'DefaultAxesColorOrder',[0 0 0],'DefaultAxesLineStyleOrder','o|-|s|--|d|:|^|-.');
    
  clear m; leg={}; SFA_full=[];
    for j=cell(i).k
        clear SFA; clear fit; clear S;
        x=1:1:length(cell(i).temp(j).frequency);
        lny=log(cell(i).temp(j).frequency);
        [fit,S]=polyfit(x,lny,1);
        m((j-cell(i).k(1)+1))=exp(fit(1));
        f = polyval(fit,x); [R,P]=corrcoef(x,lny); 
        if(length(P)>1)
            if(P(2,1)<0.05)
%             plot(x,lny,x,f); hold all;
               SFA=[cell(i).current(j) cell(i).temp(j).frequency(1) exp(fit(1))];
               SFA_full=[SFA_full; SFA];
%                 figure(1); plot(cell(i).current(j),exp(fit(1)),'.'); hold all
%                 figure(2); plot(cell(i).temp(j).frequency(1),exp(fit(1)),'.'); hold all
%             labelm=strcat('m= ',num2str(exp(fit(1))));
%             text((x(length(x))+1),f(length(f)),labelm,'fontsize',12,'horizontalalignment','left','color','black');
%             name=strcat(num2str(cell(i).current(j)),' pA');
%             leg=[leg name];
            end
        end
        %semilogy(cell(i).temp(j).frequency,'^'); hold all
        
    end
    %legend(leg,'location','best','color','none','fontsize',12,'linewidth',1); xlabel('Spike number','fontsize',14); ylabel('Ln (Frequency)','fontsize',14); title(cell(i).name,'fontsize',16);

   %set(gca,'FontSize',12,'box','off'); set(gcf,'Color','w');
    cell(i).SFA=SFA_full;
    if(isempty(SFA_full)<1)
        figure(1); plot(cell(i).SFA(:,1), cell(i).SFA(:,3),'-*'); hold all;
        figure(2); plot(cell(i).SFA(:,2), cell(i).SFA(:,3),'-*'); hold all;
        SFA_index=[SFA_index i];
    end
    cell(i).m=m;
end
figure(1); xlabel('current (pA)'); ylabel('m'); set(gca,'FontSize',12,'box','off'); set(gcf,'Color','w');
figure(2); xlabel('instantaneous freq (Hz)'); ylabel('m'); set(gca,'FontSize',12,'box','off'); set(gcf,'Color','w');