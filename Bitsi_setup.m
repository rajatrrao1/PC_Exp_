switch mode
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

    case 'MEG'
        % COM1 is connected to MEG, button-box
        bitsi=Bitsi('com1'); % 'com1' is for windows system, you can check /dev to find out all devices connected

        % use right buttonbox
        Tone_A=97; % index finger
        Tone_B=98; % middle finger
        No_Tone=99; % ring finger


    case 'Laptop'

        bitsi=Bitsi(''); % testing mode, use keyboard

        Tone_A = KbName('a'); % Set the correct key code for Tone A
        Tone_B = KbName('s'); % Set the correct key code for Tone B
        No_Tone = KbName('d'); % Set the correct key code for No Tone


    otherwise
        error('Cannot set up Bitsi-boxes');

end