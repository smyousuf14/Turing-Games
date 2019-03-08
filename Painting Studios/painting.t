% Allows the user to paint with a variety of colours 
% and create images 

import GUI

% Declaration Section
const DELAY_1 := 1000
const BUTTON_WIDTH := 50
var b : int
var buttonExit : int
var buttonX : int
var buttonY : int
var font1 : int
var font2 : int
var font3 : int
var font4 : int
var randomColour : int
var key : array char of boolean
var text : string
var x : int
var y : int

procedure drawExitButton 
    x := maxx div 16
    y := maxy div 1.1
    text := "EXIT"
    buttonExit := GUI.CreateButton (x, y ,BUTTON_WIDTH, text, GUI.Quit)
end drawExitButton
    
% Inizialization Section
setscreen ("graphics: max; max")
randint (randomColour, 1, 255)
font1 := Font.New("ravie:15")
font2 := Font.New ("ravie:15")
font3 := Font.New ("ravie:15")
font4 := Font.New ("ravie:15")

% Input Section

% Displays text
Font.Draw ("Use mouse to draw,", maxx div 2, maxy div 1.5,font1, brightred)
Font.Draw ("c is for clear ", maxx div 2, maxy div 1.6, font2, blue)
Font.Draw ("r to change colour", maxx div 2, maxy div 1.7, font3, black)
Font.Draw ("Press enter to continue", maxx div 2, maxy div 1.8, font4, magenta)
loop
Input.KeyDown (key)
if  key (KEY_ENTER) then

cls

end if
exit when key (KEY_ENTER)
end loop

% Main program
loop
    View.Set ("offscreenonly")
    drawExitButton
    View.Update
    
    Input.KeyDown (key)
    if key ('c') then

	cls

    end if
    Input.KeyDown (key)
    if key ('r') then
	randint (randomColour, 1, 255)
    end if
    mousewhere (x, y, b)
    if b = 1 then
	drawfilloval (x, y, 10, 10, randomColour)
    end if
    exit when GUI.ProcessEvent
end loop
