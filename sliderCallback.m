 function sliderCallback(hObject, evt)
    global sensitivity;
    sensitivity =  double(get(hObject, 'Value')/255);
    %disp(sensitivity);
 end