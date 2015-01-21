function[]=LevelSet_GrabCut()

global M N P  %RGBÍ¼Ïñ(M*N*P)=(512*512*3)

Img=imread('1.jpg');
[M,N,P]=size(Img);
I=FillOutOfCircle(Img);
U=LevelSet(I);


trimap=ExpandBand(U);

% 
% 
% % GrabCut
% rgb(:,:,1)=I;
% rgb(:,:,2)=I;
% rgb(:,:,3)=I;
% outTrimap=GrabCut(rgb, trimap);
% 
% roi=(outTrimap==0 |/|| outTrimap==2);  %È¡bg/pbgÎ»ÖÃ
% Img(roi)=255;
% imshow(Img);
end