function[]=LevelSet_GrabCut()

%addpath('C:\mexopencv-master')

%{0:bg, 1:fg, 2:probably-bg, 3:probably-fg}

global M N P  %RGBÍ¼Ïñ(M*N*P)=(512*512*3)

originImage=imread('CT000167.jpg');
[M,N,P]=size(originImage);
originImage=originImage(:,:,1);  %»Ò¶ÈÍ¼
filledImage=FillOutOfCircle(originImage);
mountainImage=LevelSet2(filledImage);  %LevelSet(filledImage) %LevelSet2(filledImage)

bandTrimap=ExpandBand(mountainImage);

resultImage=GrayGrabCut(filledImage, bandTrimap);

figure;
imshow(resultImage);
end