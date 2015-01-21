function[]=LevelSet_GrabCut()

Img=imread('1.jpg');
I=FillOutOfCircle(Img);
U=LevelSet(I);



% trimap=ExpandBand(U);
% 
% 
% % GrabCut
% rgb(:,:,1)=I;
% rgb(:,:,2)=I;
% rgb(:,:,3)=I;
% outTrimap=GrabCut(rgb, trimap);
% 
% roi=(outTrimap==0 | outTrimap==2);  %»°bg/pbgŒª÷√
% Img(roi)=255;
% imshow(Img);
end