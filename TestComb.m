ST = B.StimCat+1;

torem2 = {zeros(16,1)};
torem2 = torem2(ones(3));

torem2{1,2}([3 5 12 14]) = 1;
torem2{1,3}([4 7 10 13]) = 1;
torem2{2,1}([2 8  9 15]) = 1;
torem2{2,3}([3 5 12 14]) = 1;
torem2{3,1}([4 7 10 13]) = 1;
torem2{3,2}([2 8  9 15]) = 1;

% All combinations of W vs D1
[AMat,BMat] = meshgrid(1:4,5:8);
w_vs_d1 = [AMat(:),BMat(:)];

torem1 = w_vs_d1(:,1) == w_vs_d1(:,2)-4;
torem = torem1 + torem2{ST(1), ST(2)};

w_vs_d1 = w_vs_d1(~torem,:);

% All combinations of W vs D2
[AMat,BMat] = meshgrid(1:4,9:12);
w_vs_d2 = [AMat(:),BMat(:)];

torem1 = w_vs_d2(:,1) == w_vs_d2(:,2)-8;
torem = torem1 + torem2{ST(1), ST(3)};

w_vs_d2 = w_vs_d2(~torem,:);


% All combinations of D1 vs D2
[AMat,BMat] = meshgrid(5:8,9:12);
d1_vs_d2 = [AMat(:),BMat(:)];

torem1 = d1_vs_d2(:,1)-8 == d1_vs_d2(:,2)-12;
torem = torem1 + torem2{ST(2), ST(3)};

d1_vs_d2 = d1_vs_d2(~torem,:);

TestPairs = [w_vs_d1; w_vs_d2; d1_vs_d2];

CompType = repmat([1 2 3], 8, 1);
CompType = CompType(:);

% Shuffle trial order
ok = false;
while ~ok
    ix = randperm(size(TestPairs,1));
    
    TestPairs = TestPairs(ix,:);
    CompType  = CompType(ix,:);
    
    check     = nan(length(CompType)-2,1);
    
    for n = 1:length(check)
        check(n) = numel(unique(TestPairs(n:n+2,1)));
    end
    
    ok = ~any(check == 1);
end

% Shuffle in trial order of presentation
ok = false;
while ~ok
    ix = round(rand(size(TestPairs,1),1));
    
    check     = nan(length(ix)-3,1);
    
    for n = 1:length(check)
        check(n) = numel(unique(ix(n:n+3)));
    end
    
    ok = ~any(check == 1);
end

ix = [ix, ~ix]+1;

TestPairs = [TestPairs(sub2ind(size(TestPairs),(1:size(TestPairs,1))',ix(:,1))),...
    TestPairs(sub2ind(size(TestPairs),(1:size(TestPairs,1))',ix(:,2)))];