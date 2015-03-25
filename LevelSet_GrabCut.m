function[]=LevelSet_GrabCut()

%addpath('C:\mexopencv-master')

%{0:bg, 1:fg, 2:probably-bg, 3:probably-fg}

global M N P  %RGBÕºœÒ(M*N*P)=(512*512*3)

originImage=imread('CT000167.jpg');
[M,N,P]=size(originImage);
originImage=originImage(:,:,1);  %ª“∂»Õº


%BFS
image=originImage;
pointR1=256;
pointC1=130;
pointR2=256;
pointC2=350;
diff= 16;
mask = BFS(image, pointR1,pointC1, pointR2, pointC2, diff);

% Morphology
LSF=Morphology(mask);



% ÃÓ≥‰‘≤Õ‚«¯”Ú
filledImage=FillOutOfCircle(originImage);

% LevelSet
mountainImage=LevelSet2(filledImage, LSF);  %LevelSet(filledImage) %LevelSet2(filledImage)


% ’≠¥¯
bandTrimap=ExpandBand(mountainImage);

% grayCut
resultImage=GrayGrabCut(filledImage, bandTrimap);



figure;
imshow(resultImage);
end