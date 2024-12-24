image = imread("testimage2.jpg");
result = xuanzhuan(image,90);
figure;
imshow(result);

function new_image = xuanzhuan(image,degree)
    [h,w,d] = size(image);
    %计算旋转后的图像大小
    x1 = (w-1)*cosd(degree);
    x2 = (h-1)*sind(degree);
    x3 = x1+x2;
    y1 = (1-w)*sind(degree);
    y2 = (h-1)*cosd(degree);
    y3 = y1+y2;
    minx = min(0,min(x1,min(x2,x3)));
    miny = min(0,min(y1,min(y2,y3)));
    new_h = max(0,max(y1,max(y2,y3))) - miny + 1;
    new_w = max(0,max(x1,max(x2,x3))) - minx + 1;
    new_h = round(new_h);
    new_w = round(new_w);
    new_image = zeros(new_h,new_w,d);
    %旋转坐标变换
    for new_x = 1:new_w
        for new_y = 1:new_h
            for new_d = 1:d
                ini_x = (new_x-1 + minx)*cosd(degree) - (new_y-1 + miny)*sind(degree);
                ini_y = (new_x-1 + minx)*sind(degree) + (new_y-1 + miny)*cosd(degree);
                %交换坐标轴
                ini_x = ini_x + ini_y;
                ini_y = ini_x - ini_y;
                ini_x = ini_x - ini_y;
                %变换到f(x+a,x+b)
                x = floor(ini_x)+1;
                y = floor(ini_y)+1;
                a = ini_x - x;
                b = ini_y - y;
                %超出边界取边界
                x = max(1,x);
                y = max(1,y);
                x = min(h-1,x);
                y = min(w-1,y);
                %双线性插值
                a1 = image(x,y,new_d);
                a2 = image(x,y+1,new_d);
                a3 = image(x+1,y,new_d);
                a4 = image(x+1,y+1,new_d);
                b1 = a1 + b * (a2 - a1);
                b2 = a3 + b * (a4 - a3);
                new_image(new_y,new_x,new_d) = b1 + a * (b2 - b1);
            end
        end
    end
    new_image = uint8(new_image);
end