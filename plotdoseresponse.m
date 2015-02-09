%function computes and plots sigmoid fit for DRP and VRP vectorsof amplitudes and corresponding dosages
function [IC50]=plotdoseresponse(dose,data)
[~,num]=size(data)

[IC50stats]=ec50(dose, data);
ic50=IC50stats(:,3); minresponse=IC50stats(:,1); maxresponse=IC50stats(:,2); slope=IC50stats(:,4); IC50=IC50stats;
x=0:1e-9:5e-5; 

for i=1:num
    y(:,i)=((maxresponse(i)-minresponse(i))./(1+((x./ic50(i)).^slope(i))))+minresponse(i);
    figure(i*200); plot(log10(x),1-y(:,i)); hold all
 end

%figure(100);  xlabel('Log Dose (M)'); ylabel('Amplitude Depression (% of control)'); title('DRP Amplitude');
%figure(200);  xlabel('Log Dose (M)'); ylabel('Amplitude Depression (% of control)'); title('VRP Amplitude');  

% for i=1:C
%     normalizedamp(:,i)=data(:,i)./data(1,i);
% end
% 
% meanamp=nanmean(normalizedamp,2);
% stdamp=nanstd(normalizedamp,1,2);
% figure; errorbar(log10(dose),(1-meanamp),stdamp,'*');
end