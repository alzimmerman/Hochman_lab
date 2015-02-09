%function inputs data file with a 2 length array of time of baseline
%starting and stopping, adjusts for baseline offset and adds averages all sweeps
function [adjusted_and_averaged,baselinemean]=baseline_adjust_and_average(data,times)
[R,C]=size(data);
baselinemean=mean(data(times(1):times(2),:))';
adjusted=zeros(R,1); 
for i=1:C
    adjusted(:,i)=data(:,i)-baselinemean(i);
end
adjusted_and_averaged=[adjusted,mean(adjusted,2)];
end