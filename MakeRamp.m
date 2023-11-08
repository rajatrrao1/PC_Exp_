initial_noise_dur     = 5; % duration of starting noise in seconds
ini_noise_ramp_dur    = 2; % duration of ramp up in seconds

ramp_up = linspace(0, 1, ini_noise_ramp_dur * E.audio.sr);
ramp    = rand(1, round(initial_noise_dur * E.audio.sr)) - 0.5;
ramp(1:length(ramp_up)) = ramp(1:length(ramp_up)).*ramp_up;
