% Set up Psychtoolbox audio
InitializePsychSound;
freq = 44100; % sampling rate
nrchannels = 1; % mono sound
bufferDuration = 3; % buffer duration in seconds
device = [];
reqlatencyclass = 2; % low latency
suggestedLatency = [];

% Create white noise buffer
bufferSamples = round(freq * bufferDuration);
noise = rand(bufferSamples, nrchannels);

% Create Psychtoolbox audio buffer
audioBuffer = PsychPortAudio('Open', device, [], reqlatencyclass, freq, nrchannels, suggestedLatency);

% Fill the buffer with white noise
PsychPortAudio('FillBuffer', audioBuffer, noise');

% start the buffer
PsychPortAudio('Start', audioBuffer, [], 0, 1);

%  sinusoidal tone
toneDuration = 0.5; % tone duration in seconds
toneFreq = 500; % tone frequency in Hz
toneSamples = round(freq * toneDuration);
time = (0:toneSamples-1) / freq;
toneWaveform = sin(2*pi*toneFreq*time)';
toneWaveform = toneWaveform + (rand(size(toneWaveform))*2-1);
toneWaveform = toneWaveform./max(abs(toneWaveform));

% tone on top of buffer
PsychPortAudio('FillBuffer', audioBuffer, toneWaveform');
PsychPortAudio('Start', audioBuffer, [], 0, 1);

% Fill the buffer with white noise
PsychPortAudio('FillBuffer', audioBuffer, noise');

% start the buffer
PsychPortAudio('Start', audioBuffer, [], 0, 1);

%WaitSecs(toneDuration);


PsychPortAudio('Stop', audioBuffer, 1);
PsychPortAudio('Close', audioBuffer);
