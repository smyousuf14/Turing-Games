
% Tic Tac Toe Single player game

% Declaration Section
const NUMBER_OF_BUTTONS_MAIN := 9
const NUMBER_OF_ROW_COLUMN := 3

var button : array 1 .. NUMBER_OF_BUTTONS_MAIN of int
var buttonClicked : array 1 .. NUMBER_OF_BUTTONS_MAIN of boolean
var buttonClickedComputer : array 1 .. NUMBER_OF_BUTTONS_MAIN of boolean
var buttonClickedPlayer : array 1 .. NUMBER_OF_BUTTONS_MAIN of boolean
var buttonX : int
var buttonY : int
var crossPicture : array 1 .. NUMBER_OF_BUTTONS_MAIN of int
var gameTied : boolean
var gameWonPlayer : boolean

forward function checkIfLost : boolean
forward function checkIfLostComputer : boolean
forward procedure displayResults
forward procedure disposeButtons
forward procedure drawButtons
forward procedure drawCross
forward procedure performComputerMove

body function checkIfLost : boolean

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

	for buttonNumber : startDigit .. endDigit

	    if buttonClickedPlayer (buttonNumber) = true then

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
	    if buttonClickedPlayer (startDigit) = true then

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

	    if buttonClickedPlayer (startDigit) = true then

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

end checkIfLost

body function checkIfLostComputer


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

	for buttonNumber : startDigit .. endDigit

	    if buttonClickedComputer (buttonNumber) = true then

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
	    if buttonClickedComputer (startDigit) = true then

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

	    if buttonClickedComputer (startDigit) = true then

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

end checkIfLostComputer


body procedure displayResults

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
    if gameTied then

	% Determine the values
	colourText := 38     % purple
	text := "IT'S A TIE!"
	
    elsif gameWonPlayer then

	% Determine the values
	colourText := 54     % Blue
	text := "YOU WIN!"


    elsif gameWonPlayer = false then

	% Determine the values
	colourText := 40     % Red
	text := "YOU LOSE!"

    end if

    % Draw the message
    Font.Draw (text, maxx div 1.3, maxy div 1.3, results, colourText)

end displayResults

body procedure disposeButtons

    % Dispose of the previous buttons

    for buttonNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

	GUI.Dispose (button (buttonNumber))

    end for


    cls

end disposeButtons

body procedure drawButtons

    % Local Declaration Section
    const BUTTON_HEIGHT := 90
    const BUTTON_WIDTH := 90

    var widgetIdIncrease : int

    % Local Initialization Section
    widgetIdIncrease := 0

    % Draw the buttons
    buttonX := maxx div 16
    buttonY := maxy div 1.25

    for buttonNumber : 1 .. NUMBER_OF_ROW_COLUMN

	for number : 1 + widgetIdIncrease .. NUMBER_OF_ROW_COLUMN
		+ widgetIdIncrease

	    button (number) := GUI.CreatePictureButtonFull (buttonX, buttonY,
		crossPicture (number), drawCross, BUTTON_WIDTH, BUTTON_HEIGHT,
		'7', true)

	    buttonX += maxx div 8

	end for

	widgetIdIncrease += 3
	buttonX := maxx div 16
	buttonY -= maxy div 5

    end for

end drawButtons

body procedure drawCross

    % Local Declaration Section
    var gameWon : boolean
    var widgetIdNumber : int

    % Local Initialization Section
    widgetIdNumber := GUI.GetEventWidgetID

    % Check which button was clicked and draw a cross at the appropriate place
    for buttonNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

	if widgetIdNumber = button (buttonNumber) then

	    crossPicture (buttonNumber) := Pic.FileNew ("pictures2/cross.jpg")
	    crossPicture (buttonNumber) := Pic.Scale
		(crossPicture (buttonNumber), maxx div 16, maxy div 10)

	    % Assign appropriate button the true for being clicked.
	    buttonClicked (buttonNumber) := true
	    buttonClickedPlayer (buttonNumber) := true

	end if

    end for

    gameWon := checkIfLost

    if gameWon then

	gameWonPlayer := true
	GUI.Quit
	disposeButtons
	drawButtons
	return

    end if

    performComputerMove

    gameWon := checkIfLostComputer

    if gameWon then

	gameWonPlayer := false
	GUI.Quit
	disposeButtons
	drawButtons
	return

    end if

    disposeButtons
    drawButtons

end drawCross

body procedure performComputerMove

    % Local Declaration Section
    var accomplishedButtonNumber : boolean
    var buttonNumber : int
    var closeGame : boolean
    var totalClicks : int

    % Local Initialization Section
    accomplishedButtonNumber := false
    closeGame := false
    totalClicks := 0

    % Main process
    loop

	% Check if all buttons were checked
	for clickNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

	    if buttonClicked (clickNumber) then
		totalClicks += 1
	    end if
	end for

	% Randomize the computers move and make sure
	% that button is not pressed.
	randint (buttonNumber, 1, NUMBER_OF_BUTTONS_MAIN)

	for clickedNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

	    % Check if the game was a draw

	    if totalClicks = 9 then
		closeGame := true
		exit
	    end if

	    % Check if the button was clicked.
	    if buttonNumber = clickedNumber and
		    buttonClicked (clickedNumber) = false then

		accomplishedButtonNumber := true
		exit

	    elsif buttonNumber = clickedNumber and
		    buttonClicked (clickedNumber) = true then

		exit


	    end if

	end for

	exit when accomplishedButtonNumber or closeGame
    end loop


    % Check if game was a draw
    if closeGame then

	gameTied := true
	GUI.Quit
	return

    end if

    % Draw circle at appropriate button
    crossPicture (buttonNumber) := Pic.FileNew ("pictures2/circle.jpg")
    crossPicture (buttonNumber) := Pic.Scale
	(crossPicture (buttonNumber), maxx div 16, maxy div 10)

    % Set that button as a pressed button
    buttonClicked (buttonNumber) := true
    buttonClickedComputer (buttonNumber) := true


end performComputerMove

% Initialization Section
gameTied := false
gameWonPlayer := false

% Initialize the cross pictures
for pictureNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

    crossPicture (pictureNumber) := Pic.FileNew ("pictures2/blanc.jpg")
    crossPicture (pictureNumber) := Pic.Scale (crossPicture (pictureNumber),
	maxx div 16, maxy div 10)

end for

% Initialize the boolean that checks if button was clicked
for buttonNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

    buttonClicked (buttonNumber) := false

end for

for buttonNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

    buttonClickedComputer (buttonNumber) := false

end for

for buttonNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

    buttonClickedPlayer (buttonNumber) := false

end for
