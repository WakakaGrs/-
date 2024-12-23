image = imread("testimage2.jpg");
image = rgb2gray(image);
image = im2double(image);

%添加高斯噪声，均值m，方差v
image_gaosi = imnoise(image,'gaussian',0.08);
%添加椒盐噪声，噪声密度d
image_jiaoyan = imnoise(image,'salt & pepper',0.1);
%添加泊松噪声
image_bosong = imnoise(image,'poisson');
%添加斑点噪声，方差为v
image_bandian = imnoise(image,'speckle',0.03);

%均值滤波
%3*3均值滤波
lvboqi = fspecial("average",3);
result1 = filter2(lvboqi,image_gaosi);
%7*7均值滤波
lvboqi = fspecial("average",7);
result2 = imfilter(image_gaosi,lvboqi,'conv');

%高斯滤波 标准差为0.6
result3 = imgaussfilt(image_gaosi,0.6,"FilterSize",7);

%中值滤波 5*5
result4 = medfilt2(image_jiaoyan,[5 5]);

%双边滤波 
%设置双边滤波窗口宽度w，空间邻域标准差sigma_s，灰度邻近标准差sigma_r
w=3; sigma_s=3; sigma_r=0.1;
result5 = imbilatfilt(image_gaosi,sigma_r,sigma_s,"NeighborhoodSize",w);

%理想低通滤波
image1 = imread("testimage2.jpg");
image1 = double(image1);
image1 = fftshift(fft2(image1));
[h,w] = size(image1);
g = zeros(h,w);
r1 = floor(w/2);
r2 = floor(h/2);
d0 = 11;
for x = 1:w
    for y = 1:h
        d = sqrt((x-r1)^2 + (y-r2)^2);
        if d <= d0
            h=1;
        else
            h=0;
        end
        g(y,x) = h * image1(y,x);
    end
end
g = real(ifft2(ifftshift(g)));