%function inputs data file with a 2 length array of time of baseline starting and stopping
function [adjusted_and_averaged]=baseline_adjust_and_average(data,times)
[R,C]=size(data);
baselinemean=mean(data(times(1):times(2),:);
for i=1:C
    adjusted(:,i)=data-baselinemean(i);
end
adjusted_and_averaged=mean(adjusted,2)
end