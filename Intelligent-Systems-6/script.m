K = 4;
n = 0.1;
tMax = 10;
load('w6_1x.mat');
    load('w6_1y.mat');
    load('w6_1z.mat');

    N = length(w6_1x(1,:))+ length(w6_1y(1,:)) + length(w6_1z(1,:)) ;
    P = length(w6_1x(:,1));
    proto = zeros(K, N);
    random = randperm(P, K);
    t = 1;
    
    figure(1)
        plot(w6_1x(:,1),w6_1x(:,2), 'or');
        hold on
        plot(w6_1y(:,1),w6_1y(:,2), 'ob');
        hold on
        plot(w6_1z(:,1),w6_1z(:,2), 'og');
        hold off
    
    !choose K random prototypes and store them
    for i=1:K
        proto(i,1:2) = w6_1x(i,1:2);
        proto(i,3:4) = w6_1y(i,1:2);
        proto(i,5:6) = w6_1z(i,1:2);
    end
    w6_1xTemp = zeros(P,N/3);
    w6_1yTemp = zeros(P,N/3);
    w6_1zTemp = zeros(P,N/3);
    
    for t = 1:tMax
        t
        !randomize order
        temprand = randperm(P);
        for i = 1:P
            w6_1xTemp(temprand(i),:) = w6_1x(i,:);
            w6_1yTemp(temprand(i),:) = w6_1y(i,:);
            w6_1zTemp(temprand(i),:) = w6_1z(i,:);
        end
        w6_1x = w6_1xTemp;
        w6_1y = w6_1yTemp;
        w6_1z = w6_1zTemp;
        
        !training
        for i =1:P
            bestDist = inf(2);
            for k=1:K
                dist(1,1:2) = proto(k,1:2) - w6_1x(i,1:2);
                dist(1,3:4) = proto(k,3:4) - w6_1y(i,1:2);
                dist(1,5:6) = proto(k,5:6) - w6_1z(i,1:2);
                currentDist = sqrt( sum(dist(1,:).^2));
                if currentDist < bestDist(1)
                   bestDist(1) = currentDist;
                   bestDist(2) = k;
                end
            end
            ! update best k
            
            proto(bestDist(2),1:2) = proto(bestDist(2),1:2) + n*w6_1x(i,1:2);
            proto(bestDist(2),3:4) = proto(bestDist(2),3:4) + n*w6_1y(i,1:2);
            proto(bestDist(2),5:6) = proto(bestDist(2),5:6) + n*w6_1z(i,1:2);
        end
        !plot graph
        figure(1)
        plot(proto(:,1),proto(:,2), '+r');
        hold on
        plot(proto(:,3),proto(:,4), '+b');
        hold on
        plot(proto(:,5),proto(:,6), '+g');
        
        !calculate quantization error HV Q ??
    end
    hold off
    
    !plot learning curve
  figure (2)