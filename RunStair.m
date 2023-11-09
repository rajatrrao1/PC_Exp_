function [E] = RunStair(E)
%% Screen Setup
% DrawFormattedText(E.window, 'Press any key to start', 'center', 'center', E.white);
% Screen('Flip', E.window);
% KbWait();

E.task = 'Stair';

nTones                   = 4;                % For how many tones do staircasing
E.staircase.maxTrials    = 80; % Maximum amount of trials allowed for staircasing
E.staircase.maxReversals = 30; % 15 % The staircasing procedure stops when this number of reversals is reached (even before maxTrials is reached)

E.staircase.stepUpSize   = 0.05;                             % Step size for ascending the stimulus level
E.staircase.stepDownSize = -0.4142 * E.staircase.stepUpSize; % Step size for descending the stimulus level

% Containers for reversal recording
E.staircase.reversals      = zeros(1,nTones);           % Counter of reversals
E.staircase.reversalLevels = nan(nTones, E.staircase.maxReversals); % Container for stimuluslevel values at the time of reversals

% Container for all stimulus levels. Used for code dev. Can be removed
% later
E.staircase.stimulusLevels = nan(nTones, E.staircase.maxTrials);

% Containers for staircase responses
E.resp.staircase.resp     = nan(nTones, E.staircase.maxTrials);
E.resp.staircase.respTime = nan(nTones, E.staircase.maxTrials);

%% Main loop for each tone
E.staircase.toneOrder = randperm(nTones); % Randomize tone order
E.staircase.toneOrder = 1:4;

for whichTone = E.staircase.toneOrder
    
    % Reset staircase starting parameters
    stimulusLevel  = 0.4;                    % Stimulus level used to run the staircase procedure
    amplitude      = stimulusLevel;          % Actual amplitude of the sound, which is equal to stimuluslevel unless stimulusLevel becomes smaller than zero or higher than 1
    
    % Play noise ramp
    MakeRamp
    PsychPortAudio('FillBuffer', E.audio.pahandle, ramp, 0); % The buffer is first filled with an initial ramp of noise of 5 seconds total
    PsychPortAudio('Start', E.audio.pahandle, 0, [], 1);
    
    % Wait almost to the end of the ramp
    WaitSecs(4.5);
    
    %% Individual tones loop
    for trial = 1:E.staircase.maxTrials
        
        %                 % Draw and present fixation cross
        %                 Screen('DrawLines', E.window, E.crossCoords, 2, E.white, [E.screenCenterX, E.screenCenterY]);
        %                 Screen('Flip', E.window);
        
        %Play tone
        tone = E.stim.tones(whichTone,:) * amplitude; % Scale the tone
        E.ISI  =  1.75 + rand*2.5;
        PlayStim(tone, E.audio.sr, E.ISI, E.audio.pahandle);
        
        %Collect response
        listenTime = length(tone)/E.audio.sr + E.ISI; % This determines how long to wait before moving to the next trial
        [resp, respTime] = GetResponse(E, listenTime);
        
        % Responses 1 and 2 count as detection. Response 3 or no response
        % count as miss
        if resp == 1 || resp == 2, resp = 1; elseif resp == 0 || resp == 3, resp = 0; end
        
        E.resp.staircase.resp(whichTone,trial)     = resp;
        E.resp.staircase.respTime(whichTone,trial) = respTime;
        % Save all stimulus levels for code checking. Can be removed later
        E.staircase.stimulusLevels(whichTone, trial) = stimulusLevel;
        
        % Check if reversal and save stimulusLevel
        if trial > 1 && resp ~= E.resp.staircase.resp(whichTone,trial-1)
            E.staircase.reversals(whichTone) = E.staircase.reversals(whichTone) +1; % Counter of reversals
            E.staircase.reversalLevels(whichTone, E.staircase.reversals(whichTone)) = stimulusLevel;
        end
        
        
        % Adjust the stimulus level based on the staircase direction
        if resp == 1
            stimulusLevel = stimulusLevel + E.staircase.stepDownSize;
        else
            stimulusLevel = stimulusLevel + E.staircase.stepUpSize;
        end
        
        % Cap amplitude between 0 and 0.5
        amplitude = max(0, min(0.5, stimulusLevel));
        
        % Stop if the max number of reversals is reached
        if E.staircase.reversals(whichTone) >= E.staircase.maxReversals
            break;
        end
        
    end
    
    PsychPortAudio('Stop', E.audio.pahandle);
    
    % Wait until a response key is pressed
    PressToContinue
end

%PsychPortAudio('Stop', 0);
%ListenChar(0)