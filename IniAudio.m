%% Audio
% Initialize PsychPortAudio
InitializePsychSound(1);
E.audio.version      = PsychPortAudio('Version');
E.audio.oldlevel     = PsychPortAudio('Verbosity',0);
E.audio.count        = PsychPortAudio('GetOpenDeviceCount');
E.audio.devices      = PsychPortAudio('GetDevices');

E.audio.pahandle     = PsychPortAudio('Open', [], 1, 0, E.audio.sr, 1, [], []);
