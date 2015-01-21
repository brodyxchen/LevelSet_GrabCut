function[outTrimap]=ExpandBand(U)

global M N P   %RGBÍ¼Ïñ(M*N*P)=(512*512*3)
%{0:bg, 1:fg, 2:probably-bg, 3:probably-fg}
roi=(U<=1);
I=zeros(M,N);
I=uint8(I);
I(roi)=255;
roi=(U<-1);
I(roi)=1;


figure;
imshow(I);

I2=zeros(M,N);
roi=(U>=-1 & U<=1);
I2(roi)=255;


figure;
imshow(I2);

Model=[
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
    ]

I3=conv2(I2,Model);


figure;
imshow(I3);
 I3=uint8(I3);
whos I3
 I=uint8(I);
roi=(I3>=200);
I(roi)=3;
whos I

outTrimap=I;



end