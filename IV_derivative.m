function [slope]=IV_derivative(Vm,Im,Fs)
cutoff1=50; 
Wn1=cutoff1./Fs;
[b1,a1]=butter(3,Wn1);
fIm = filtfilt(b1,a1,Im);

figure; subplot(2,1,1); plot(Vm,fIm); xlabel('Vm'); ylabel('Im'); title('Filtered'); 
size(Vm)
slope=diff(fIm')./diff(Vm);


%figure; plot(Vm,slope);
end