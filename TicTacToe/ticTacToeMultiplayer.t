
% Tic Tac Toe Single player game

% Declaration Section
const NUMBER_OF_BUTTONS_MAIN_2 := 9
const NUMBER_OF_ROW_COLUMN_2 := 3

var button2 : array 1 .. NUMBER_OF_BUTTONS_MAIN_2 of int
var button2Clicked : array 1 .. NUMBER_OF_BUTTONS_MAIN_2 of boolean
var button2ClickedComputer : array 1 .. NUMBER_OF_BUTTONS_MAIN_2 of boolean
var button2ClickedPlayer : array 1 .. NUMBER_OF_BUTTONS_MAIN_2 of boolean
var button2X : int
var button2Y : int
var crossPicture2 : array 1 .. NUMBER_OF_BUTTONS_MAIN_2 of int
var gameTied2 : boolean
var gameWonPlayer2 : boolean
var playerTurn2 : boolean

forward function checkIfLost2 : boolean
forward function checkIfLost2Computer : boolean
forward procedure displayResults2
forward procedure disposeButtons2
forward procedure drawButtons2
forward procedure drawCross2

body function checkIfLost2 : boolean

    % Local Declaration Section
    var certainNumber : int
    var endDigit : int
    var startDigit : int
    var thePlayer : string
    var totalNumber : int

    % Local Initialization Section
    endDigit := 3
    startDigit := 1
    totalNumber := 0

    % Main function


    % Check for the player
    % Check all of the rows


    for numberOfTimes : 1 .. 3

	for button2Number : startDigit .. endDigit

	    if button2ClickedPlayer (button2Number) = true then

		totalNumber += 1

	    end if

	end for

	% Check if the game is over

	if totalNumber = 3 then

	    result true

	end if


	totalNumber := 0
	endDigit += 3
	startDigit += 3

    end for

    % Initialize the variables
    startDigit := 1
    endDigit := 1
    totalNumber := 0

    % Check for all the column
    for numberOfTimes : 1 .. 3

	loop
	    if button2ClickedPlayer (startDigit) = true then

		totalNumber += 1

	    end if

	    exit when startDigit = endDigit + 6

	    startDigit += 3
	end loop

	% Check if the game is over

	if totalNumber = 3 then

	    result true

	end if


	endDigit += 1
	startDigit -= 6
	startDigit += 1
	totalNumber := 0

    end for

    % Initialize the variables
    certainNumber := 4
    endDigit := 1
    startDigit := 1
    totalNumber := 0

    % Check for diagonals
    for numberOfTimes : 1 .. 2

	for numberOfTime : 1 .. 3

	    if button2ClickedPlayer (startDigit) = true then

		totalNumber += 1

	    end if

	    startDigit += certainNumber

	end for

	% Check if game is over
	if totalNumber = 3 then

	    result true

	end if

	% Reinitialize the variables
	startDigit := 3
	certainNumber := 2
	totalNumber := 0

    end for

    % If the game is not over than the result is false.
    result false

end checkIfLost2

body function checkIfLost2Computer


    % Local Declaration Section
    var certainNumber : int
    var endDigit : int
    var startDigit : int
    var thePlayer : string
    var totalNumber : int

    % Local Initialization Section
    endDigit := 3
    startDigit := 1
    totalNumber := 0

    % Main function


    % Check for the player
    % Check all of the rows


    for numberOfTimes : 1 .. 3

	for button2Number : startDigit .. endDigit

	    if button2ClickedComputer (button2Number) = true then

		totalNumber += 1

	    end if

	end for

	% Check if the game is over

	if totalNumber = 3 then

	    result true

	end if


	totalNumber := 0
	endDigit += 3
	startDigit += 3

    end for

    % Initialize the variables
    startDigit := 1
    endDigit := 1
    totalNumber := 0

    % Check for all the column
    for numberOfTimes : 1 .. 3

	loop
	    if button2ClickedComputer (startDigit) = true then

		totalNumber += 1

	    end if

	    exit when startDigit = endDigit + 6

	    startDigit += 3
	end loop

	% Check if the game is over

	if totalNumber = 3 then

	    result true

	end if


	endDigit += 1
	startDigit -= 6
	startDigit += 1
	totalNumber := 0

    end for

    % Initialize the variables
    certainNumber := 4
    endDigit := 1
    startDigit := 1
    totalNumber := 0

    % Check for diagonals
    for numberOfTimes : 1 .. 2

	for numberOfTime : 1 .. 3

	    if button2ClickedComputer (startDigit) = true then

		totalNumber += 1

	    end if

	    startDigit += certainNumber

	end for

	% Check if game is over
	if totalNumber = 3 then

	    result true

	end if

	% Reinitialize the variables
	startDigit := 3
	certainNumber := 2
	totalNumber := 0

    end for

    % If the game is not over than the result is false.
    result false

end checkIfLost2Computer


body procedure displayResults2

    % Local Declaration Section
    var colourText : int
    var results : int
    var text : string
    var size : int

    % Local Initialization Section

    /*
     Scale the size of the font so that it is scalable on every screen
     */
    size := maxx div 63.9

    results := Font.New ("Vedetta:" + intstr (size) + ":bold")

    % Determine if won or lost
    if gameTied2 then

	% Determine the values
	colourText := 38     % purple
	text := "IT'S A TIE!"

    elsif gameWonPlayer2 then

	% Determine the values
	colourText := 54     % Blue
	text := "PLAYER ONE WINS!"


    elsif gameWonPlayer2 = false then

	% Determine the values
	colourText := 40     % Red
	text := "PLAYER TWO WINS!"

    end if

    % Draw the message
    Font.Draw (text, maxx div 1.3, maxy div 1.3, results, colourText)

end displayResults2

body procedure disposeButtons2

    % Dispose of the previous button2s

    for button2Number : 1 .. NUMBER_OF_BUTTONS_MAIN_2

	GUI.Dispose (button2 (button2Number))

    end for


    cls

end disposeButtons2

body procedure drawButtons2

    % Local Declaration Section
    const BUTTON_HEIGHT := 90
    const BUTTON_WIDTH := 90

    var widgetIdIncrease : int

    % Local Initialization Section
    widgetIdIncrease := 0

    % Draw the button2s
    button2X := maxx div 16
    button2Y := maxy div 1.25

    for button2Number : 1 .. NUMBER_OF_ROW_COLUMN_2

	for number : 1 + widgetIdIncrease .. NUMBER_OF_ROW_COLUMN_2
		+ widgetIdIncrease

	    button2 (number) := GUI.CreatePictureButtonFull (button2X, button2Y,
		crossPicture2 (number), drawCross2, BUTTON_WIDTH, BUTTON_HEIGHT,
		'7', true)

	    button2X += maxx div 8

	end for

	widgetIdIncrease += 3
	button2X := maxx div 16
	button2Y -= maxy div 5

    end for

end drawButtons2

body procedure drawCross2

    % Local Declaration Section
    var file : string
    var gameWon : boolean
    var nameOfPlayer : string
    var widgetIdNumber : int

    % Local Initialization Section
    widgetIdNumber := GUI.GetEventWidgetID


    % Check which player turn it is
    if playerTurn2 then

	file := "pictures2/cross.jpg"
	nameOfPlayer := "player"

    else

	file := "pictures2/circle.jpg"
	nameOfPlayer := "computer"

    end if

    % Check which button2 was clicked and draw a cross at the appropriate place
    for button2Number : 1 .. NUMBER_OF_BUTTONS_MAIN_2

	if widgetIdNumber = button2 (button2Number) then

	    crossPicture2 (button2Number) := Pic.FileNew (file)
	    crossPicture2 (button2Number) := Pic.Scale
		(crossPicture2 (button2Number), maxx div 16, maxy div 10)

	    % Assign appropriate button2 the true for being clicked.
	    button2Clicked (button2Number) := true

	    if nameOfPlayer = "player" then

		button2ClickedPlayer (button2Number) := true

	    else

		button2ClickedComputer (button2Number) := true

	    end if

	end if

    end for

    % Change turns of the players
    playerTurn2 := not playerTurn2

    gameWon := checkIfLost2

    if gameWon then

	gameWonPlayer2 := true
	GUI.Quit
	disposeButtons2
	drawButtons2
	return

    end if

    gameWon := checkIfLost2Computer

    if gameWon then

	gameWonPlayer2 := false
	GUI.Quit
	disposeButtons2
	drawButtons2
	return

    end if

    disposeButtons2
    drawButtons2

end drawCross2

% Initialization Section
gameTied2 := false
gameWonPlayer2 := false
playerTurn2 := true

% Initialize the cross pictures
for pictureNumber : 1 .. NUMBER_OF_BUTTONS_MAIN_2

    crossPicture2 (pictureNumber) := Pic.FileNew ("pictures2/blanc.jpg")
    crossPicture2 (pictureNumber) := Pic.Scale (crossPicture2 (pictureNumber),
	maxx div 16, maxy div 10)

end for

% Initialize the boolean that checks if button2 was clicked
for button2Number : 1 .. NUMBER_OF_BUTTONS_MAIN_2

    button2Clicked (button2Number) := false

end for

for button2Number : 1 .. NUMBER_OF_BUTTONS_MAIN_2

    button2ClickedComputer (button2Number) := false

end for

for button2Number : 1 .. NUMBER_OF_BUTTONS_MAIN_2

    button2ClickedPlayer (button2Number) := false

end for


