T = zeros(numel(unique(tone_list)),numel(unique(tone_list)));

for n = 1:length(tone_list)-1
    T(tone_list(n),tone_list(n+1)) = T(tone_list(n),tone_list(n+1))+1;
end

T = T./sum(T,2)

close all
figure;imagesc(T)