function[bandTrimap]=ExpandBand(mountainImage)

global M N P   %RGB图像(M*N*P)=(512*512*3)
%{0:bg, 1:fg, 2:probably-bg, 3:probably-fg}

%mountainImage  -n  -1  +1  +n

%构造窄带三分图
roi=(mountainImage<=1);
bandTrimap=ones(M,N);  %bg=0 
bandTrimap=uint8(bandTrimap);
bandTrimap(roi)=255;  %设置边界和前景=255 
roi=(mountainImage<-1);
bandTrimap(roi)=0;  %fg=1

% figure;
% imshow(bandTrimap);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%构造边界三分图(用于之后扩展成窄带)
trimap=zeros(M,N);
roi=(mountainImage>=-1 & mountainImage<=1);
trimap(roi)=255;  %设置边界为255    白

% figure;
% imshow(trimap);

%构造扩展的模板
K=3; %设置模板大小(=2K+1)
Model=ones(2*K+1,2*K+1);

%扩展边界三分图
expandTrimap=conv2(trimap,Model);  %卷积运算 尺寸变大
% trimap=zeros(M,N);
trimap=expandTrimap(K+1:M+K , K+1:M+K);  %恢复尺寸

%把扩展后的边界叠加到窄带三分图里
roi=(trimap>=200);  
bandTrimap(roi)=3;  %pfg=3


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%修正圆外区域为背景bg=0
r=min(M,N)/2;
[x,y]=meshgrid(-r+1:r);
circle=(x.^2 + y.^2) >= r^2;
% roi=find(circle>=1); 
roi=(circle>=1);
bandTrimap(roi)=0;  %bg=0


% 
% figure;
% imshow(bandTrimap,[]);
end