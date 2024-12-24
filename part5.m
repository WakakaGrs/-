image = imread("testimage2.jpg");
image_gaosi = addnoise_gaussian(image,0.1,0.05);
new_image = ILPF(image_gaosi,68);
figure;
imshow(image_gaosi);
figure;
imshow(new_image);


%添加高斯噪声，均值m，方差v,默认0、0.01
function new_image = addnoise_gaussian(image,m,v)
    image = rgb2gray(image);
    image = im2double(image);
    new_image = imnoise(image,'gaussian',m,v);
    new_image = im2uint8(new_image);
end

%添加椒盐噪声，噪声密度d，默认0.05
function new_image = addnoise_salt(image,d)
    image = rgb2gray(image);
    image = im2double(image);
    new_image = imnoise(image,'salt & pepper',d);
    new_image = im2uint8(new_image);
end

%添加泊松噪声
function new_image = addnoise_poisson(image)
    image = rgb2gray(image);
    image = im2double(image);
    new_image = imnoise(image,'poisson');
    new_image = im2uint8(new_image);
end

%添加斑点噪声，方差为v，默认0.04
function new_image = addnoise_speckle(image,v)
    image = rgb2gray(image);
    image = im2double(image);
    new_image = imnoise(image,'speckle',v);
    new_image = im2uint8(new_image);
end




%均值滤波
function new_image = avergeF(image,matri)
    new_image = double(image);
    [h,w] = size(image);
    x = (matri-1)/2;
    for i = x+1:w-x
        for j = x+1:h-x
            box = image(j-x:j+x,i-x:i+x);
            f = sum(box(:));
            f = f / (matri*matri);
            new_image(j,i) = f;
        end
    end
    new_image = uint8(new_image);
end


%高斯滤波 标准差为0.6
function new_image = gaussianF(image,v,matri)
    new_image = imgaussfilt(image,v,"FilterSize",matri);
end


%中值滤波 5*5
function new_image = midF(image,matri)
    new_image = medfilt2(image,[matri matri]);
end


%双边滤波 
%设置双边滤波窗口宽度w，空间邻域标准差sigma_s，灰度邻近标准差sigma_r
function new_image = doubleF(image,matri,sigma_s,sigma_r)
    new_image = imbilatfilt(image,sigma_r,sigma_s,"NeighborhoodSize",matri);
end


%理想低通滤波
function new_image = ILPF(image,d0)
    image = fftshift(fft2(double(image)));
    [h,w] = size(image);
    new_image = zeros(h,w);
    r1 = floor(w/2);
    r2 = floor(h/2);
    for x = 1:w
        for y = 1:h
            d = sqrt((x-r1)^2+(y-r2)^2);
            if d <= d0
                H=1;
            else
                H=0;
            end
            new_image(y,x) = H * image(y,x);
        end
    end
    new_image = real(ifft2(ifftshift(new_image)));
    new_image = uint8(new_image);
end