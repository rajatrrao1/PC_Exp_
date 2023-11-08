

imagesc(E.resp.mainTask.resp)
%%

%S = E.lists.mainTask(E.BlockCounter,:);
%R = E.resp.mainTask.resp(E.BlockCounter,:);

S = E.lists.mainTask(2:E.nBlocks,:);
R = E.resp.mainTask.resp(2:E.nBlocks,:);


% Hits
Hit_STD1 = sum(S == 1 & R == 1,'all')/sum(S(:) == 1);
Hit_STD2 = sum(S == 2 & R == 2,'all')/sum(S(:) == 2);
Hit_DEV1 = sum(S == 3 & R == 2,'all')/sum(S(:) == 3);
Hit_DEV2 = sum(S == 4 & R == 1,'all')/sum(S(:) == 4);

% Miss
Miss_STD1 = sum(S == 1 & R == 3,'all')/sum(S(:) == 1);
Miss_STD2 = sum(S == 2 & R == 3,'all')/sum(S(:) == 2);
Miss_DEV1 = sum(S == 3 & R == 3,'all')/sum(S(:) == 3);
Miss_DEV2 = sum(S == 4 & R == 3,'all')/sum(S(:) == 4);

% Miss no answer
Miss_na_STD1 = sum(S == 1 & R == 0,'all')/sum(S(:) == 1);
Miss_na_STD2 = sum(S == 2 & R == 0,'all')/sum(S(:) == 2);
Miss_na_DEV1 = sum(S == 3 & R == 0,'all')/sum(S(:) == 3);
Miss_na_DEV2 = sum(S == 4 & R == 0,'all')/sum(S(:) == 4);

% FA
FA_exp_1   = sum(S == 5 & R == 1,'all')/sum(S(:) == 5);
FA_unexp1 = sum(S == 5 & R == 2,'all')/sum(S(:) == 5);
FA_exp_2   = sum(S == 6 & R == 2,'all')/sum(S(:) == 5);
FA_unexp_2 = sum(S == 6 & R == 1,'all')/sum(S(:) == 5);

% CorReg
CorReg1  = sum(S == 5 & R == 3,'all')/sum(S(:) == 5);
CorReg2  = sum(S == 6 & R == 3,'all')/sum(S(:) == 6);

% Confusions
Conf_STD1 = sum(S == 1 & R == 2,'all')/sum(S(:) == 1);
Conf_STD2 = sum(S == 2 & R == 1,'all')/sum(S(:) == 2);
Conf_DEV1 = sum(S == 3 & R == 1,'all')/sum(S(:) == 3);
Conf_DEV2 = sum(S == 4 & R == 2,'all')/sum(S(:) == 4);

%if not(Hit_DEV1 + Miss_DEV1 + Miss_na_DEV1 == 1), warning('Percentages don''t add up to 1'); end

Hit_DEV = (Hit_DEV1 + Hit_DEV2)/2
Hit_STD = (Hit_STD1 + Hit_STD2)/2
