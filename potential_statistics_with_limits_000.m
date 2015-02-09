%function inputs slow potential traces with a predetermined sample on and
%sample off
function [amplitude,time2max,integrateup,integratedown]= potential_statistics_with_limits(data,Fs, onset, offset)
[~,C]=size(data);
amplitude=zeros(C,1); time2max=zeros(C,1); integrateup=zeros(C,1); integratedown=zeros(C,1);

%user defined variables for search region
maxsearchindex=round(offset(1)*Fs);  %defines maximum region in which to search, by sample number;
minsearchindex=round(onset(1)*Fs);
maxindexwindow=0;


    for i=1:C
    %finds maximum amplitude and time it occurs 
    [amp,maxindex]=max(-(data(minsearchindex:maxsearchindex,i)));
    maxindexwindow=maxindex+minsearchindex;  %sample number of max
    amplitude(i)=amp;
    time2max(i)=maxindexwindow./Fs;

        if onset~=0 && offset~=0
            %defines integral to peak and predefined offset
            integrateup(i)=trapz(data(minsearchindex:maxsearchindex,i)); %finds integral from onset to peak amplitude,
            integratedown(i)=trapz(data(maxindexwindow:maxsearchindex,i));
  
        end
    end

end
