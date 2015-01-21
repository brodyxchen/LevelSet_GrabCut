function [outI] = FillOutOfCircle(inI)

global M N P  %RGB图像(M*N*P)=(512*512*3)

% 填充圆形外围区域为白色/灰色
% I=imread('1.jpg');
I=inI(:,:,1);
[M,N]=size(I);
r=min(M,N)/2;
[x,y]=meshgrid(-r+1:r);
circle=(x.^2 + y.^2) >= r^2;
% roi=find(circle>=1); 
roi=(circle>=1);
I(roi)=128;
% imshow(I);
outI=I;
end