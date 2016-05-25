function [Fx, Fy] = script1(image)
I = imread(image);
F = im2double(I);
hx = [-1, 0, 1]; % x derivative
hy = [-1 ;0  ;1]; % y derivative

Fx = imfilter(F,hx,'replicate','conv');
Fy = imfilter(F,hy, 'replicate', 'conv');

h2 = [0,1,0;1,1,1;0,1,0]; %Dilation
F3 = imdilate(F,h2); %Dilation


subplot(4,4,1), imshow(image);
xlabel('input')

subplot(4,4,2), imshow(Fx);
xlabel('x derivative')

subplot(4,4,3), imshow(Fy);
xlabel('y derivative')

subplot(4,4,4), imshow(F3);
xlabel('dilation')

subplot(4,4,5), imshow(imnoise(I,'Gaussian',0.1, 0.1));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.1')

subplot(4,4,6), imshow(imnoise(Fx,'Gaussian',0.1, 0.1));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.1')

subplot(4,4,7), imshow(imnoise(Fy,'Gaussian',0.1, 0.1));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.1')

subplot(4,4,8), imshow(imnoise(F3,'Gaussian',0.1, 0.1));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.1')

subplot(4,4,9), imshow(imnoise(I,'Gaussian',0.1, 0.01));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.01')

subplot(4,4,10), imshow(imnoise(Fx,'Gaussian',0.1, 0.01));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.01')

subplot(4,4,11), imshow(imnoise(Fy,'Gaussian',0.1, 0.01));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.01')

subplot(4,4,12), imshow(imnoise(F3,'Gaussian',0.1, 0.01));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.01')

subplot(4,4,13), imshow(imnoise(I,'Gaussian',0.1, 0.001));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.001')

subplot(4,4,14), imshow(imnoise(Fx,'Gaussian',0.1, 0.001));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.001')

subplot(4,4,15), imshow(imnoise(Fy,'Gaussian',0.1, 0.001));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.001')

subplot(4,4,16), imshow(imnoise(F3,'Gaussian',0.1, 0.001));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.001')

end