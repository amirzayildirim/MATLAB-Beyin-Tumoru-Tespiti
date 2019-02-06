resim=imread('img2.jpg');

resim_gray=rgb2gray(resim);
[sutun kolon]=size(resim_gray);


b=zeros(sutun,kolon);

hp_fil=[-1 2 -1;0 0 0;1 -2 1];
b=imfilter(resim_gray,hp_fil);

kolon=b+resim_gray+25;
medfilt2(kolon);

T = graythresh(kolon);
thresh = im2bw(kolon,T+0.3);

thresh5=watershed(thresh);

%morfolojik islemler
fs = get(0,'ScreenSize');
figure('Position',[0 0 fs(3)/2 fs(4)])
se = strel('disk',0);
 
thresh1 = imerode(thresh,se);
subplot(3,2,1);
imshow(thresh1);
            

se = strel('disk',0);
thresh1 = imdilate(thresh1,se);
subplot(3,2,2);
imshow(thresh1);

se2 = strel('disk',1);
thresh2 = imerode(thresh1,se2);
subplot(3,2,3);
imshow(thresh2)
             
se2 = strel('disk',1);
thresh2 = imdilate(thresh2,se2);
subplot(3,2,4);
imshow(thresh2)

se3 = strel('disk',6);
thresh3 = imerode(thresh2,se3);
subplot(3,2,5);
imshow(thresh3)
             
se3 = strel('disk',6);
thresh3 = imdilate(thresh3,se3);
subplot(3,2,6);
imshow(thresh3)


fs = get(0,'ScreenSize');
figure('Position',[round(fs(3)/2) 0 fs(3)/2 fs(4)])

[sutun2 kolon2]=size(thresh3);

for i=1:1:sutun2
    for j=1:1:kolon2
        if thresh3(i,j)==1
            resim_gray(i,j)=255;
        else
            resim_gray(i,j)=resim_gray(i,j)*0.5;
        end;
    end;
end;
subplot(2,1,1);
imshow(resim);
subplot(2,1,2);
imshow(resim_gray);

