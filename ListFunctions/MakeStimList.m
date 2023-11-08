function [Seq] = MakeStimList()

Intervals  = 3;  % Number of std between deviants
TotDev     = 26; % Number of deviants within a block
DevTypes   = 2;  % Number of types of deviants
TotLength  = 104; % Number of trials in a block
HeadingStd = 4; % Starts with 4 STD stim
Stds          = TotLength-TotDev-HeadingStd;

Int = [];
ck = ones(4,1);
c=1;
CK = ones(4,1000);

while any(ck)
    Int = GenSequence( Intervals, TotDev, 2 ) +1; % Interval between Devs
    % (aka how many STD between Devs)
    ck(1) = sum(Int)~=(Stds); % This should be equal to the total number of STD besides the Heading ones
    ck(2) = abs(sum(Int == 2) - floor(TotDev/Intervals))>2; % Check that the 3 intervals are used
    ck(3) = abs(sum(Int == 3) - floor(TotDev/Intervals))>2;
    ck(4) = abs(sum(Int == 4) - floor(TotDev/Intervals))>2;
    CK(:,c) = ck;
    c = c+1;
end

%Identity of the deviant
D = [];
while sum(D == 3)~= TotDev/DevTypes || sum(D == 4)~= TotDev/DevTypes
    D   = GenSequence( DevTypes, TotDev, 1 ) + 2; % Type of Dev. There are 2 types which are further split
    %up when calling the output
end

%Identity of the standard
S = [];
while sum(S == 1)~=Stds/2
    S = GenSequence( 2, Stds, 2 ); % Identity of the Std
end

%% Creates a sequences of 1 = STD and 0 = DEV
Seq = ones(TotLength-HeadingStd,1);

c = 1;
for I = 1:length(Int)
    n = c:c+(Int(I)-1);
    
    Seq(n(end)+1) = 0;
    c = c+Int(I)+1;
end


% maximum number of iterations for selecting deviant trials
max_iterations = 1000;

for z = 1:10
    % reset the number of omissions and the type of omissions
    omi_count = 1;
    omi_type = Shuffle([ones(5,1)*5; ones(5,1)*6]);
    
    % iteration counter
    iter = 1;

    while omi_count <= 10 && iter <= max_iterations
        % randomly select a deviant trial
        dev_idx = randi(TotDev);

        % check if the selected deviant trial is valid
        while (sum(D==3) <= 8 && D(dev_idx)==3) || (sum(D==4)<=8 && D(dev_idx)==4)
            dev_idx = randi(TotDev);
        end

        % if the value is already in the sequence or occurs successively, select another value
        omi_val = omi_type(omi_count);

        % if the deviant trial is not already an omission (5 or 6)
        if not(any(D(dev_idx) == [5,6]))
            % check if it has any adjacent omission
            if dev_idx == 1 && not(any(D(dev_idx+1) == [5,6]))
                D(dev_idx) = omi_val;
                omi_count = omi_count + 1;
            elseif dev_idx == TotDev && not(any(D(dev_idx-1) == [5,6]))
                D(dev_idx) = omi_val;
                omi_count = omi_count + 1;
            elseif dev_idx > 1 && dev_idx < TotDev && not(any(D(dev_idx-1) == [5,6])) && not(any(D(dev_idx+1) == [5,6]))
                D(dev_idx) = omi_val;
                omi_count = omi_count + 1;
            end
        end

        % increase iteration counter
        iter = iter + 1;

        % check if maximum iterations reached
        if iter > max_iterations
            disp("Maximum iterations reached, exiting loop");
            break;
        end
    end
end

Seq(Seq==1) = S;
Seq(Seq==0) = D;

l = [1;2;1;2];
Seq = [l(randperm(length(l))); Seq];

%%

unique_values = unique(Seq);
counts = histc(Seq, unique_values);
disp("Unique values in Seq:");
disp(unique_values);
disp("Counts for each unique value:");
disp(counts);
