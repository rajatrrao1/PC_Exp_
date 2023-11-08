TotLength  = 104; % Number of trials in a block. CHECK: It should match what is defined in MakeStimList()
E.lists.mainTask = nan(15,TotLength);

for n = 1:size(E.lists.mainTask,1)
    
    ck = [true true true];
    
    while any(ck)
        %% Generate a sequence
        tone_list = MakeStimList();
        
        %% First, check if std pair frequency is stable
        w = 30;
        h = [];
        
        for i = 1:length(tone_list)-w
            h(i,:) = hist(tone_list(i:i+(w-1)),6)/w;
        end
        
        h = h(:,1:2);

        ck(1) = any(abs(h(:) - .76/2) > .05);
        ck(1) = false;
        
        %% Second, check if at any point, mean dev freq is higher than std freq, or if mean dev freq is above 10% 
        w = 20;
        h = [];
        
        for i = 1:length(tone_list)-w
            h(i,:) = hist(tone_list(i:i+(w-1)),6)/w;
        end
        
        mpd = mean(h(:,3:6),2); % mean prob deviant
        mps = mean(h(:,1:2),2); % mean prob standard
        
        ck(2) = any(mpd > mps) || any(mpd > .1);
        %ck(2) = false;

       
        %% Check if there are the right amount of each trial type
        % Get the histogram of all the sequence and check if is equal to [39 39 8 8 5 5]
        h = histcounts(tone_list);
        ck(3) = not(all(h == [39 39 8 8 5 5]));
        %ck(3) = false;

    end

    E.lists.mainTask(n,:) = tone_list;
    disp(['List ', num2str(n),' created']);
end

% for n = 1:length(Lists)
%     tone_list = Lists{n};
%     save(['S_',num2str(n),'.mat'],'tone_list')
% end
