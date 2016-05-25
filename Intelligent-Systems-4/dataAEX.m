clear all;
load('dataAEX.mat');

matrix = linkage(data,'complete','euclidean');
dendrogram(matrix);
title('Dendrogram of AEX data');
xlabel('ID of the stock')