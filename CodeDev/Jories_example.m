% some settings
sr = 48000;
nrchannels = 1;
stimlen = 1;

% create some tones and empty arrays
emptybuffer = zeros(1, 5*sr);

%  sinusoidal tone1
toneDuration = 0.4; % tone duration in seconds
toneFreq = 150; % tone frequency in Hz
toneSamples = round(sr * toneDuration);
time = (0:toneSamples-1) / sr;
tone150 = sin(2*pi*toneFreq*time)';
tone150 = tone150 + (rand(size(tone150))*2-1);
tone150 = tone150./max(abs(tone150));
tone150 = tone150';


% create noise for the tone
noise_duration = 5; % duration of noise in seconds
noise_ramp_duration = 2; % duration of ramp up in seconds
noise = rand(1, noise_duration*sr) - 0.5;

% create a ramp up for the noise
ramp_up = linspace(0, 1, noise_ramp_duration*sr);
noise(1:length(ramp_up)) = noise(1:length(ramp_up)).*ramp_up;

noise_between_pairs = rand(1, 0.3*sr) - 0.5;


%  sinusoidal tone2
toneDuration = 0.4; % tone duration in seconds
toneFreq = 600; % tone frequency in Hz
toneSamples = round(sr * toneDuration);
time = (0:toneSamples-1) / sr;
tone600 = sin(2*pi*toneFreq*time)';
tone600 = tone600 + (rand(size(tone600))*2-1);
tone600 = tone600./max(abs(tone600));
tone600 = tone600';

%  sinusoidal tone3
toneDuration = 0.4; % tone duration in seconds
toneFreq = 2400; % tone frequency in Hz
toneSamples = round(sr * toneDuration);
time = (0:toneSamples-1) / sr;
tone2400 = sin(2*pi*toneFreq*time)';
tone2400 = tone2400 + (rand(size(tone2400))*2-1);
tone2400 = tone2400./max(abs(tone2400));
tone2400 = tone2400';

%  sinusoidal tone4
toneDuration = 0.4; % tone duration in seconds
toneFreq = 9600; % tone frequency in Hz
toneSamples = round(sr * toneDuration);
time = (0:toneSamples-1) / sr;
tone9600 = sin(2*pi*toneFreq*time)';
tone9600 = tone9600 + (rand(size(tone9600))*2-1);
tone9600 = tone9600./max(abs(tone9600));
tone9600 = tone9600';

%  sinusoidal tone5
toneDuration = 0.4; % tone duration in seconds
toneFreq = 00; % tone frequency in Hz
toneSamples = round(sr * toneDuration);
time = (0:toneSamples-1) / sr;
tone00 = sin(2*pi*toneFreq*time)';
tone00 = tone00 + (rand(size(tone00))*2-1);
tone00 = tone00./max(abs(tone00));
tone00 = tone00';

tone_pairing = [tone600, noise_between_pairs, tone150;% Expected
                tone2400,noise_between_pairs,tone9600; % Expected
                tone600,noise_between_pairs,tone9600; % Unexpected
                tone2400,noise_between_pairs,tone150; % Unexpected
                tone600,noise_between_pairs,tone00; % Omission 
                tone2400,noise_between_pairs,tone00];% Omission

% open psychportaudio divice
InitializePsychSound;
Pahandle = PsychPortAudio('Open', [], 1, 0, sr, nrchannels, [], []);

% initialize a rolling buffer that is bigger then what we append
rollingbuffer = PsychPortAudio('CreateBuffer', [], emptybuffer);
PsychPortAudio('FillBuffer', Pahandle, rollingbuffer);

% start playback of initi alie loaded buffer
[eststatTime]  = PsychPortAudio('Start', Pahandle, 0);

% append  to rolling buffer as soon as there is space [tonestoplay, freespace]
PsychPortAudio('FillBuffer', Pahandle, noise, 1);
PsychPortAudio('FillBuffer', Pahandle, tone_pairing(1,:), 1);
PsychPortAudio('FillBuffer', Pahandle, tone_pairing(2,:), 1);



% stop after playback
pause(10)
PsychPortAudio('Stop', Pahandle);
PsychPortAudio('Close', Pahandle);