clear; 
clc; clf;
%% i
image_matrix = imread('dog.jpeg');
red = image_matrix(:,:,1); 
green = image_matrix(:,:,2); 
blue = image_matrix(:,:,3); 
set_to_zero = zeros(size(image_matrix, 1), size(image_matrix, 2), 'uint8');
GBto0 = cat(3, red, set_to_zero, set_to_zero);
RBto0 = cat(3, set_to_zero, green, set_to_zero);
RGto0 = cat(3, set_to_zero, set_to_zero, blue);

figure(1);
imshow(image_matrix);
fontSize = 20;
title('Dog Image', 'FontSize', fontSize)

figure(2);
imshow(RGto0);
title('Red and Green Set to 0', 'FontSize', fontSize)

figure(3);
imshow(RBto0)
title('Red and Blue Set to 0', 'FontSize', fontSize)

figure(4);
imshow(GBto0);
title('Blue and Green Set to 0', 'FontSize', fontSize)
%% ii

Gray = double((0.299*double(image_matrix(:,:,1)) + 0.587*double(image_matrix(:,:,2)) + 0.114*double(image_matrix(:,:,3)))/512);
figure(5);
imshow(Gray);
title('Gray Scale', 'FontSize', fontSize)

%% iii
reverse_matrix = flip(image_matrix);

figure(6);
subplot(1,3,1)
imshow(image_matrix)
title('Normal Version', 'FontSize', fontSize)

subplot(1,3,2)
imshow(reverse_matrix)
title('Upside Down Version', 'FontSize', fontSize)


subplot(1,3,3)
rotate_ninety = rot90(image_matrix);  %rotate_ninety = transpose(image_matrix);
imshow(rotate_ninety)
title('90 degrees rotated version', 'FontSize', fontSize)

%% iv

cropped_version = image_matrix( 25:775,50:750);
figure(7)
imshow(cropped_version)
title('Cropped version', 'FontSize', fontSize)

%% v

for i=1:size(Gray)
    if Gray(i) <= 100
        Gray(i) = 0;
    end
end

figure(8)
imshow(Gray)
title('New Pixelled Version', 'FontSize', fontSize)


%% Question 2

image_matrix = Gray;
k1 = [-1 0 1;
        -2 0 2;
        -1 0 1];
    
k2 = [-1 -2 -1;
    0 0 0;
    1 2 1];

A_1 = convolve(image_matrix, k1);
A_2 = convolve(image_matrix, k2);
A_3 = convolve(A_1, k2);

B_1 = convn(image_matrix,k1,'same');
B_2 = convn(image_matrix,k2,'same');
B_3 = convn(B_1,k2,'same');


figure(9)
imshow(A_1)
title('Question 2-i')

figure(10)
imshow(B_1)
title('Question 2-i with conv2')

figure(11)
imshow(A_2)
title('Question 2-ii')

figure(12)
imshow(A_1)
title('Question 2-ii with conv2')

figure(13)
imshow(A_3)
title('Question 2-iii')

figure(14)
imshow(B_3)
title('Question 2-iii with conv2')

%% Question 3
image_matrix = Gray;
k1 = [0 -1  0;
     -1  5 -1;
      0 -1  0];
           
Hsl1 = convolve(image_matrix, k1);
figure(15)
imshow(Hsl1)
title('Question 3-i')


N = 1024;
figure(16)
freqz2(k1,N,N);
title('Question 3-iii')    

%% Question 4

image_matrix = imread('dog.jpeg');
a = image_matrix;
figure(17)
subplot(1,2,1)
imshow(image_matrix)
title('Question 4 - i normal image')

new_image_matrix = imnoise(image_matrix,'gaussian',0,0.2*0.5);
subplot(1,2,2)
imshow(new_image_matrix)
title('Question 4 - i noisy image')


filtered3 = medfilt3(new_image_matrix,[1,3,1]);
filtered7 = medfilt3(new_image_matrix,[1,7,1]);
filtered21 = medfilt3(new_image_matrix,[1,21,1]);
filtered41 = medfilt3(new_image_matrix,[1,41,1]);


%%
figure(18)
subplot(1,2,1)
imshow(new_image_matrix)
title('Noisy image')

subplot(1,2,2)
imshow(filtered3)
title('3-point Average Filter')

%%
figure(19)
subplot(1,2,1)
imshow(new_image_matrix)
title('Noisy image')

subplot(1,2,2)
imshow(filtered7)
title('7-point Average Filter')

%%
figure(20)
subplot(1,2,1)
imshow(new_image_matrix)
title('Noisy image')

subplot(1,2,2)
imshow(filtered21)
title('21-point Average Filter')

%%
figure(21)
subplot(1,2,1)
imshow(new_image_matrix)
title('Noisy image')

subplot(1,2,2)
imshow(filtered41)
title('41-point Average Filter')

%% Convolve Function
function convolvef = convolve(H, X)
    [i j] = size(H);
    [u v] = size(X);
    transforming_edge_detection = rot90(X, 2);
    median = floor((size(transforming_edge_detection)+1)/2);
    start = median(2) - 1;
    ending = v - median(2);
    up = median(1) - 1;
    down = u - median(1);
    Replacement = zeros(i + up + down, j + start + ending);

    for x = 1 + up : i + up
        for y = 1 + start : j + start
            Replacement(x,y) = H(x - up, y - start);
        end
    end
    convolvef = zeros(i , j);
    for x = 1 : i
        for y = 1 : j
            for a = 1 : u
                for b = 1 : v
                    x_coordinate = x-1;
                    y_coordinate = y-1;
                    convolvef(x, y) = convolvef(x, y) + (Replacement(a + x_coordinate, b + y_coordinate)...
                        * transforming_edge_detection(a, b));
                end
            end
        end
    end
end 
     
    