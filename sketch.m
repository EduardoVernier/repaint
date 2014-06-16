function sketch(cmd)

if nargin == 0
    cmd = 'init';
end
 
switch cmd
case 'init'
    fig = figure('DoubleBuffer','on','back','off');
    info.ax = axes('XLim',[0 1],'YLim',[0 1]);
    imshow(imread('planes2.jpg'));
    info.drawing = [];
    info.x = [];
    info.y = [];
    set(fig,'UserData',info,...
            'WindowButtonDownFcn',[mfilename,' down'])
   
case 'down'
    myname = mfilename;
    fig = gcbf;
    info = get(fig,'UserData');
    curpos = get(info.ax,'CurrentPoint');
    info.x = curpos(1,1);
    info.y = curpos(1,2);
    info.drawing = line(info.x,info.y,'Color',xp.value);
    set(fig,'UserData',info,...
            'WindowButtonMotionFcn',[myname,' move'],...
            'WindowButtonUpFcn',[myname,' up'])
    [info.x, info.y]
case 'move'
    fig = gcbf;
    info = get(fig,'UserData');
    curpos = get(info.ax,'CurrentPoint');
    info.x = [info.x;curpos(1,1)];
    info.y = [info.y;curpos(1,2)];
    set(info.drawing,'XData',info.x,'YData',info.y)
    set(fig,'UserData',info)
    [info.x, info.y]
 
case 'up'
    fig = gcbf;
    set(fig,'WindowButtonMotionFcn','',...
            'WindowButtonUpFcn','')
%    info = get(fig, 'UserData');
%    [info.x, info.y]
 
end