function [filledImage] = FillOutOfCircle(originImage)

global M N P  %RGB图像(M*N*P)=(512*512*3)

% 填充圆形外围区域为白色/灰色
% I=imread('1.jpg');
filledImage=originImage;
[M,N]=size(filledImage);
r=min(M,N)/2;
[x,y]=meshgrid(-r+1:r);
circle=(x.^2 + y.^2) >= r^2;
% roi=find(circle>=1); 
roi=(circle>=1);
filledImage(roi)=255;  %填充白色
% imshow(I);
end