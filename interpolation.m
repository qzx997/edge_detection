clc;
clear all;
close all;

pic_choose = 3;
I = sprintf('Pic1_%d.bmp', pic_choose);
img_out = sprintf('Pic1_%d_10.bmp', pic_choose);
zmf = 10;   % magnification times

%% Image read
[I,M] = imread(I);

%%

[IH,IW,ID] = size(I);
ZIH = round(IH*zmf); %
ZIW = round(IW*zmf); % 
ZI = zeros(ZIH,ZIW,ID); % 

%%

IT = zeros(IH+2,IW+2,ID);
IT(2:IH+1,2:IW+1,:) = I;
IT(1,2:IW+1,:)=I(1,:,:);IT(IH+2,2:IW+1,:)=I(IH,:,:);
IT(2:IH+1,1,:)=I(:,1,:);IT(2:IH+1,IW+2,:)=I(:,IW,:);
IT(1,1,:) = I(1,1,:);IT(1,IW+2,:) = I(1,IW,:);
IT(IH+2,1,:) = I(IH,1,:);IT(IH+2,IW+2,:) = I(IH,IW,:);

%% 
for zj = 1:ZIW         % 对图像进行按列逐元素扫描
    for zi = 1:ZIH
        ii = (zi-1)/zmf; jj = (zj-1)/zmf;
        i = floor(ii); j = floor(jj); % 向下取整
        u = ii - i; v = jj - j;
        i = i + 1; j = j + 1;
        ZI(zi,zj,:) = (1-u)*(1-v)*IT(i,j,:) +(1-u)*v*IT(i,j+1,:)...
                    + u*(1-v)*IT(i+1,j,:) +u*v*IT(i+1,j+1,:);
    end
end
ZI = uint8(ZI);

%% 

figure
subplot(1,2,1)
imshow(I,M);
axis on
title(['Origin Image（SIZE： ',num2str(IH),'*',num2str(IW),'*',num2str(ID),')']);

subplot(1,2,2)
imshow(ZI,M);
axis on
title(['Output Image（SIZE： ',num2str(ZIH),'*',num2str(ZIW),'*',num2str(ID)',')']);

imwrite(ZI, img_out);

