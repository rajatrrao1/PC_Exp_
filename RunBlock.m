function [ E ] = RunBlock( E )
%% Screen Setup

% DrawFormattedText(E.window, 'Press any key to start', 'center', 'center', E.white);
% Screen('Flip', E.window);
% KbWait();

E.task = 'Main';


%% Main loop for each tone
% Play noise ramp
MakeRamp
PsychPortAudio('FillBuffer', E.audio.pahandle, ramp, 0); % The buffer is first filled with an initial ramp of noise of 5 seconds total
PsychPortAudio('Start', E.audio.pahandle, 0, [], 1);

% Wait almost to the end of the ramp
WaitSecs(4.5);

%% Individual tones loop
for trial = 1:length(E.lists.mainTask(E.BlockCounter,:))
    
    %                 % Draw and present fixation cross
    %                 Screen('DrawLines', E.window, E.crossCoords, 2, E.white, [E.screenCenterX, E.screenCenterY]);
    %                 Screen('Flip', E.window);
    ISI  =  1.75 + rand*2.5;
    
    whichPair = E.lists.mainTask(E.BlockCounter,trial);
    % In the first 10 trials, use tone pairs in which the target is 10db
    % above the level defined by the staircase
    if trial <=10
        pair      = E.stim.tone_pairs_practice(whichPair,:);
    else
        pair      = E.stim.tone_pairs(whichPair,:);
    end
    
    PlayStim(pair, E.audio.sr, ISI, E.audio.pahandle);
    
    %Collect response
    listenTime = length(pair)/E.audio.sr + ISI; % This determines how long to wait before moving to the next trial
    [resp, respTime] = GetResponse(E, listenTime);
    
    E.resp.mainTask.resp(E.BlockCounter,trial)     = resp;
    E.resp.mainTask.respTime(E.BlockCounter,trial) = respTime;
    
end

PsychPortAudio('Stop', E.audio.pahandle);

% Wait until a response key is pressed
PressToContinue