img = imread("testimage2.jpg");
img = double(img);
[ROW,COL] = size(img);
new_img = zeros(ROW,COL);

%定义robert算子
roberts_x = [1,0;0,-1];
roberts_y = [0,-1;1,0];
for i = 1:ROW - 1
    for j = 1:COL - 1
        funBox = img(i:i+1,j:j+1);
        G_x = roberts_x .* funBox;
        G_x = abs(sum(G_x(:)));
        G_y = roberts_y .* funBox;
        G_y = abs(sum(G_y(:)));
        roberts_xy  = G_x * 0.5 + G_y * 0.5;
        new_img(i,j) = roberts_xy;
    end
end
new_img = new_img/255;

%定义sobel算子
sobel_x = [-1,0,1;-2,0,2;-1,0,1];
sobel_y = [-1,-2,-1;0,0,0;1,2,1];
for i = 1:ROW - 2
    for j = 1:COL - 2
        funBox = img(i:i+2,j:j+2);
        G_x = sobel_x .* funBox;
        G_x = abs(sum(G_x(:)));
        G_y = sobel_y .* funBox;
        G_y = abs(sum(G_y(:)));
        sobelxy  = G_x * 0.5 + G_y * 0.5;
        new_img(i+1,j+1) = sobelxy;
    end
end
new_img = new_img/255;

%定义Prewitt算子
prewitt_x = [-1,0,1;-1,0,1;-1,0,1];
prewitt_y = [-1,-1,-1;0,0,0;1,1,1];
for i = 1:ROW - 2
    for j = 1:COL - 2
        funBox = img(i:i+2,j:j+2);
        G_x = prewitt_x .* funBox;
        G_x = abs(sum(G_x(:)));
        G_y = prewitt_y .* funBox;
        G_y = abs(sum(G_y(:)));
        sobelxy  = G_x * 0.5 + G_y * 0.5;
        new_img(i+1,j+1) = sobelxy;
    end
end
new_img = new_img/255;

% 定义laplace算子
laplace = [0,1,0;1,-4,1;0,1,0];
for i = 1:ROW - 2
    for j = 1:COL - 2
        funBox = img(i:i+2,j:j+2);
        G = laplace .* funBox;
        G = abs(sum(G(:)));
        new_img(i+1,j+1) = G;
    end
end
new_img = new_img/255;