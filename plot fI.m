
for i=1:length(cell)
    for j=cell(i).k
        first_freq(j-cell(i).k(1)+1)=cell(i).temp(j).frequency(1);
    end
    cell(i).first_freq=first_freq;
if(group(i)==1)
plot(cell(i).current(cell(i).k),cell(i).freq,'b','LineWidth',2); hold all
elseif(group(i)==2)
plot(cell(i).current(cell(i).k),cell(i).freq,'k','LineWidth',2); hold all
elseif(group(i)==3)
plot(cell(i).current(cell(i).k),cell(i).freq,'g','LineWidth',2); hold all
else
plot(cell(i).current(cell(i).k),cell(i).freq,'r','LineWidth',2); hold all
end
end
xlabel('Current (pA)','fontsize',14); ylabel('Mean Firing Frequency (Hz)','fontsize',14); set(gca,'FontSize',14,'LineWidth',2); set(gcf,'Color','w');
title('Mean F-I Plot','fontsize',16)

% for i=1:length(cell)
%     if(group(i)==1)
%     plot(cell(i).current(cell(i).k),cell(i).first_freq,'b','LineWidth',2); hold all
%     elseif(group(i)==2)
%     plot(cell(i).current(cell(i).k),cell(i).first_freq,'k','LineWidth',2); hold all
%     elseif(group(i)==3)
%     plot(cell(i).current(cell(i).k),cell(i).first_freq,'g','LineWidth',2); hold all
%     else
%     plot(cell(i).current(cell(i).k),cell(i).first_freq,'r','LineWidth',2); hold all
%     end
%     end
% xlabel('Current (pA)','fontsize',14); ylabel('Instantaneous Firing Frequency (Hz)','fontsize',14); set(gca,'FontSize',14,'LineWidth',2); set(gcf,'Color','w');
% title('Instantaneous F-I Plot','fontsize',16)
