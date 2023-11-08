function [Tone] = PureTone(f,d,sr,intensity_value, t_ramp)
t = 1/sr:1/sr:d;
Tone = intensity_value * sin(t*2*pi*f);

r = ones(1,length(Tone));
r(1:round(t_ramp*sr)) = linspace(0,1,round(t_ramp*sr));
r(end-round(t_ramp*sr)+1:end) = linspace(1,0,round(t_ramp*sr));
% r is a ramp which is a vector of the same length as S that is all ones except at the
% beginning and at the end for 5ms


Tone = Tone.*r;

 end

