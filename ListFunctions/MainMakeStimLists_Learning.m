Lists = cell(5,1);

for n = 1:length(Lists)
    
    ck = true;
    
    while ck
        tone_list = MakeWordList_Learning();
        w = 50;
        h = [];
        
        for i = 1:length(tone_list)-w
            h(i,:) = hist(tone_list(i:i+(w-1)),2)/w;
        end
        
        ck = any(abs(h(:) - 1/2) > .15);
    end
    
    Lists{n} = tone_list;
end


for n = 1:length(Lists)
    tone_list = Lists{n};
    save(['S_Learn_',num2str(n),'.mat'],'words')
end
