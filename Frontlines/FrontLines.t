% This program is a game, the objective is to click soldiers and take them
% out as fast as you can! Use the mouse to move your designator and aim
% at enemy soldiers.

import GUI


% Declaration Section
const BUTTON_WIDTH := 100
const DELAY_TIME_1 := 5300

var b : int
var background : int
var backgroundHeight : int
var backgroundWidth : int
var boxX : int
var bulletsShot : int
var buttonQuit : int
var buttonX : int
var buttonY : int
var centered : boolean
var delayTime : int
var designatorId : int
var designatorSprite : int
var finalRadX : int
var finalRadY : int
var fire : int
var fireHeight : int
var fireLength : int
var fireSprite : int
var i : int
var location : int
var loadingDone : boolean
var logo : int
var logoHeight : int
var logoWidth : int
var hitCounter : int
var quitGame : boolean
var soldier : int
var soldierSpeed : int
var soldierHeight : int
var soldierWidth : int
var soldierX : int
var soldierY : int
var soldierSprite : int
var startPicture : array 1 .. 3 of int
var startPictureHeight : array 1 .. 3 of int
var startPictureLength : array 1 .. 3 of int
var timeCount : int
var x : int
var y : int

% Forwards procedure
forward procedure drawButtons
forward procedure drawHeading

% Procedures

body procedure drawButtons

    const BUTTON_WIDTH := 50
    var buttonExit : int
    var buttonStart : int
    var buttonX : int
    var buttonY : int
    var text : string
    var widgetId : int

    % These are the GUI buttons
    buttonX := maxx div 1.4
    buttonY := maxy div 2
    text := "Start Campaign"

    buttonStart := GUI.CreateButton (buttonX, buttonY, BUTTON_WIDTH, text, GUI.Quit)

    buttonY := maxy div 2.5
    text := "Exit"

    buttonExit := GUI.CreateButton (buttonX, buttonY, BUTTON_WIDTH, text, GUI.Quit)

    loop
	exit when GUI.ProcessEvent
    end loop

end drawButtons


body procedure drawHeading

    const DELAY_TIME := 6300
    var heading : int

    heading := Pic.FileNew ("pictures/heading.jpg")
    heading := Pic.Scale (heading, maxx div 2, maxy div 2)

    Pic.DrawSpecial (heading, maxx div 3, maxy div 3,
	picCopy, picFadeIn, DELAY_TIME)

    cls

    Pic.Free (heading)

end drawHeading

process drawLoadingScreen

    % Local Declaration Section
    const DELAY_TIME := 50
    const FRAMES := Pic.Frames ("pictures/loadingScreenFuture.gif")

    var delayTime2 : int
    var loadingScreen : array 1 .. FRAMES of int
    var loadingScreenSprite : int
    var screenCentered : boolean

    % Local Initialization Section
    delayTime2 := 1
    screenCentered := false

    % Load all the GIF pictures into an array of integers.
    Pic.FileNewFrames ("pictures/loadingScreenFuture.gif", loadingScreen,
	delayTime2)

    % Initialize the pictures and scale it to an appropriate size.
    for numberOfTimes : 1 .. FRAMES

	loadingScreen (numberOfTimes) := Pic.Scale (loadingScreen (numberOfTimes), maxx, maxy)

    end for



    % Make the loading screen a sprite so that it can be hidden with ease.
    loadingScreenSprite := Sprite.New (loadingScreen (1))

    % Draw loading as a sprite and delay it for some seconds.
    Sprite.SetPosition (loadingScreenSprite, 1, 1, screenCentered)
    Sprite.Show (loadingScreenSprite)
    delay (DELAY_TIME)

    % Continuously check if the screen has loaded
    loop

	for numberOfTimes : 1 .. FRAMES

	    % Change the pictures.
	    Sprite.ChangePic (loadingScreenSprite, loadingScreen (numberOfTimes))
	    Sprite.Show (loadingScreenSprite)
	    delay (DELAY_TIME)

	    % Check if screen loaded
	    if loadingDone then

		Sprite.Hide (loadingScreenSprite)

	    end if

	end for
	exit when loadingDone
    end loop

end drawLoadingScreen

procedure printConclusion

    % Declaration Section

    var font : int
    var highScoreFile : int
    var highScore : int
    var score : int
    var text : string
    var userName : string

    % Inizialization Section
    userName := Sys.GetUserName
    font := Font.New ("Ravie:45")

    % Processing Section
    score := ((hitCounter - bulletsShot) - (timeCount div 100000)) + 1000
    text := intstr (score)

    % Obtain high score
    open : highScoreFile, "highScore.text", get
    get : highScoreFile, highScore

    close : highScoreFile
    
    if score > highScore then

	open : highScoreFile, "highScore.text", put
	put : highScoreFile, score, skip
	
	close : highScoreFile

    end if


    open : highScoreFile, "highScore.text", get
    get : highScoreFile, highScore

    % Outputs the conclusion
    Font.Draw (text, maxx div 2, maxy div 2, font, green)
    Font.Draw ("Your Score: ", maxx div 2, maxy div 1.6, font, magenta)
    Font.Draw ("High Score: ", maxx div 2, maxy div 2.7, font, magenta)
    Font.Draw (intstr (highScore), maxx div 2, maxy div 4, font, green)
    close : highScoreFile

end printConclusion

process playTheme
    Music.PlayFile ("sounds/theme.wav")
end playTheme

process playShot
    Music.PlayFile ("sounds/shot.wav")
end playShot

% Inizialization Section
setscreen ("graphics:max;max,nobuttonbar")
quitGame := false
designatorId := Pic.FileNew ("pictures/designator.jpg")
designatorSprite := Sprite.New (designatorId)
fire := Pic.FileNew ("pictures/fire.jpg")
fireHeight := Pic.Height (fire)
fireLength := Pic.Width (fire)
fire := Pic.Scale (fire, maxx div 16, maxy div 8)
fireSprite := Sprite.New (fire)
startPicture (1) := Pic.FileNew ("pictures/startImage.jpg")
startPicture (2) := Pic.FileNew ("pictures/startImage2.jpg")
startPicture (3) := Pic.FileNew ("pictures/startImage3.jpg")
background := Pic.FileNew ("pictures/background.jpg")
logo := Pic.FileNew ("pictures/logo.jpg")
soldierSpeed := 150
bulletsShot := 0
timeCount := 0
hitCounter := 0
location := 1
loadingDone := false
boxX := maxx div 4


randint (i, 1, 3)


startPictureHeight (i) := Pic.Height (startPicture (i))
startPictureLength (i) := Pic.Width (startPicture (i))
startPicture (i) := Pic.Scale (startPicture (i), maxx div 1.5, maxy)

backgroundHeight := Pic.Height (background)
backgroundWidth := Pic.Width (background)
background := Pic.Scale (background, maxx, maxy)

logoHeight := Pic.Height (logo)
logoWidth := Pic.Width (logo)
logo := Pic.Scale (logo, maxx div 4, maxy div 5)

soldier := Pic.FileNew ("pictures/soldier.jpg")
soldierHeight := Pic.Height (soldier)
soldierWidth := Pic.Width (soldier)
soldierSprite := Sprite.New (soldier)

centered := true

% Give a properties to the soldier sprite
Sprite.SetHeight (soldierSprite, 1)
randint (soldierX, 1, maxx div 1.6)
soldierY := maxy div 4

% Start of program

drawHeading

% Start loading

fork drawLoadingScreen
delay (DELAY_TIME_1)
fork playTheme
Pic.Draw (startPicture (i), 1, 1, picCopy)
Pic.Draw (logo, maxx div 1.4, maxy div 1.4, picCopy)
loadingDone := true

drawButtons

% Main program
loop

    % This determines the frame rate
    Sprite.SetFrameRate (80)

    % Adds 1 to time count
    timeCount := timeCount + 1

    % Sets the position of the Soldier
    Sprite.SetPosition (soldierSprite, soldierX, soldierY, centered)

    % Sets properties to the sprite for animation
    % Makes sure that the sprite moves across the
    % screen horizontally.
    if soldierX <= maxx div 32 then
	location := -maxx div soldierSpeed
    elsif soldierX >= maxx - (maxx div 32) then
	location := maxx div soldierSpeed
    end if

    soldierX := soldierX - location

    % Shows the soldier and gets the location of the mouse
    View.Set ("offscreenonly")
    Sprite.Show (soldierSprite)
    Pic.Draw (background, 1, 1, picCopy)
    View.Update
    View.Set ("offscreenonly")
    mousewhere (x, y, b)

    % Draws the designator
    Sprite.SetHeight (designatorSprite, 4)
    Sprite.SetPosition (designatorSprite, x, y, centered)
    Sprite.Show (designatorSprite)
    View.Update

    cls


    if b = 1 then

	if x > (soldierX - soldierWidth div 2)
		and x < (soldierX + soldierWidth div 2)
		and y > (soldierY - soldierHeight div 2)
		and y < (soldierY + soldierHeight div 2) then

	    Sprite.Hide (soldierSprite)
	    randint (soldierX, 1, maxx div 1.6)
	    randint (soldierY, 1, maxy div 1.6)

	    fork playShot

	    View.Set ("offscreenonly")
	    Sprite.SetHeight (fireSprite, 2)
	    Sprite.SetPosition (fireSprite, x, y, centered)
	    Sprite.Show (fireSprite)
	    View.Update

	    % Add 1 to hit counter
	    hitCounter := hitCounter + 1

	    % Adds 1 to shot counter
	    bulletsShot := bulletsShot + 1

	    % Subtracts 5 from soldier Speed
	    soldierSpeed := soldierSpeed - 5

	elsif b = 1 then

	    fork playShot

	    View.Set ("offscreenonly")
	    Sprite.SetHeight (fireSprite, 2)
	    Sprite.SetPosition (fireSprite, x, y, centered)
	    Sprite.Show (fireSprite)
	    View.Update

	    % Adds 1 to shot counter
	    bulletsShot := bulletsShot + 1
	end if
    end if
    exit when hitCounter = 25
end loop

% Hides all sprite after game is finished
Sprite.Hide (soldierSprite)
Sprite.Hide (designatorSprite)
Sprite.Hide (fireSprite)

% Prints the conclusion
printConclusion
