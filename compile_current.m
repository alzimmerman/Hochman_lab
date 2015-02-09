function [cell,meanparams]=compile_current(files,injection)
% Function inputs set of similar files, outputs individual and population
% dependent spike parameters

[structure]=comparecurr(files,injection);
cell=struct2cell(structure);
[R,C,D]=size(cell);
meanparams=zeros(D,5);

%Takes parameter values from first spiking current
for k=1:D
    if (isempty(structure(k).Vth)~=1)
    meanparams(k,1)=structure(k).Vth(1);
    meanparams(k,2)=structure(k).amp(1);
    meanparams(k,3)=structure(k).dur(1);
    meanparams(k,4)=structure(k).AHPmag(1);
    
    j=find(isnan(structure(k).AHPdur)~=1,1); 
    meanparams(k,5)=structure(k).AHPdur(j);
       
    end
end
%     for i=2:6
%         temp=cell{i,:,k};
%         meanparams(k,(i-1))=nanmean(temp);
%     end
