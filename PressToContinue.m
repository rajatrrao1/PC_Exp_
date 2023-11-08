% Wait for a response
response     = 0;
responsetime = NaN;

if E.useDev.useBitsi
    % TO DO
    [response, responsetime] = E.bitsi.getResponse(ListenTime, true); % Wait for response within the remaining time
    
    E.bitsi.clearResponses();
    
    if ~isempty(resp)
        % TO DO
    end
    
else
    fprintf('Press a response key to continue...')
    while 1
        [keyIsDown, ~, keyCode] = KbCheck;
        
        if keyIsDown && (keyCode(E.keys.aKey) || keyCode(E.keys.sKey) || keyCode(E.keys.dKey))
            break
        end
    end
end