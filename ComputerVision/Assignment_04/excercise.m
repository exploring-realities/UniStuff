img = imread('text.png');
imshow(img);
SE = strel('line', 11, 90); 
img2 = imdilate (img, SE);
imshow(img2);

img3 = imread('snowflakes.png');
imshow(img3)
SE2 = strel('disk', 4);
imgOpen = imopen(img3, SE2);
imshow(imgOpen);