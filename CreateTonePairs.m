
% Targets are scaled to the amplitude determined during the staircase
scale1 = E.stim.staircase_amplitude(1);
scale4 = E.stim.staircase_amplitude(4);

E.stim.tone_pairs = [E.stim.tones(2,:), silence, E.stim.tones(1,:)*scale1;% Expected
                     E.stim.tones(3,:), silence, E.stim.tones(4,:)*scale4; % Expected
                     E.stim.tones(2,:), silence, E.stim.tones(4,:)*scale4; % Unexpected
                     E.stim.tones(3,:), silence, E.stim.tones(1,:)*scale1; % Unexpected
                     E.stim.tones(2,:), silence, E.stim.tones(5,:); % Omission
                     E.stim.tones(3,:), silence, E.stim.tones(5,:)];% Omission
                 
E.stim.tone_pairs_practice = ...
                    [E.stim.tones(2,:), silence, E.stim.tones(1,:)*scale1*db2mag(10);% Expected
                     E.stim.tones(3,:), silence, E.stim.tones(4,:)*scale4*db2mag(10); % Expected
                     E.stim.tones(2,:), silence, E.stim.tones(4,:)*scale4*db2mag(10); % Unexpected
                     E.stim.tones(3,:), silence, E.stim.tones(1,:)*scale1*db2mag(10); % Unexpected
                     E.stim.tones(2,:), silence, E.stim.tones(5,:); % Omission
                     E.stim.tones(3,:), silence, E.stim.tones(5,:)];% Omission