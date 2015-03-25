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
pointC2=390;
diff= 16;

disp('BFS-time=');
tic;
mask = BFS(image, pointR1,pointC1, pointR2, pointC2, diff);
toc;

% show mask
mask2=255*ones(M,N);
roi=mask==1;
mask2(roi)=0;
figure;
imshow(mask2);title('mask2')

% Morphology
disp('Morphology-time=');
tic;
LSF=Morphology(mask);
toc;


% ÃÓ≥‰‘≤Õ‚«¯”Ú
filledImage=FillOutOfCircle(originImage);

% LevelSet
mountainImage=LevelSet2(filledImage, LSF);  %LevelSet(filledImage) %LevelSet2(filledImage)


% ’≠¥¯
bandTrimap=ExpandBand(mountainImage);

% grayCut
resultImage=GrayGrabCut(filledImage, bandTrimap);



figure;
imshow(resultImage);title('resultImage')
end