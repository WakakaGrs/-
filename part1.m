image = imread("testimage.png");
image = rgb2gray(image);
image2 = imread("testimage2.jpg");
image2 = rgb2gray(image2);

data = imhist(image);
data1 = zeros(256,1);
newimage = histeq(image,256);
newimage2 = histeq(image,imhist(image2));

subplot(221),title("1"),imshow(image);
subplot(222),title("1"),imshow(image2);
subplot(223),title("1"),imshow(newimage);
subplot(224),title("1"),imshow(newimage2);

function histo = gethistogram(app, image)
    histo = zeros(256,1);
    [h,w] = size(image);
    for x = 1:h
        for y = 1:w
            histo(image(x,y)+1) = histo(image(x,y)+1) + 1;
        end
    end
end

function newimage = equalization(app, image)
    histo = imhist(image);
    [h,w] = size(image);
    newimage = zeros(h,w);
    s = zeros(256,1);
    s(1) = histo(1);
    for t = 2:256
        s(t) = s(t-1) + histo(t);
    end
    for x = 1:h
        for y = 1:w
            newimage(x,y) = s(image(x,y)+1) / (h*w);
        end
    end
    newimage = im2uint8(newimage);
end

function newimage = match(app, image1,image2)
    histo = imhist(image2);
    newimage = histeq(image1,histo);
end