function [] =  sketch(cmd)
    global pathX;
    global pathY;
    global imageFile;
    global image;
    global mask;
    global gradients;
    global figMask;
    
if nargin == 0
    cmd = 'init';
end
 
switch cmd
case 'init'
    
    fig = figure('DoubleBuffer','on','back','off');
    info.ax = axes('XLim',[0 1],'YLim',[0 1]);
    image = imread(imageFile);
    if ndims(image) > 2
        image = rgb2gray(image);
    end
    [gradients, ~] = imgradient(image, 'prewitt');
    % Get the max gradient magnitude.
    gradients = gradients ./ max(max(gradients), [], 2);

    
    imshow(image);
    figMask = figure;
    imshow(mask);
    
    info.drawing = [];
    info.x = [];
    info.y = [];
    set(fig,'UserData',info,...
            'WindowButtonDownFcn',[mfilename,' down'])
    pathX = []; pathY = [];
    mask = zeros(size(image,1), size(image,2));
case 'down'
    myname = mfilename;
    fig = gcbf;
    info = get(fig,'UserData');
    curpos = get(info.ax,'CurrentPoint');
    info.x = curpos(1,1);
    info.y = curpos(1,2);
    info.drawing = line(info.x,info.y,'Color','r');
    
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
    SpreadLine(uint32([pathY pathX]), 0.15, 110);
    set(0,'CurrentFigure',figMask);
    imshow(mask);
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