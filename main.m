%{
GLOBAL_COLOR = 0;
global labels;
parfor i=1:2
    if (i==1)
        color = uisetcolor;
        GLOBAL_COLOR = color;
    else
        sketch('init', GLOBAL_COLOR);
    end
end

%}
global pathX;
global pathY;
global imageToRead;
global shownImage;
global labels;
imageToRead = 'images/planes2.jpg';
sketch 'init'