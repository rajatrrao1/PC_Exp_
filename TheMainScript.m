function E = TheMainScript()
%% ToDO
% Check MainMakeStimLists
% Check Bitsi responses
% Add localizer block
% Add practice trials at the beginning of main blocks

%% Parameters

% Experiment name
exp_name = 'AE in noise - Behavioral';

GetSubInfo;

% Name of the output file
filename = [exp_name '-' num2str(E.sbj.n,'%02.f') '-' datestr(now, 'dd-mm-yyyy')];

% Uses the subject number as seed for random number generation
rng(E.sbj.n)

%%
% Add all subfolders to path
addpath(genpath(pwd));

CreateStim;
MainMakeStimLists;

CloseBitsi;
PsychJavaTrouble(); % Fix possible Java problem
IniResponseDev;
IniScreen;
IniAudio;

%% -------------------------------------------------------------------------
%% Staircasing blocks
useStaircase = 0;
if useStaircase
    E = RunStair(E);
    E.stim.staircase_amplitude = mean(E.staircase.reversalLevels(:,end-4:end),2);% After having determined stimulus levels with the staircase, adjust tone
% intensity and create pairs
else
    E.stim.staircase_amplitude = repmat(.175,[1,4]); % .05 - .1
end

CreateTonePairs

%% Main task
E.nBlocks = 1;

% Response containers

E.resp.mainTask.resp     = nan(E.nBlocks,length(E.lists.mainTask));
E.resp.mainTask.respTime = nan(E.nBlocks,length(E.lists.mainTask));


for BlockCounter = 1:E.nBlocks
    E.BlockCounter = BlockCounter;
    
    %ListenChar(2);
    E = RunBlock(E);
end

save E E
CloseBitsi;