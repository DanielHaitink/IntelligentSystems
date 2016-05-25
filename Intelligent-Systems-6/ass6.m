function [proto, data] = ass6(file, K, n, tMax)
%compute HVq and show the clusterdata and cluster prototypes
%input: file = 1,2 or 3. Which chooses the data to load. K = number of
%clusters. n = learning rate. tMax is number of epochs
    load('w6_1x.mat');
    load('w6_1y.mat');
    load('w6_1z.mat');
    if file == 1
        data = w6_1x;
    end
    if file == 2
        data = w6_1y;
    end
    if file == 3
        data = w6_1z;
    end

    N = length(data(1,:)) ;
    P = length(data(:,1));
    proto = zeros(K, N);
    random = randperm(P, K);
    dataTemp = zeros(P,N);
    dataClusters = zeros(P);
    HVq = zeros(tMax,2);

    %plot data on figure 1
    figure(1)
    plot(data(:,1), data(:,2), 'ob' );
    hold on
    
    
    %choose K random prototypes and store them
    for i=1:K
       
        proto(i,1:2) = data(random(i),1:2);
      

    end
    %plot first prototype on figure 1
    figure (1)
    plot(proto(:,1), proto(:,2), '+r');
    hold on
    text(proto(:,1), proto(:,2),cellstr(num2str(0)),'right');
    hold on  
    
    for t = 1:tMax
        
        %randomize order
        temprand = randperm(P);
        for i = 1:P
            dataTemp(temprand(i),:) = data(i,:);
        end
        data = dataTemp;
       
        %training
        for i =1:P
            bestDist = inf(2);
            %loop through clusters
            for k=1:K
                %compute distance and see if it is better than the current
                %best
                dist(1,1:2) = proto(k,1:2) - data(i,1:2);
                currentDist = sqrt(dist(1,1)^2 + dist(1,2)^2)^2;
                if currentDist < bestDist(1)
                   bestDist(1) = currentDist;
                   bestDist(2) = k;
                   dataClusters(i) = k;
                end
            end
            % update best k
            proto(bestDist(2),1:2) = [(1-n)*proto(bestDist(2),1) + n*data(i,1),(1-n)*proto(bestDist(2),2) + n*data(i,2)] ;
           
        end
        %plot graph
        figure(1)
        plot(proto(:,1),proto(:,2), '+r');
        hold on
        text(proto(:,1),proto(:,2),cellstr(num2str(t)),'right');
        hold on
        
        %calculate quantization error HV Q
        for i = 1:P
           for k = 1:K
              if dataClusters(i) == k
                  % compute sum eucledian distance
                  dist(1,1:2) = proto(k,1:2) - data(i,1:2);
                  HVq(t,2) = HVq(t,2) + sqrt(dist(1,1)^2 + dist(1,2)^2);
                  HVq(t,1) = t;
              end
           end
        end
       
    end
    %add labels
    figure(1)
    title('Clustering')
    hold on
    legend('Datapoint','Prototype, with creation epoch','Location','southwest')
    hold off

    
    %plot learning curve
    figure (2)
    plot(HVq(:,1),HVq(:,2), 'ob');
    title('Change in learning rate')
    xlabel('Epochs')
    ylabel('HVq')
    hold off
    
end