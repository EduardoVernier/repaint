function [] =  sketch(cmd)
    global pathX;
    global pathY;
    global imageToRead;
    global shownImage;
if nargin == 0
    cmd = 'init';
end
 
switch cmd
case 'init'
    fig = figure('DoubleBuffer','on','back','off');
    info.ax = axes('XLim',[0 1],'YLim',[0 1]);
    shownImage = imread(imageToRead);
    imshow(shownImage);
    info.drawing = [];
    info.x = [];
    info.y = [];
    set(fig,'UserData',info,...
            'WindowButtonDownFcn',[mfilename,' down'])
    pathX = []; pathY = [];
    
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
    % the labels have been generated, now to the coloring!
    labels = SpreadLine([pathX pathY], 200, hex2dec('FF0000'), shownImage);
    disp 'Done!'
%    info = get(fig, 'UserData');
%    [info.x, info.y]
 
end