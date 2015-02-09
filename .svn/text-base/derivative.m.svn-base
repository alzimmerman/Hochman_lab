%function takes first, second, and third temporal derivative using central difference
%techniques accurate to O(dt^4) and smoothing the endpoints

function [Vprime,V2prime,V3prime]=derivative(Vm,dt)

for i=4:(length(Vm)-3)
    Vprime(i)= (Vm(i-2)-8*Vm(i-1)+8*Vm(i+1)-Vm(i+2))./(12*dt);
    V2prime(i)= (-Vm(i-2)+16*Vm(i-1)-30*Vm(i)+16*Vm(i+1)-Vm(i+2))./(12*dt^2);
    V3prime(i)=(Vm(i-3)-8*Vm(i-2)+13*Vm(i-1)-13*Vm(i+1)+8*Vm(i+2)-Vm(i+3))./(8*dt^3);
end

for i=1:3
    Vprime(i)=Vprime(4);
    V2prime(i)=V2prime(4);
    V3prime(i)=V3prime(4);
end

for i=(length(Vm)-2):length(Vm)
    Vprime(i)=Vprime(i-1);
    V2prime(i)=V2prime(i-1);
    V3prime(i)=V3prime(i-1);
end

end
    
        