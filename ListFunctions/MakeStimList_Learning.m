function [Seq] = MakeStimList_Learning()

Seq       = [];
TotLength = 96;

ck = true(2,1);

while any(ck)
    Seq   = GenSequence( 2, TotLength, 2 ); % Identity of the Std
    
    for n = 1:2
        ck(n) = abs(sum(Seq == n) - TotLength/2) > 3;
    end
end

end