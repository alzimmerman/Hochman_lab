[r,c]=size(measurements);
for i=1:r
index=find(measurements(i,:)~=0);
figure; bar(index,measurements(i,index),0.9); hold all;
set(gca,'LineWidth',2,'FontSize',12);
errorbar(index,measurements(i,index),stdevs(i,index),'.k');
xlabel(names(i));
end