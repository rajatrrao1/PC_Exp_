function [ Seq ] = GenSequence( Op, N, MaxR )
%GENSEQUENCE Generates a pseudorandom sequence of numbers with limited
%consecutive repetitions.
%   Usage:
%         [ Seq ] = GenSequence( Op, N, MaxR );
%
%   Where:
%         Op: Integer. eg. if 3, then numbers 1:3 will be used.
%          N: Integer. Length of the sequence.
%       MaxR: Maximun number of consecutive repetitions.


%%
Op = 1:Op;

Seq = nan(N,1);

Seq(1:length(Op)) = randsample(length(Op),length(Op));

for s = length(Op)+1:N
    %for s = 1:N
    
    cOp = Op;
    
    if MaxR > 1
        if numel(unique(Seq(s-MaxR:s-1)))==1
            cOp(cOp == Seq(s-1)) = [];
        end
    else
        cOp(cOp == Seq(s-1)) = [];
    end
    
    if numel(cOp)>1
        cOp = cOp(randperm(length(cOp)));
        Seq(s) = cOp(1);
    else
        Seq(s) = cOp;
    end
    
end

end