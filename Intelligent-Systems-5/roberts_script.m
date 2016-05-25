function [Fx, Fy] = roberts_script(image)
I = imread(image);
F = im2double(I);
hx = [0,1;-1,0]; % x derivative
hy = [1,0;0,-1]; % y derivative

Fx = imfilter(F,hx,'replicate','conv');
Fy = imfilter(F,hy, 'replicate', 'conv');

subplot(3,3,1), imshow(image);
xlabel('input')

subplot(3,3,2), imshow(Fx);
xlabel('x derivative')

subplot(3,3,3), imshow(Fy);
xlabel('y derivative')

subplot(3,3,4), imshow(imnoise(I,'Gaussian',0.1, 0.1));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.1')

subplot(3,3,5), imshow(imnoise(Fx,'Gaussian',0.1, 0.1));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.1')

subplot(3,3,6), imshow(imnoise(Fy,'Gaussian',0.1, 0.1));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.1')

subplot(3,3,7), imshow(imnoise(I,'Gaussian',0.1, 0.001));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.001')

subplot(3,3,8), imshow(imnoise(Fx,'Gaussian',0.1, 0.001));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.001')

subplot(3,3,9), imshow(imnoise(Fy,'Gaussian',0.1, 0.001));
xlabel('w/ Gaussian noise w/ mean = 0.1, variance =0.001')

end