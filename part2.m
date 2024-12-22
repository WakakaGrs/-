function newimage = linear(app, image, x)
    x = pi*x/180;
    image = im2double(image);
    newimage = image * tan(x);
    newimage = min(255,newimage);
    newimage = max(0,newimage);
    newimage = im2uint8(newimage);
end

function newimage = nonlinearlog(app, image, c)
    image = double(image);
    newimage = (log(image + 1)) * c;
    newimage = min(255,newimage);
    newimage = max(0,newimage);
    newimage = uint8(newimage);
end

function newimage = nonlinearexp(app, image, a, b, c)
    image = double(image);
    newimage = power(b,(c * (image - a))) - 1;
    newimage = min(255,newimage);
    newimage = max(0,newimage);
    newimage = uint8(newimage);
end