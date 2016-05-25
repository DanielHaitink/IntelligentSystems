
I = imread('chest.pgm');
F = im2double(I);
figure(1);
BW = edge(F, 'canny');
subplot(2,4,1), imshow(BW);
xlabel('canny')

BW = edge(F, 'canny', [0.5,0.8]);
subplot(2,4,2), imshow(BW);
xlabel('canny [0.5, 0.8]')

BW = edge(F, 'canny', [0.01,0.8]);
subplot(2,4,3), imshow(BW);
xlabel('canny [0.01, 0.8]')

BW = edge(F, 'canny', [0.01,0.1]);
subplot(2,4,4), imshow(BW);
xlabel('canny [0.01, 0.1]')

BW = edge(F, 'canny', [0.01,0.1],1);
subplot(2,4,5), imshow(BW);
xlabel('canny [0.5, 0.8] sigma = 1')

BW = edge(F, 'canny', [0.01,0.1],3);
subplot(2,4,6), imshow(BW);
xlabel('canny [0.5, 0.8] sigma = 3')

BW = edge(F, 'canny', [0.01,0.1],5);
subplot(2,4,7), imshow(BW);
xlabel('canny [0.5, 0.8] sigma = 5')

BW = edge(F, 'canny', [0.01,0.1],7);
subplot(2,4,8), imshow(BW);
xlabel('canny [0.5, 0.8] sigma = 7')

figure(2);
I = imnoise(F,'salt & pepper');
subplot(2,4,1), imshow(I);
xlabel('salt & pepper')

BW = edge(I, 'canny');
subplot(2,4,5), imshow(BW);
xlabel('canny salt & pepper')

I = imnoise(F, 'poisson');
subplot(2,4,2), imshow(I);
xlabel('poisson')

BW = edge(I, 'canny');
subplot(2,4,6), imshow(BW);
xlabel('canny poisson')

I = imnoise(F, 'gaussian');
subplot(2,4,3), imshow(I);
xlabel('gaussian')

BW = edge(I, 'canny');
subplot(2,4,7), imshow(BW);
xlabel('canny gaussian')

I = imnoise(F, 'speckle');
subplot(2,4,4), imshow(I);
xlabel('speckle')


BW = edge(I, 'canny');
subplot(2,4,8), imshow(BW);
xlabel('canny speckle')

