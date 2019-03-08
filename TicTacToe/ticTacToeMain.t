import GUI

% The Main Tic Tac Toe game.

% Declaration Section
const NUMBER_OF_BUTTONS := 3

var buttonMain : array 1 .. NUMBER_OF_BUTTONS of int

forward procedure colourButtons
forward procedure drawAndInitializeButton
forward procedure disposeMainButtons
forward procedure performTask

% Add the Declaration Section of the other programs
include "ticTacToeSinglePlayer.t"
include "ticTacToeMultiplayer.t"

body procedure colourButtons

    % Colour the main buttons except the quit button
    for buttonNumber : 1 .. NUMBER_OF_BUTTONS - 1

	GUI.SetColour (buttonMain (buttonNumber), brightgreen)

    end for

    % Colour the quit button
    GUI.SetColour (buttonMain (NUMBER_OF_BUTTONS), brightred)

end colourButtons

body procedure drawAndInitializeButton

    % Local Declaration Section
    const BUTTON_WIDTH := 0

    var buttonMainX : int
    var buttonMainY : int
    var text : array 1 .. NUMBER_OF_BUTTONS of string

    % Initialization Section
    buttonMainX := maxx div 1.1
    buttonMainY := maxy div 1.6
    text (1) := "Single Player"
    text (2) := "Multiplayer"
    text (3) := "Exit"

    % Create the buttonMains
    for Number : 1 .. NUMBER_OF_BUTTONS

	buttonMain (Number) := GUI.CreateButton (buttonMainX, buttonMainY,
	    BUTTON_WIDTH, text (Number), performTask)

	buttonMainY -= maxy div 10

    end for

end drawAndInitializeButton

body procedure disposeMainButtons

    % Dispose the main buttons and deletes them.
    for buttonNumber : 1 .. NUMBER_OF_BUTTONS

	GUI.Dispose (buttonMain (buttonNumber))

    end for

end disposeMainButtons

body procedure performTask

    % Local Declaration Section
    var widgetIdNumber : int

    % Local Initialization Section
    widgetIdNumber := GUI.GetEventWidgetID

    % Check which buttonMain was pressed.
    if widgetIdNumber = buttonMain (1) then

	disposeMainButtons
	include "ticTacToeSinglePlayerMain.t"

    elsif widgetIdNumber = buttonMain (2) then

	disposeMainButtons
	include "ticTacToeMultiplayerMain.t"

    else

	GUI.Quit

    end if

end performTask

% Initialization Section
View.Set("graphics:max,max")  

% Main program
drawAndInitializeButton
colourButtons

loop
    exit when GUI.ProcessEvent
end loop
