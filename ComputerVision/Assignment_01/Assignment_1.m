%assignment 1.1
M1 = [1 2; 3 4; 5 6];
M1([2 3],:) = M1([3 2],:)

%assignment 1.2
Mrand = randi([0 10], 10, 10);
Mrand([1],:) = 1
Mrand(:,[1]) = 1

%assignment 1.3
row200 = [[8 6 4 2], zeros(1, 195), [10]]