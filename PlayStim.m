function PlayStim(tone, sr, ISI, pahandle)

noise_level = 1; % Parameter for code testing. In the experiment it should be set to 1.
% create noise buffer
noise_stim = rand(size(tone)) - 0.5;
noise_stim = tone + noise_stim*noise_level;
noise      = (rand(1, round(ISI*sr)) - 0.5)*noise_level;

% Play a selected tone of pure tones with a randomised noise buffer.
[underflow] = PsychPortAudio('FillBuffer', pahandle, [noise_stim, noise],1);

%display(['Underflow?: ',num2str(underflow)])

end