%% Response input
E.useDev.useBitsi = 1;
if E.useDev.useBitsi
    % button details
    %         % Right hand
    %         cfg.button1 = 97;  % Blue
    %         cfg.button2 = 98;  % Yellow
    %         cfg.button3 = 99;  % Green
    %         cfg.button4 = 100; % Red
    %
    %         % Left hand
    %         cfg.button5 = 101;  % Blue
    %         cfg.button6 = 102;  % Yellow
    %         cfg.button7 = 103;  % Green
    %         cfg.button8 = 104; % Red
    
    % COM1 is connected to MEG, button-box
    E.bitsi=Bitsi('com1'); % 'com1' is for windows system, you can check /dev to find out all devices connected
    
    % use right buttonbox
    E.keys.aKey = 97; % index finger
    E.keys.sKey = 98; % middle finger
    E.keys.dKey = 99; % ring finger
    ListenChar(2);
    
else
    E.bitsi = Bitsi(''); % testing mode, use keyboard
    KbName('UnifyKeyNames');
    
    E.keys.aKey      = KbName('j');
    E.keys.sKey      = KbName('k');
    E.keys.dKey      = KbName('l');
    E.keys.escKey    = KbName('escape');
    E.keys.returnKey = KbName('return');
   
    
    KbCheckList = [E.keys.escKey, E.keys.aKey, E.keys.sKey, E.keys.dKey, E.keys.returnKey];
    
    RestrictKeysForKbCheck(KbCheckList);
    
    % Suppress key presses in GUI
    ListenChar(2);
end