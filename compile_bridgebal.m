% function inputs file and injection vectors and adjusts for changes based
% on Vth of comparison file
function [cell,meanparams]=compile_bridgebal(compare_file,injection1,files,injection)

starter_file=readabf(compare_file);
[VTH1,AMP1,DUR1,AHPMAG1,AHPDUR1,FREQ1,k1,CURRENT1,VM_SS1,TAU1]=currclamp(starter_file,injection1);
[R,C]=size(files);
cell = struct('name', {}, 'Vth', {}, 'amp', {}, 'dur', {},'AHPmag', {},'AHPdur', {}, 'freq', {}, 'current', {},'Rm', {},'Cm',{});
ind=find(VTH1);
mean_VTH=mean(VTH1(ind));   

for i=1:C
    name=files{i};
    cell(i).name=name;
    file=readabf(name);
    [Vth,amp,dur,AHPmag,AHPdur,freq,k,current,Vm_ss,tau]=currclamp(file,injection(i));
    ind2=find(Vth); 
    delta_Vm=mean_VTH-Vth(ind2);
    delta_Rp=delta_Vm./current(ind2);
    max_delta_Rp=min(delta_Rp);
    
    
    [VTH,AMP,DUR,AHPMAG,AHPDUR,FREQ,k,CURRENT,VM_SS,VM_BASE,TAU]=adjust_bridgebal(file,injection(i),max_delta_Rp);
         
    if (isempty(k)<1)
        cell(i).Vth=VTH(k);
        cell(i).amp=AMP(k);
        cell(i).dur=DUR(k);
        cell(i).AHPmag=AHPMAG(k);
        cell(i).AHPdur=AHPDUR(k);
        cell(i).freq=FREQ(k);
        cell(i).current=CURRENT(k);
        
        fit= polyfit(CURRENT(1:(k-1)),VM_SS(1:(k-1)),1);          
        cell(i).Rm=fit(1)*10^9;
        cell(i).Cm=mean(TAU(1:(k-1)))/cell(i).Rm;
    else
         fit= polyfit(CURRENT,VM_SS,1);
         cell(i).Rm=fit(1)*10^9;
         cell(i).Cm=mean(TAU)/cell(i).Rm;
    end
    cell(i).delta_Rp=delta_Rp;
    cell(i).Vm_ss=VM_SS;
    cell(i).Vm_base=VM_BASE;
end
   
cell_new=struct2cell(cell);
[R,C,D]=size(cell_new);
meanparams=zeros(D,5);

%Takes mean of non-NaN of active parameters
for l=1:D
    for i=2:6
        temp=cell_new{i,:,l};
        ind=find(temp);
        meanparams(l,(i-1))=nanmean(temp(ind));
    end
end


