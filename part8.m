image = imread("testimage3.jpg");
new_image = LBP(image,8,2);
figure;
imshow(new_image);


function new_image = LBP(image,num,radius)
    image = rgb2gray(image);
    [n,m] = size(image);
    P = num;R = radius;
    clbp = zeros(n,m);
    for j = 1+R:n-R
        for i = 1+R:m-R
            count = 0;
            for k=0:P-1
                x = i + R*cos(2*pi*k/P);
                y = j + R*sin(2*pi*k/P);
                Lowx=floor(x);Highx=ceil(x);Lowy=floor(y);Highy=ceil(y);
                coex = x - Lowx;
                coey = y - Lowy;
                a = image(Lowy,Lowx) + coex*(image(Lowy,Highx)-image(Lowy,Lowx));
                b = image(Highy,Lowx) + coex*(image(Highy,Highx)-image(Highy,Lowx));
                pixel = a + coey*(b-a);
                if pixel>image(j,i)
                    count = count + 2^(P-1-k);
                end
            end
            lbp = dec2bin(count);
            mincount = count;
            for k = 1:P-1
                lbp = circshift(lbp',1)';
                count = bin2dec(lbp);
                if mincount>count
                    mincount = count;
                end
            end
            clbp(j,i) = mincount;
        end
    end
    new_image = uint8(clbp);
end