clear all
clc

%path of the CIFAR-10 data
cifar10Data = 'C:\Users\Panda\Documents\Git Repos\UniStuff\ComputerVision\Assignment_03'

% Load the CIFAR-10 training and test data.
[trainingImages, trainingLabels, testImages, testLabels] = helperCIFAR10Data.load(cifar10Data);

auto = [];
deer = [];
ships = [];
count_a = 1;
count_d = 1;
count_s = 1;

auto_hist = [];
deer_hist = [];
ships_hist = [];

autotest = [];
deertest = [];
shipstest = [];
autotest_hist = [];
deertest_hist = [];
shipstest_hist = [];
count_ta = 1;
count_td = 1;
count_ts = 1; 

distance = 0; 
class = 'none';

samples = 0;
wrong_classifications = 0;
auto_count = 0;
deer_count = 0;
ship_count = 0;

%go through first batch of training data, extract first 30 images form the
%3 given classes (automobile, deer, ships), convert them into greyscale and
%get their histograms and store them
for i = 1 : 10000
    
    if trainingLabels(i) == 'automobile' && count_a < 31
        %get image at index i and convert to greyscale
        img = rgb2gray(trainingImages(:,:,:,i));
        %get histogram of greayscale image and store in an array
        auto_hist = [auto_hist, imhist(img)];
        %store image in array
        auto = cat(1, auto, img);
        %write image into png file for debugging purposes
        %imwrite(img,strcat('C:\Users\Panda\Documents\Git Repos\UniStuff\ComputerVision\Assignment_03\trainingImg\auto',int2str(count_a),'.png'),'png');
        count_a = count_a+1;
    elseif trainingLabels(i) == 'deer' && count_d < 31
        img = rgb2gray(trainingImages(:,:,:,i));
        deer_hist = [deer_hist, imhist(img)];
        deer = cat(1, deer, img);
        %imwrite(img,strcat('C:\Users\Panda\Documents\Git Repos\UniStuff\ComputerVision\Assignment_03\trainingImg\deer',int2str(count_d),'.png'),'png');
        count_d = count_d+1; 
    elseif trainingLabels(i) == 'ship' && count_s < 31
        img = rgb2gray(trainingImages(:,:,:,i));
        ships_hist = [ships_hist, imhist(img)];
        ships = cat(1, ships, img);
        %imwrite(img,strcat('C:\Users\Panda\Documents\Git Repos\UniStuff\ComputerVision\Assignment_03\trainingImg\ships',int2str(count_s),'.png'),'png');
        count_s = count_s+1; 
    elseif count_a == 30 && count_d == 30 && count_s == 30
        break
    end
end



%get fist 10 images of each class of the test batch 
for i = 1 : 10000
    if testLabels(i) == 'automobile' && count_ta < 11
        img = rgb2gray(testImages(:,:,:,i));
        autotest_hist = [autotest_hist, imhist(img)];
        autotest = cat(1, autotest, img);
        imwrite(img,strcat('C:\Users\Panda\Documents\Git Repos\UniStuff\ComputerVision\Assignment_03\testImg\auto',int2str(count_ta),'.png'),'png');
        count_ta = count_ta+1;
    elseif testLabels(i) == 'deer' && count_td < 11
        img = rgb2gray(testImages(:,:,:,i));
        deertest_hist = [deertest_hist, imhist(img)];
        deertest = cat(1, deertest, img);
        imwrite(img,strcat('C:\Users\Panda\Documents\Git Repos\UniStuff\ComputerVision\Assignment_03\testImg\deer',int2str(count_td),'.png'),'png');
        count_td = count_td+1; 
    elseif testLabels(i) == 'ship' && count_ts < 11
        img = rgb2gray(testImages(:,:,:,i));
        shipstest_hist = [shipstest_hist, imhist(img)];
        shipstest = cat(1, shipstest, img);
        imwrite(img,strcat('C:\Users\Panda\Documents\Git Repos\UniStuff\ComputerVision\Assignment_03\testImg\ships',int2str(count_ts),'.png'),'png');
        count_ts = count_ts+1; 
    elseif count_ta == 10 && count_ta == 10 && count_ts == 10
        break
    end   
end


%array with the histograms of all test images
test_hist = [autotest_hist, deertest_hist, shipstest_hist];


%get histogram of a test image img and compare it to all stored histograms
%from the training phase using the Euclidian distance mesure and classify
%image accordingly. 


for n = 1 : 30
    
img_hist = test_hist(:,n);
distance = pdist2(img_hist',auto_hist(:, 1)');
samples = samples +1;

for i = 1 : 30
    
    da = pdist2(img_hist', auto_hist(:, i)');
    dd = pdist2(img_hist', deer_hist(:, i)');
    ds = pdist2(img_hist', ships_hist(:, i)');
    if (da <= distance)
        distance = da;
        class = 'automobile';
    elseif (dd <= distance)
        distance = dd;
        class = 'deer';
    elseif (ds <= distance)
        distance = ds;
        class = 'ship';
    end
end

if n <= 10 
    class_act = 'automobile';
    if strcmp(class_act, class) == 0
            auto_count = auto_count +1;
            wrong_classifications = wrong_classifications +1;         
    end
elseif n > 10 && n <= 20 
        class_act = 'deer';
        if strcmp(class_act, class) == 0
            deer_count = deer_count +1;
            wrong_classifications = wrong_classifications +1;
        end
elseif n > 20        
        class_act = 'ship';
        if strcmp(class_act, class) == 0
            ship_count = ship_count +1;
            wrong_classifications = wrong_classifications +1;
        end
end

fprintf('test image no. %d \n', n);
fprintf('smallest Euclidian distance: %f \n', distance);
C = ['image is classified as: ' class];
R = ['actual class of the image is: ' class_act];
disp(C)
disp(R)
disp('-------------------------------------------------------------')

end 

%Calculate the accuracy = number of correctly classified samples / total
%number of test samples 

fprintf('number of tested image samples %d \n', samples);
fprintf('correctly found %d automobiles, %d deer and %d ships. \n', (10-auto_count), (10-deer_count), (10-ship_count));
fprintf('wrong classifications %d \n', wrong_classifications);
fprintf('accuracy %f \n', ((samples-wrong_classifications)/samples));


