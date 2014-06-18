function keyPress(~, eventDat)
    global color;
    key = eventDat.Key;
    disp(key);
    
    if (key == 'c')
        color = uisetcolor;
    else
        if (key == 's')
            % call the sensibility slider
        end
    end
end