image = imread("testimage2.jpg");
result = edgextract_roberts(image);
figure;
imshow(result);


function new_image = edgextract_roberts(image)
    image = rgb2gray(image);
    image = double(image);
    [h,w] = size(image);
    new_image = uint8(zeros(h,w));
    H_x = [1,0;0,-1];
    H_y = [0,-1;1,0];
    for i = 1:w-1
        for j = 1:h-1
            box = image(j:j+1,i:i+1);
            f_x = H_x .* box;
            f_x = sum(f_x(:));
            f_y = H_y .* box;
            f_y = sum(f_y(:));
            new_image(j,i) = abs(f_x) + abs(f_y);
        end
    end
end


function new_image = edgextract_sobel(image)
    image = rgb2gray(image);
    image = double(image);
    [h,w] = size(image);
    new_image = uint8(zeros(h,w));
    H_x = [-1,0,1;-2,0,2;-1,0,1];
    H_y = [-1,-2,-1;0,0,0;1,2,1];
    for i = 2:w-1
        for j = 2:h-1
            box = image(j-1:j+1,i-1:i+1);
            f_x = H_x .* box;
            f_x = sum(f_x(:));
            f_y = H_y .* box;
            f_y = sum(f_y(:));
            new_image(j,i) = abs(f_x) + abs(f_y);
        end
    end
end


function new_image = edgextract_prewitt(image)
    image = rgb2gray(image);
    image = double(image);
    [h,w] = size(image);
    new_image = uint8(zeros(h,w));
    H_x = [-1,0,1;-1,0,1;-1,0,1];
    H_y = [-1,-1,-1;0,0,0;1,1,1];
    for i = 2:w-1
        for j = 2:h-1
            box = image(j-1:j+1,i-1:i+1);
            f_x = H_x .* box;
            f_x = sum(f_x(:));
            f_y = H_y .* box;
            f_y = sum(f_y(:));
            new_image(j,i) = abs(f_x) + abs(f_y);
        end
    end
end


function new_image = edgextract_laplace(image)
    image = rgb2gray(image);
    image = double(image);
    [h,w] = size(image);
    new_image = uint8(zeros(h,w));
    H = [0,1,0;1,-4,1;0,1,0];
    for i = 2:w-1
        for j = 2:h-1
            box = image(j-1:j+1,i-1:i+1);
            f = H .* box;
            f = sum(f(:));
            %运算产生负值，可abs(f)，可f + x产生浮雕效果
            new_image(j,i) = abs(f);
        end
    end
end