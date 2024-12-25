img = imread("testimage3.jpg");

hog_image= HOG(img, 8);

figure;
imshow(hog_image, []);

function new_image = HOG(image, cell_size)
    image = rgb2gray(image);
    image = double(image);
    [Gx, Gy] = imgradientxy(image);
    [mag, ang] = imgradient(Gx, Gy);
    [height, width] = size(image);
    num_cells_x = floor(width / cell_size);
    num_cells_y = floor(height / cell_size);
    new_image = zeros(height, width);
    for i = 1:num_cells_y
        for j = 1:num_cells_x
            cell_x_start = (j-1) * cell_size + 1;
            cell_x_end = j * cell_size;
            cell_y_start = (i-1) * cell_size + 1;
            cell_y_end = i * cell_size;
            cell_mag = mag(cell_y_start:cell_y_end, cell_x_start:cell_x_end);
            cell_ang = ang(cell_y_start:cell_y_end, cell_x_start:cell_x_end);
            for x = 1:cell_size
                for y = 1:cell_size
                    angle = cell_ang(y, x);
                    magnitude = cell_mag(y, x);
                    new_image(cell_y_start + y - 1, cell_x_start + x - 1) = magnitude;
                end
            end
        end
    end
    new_image = uint8(new_image);
end