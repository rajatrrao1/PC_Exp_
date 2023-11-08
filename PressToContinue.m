% Wait for a response
response     = 0;
responsetime = NaN;

if E.useDev.useBitsi
    fprintf('Press a response key to continue...')
    while 1
        if ~isempty(resp)
            if resp == (E.keys.aKey) || resp == (E.keys.sKey) || resp == (E.keys.dKey)
                response = resp; % Assign the response
                responsetime = rt; % Assign the response time
                break; % Exit the loop since a response was detected
            end
        end

        % Check if the maximum listen time has been exceeded
        if (GetSecs - starttime) > ListenTime
            break; % Exit the loop if no response has been detected within the ListenTime
        end
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