%function inputs time and data arrays, outputs arrays filtered at the
%specified frequency
function fdata=lowpass_filter(time, data, cutoff)
 
Fs=1/time(2);   %sampling frequency
Wn1=cutoff./Fs;
[b1,a1]=butter(3,Wn1);
[R,C]=size(data);

fdata = filtfilt(b1,a1,data);

end
