function[resultImage]=GrayGrabCut(originImage, bandTrimap);
%addpath('C:\mexopencv-master')

global M N P  %RGBÍ¼Ïñ(M*N*P)=(512*512*3)

%{0:bg, 1:fg, 2:probably-bg, 3:probably-fg}

rgb(:,:,1)=originImage;
rgb(:,:,2)=originImage;
rgb(:,:,3)=originImage;
rgb=uint8(rgb);
trimap=cv.grabCut(rgb, bandTrimap);

roi=(trimap==1 | trimap==3);  %È¡fg/pfgÎ»ÖÃ

resultImage=originImage;
resultImage(roi)=255;

end