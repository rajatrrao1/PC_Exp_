
% Words vs Dev1
hits1 = mean(B.answers(B.CompType == 1));
display('---------------------');
display(['Words vs Dev1: ',num2str(hits1*100),'%']);

% Words vs Dev2
hits2 = mean(B.answers(B.CompType == 2));
display(['Words vs Dev2: ',num2str(hits2*100),'%']);

% Dev1 vs Dev2
hits3 = mean(B.answers(B.CompType == 3));
display(['Dev1 vs Dev2: ' ,num2str(hits3*100),'%']);

display([' ']);

%%

ClickTime = B.ClickTime(:);
WordLists = B.WordLists(:);

B.ClickRes.Hits = sum(~isnan(ClickTime) & (WordLists > 4)) / sum(WordLists > 4);
B.ClickRes.Miss = sum( isnan(ClickTime) & (WordLists > 4)) / sum(WordLists > 4);
B.ClickRes.Fals = sum(~isnan(ClickTime) & (WordLists < 5)) / sum(WordLists < 5);
B.ClickRes.CorR = sum( isnan(ClickTime) & (WordLists < 5)) / sum(WordLists < 5);

display(['Hits: ' ,num2str(B.ClickRes.Hits*100),'%']);
display(['Miss: ' ,num2str(B.ClickRes.Miss*100),'%']);
display(['Fals: ' ,num2str(B.ClickRes.Fals*100),'%']);
display(['CorR: ' ,num2str(B.ClickRes.CorR*100),'%']);

display([' ']);
