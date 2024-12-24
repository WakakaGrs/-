image = imread("testimage2.jpg");
result = suofang(image,2,3);
figure;
imshow(result);



function new_image = suofang(image,kx,ky)
    [h,w,d] = size(image);
    new_h = round(h*kx);
    new_w = round(w*ky);
    new_image = zeros(new_h,new_w,d);
    %缩放坐标变换
    for new_x = 1:new_h
        for new_y = 1:new_w
            for new_d = 1:d
                ini_x = new_x / kx;
                ini_y = new_y / ky;
                x = floor(ini_x);
                y = floor(ini_y);
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
                new_image(new_x,new_y,new_d) = b1 + a * (b2 - b1);
            end
        end
    end
    new_image = uint8(new_image);
end