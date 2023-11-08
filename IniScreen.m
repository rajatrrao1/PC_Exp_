%% Screen
% Initialize Psychtoolbox screen
Screen('Preference', 'SkipSyncTests', 1);
E.screen.screenN     = max(Screen('Screens'));  % screen where the experiment is shown
%screenN     = 1;
%E.screen.res         = [1920 1080];
E.screen.res         = [1024 768];
E.screen.window      = 1*E.screen.res;              % Size of the window were the experiment is shown
E.screen.rec         = [E.screen.res - E.screen.window E.screen.res];   % Position of the window where the experiment is shown
E.screen.clrdepth    = 32;                 % Color depth
E.screen.textsize    = 20;                 % Text size for the instructions
E.screen.white       = WhiteIndex(E.screen.screenN);
E.screen.black       = BlackIndex(E.screen.screenN);


%Prompt and fixation cross screen
% PsychDefaultSetup(2);
% E.screen.window = Screen('OpenWindow', E.screen.screenNumber, [128 128 128]);
% [E.screen.screenWidth, E.screen.screenHeight] = Screen('WindowSize', E.screen.window);
% E.screen.screenCenterX = E.screen.screenWidth / 2;
% E.screen.screenCenterY = E.screen.screenHeight / 2;
