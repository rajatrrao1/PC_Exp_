%%
% Set parameters
E.stim.noise_level = 0.5;
E.stim.dur         = 0.050;
E.stim.gap         = 0.35;
E.audio.sr         = 48000;

base_tone         = 150;
E.stim.tone_freqs = base_tone * 2.^(0:2:6);
E.stim.tones      = nan(5,round(E.stim.dur * E.audio.sr));

for tone = 1:length(E.stim.tone_freqs)
    E.stim.tones(tone,:) = PureTone(E.stim.tone_freqs(tone), E.stim.dur, E.audio.sr, 1, 0.005);
end

E.stim.tones(5,:) = zeros(size(E.stim.tones(1,:)));
silence           = zeros(1, round(E.stim.gap*E.audio.sr));


