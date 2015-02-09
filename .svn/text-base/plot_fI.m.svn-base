figure;
for i=1:length(cell)
    clear first_freq; clear length_freq;
    for j=cell(i).k
        first_freq(j-cell(i).k(1)+1)=cell(i).temp(j).frequency(1);
        length_freq(j)=length(cell(i).temp(j).frequency);
        max_freq(j)=max(cell(i).temp(j).frequency);
    end
    max_frequency(i)=max(max_freq);
    cell(i).first_freq=first_freq;
    depol_block_index=find(diff(length_freq)<0,1);
    if(isempty(depol_block_index)==0)
        cell(i).depol_block_current=cell(i).current(depol_block_index);
        cell(i).depol_block_freq=first_freq(1+depol_block_index-cell(i).k(1));
        cell(i).depol_block_meanfreq=cell(i).freq(1+depol_block_index-cell(i).k(1));
        depol_block(i,1:2)=[cell(i).depol_block_current cell(i).depol_block_freq];
    else
        cell(i).depol_block_current=NaN;
        cell(i).depol_block_freq=NaN;
        cell(i).depol_block_meanfreq=NaN;
        depol_block(i,1:2)=NaN;
    end
    if(group(i)==1)
        plot(cell(i).current(cell(i).k),cell(i).freq,'b',cell(i).depol_block_current,cell(i).depol_block_meanfreq,'*k','LineWidth',2); hold all
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

figure; 
for i=1:length(cell)
    if(group(i)==1)
    plot(cell(i).current(cell(i).k),cell(i).first_freq,'b',cell(i).depol_block_current,cell(i).depol_block_freq,'*k','LineWidth',2); hold all
    elseif(group(i)==2)
    plot(cell(i).current(cell(i).k),cell(i).first_freq,'k','LineWidth',2); hold all
    elseif(group(i)==3)
    plot(cell(i).current(cell(i).k),cell(i).first_freq,'g','LineWidth',2); hold all
    else
    plot(cell(i).current(cell(i).k),cell(i).first_freq,'r','LineWidth',2); hold all
    end
end
xlabel('Current (pA)','fontsize',14); ylabel('Instantaneous Firing Frequency (Hz)','fontsize',14); set(gca,'FontSize',14,'LineWidth',2); set(gcf,'Color','w');
title('Instantaneous F-I Plot','fontsize',16)
