function testcode
%addpath('C:\mexopencv-master')
I=imread('img.jpg');
I=uint8(I);
rect=[35 33 278 239];

outI=cv.grabCut(I,rect);
imshow(outI,[]);

end