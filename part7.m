image = imread("testimage4.jpg");
new_image = fourtree(image);
figure;
imshow(new_image);



%基于OTSU的阈值分割
function new_image = OTSU(image)
    image = rgb2gray(image);
    T = graythresh(image);
    new_image = imbinarize(image,T);
end

%基于kmeans的区域分割，输入k的值
function new_image = kjunzhi(image,k)
    hsv = rgb2hsv(image);
    h = hsv(:,:,1);
    h(h>330/360) = 0;
    training = h(:);
    startdata = linspace(0,1,k);
    startdata = startdata(:);
    IDX = kmeans(training,k,'Start',startdata);
    idbw = (IDX==1);
    new_image = reshape(idbw,size(h));
end






%基于边界的四叉树分解
function new_image = fourtree(image)
    S = qtdecomp(image,0.27);
    blocks = repmat(uint8(0),size(S));
    for dim = [256 128 64 32 16 8 4 2 1]
        numblocks = length(find(S==dim));
        if(numblocks>0)
            values = repmat(uint8(1),[dim dim numblocks]);
            values(2:dim,2:dim,:)=0;
            blocks = qtsetblk(blocks,S,dim,values);
        end
    end
    blocks(end,1:end)=1;
    blocks(1:end,end)=1;
end