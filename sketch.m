function [] =  sketch(cmd)
    global pathX;
    global pathY;
    global imageFile;
    global image;
    global mask;
    global gradients;
    global figMask;
    global color;
    global sensitivity;
    global partialImage;
    global labels;
if nargin == 0
    cmd = 'init';
end
 
switch cmd
case 'init'
    rect = get(0,'ScreenSize');
    rect(3) = rect(3)/2;

    fig = figure('DoubleBuffer','on','back','off');
    info.ax = axes('XLim',[0 1],'YLim',[0 1]);
    image = imread(imageFile);
    if ndims(image) > 2
        image = rgb2gray(image);
    end
    partialImage(:,:,1) = image;
    partialImage(:,:,2) = image;
    partialImage(:,:,3) = image;
    [gradients, ~] = imgradient(image, 'prewitt');
    % Get the max gradient magnitude.
    gradients = gradients ./ max(max(gradients), [], 2);
    
    uicontrol('Style', 'slider',...
        'Min',1,'Max',255,'Value',30,...
        'Position', [100 80 220 20],...
        'Callback', @sliderCallback);

  
    imshow(image);
    set(fig,'OuterPosition',rect);



    %figMask = figure;
    %imshow(mask);
    rect(1) = rect(3);
    
    info.drawing = [];
    info.x = [];
    info.y = [];
    set(fig, 'KeyPressFcn', ...
    @(fig_obj , eventDat) keyPress(fig_obj, eventDat));
    set(fig,'UserData',info,...
            'WindowButtonDownFcn',[mfilename,' down'])
    pathX = []; pathY = [];
    mask = zeros(size(image,1), size(image,2));
    labels = zeros(size(image, 1), size(image, 2));
case 'down'
    myname = mfilename;
    fig = gcbf;
    info = get(fig,'UserData');
    curpos = get(info.ax,'CurrentPoint');
    info.x = curpos(1,1);
    info.y = curpos(1,2);
    info.drawing = line(info.x,info.y,'Color',color);
    
    set(fig,'UserData',info,...
            'WindowButtonMotionFcn',[myname,' move'],...
            'WindowButtonUpFcn',[myname,' up'])
   pathX = []; pathY = [];
case 'move'
    fig = gcbf;
    info = get(fig,'UserData');
    curpos = get(info.ax,'CurrentPoint');
    info.x = [info.x;curpos(1,1)];
    info.y = [info.y;curpos(1,2)];
    set(info.drawing,'XData',info.x,'YData',info.y)
    set(fig,'UserData',info)
    
case 'up'
    fig = gcbf;
    set(fig,'WindowButtonMotionFcn','',...
            'WindowButtonUpFcn','')
    info = get(fig, 'UserData');
    pathX = info.x;
    pathY = info.y;
    SpreadLine(uint32([pathY pathX]), sensitivity, 100);
    %blurred = FilterMask(mask);
    blurred = mask;
    %set(0,'CurrentFigure',figMask);
    %imshow(blurred);
    c = color.*255;
    redFinal = ...
        uint8(1 - blurred) .* uint8(partialImage(:,:,1)) + ... 
        uint8(blurred .* (c(1) * (double(image) ./ 255.0)));
    greenFinal = ...
        uint8(1 - blurred) .* uint8(partialImage(:,:,2)) + uint8(blurred .* (c(2) * (double(image) ./ 255.0)));
    blueFinal = ...
        uint8(1 - blurred) .* uint8(partialImage(:,:,3)) + uint8(blurred .* (c(3) * (double(image) ./ 255.0)));
    final(:,:,1) = redFinal;
    final(:,:,2) = greenFinal;
    final(:,:,3) = blueFinal;
    
    partialImage(:,:,:) = final(:,:,:);
    imshow(final);
    set(0,'CurrentFigure',fig)

    mask = zeros(size(image));
    %figure, imshowpair(image, mask, 'montage');
    % the labels have been generated, now to the coloring!
    %{
    SpreadLine([pathY pathX], 1000, hex2dec('FF0000'), shownImage);
    labels = tempLabels;
    figure, imshow(labels);
    disp 'Done!'
    %}
%    info = get(fig, 'UserData');
%    [info.x, info.y]
 
end
