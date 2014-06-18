function keyPress(~, eventDat)
    global color;
    key = eventDat.Key;
    disp(key);
    
    if (key == 'c')
        color = uisetcolor;
    end
end