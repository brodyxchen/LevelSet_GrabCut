% This Matlab file demomstrates the level set method in Li et al's paper
%    "Level Set Evolution Without Re-initialization: A New Variational Formulation"
%    in Proceedings of CVPR'05, vol. 1, pp. 430-436.
% Author: Chunming Li, all rights reserved.
% E-mail: li_chunming@hotmail.com
% URL:  http://www.engr.uconn.edu/~cmli/
function uuu = Demo3()
clear all;
close all;
Img = imread('aa.bmp');  % synthetic noisy image
Img=double(Img(:,:,1)); %取第一层图像（RGB中的R，或者Gray中的Gray），并转换成double矩阵
sigma=1.5;    % scale parameter in Gaussian kernel for smoothing
G=fspecial('gaussian',15,sigma);
Img_smooth=conv2(Img,G,'same');  % smooth image by Gaussiin convolution
[Ix,Iy]=gradient(Img_smooth);
f=Ix.^2+Iy.^2;  %梯度模的平方

g=1./(1+f);  %公式[5.1] edge indicator function. %梯度倒数矩阵，梯度越大，值越小



timestep=200;  % time step
%[4]
mu=0.2/timestep;  %[4]中mu% coefficient of the internal (penalizing) energy term P(\phi) % Note: the product timestep*mu must be less than 0.25 for stability!
%[6]
lambda=5; %[6]中lambda % coefficient of the weighted length term Lg(\phi)
alf=-3;   %[6]中alf（v） %+收缩，-扩散 % coefficient of the weighted area term Ag(\phi); % Note: Choose a positive(negative) alf if the initial contour is outside(inside) the object.
%[11]
epsilon=1.5; %[11]中epsilon % the papramater in the definition of smoothed Dirac function


% define initial level set function (LSF) as -c0, 0, c0 at points outside, on
% the boundary, and inside of a region R, respectively.
[nrow, ncol]=size(Img);  

c0=4;
initialLSF=c0*ones(nrow,ncol);
w=8;%初始的闭合动态曲线位置（距边界位置）
initialLSF(400:450, 150:200)=0;
initialLSF(401:449, 151:199)=-c0;
% initialLSF(w+1:end-w, w+1:end-w)=0;  % zero level set is on the boundary of R. 
                                     % Note: this can be commented out. The intial LSF does NOT necessarily need a zero level set.
                                     
% initialLSF(w+2:end-w-1, w+2: end-w-1)=-c0; % negative constant -c0 inside of R, postive constant c0 outside of R.
% img = [7,8]  % 建立初始的水平集闭合曲线(下图中的0，内部-c0=-4，外部c0=4)
%           4  4  4  4  4  4  4  4
%           4  0  0  0  0  0  0  4
%           4  0 -4 -4 -4 -4  0  4
%   LSF =   4  0 -4 -4 -4 -4  0  4
%           4  0 -4 -4 -4 -4  0  4
%           4  0  0  0  0  0  0  4
%           4  4  4  4  4  4  4  4

u=initialLSF;
figure;imagesc(Img, [0, 255]);colormap(gray);hold on;%hold on 新绘制会叠加到原本图像上
[c,h] = contour(u,[0 0],'r');                          
title('Initial contour');


% start level set evolution
for n=1:1000
    u=EVOLUTION(u, g ,lambda, mu, alf, epsilon, timestep, 1);      
    if mod(n,20)==0     %每20次迭代绘制一次图像
        pause(0.001);
%         imshow(u,[]); %%%%%%%%%%
        imagesc(Img, [0, 255]);colormap(gray);hold on;
        [c,h] = contour(u,[0 0],'r'); 
        iterNum=[num2str(n), ' iterations'];        
        title(iterNum);
        hold off;   %新绘制会覆盖原本图像 
    end
end
imagesc(Img, [0, 255]);colormap(gray);hold on;%hold on 新绘制会叠加到原本图像上
[c,h] = contour(u,[0 0],'r'); 
totalIterNum=[num2str(n), ' iterations'];  
title(['Final contour, ', totalIterNum]);
uuu=u;


function u = EVOLUTION(u0,           g,            lambda,   mu,   alf,  epsilon,  delt,  numIter)
%            EVOLUTION(曲线矩阵，  边缘检测矩阵，    5，   0.04，  3，    1.5，     5，     1   )
%
%  EVOLUTION(u0, g, lambda, mu, alf, epsilon, delt, numIter) updates the level set function 
%  according to the level set evolution equation in Chunming Li et al's paper: 
%      "Level Set Evolution Without Reinitialization: A New Variational Formulation"
%       in Proceedings CVPR'2005, 
%  Usage:
%   u0: level set function to be updated
%   g: edge indicator function
%   lambda: coefficient of the weighted length term L(\phi)
%   mu: coefficient of the internal (penalizing) energy term P(\phi)
%   alf: coefficient of the weighted area term A(\phi), choose smaller alf 
%   epsilon: the papramater in the definition of smooth Dirac function, default value 1.5
%   delt: time step of iteration, see the paper for the selection of time step and mu 
%   numIter: number of iterations. 
%
% Author: Chunming Li, all rights reserved.
% e-mail: li_chunming@hotmail.com
% http://vuiis.vanderbilt.edu/~licm/

% [mr,mc] = size(g);
% disp(mr);
% disp(mc);

u=u0;
[vx,vy]=gradient(g);
 
% 公式[12]
for k=1:numIter

    u=NeumannBoundCond(u);%处理边界，防止遇到边界出现问题

    [ux,uy]=gradient(u); 

    normDu=sqrt(ux.^2 + uy.^2 + 1e-10);    % 曲线u的梯度模
    Nx=ux./normDu;
    Ny=uy./normDu;

    diracU=Dirac(u,epsilon); %公式[11]

    K=curvature_central(Nx,Ny);   %[7]中的div(u), k=div散度=Nxx+Nyy >0 表示向外冒水的源点，<0 表示吸收水的汇点

    weightedLengthTerm=lambda*diracU.*(vx.*Nx + vy.*Ny + g.*K);   %==公式[7]

    penalizingTerm=mu*(4*del2(u)-K);

    weightedAreaTerm=alf.*diracU.*g;

    %公式[10][13]
    u=u+delt*(weightedLengthTerm + weightedAreaTerm + penalizingTerm);  % update the level set function
    %=u+delt*L（[13]的L）

end

% the following functions are called by the main function EVOLUTION
% x 是矩阵，sigma是数，f是矩阵
function f = Dirac(x, sigma)        %公式[11] 狄拉克函数(冲击函数)：只处理一定数据范围内的数据
f=(1/2/sigma)*(1+cos(pi*x/sigma));
b = (x>=-sigma) & (x<=sigma);   % b 是bool 矩阵  判断矩阵x中每个元素是不是在（-sigma,sigma）范围内
f = f.*b;   %把f中 在矩阵b中位置=false 的数据清0


% nx 是矩阵  ny 是矩阵
function K = curvature_central(nx,ny) %曲率中心
[nxx,junk]=gradient(nx);  
[junk,nyy]=gradient(ny);
K=nxx+nyy;

% f 是矩阵  g 是矩阵
function g = NeumannBoundCond(f)
% Make a function satisfy Neumann boundary condition 边界处理
[nrow,ncol] = size(f);
g = f;
% g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);  
% g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);          
% g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);     
g([1 nrow],[1 ncol]) = g([30 nrow-29],[30 ncol-29]);  
g([1 nrow],2:end-1) = g([30 nrow-29],2:end-1);          
g(2:end-1,[1 ncol]) = g(2:end-1,[30 ncol-29]);   

