%function reads voltage ramps and creates IV plot, calculates hysteresis if
%present
function vramp(filename)

file=readabf(filename);

time=file.data.time;
Im= file.data.v_clamp;
Vm=file.waveform.yPoints-80;

