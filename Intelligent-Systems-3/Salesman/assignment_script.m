%Assignment TSP script

%All the values of T we need to check
listofT= [0.5, 0.2, 0.1, 0.05, 0.02, 0.01];

itterations = length(listofT);
N = 50;

for i = 1:itterations
    T = listofT(i);
    tsp(N,100,3,T);
end