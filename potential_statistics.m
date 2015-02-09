%Function inputs filtered and averaged slow potential,time, and time of
%stimulus, and outputs statistics on that potential
function [onset, amplitude,time2max,offset,integrateup,integratedown]= potential_statistics(time,data,Fs, sampletimeon)
onset=0; amplitude=0; time2max=0; offset=0; integrateup=0; integratedown=0;

%user defined variables
maxsearchindex=1.7*Fs;  %defines maximum region in which to search, by sample number (default 1.5);
maxampsearch=.4*Fs;  %defaul 0.4
minsearchindex=.005*Fs; % minsearch index is in reference to stimulus (default .001)
offsetfraction=1./3;  %percentage of decay to integrate until and return as offset time

%finds maximum amplitude and time it occurs after stimulus
[amp,maxindex]=max(-(data((sampletimeon+minsearchindex):(sampletimeon+maxampsearch))));
maxsample=maxindex+sampletimeon+minsearchindex;  %sample number of max

%finds first derivative from stimulus until peak amplitude, finds last time
%first derivative is >0
[Vprime]=derivative(data(sampletimeon:(maxsample-minsearchindex)),1./Fs);
%figure; subplot(2,1,1); plot(Vprime); subplot(2,1,2); plot(V2prime);

%finds last time slope was greater than zero
zeroindex=find(Vprime>0,1,'last');
onsetindex=find(data((zeroindex+sampletimeon):maxsample)<0,1,'first');
onsetbackupindex=find(data(sampletimeon:maxsample)>0,1,'last');  %as a backup, defines onset as the last time before max that the signal was positive
%defines onset and integral to peak only if it exists
if (isempty(onsetindex)==0)
    onsetsample=zeroindex+onsetindex+sampletimeon;
    %onsetsample=onsetindex+sampletimeon+onsetprimeindex;  %sample number of onset
    onset=time(onsetsample);
    integrateup=trapz(data(onsetsample:maxsample))-trapz(data(1:(maxsample-onsetsample))); %finds integral from onset to peak amplitude,
    diff1=trapz(data(1:(maxsample-onsetsample)));
    time2max=time(round(maxsample));
    amplitude=amp+data(onsetsample);
else
    onset=time(sampletimeon+onsetbackupindex); integrateup=trapz(data(sampletimeon:maxsample))-trapz(data(1:(maxsample-sampletimeon))); time2max=time(round(maxsample)); amplitude=amp+data(sampletimeon+onsetbackupindex); onsetsample=[];
end

% finds integral from peak amplitude to offsetfraction
offsetindex=find(data(maxsample:maxsearchindex)<(-offsetfraction.*amp),1,'last');

if isempty(offsetindex)==0 
    offsetsample=maxsample+offsetindex;
    offset=time(round(offsetsample));
    integratedown=trapz(data(maxsample:offsetsample))-trapz(data(1:(offsetsample-maxsample)));
    diff2=trapz(data(1:(offsetsample-maxsample)))
else
    offset=time(maxsearchindex);
    integratedown=trapz(data(maxsample:maxsearchindex))-trapz(data(1:(maxsearchindex-maxsample)));
end


end


