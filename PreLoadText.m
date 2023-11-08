%% Instructions and text
T_Blocks         = 'Instructions_Blocks.txt'; % text file for the second instructions
T_Test           = 'Instructions_Test.txt'; % text file for the second instructions
T_Rest           = 'Instructions_Rest.txt'; % text file for the second instructions
T_testquestion   = 'TestQuestion.txt';

%% Read the text files for the instructions
%Resting block
id     = fopen(fullfile(pwd, T_Rest));
t_rest = textscan(id,'%c','whitespace','');
t_rest = t_rest{1}';
fclose(id);

% Regular blocks
id       = fopen(fullfile(pwd, T_Blocks));
t_blocks = textscan(id,'%c','whitespace','');
t_blocks = t_blocks{1}';
fclose(id);

% Test block
id     = fopen(fullfile(pwd, T_Test));
t_test = textscan(id,'%c','whitespace','');
t_test = t_test{1}';
fclose(id);

% Test question
id             = fopen(fullfile(pwd, T_testquestion));
t_testquestion = textscan(id,'%c','whitespace','');
t_testquestion = t_testquestion{1}';
fclose(id);
