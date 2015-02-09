%run dose response, inputs cell with cell{i,1} a dose array and cell{i,2} a
%string array of file names
%IC50stats in the form [min max IC50 slope(Hill coef)]
function [dosestats,IC50stats,normalDRPamp,normalVRPamp,doselong,baselinestats,normalbaselines]=doseresponse(inputcell)
[numruns,~]=size(inputcell);
dosestats=cell(numruns,2);    %defines cell size as the number of runs, with columns for DRP and VRP
legendname=[]; doselong=[]; normalDRPamp=[]; normalVRPamp=[]; normalbaseDRP=[]; normalbaseVRP=[];
x=0:1e-9:5e-5; IC50stats=[];

for i=1:numruns
    files=inputcell{i,2};
    dose=inputcell{i,1};
    [DRPstats,baselinevalues]=comparemeanDRP(files,i);
    
    baselinestats{i,1}=baselinevalues;
    dosestats{i,1}=DRPstats{1,1};
    dosestats{i,2}=DRPstats{2,1};
    legendname=[legendname; num2str(i)];
    doselong=[doselong dose];
    %j=find(dose>4e-6,1); 
    
    %normalizes DRP and VRP amplitude based on initial file for each run
    normalDRPamp=[normalDRPamp; DRPstats{1,1}(:,2)./DRPstats{1,1}(1,2)];
    normalVRPamp=[normalVRPamp; DRPstats{2,1}(:,2)./DRPstats{2,1}(1,2)];
    normalbaseDRP=[normalbaseDRP;(baselinevalues(:,1)-baselinevalues(1,1))./DRPstats{1,1}(1,2)];
    normalbaseVRP=[normalbaseVRP;(baselinevalues(:,2)-baselinevalues(1,2))./DRPstats{2,1}(1,2)];   
%     
figure(100); plot(log10(dose),(1-DRPstats{1,1}(:,2)./DRPstats{1,1}(1,2)),'.'); hold all
figure(200); plot(log10(dose),(1-DRPstats{2,1}(:,2)./DRPstats{2,1}(1,2)),'.'); hold all
%figure(300); plot(log10(dose),(baselinevalues(:,1)-baselinevalues(1,1))./DRPstats{1,1}(1,2),'.'); hold all
%figure(400); plot(log10(dose),(baselinevalues(:,2)-baselinevalues(1,2))./DRPstats{2,1}(1,2),'.'); hold all

% if i>3
%     fraction=0.1;
% else
%     fraction=1;
% end
%     normalbaseDRP=[normalbaseDRP;(baselinevalues(:,1)-baselinevalues(1,1))./fraction];
%     normalbaseVRP=[normalbaseVRP;(baselinevalues(:,2)-baselinevalues(1,2))./fraction];   
%     figure(300); plot(log10(dose),(baselinevalues(:,1)-baselinevalues(1,1))/fraction,'.'); hold all
%     figure(400); plot(log10(dose),(baselinevalues(:,2)-baselinevalues(1,2))/fraction,'.'); hold all

% figure(500); plot(-(baselinevalues(:,2)-baselinevalues(1,2))./DRPstats{2,1}(1,2),(1-DRPstats{2,1}(:,2)./DRPstats{2,1}(1,2)),'.'); hold all
% figure(600); plot(log10(dose),-(1-DRPstats{2,1}(:,2)./DRPstats{2,1}(1,2))./((baselinevalues(:,2)-baselinevalues(1,2))./DRPstats{2,1}(1,2)),'.'); hold all
% figure(600); plot(log10(dose),(1-DRPstats{2,1}(:,2)./DRPstats{2,1}(1,2))./((baselinevalues(:,2)-baselinevalues(1,2))./fraction),'.'); hold all

% -----------------------plots dose response for summed integrals---------
% figure(700); plot(log10(dose),(1-(DRPstats{1,1}(:,5)+DRPstats{1,1}(:,6))./(DRPstats{1,1}(1,5)+DRPstats{1,1}(1,6))),'.'); hold all;
% figure(800); plot(log10(dose),(1-(DRPstats{2,1}(:,5)+DRPstats{2,1}(:,6))./(DRPstats{2,1}(1,5)+DRPstats{2,1}(1,6))),'.'); hold all;

end
 normalbaselines=[normalbaseDRP, normalbaseVRP]; IC50stats=[];
% [IC50stats]=ec50(doselong', [normalDRPamp, normalVRPamp]) % normalbaselines]);
% ic50=IC50stats(:,3); minresponse=IC50stats(:,1); maxresponse=IC50stats(:,2); slope=IC50stats(:,4);
% 
% for i=1:length(ic50)
%     y(:,i)=((maxresponse(i)-minresponse(i))./(1+((x./ic50(i)).^slope(i))))+minresponse(i);
% end
% P_drp=polyfit(log10(doselong)',normalbaseDRP ,1)
% P_vrp=polyfit(log10(doselong)',normalbaseVRP,1)
% y(:,3)=polyval(P_drp,log10(x));
% y(:,4)=polyval(P_vrp,log10(x));
    

figure(100);  xlabel('Log Dose (M)'); ylabel('Amplitude Depression (% of control)'); title('Evoked DRP Amplitude');legend(legendname); % plot(log10(x),1-y(:,1));
figure(200); xlabel('Log Dose (M)'); ylabel('Amplitude Depression (% of control)'); title('Evoked VRP Amplitude');  legend(legendname); % plot(log10(x),1-y(:,2));
% figure(300); xlabel('Log Dose (M)'); ylabel('Normalized Baseline DRP'); title('Normalized Baseline DRP');legend(legendname); plot(log10(x),-y(:,3));
% figure(400); xlabel('Log Dose (M)'); ylabel('Normalized Baseline VRP '); title('Normalized Baseline VRP');legend(legendname); plot(log10(x),-y(:,4));
% figure(500); xlabel('Log Dose (M)'); ylabel('Normalized Baseline VRP'); title('Normalized Baseline VRP');legend(legendname); %plot(log10(x),-y(:,4));
%figure(500); xlabel('Normalized Baseline VRP'); ylabel('VRP Depression (% of control)');title('VRP amplitude versus changes in resting potential'); legend(legendname);
%figure(600); xlabel('Log Dose (M)'); ylabel('Evoked Response/change in baseline VRP'); title('Evoked VRP fraction'); legend(legendname);%plot(log10(x),-y(:,5));
% figure(500); xlabel('Log Dose (M)'); ylabel('Normalized Baseline DRP'); title('Normalized Baseline DRP 2');legend(legendname);
% figure(600); xlabel('Log Dose (M)'); ylabel('Normalized Baseline VRP'); title('Normalized Baseline VRP 2');legend(legendname);
% figure(700);  xlabel('Log Dose (M)'); ylabel('Integral Depression (% of control)'); title('DRP Integral');legend(legendname);  
% figure(800); xlabel('Log Dose (M)'); ylabel('Integral Depression (% of control)'); title('VRP Integral');  legend(legendname);  

%------------normalizes to 5uM response----------
% figure(500); plot(log10(dose),(baselinevalues(:,1)-baselinevalues(j,1))./(baselinevalues(1,1)-baselinevalues(j,1)),'.'); hold all
% figure(600); plot(log10(dose),(baselinevalues(:,2)-baselinevalues(j,2))./(baselinevalues(1,2)-baselinevalues(j,2)),'.'); hold all