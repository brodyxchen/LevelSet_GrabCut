function[outTrimap]=GrabCut(Img,inTrimap)
%addpath('C:\mexopencv-master')

global M N P  %RGBÍ¼Ïñ(M*N*P)=(512*512*3)

%{0:bg, 1:fg, 2:probably-bg, 3:probably-fg}

I=uint8(Img);
outTrimap=cv.grabCut(I,inTrimap);
imshow(outTrimap,[]);

end