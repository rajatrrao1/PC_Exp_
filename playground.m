function [E] = RunStair(E, pahandle)

%% Screen Setup

% DrawFormattedText(E.window, 'Press any key to start', 'center', 'center', E.white);
% Screen('Flip', E.window);
% KbWait();

%% Noise + Ramp
noise_duration = 5; % duration of noise in seconds
noise_ramp_duration = 2; % duration of ramp up in seconds
E.noise = rand(1, noise_duration*E.sr) - 0.5;


% Create a ramp up for the noise
ramp_up = linspace(0, 1, noise_ramp_duration*E.sr);
%ramp_up = 1;
E.noise(1:length(ramp_up)) = E.noise(1:length(ramp_up)).*ramp_up;

% Scale the noise amplitude
E.noise = E.noise_level * E.noise;


%%
% Main loop for each tone
for whichtone = 1:E.numTones

    % Reset direction for each tone
    E.stimuluslevel = 0.3;
    E.amplitude = E.stimuluslevel;
    E.amplitude = max(0, min(0.5, E.amplitude));
    E.reversals = 0;
    E.reversalLevels = zeros(1, E.maxReversals);
    E.reversalIndex = 1:E.maxReversals;
    E.maxReversals = 15;


    % Individual tones loop
    PsychPortAudio('FillBuffer', pahandle, E.noise, 0);
    PsychPortAudio('Start', pahandle, 0);

    WaitSecs(4.9);

    delay2 = 0;

    for trial = 1:E.maxTrials
        tic
       
        %Update reversal levels
        E.reversalLevels(E.reversalIndex) = E.stimuluslevel;
        disp(['E.stimuluslevel = ', num2str(E.stimuluslevel)]);
        disp(['E.amplitude = ', num2str(E.amplitude)]);
                          % Draw and present fixation cross
        %                 Screen('DrawLines', E.window, E.crossCoords, 2, E.white, [E.screenCenterX, E.screenCenterY]);
        %                 Screen('Flip', E.window);
        
        % Scale the tone
        tone = E.Tones{whichtone}*E.amplitude;
        %Play tone
        E.ISI =  2.5 + rand*1.5;
        disp(['The ISI IS = ', num2str(E.ISI)]);
        PlayStair(tone, 0, E.sr, E.ISI, pahandle);
        % Display a message after playing the tone
        disp('Tone played.');
        delay1 = toc;
        %Collect response
        
        totaldelay = delay1 + delay2
        E = GetStairResponse(E, trial,totaldelay);
        
        tic
        if E.reversals >= E.maxReversals
            break;
        end

        % Update the staircase direction based on the response
        if trial > 1 && E.correctResponses(trial) ~= E.correctResponses(trial-1)
            E.reversals = E.reversals + 1;
            E.reversalIndex = E.reversalIndex + 1;
        end
        % Adjust the sti mulus level based on the staircase direction

        if E.direction == -1
            E.stimuluslevel = E.stimuluslevel + (E.stepDownSize * E.direction);
        else
            E.stimuluslevel = E.stimuluslevel + (E.stepUpSize * E.direction);
        end

        %Update reversal levels

        E.amplitude = E.stimuluslevel;
        E.amplitude = max(0, min(0.5, E.amplitude));

        disp(['E.amplitude = ', num2str(E.amplitude)]);
        delay2 = toc;
    end
    PsychPortAudio('Stop', pahandle);

    E.reversalLevelsInRange = E.reversalLevels(4:15);
    E.threshold = mean(E.reversalLevelsInRange);
    E.threshold
    disp(['E.threshold = ', num2str(E.threshold)]);
    %         % Staircasing procedure complete
    %         DrawFormattedText(E.window, 'Staircasing procedure is now completed for this tone', 'center', 'center', E.white);
    %         Screen('Flip', E.window);
    KbWait();

    % Set the tone intensity to the threshold value
    E.stimuluslevelfinal(whichtone) = E.threshold;
    E.Tones{whichtone} = E.Tones{whichtone} * E.stimuluslevelfinal(whichtone);

end

% Display the stimLevels for each tone
disp('Stimulus Levels:');
for whichtone = 1:E.numTones
    disp(['Tone ', num2str(whichtone), ': ', num2str(E.stimuluslevelfinal(whichtone))]);
end

PsychPortAudio('Close', 0);

% Close the screen
Screen('CloseAll');

%Unsupress key press

ListenChar(0)