function[outTrimap]=GrabCut(Img,inTrimap)
%addpath('C:\mexopencv-master')

I=uint8(Img);
outTrimap=cv.grabCut(I,inTrimap);
imshow(outTrimap,[]);

end