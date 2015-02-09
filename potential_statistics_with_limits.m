%function inputs slow potential traces with a predetermined sample on and
%sample off
function [amplitude,time2max,integrateup,integratedown]= potential_statistics_with_limits(data,Fs, onset, offset,peaktime)
[~,C]=size(data);
amplitude=zeros(C,1); time2max=zeros(C,1); integrateup=zeros(C,1); integratedown=zeros(C,1);

%user defined variables for search region
maxsearchindex=round(offset(1)*Fs);  %defines maximum region in which to search, by sample number;
minsearchindex=round(onset(1)*Fs);
maxsample=0;
peaksearchwindow=(maxsearchindex-minsearchindex)/10;
peakindex=round(peaktime(1)*Fs);

    for i=1:C
    %finds maximum amplitude and time it occurs 
    [amp,maxindex]=max(-(data(minsearchindex:peakindex+peaksearchwindow,i)));
    maxsample=maxindex+minsearchindex;  %sample number of max
   if isempty(amp)<1
        amplitude(i)=amp+data(minsearchindex);
        time2max(i)=maxsample./Fs;
   end

        if onset~=0 && offset~=0
            %defines integral to peak and predefined offset
            integrateup(i)=trapz(data(minsearchindex:maxsample,i))-trapz(data(1:(maxsample-minsearchindex))); %finds integral from onset to peak amplitude and subtracts baselineintegral
            integratedown(i)=trapz(data(maxsample:maxsearchindex,i))-trapz(data(1:(maxsearchindex-maxsample)));  %same for offset integral
  
        end
    end

end
