%function for doing k-means clustering
%cluster is the amount of clusters wanted; inputmatrix is a n*2 matrix 
function [] = kmeans(clusters, inputmatrix)

%get length of matrix
length_matrix = length(inputmatrix);

colors = ['m','y','c','r','g','b','k'];
markers = ['o', '+', '*', '.', '+', 'x'];
%pick random points to become mu
randK = randperm(length_matrix,clusters);
%Create a vector where the cluster gets saved to which a datapoint belongs to 
clusteredData = zeros(length_matrix,1);

clusterLook = zeros(clusters, 2);
mark = 1;
color =1;
%Determines appearance of cluster (color and shape)
for i = 1:clusters
    color = color + 1;
    if color > length(colors)
        mark = mark+1;
        color = 1;
    end
   clusterLook(i,1) = color;
   clusterLook(i,2) = mark;
end

%Saves the coordinates of the cluster centers
for i = 1:clusters
    clusterK(i,:) = inputmatrix(randK(i),:);
end

%Create the plot
for i = 1:length_matrix
     currentK = inputmatrix(i,:);
     best = inf;
     bestCluster = -1;
     for j = 1:clusters
        %Determine distance using pythagoras
        dX =abs( currentK(1,1) - clusterK(j,1));
        dY =abs( currentK(1,2) - clusterK(j,2));
        currentDist = sqrt(dY*dY+dX*dX);
        %In case a closer cluster is found, save that
        if best > currentDist
            best = currentDist;
            bestCluster = j;
        end
     end
     clusteredData(i) = bestCluster;
     scatter(currentK(1,1), currentK(1,2),colors(clusterLook(bestCluster,1)), markers(clusterLook(bestCluster,2)));
     hold on
end  
hold off