%function inputs filtered and adjusted data, averages 2 and 3 sweeps
function [averaged_data]=average_data(data,num)
[~,C]=size(data);

for i=1:C./num
    counter=num.*(i-1)+1;
    averaged_data(:,i)=mean(data(:,counter:counter+num-1),2);
end

end