clear all;
load('normdist.mat');

%%Assignment a
%Calculate mean and SD
nS1 = mle(S1);
nS2 = mle(S2);
nT = mle(T);

%plot S1, S2, T as points
figure(1);
plot(S1(:,1), 0, 'bo');
hold on;
plot(S2(:,1), 0, 'ro');
hold on;
plot(T, 0, 'ks');

hold off;

%%Assignment b
figure(2);
%Gaus function 1 in blue, for set S1
x = [min(S1)*2:.5:max(S1)*2]; % Range of x-axis. Multiplied by 2 to create fancier plot.
norm = normpdf(x,nS1(1),nS1(2)); % Argument 1 is the mu, argument 2 the sigma.
plot(x,norm, 'blue')
hold on;
%Gaus function 2 in red, for set S2
x = [min(S2)/2:.5:max(S2)*2]; % Devided by 2 because min(S2) is a positive value
norm = normpdf(x,nS2(1),nS2(2)); 
plot(x,norm, 'red')
hold on;

%plot the datapoints
plot(S1(:,1),0, 'bo');
hold on;
plot(S2(: ,1),0, 'ro');

hold off;

%%Assignment c&d
figure(3);
P_omega1 = 2/3;
P_omega2 = 1/3;
%Geen idee hoe ik P(omega1)*P(x|omega1) doe
plot(P_omega1 * (S1*P_omega1)) %klopt niet
hold on;
plot(P_omega2 * (S2*P_omega2)) %klopt niet
%plot the datapoints
plot(S1(:,1),0, 'bo');
hold on;
plot(S2(: ,1),0, 'ro');
hold on;
plot(T, 0, 'ks');
hold off;