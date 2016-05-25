%function for doing k-nearest neighbour clustering
function [] = knn(K, nrofclasses, data)

colors = ['m','y','c','r','g','b','k'];
markers = ['o', '+', '*', '.', '+', 'x'];
N=64;

Klook = zeros(K+1, 2);
mark = 1;
color =0;
%Determines appearance of cluster (color and shape)
for i = 1:nrofclasses+1
    color = color + 1;
    if color > length(colors)
        mark = mark+1;
        color = 1;
    end
   Klook(i,1) = color;
   Klook(i,2) = mark;
end

for i=1:N
  X=(i-1/2)/N;
  for j=1:N
    Y=(j-1/2)/N;
  
    % create vertex with infinite numbers and calculate the classlength %
    NN = inf(K,2);
    classLength = length(data)/nrofclasses;
    % loop through data %
    for ii = 1:length(data)
         % calculate distance from point i to vector %
         dX =abs( X - data(ii,1));
         dY =abs( Y - data(ii,2));
         currentDist = sqrt(dY*dY+dX*dX);
         % Loop through all K Nearest Neighbours %
        for jj = 1:K
            % If current point is closer to the vector as j, replace it with the current point %
            if  currentDist<NN(jj,1)
                NN(jj,1) = currentDist;
                % if ii is the length of data (100), make NN(jj,2) the max class number %
                if ii == length(data)
                    NN(jj,2) = nrofclasses;
                else
                    % else, use the calculation below to remove the remainder after the comma, and increase by one %
                    NN(jj,2) = (ii/classLength)- (mod(ii/classLength,1))+1;
                end
                break;
            end
        end
    % Find the mode (most occuring class) of the K-nearest neighbours and return it %
    result(j,i) = mode(NN(:,2));
    
    % check if the result is really the mode, or if it is a draw between the clusters %
    sum = 0;
    for a = 1:K
        if result(j,i) == NN(a,2)
            sum = sum+1;
        end
    end
    % If there is only one instance of the mode, look for the cluster with the smallest distance to the point %
    if sum == 1
        for a = 1:K
           if min(NN(:,1)) == NN(a,1)
              result(j,i) = NN(a,2); 
           end
        end
    end
   
    end
  end
end
imshow(result,[1 nrofclasses],'InitialMagnification','fit')
hold on;
data=N*data; % scaling

% print the point for nrofclasses %
for i = 1:nrofclasses
    startPoint = (i-1)*classLength+1;
    endPoint = i*classLength;
   plot(data(startPoint:endPoint,1),data(startPoint:endPoint, 2), [colors(Klook(i,1)), markers(Klook(i,2))]);
   hold on
end
hold off

