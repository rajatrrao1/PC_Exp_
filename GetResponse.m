function [response, responsetime] = GetResponse(E, ListenTime)

% Wait for a response, or for the full duration of the ISI
response     = 0;
responsetime = NaN;

if E.useDev.useBitsi

    starttime = GetSecs;
    [resp, rt] = E.bitsi.getResponse(ListenTime, false); % Wait for response within the remaining time
    E.bitsi.clearResponses();

    if ~isempty(resp)
        if resp == (E.keys.aKey)
            response = 1;
            responsetime = (rt-starttime);
            if strcmp(E.task,'Stair'), fprintf('Detected\n'); else, fprintf('Tone A\n'); end
        elseif resp == (E.keys.sKey)
            response = 2;
            responsetime =  (rt-starttime);
            if strcmp(E.task,'Stair'), fprintf('Detected\n'); else, fprintf('Tone B\n'); end
        elseif resp == (E.keys.dKey)
            response = 3;
            responsetime =  (rt-starttime);
            if strcmp(E.task,'Stair'), fprintf('Undetected\n'); else, fprintf('No Tone\n'); end

        end
    end

else
    starttime = GetSecs; % Start timer

    while ((GetSecs-starttime) < ListenTime)
        [keyIsDown, ~, keyCode] = KbCheck;

        if keyIsDown && ~response
            if keyCode(E.keys.aKey)
                response = 1;
                if strcmp(E.task,'Stair'), fprintf('Detected\n'); else, fprintf('Tone A\n'); end
            elseif keyCode(E.keys.sKey)
                response = 2;
                if strcmp(E.task,'Stair'), fprintf('Detected\n'); else, fprintf('Tone B\n'); end
            elseif keyCode(E.keys.dKey)
                response = 3;
                if strcmp(E.task,'Stair'), fprintf('Undetected\n'); else, fprintf('No Tone\n'); end
            end
            responsetime = GetSecs-starttime;
        end
    end
end