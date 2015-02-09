 y = [1, 2; 2,4; 3,6]; %means
    stdevs = 0.25*ones(3,2); %stds
        figure
        bar(y)
        xtick = [1,2,3]; x=[(xtick-0.15); (xtick+0.15)]';
        hold on
        errorbar(x(:,1),y(:,1), stdevs(:,1), '.k')
        hold on
        errorbar(x(:,2),y(:,2), stdevs(:,2), '.k')
        ylabel('DRP Area', 'FontSize', 14)
       % xticklabel = {sprintf('Low F (0-%d)',cut(1)), sprintf('Med F (%d-%d)', cut(1), cut(2)), sprintf('High F (%d-%d)', cut(2), cut(3))};
       % xticklabel_rotate(xtick, 45, xticklabel, 'FontSize', 14);
        title(gca, 'DRP Area across Force Conditions')
        set(gca, 'FontSize', 14)
        legend(gca, 'Right Contact', 'Left Contact')
        hold off 
