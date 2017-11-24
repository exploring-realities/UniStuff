img = imread('text.png');
%L = bwlabel(img, conn) %conn means connectivity, which is either 4 or 8
cc = bwconncomp(img);

%cellfun() applies a certain function to each array cell

pixels = cellfun(@numel, cc.PixelIdxList);
[biggest, index] = max(pixels);
im(cc.PixelIdxList{index}) = 0;

% img2 = imfilter(img, kernel);
img = imread('coins.png');
boxfilter = ones(3,3)/9;
img2 = imfilter(im, boxfilter);
imshow(img2)
