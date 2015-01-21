function[outTrimap]=ExpandBand(U)

I=zeros(512,512);
I(U)=128;
imshow(I);
outTrimap=I;


end