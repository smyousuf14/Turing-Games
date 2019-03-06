import GUI

% Programmer : Syed Yousuf

%       Date : 2014-05-13

%  File name : intoTheFire.t

%  Version # : 1.2

%    Purpose : This is an RPG game that allows players to interact with an
%              imense world. Players can engage in combat against foes such
%              monsters and various other creatures.



% Declaration Section
const DELAY_TIME := 50
const DELAY_TIME_2 := 1000
const NUMBER_OF_BACKGROUNDS := 15
const NUMBER_OF_BUTTONS_MAIN := 3
const NUMBER_OF_DOORS := 2
const NUMBER_OF_ENEMIES_PICTURES := 27

var armour : int
var background : array 1 .. NUMBER_OF_BACKGROUNDS of int
var backgroundAsk : int
var backgroundNumber : int
var buttonItem : array 1 .. 3 of int
var buttonMain : array 1 .. NUMBER_OF_BUTTONS_MAIN of int
var delta : int
var door : array 1 .. NUMBER_OF_DOORS of int
var doorVanish : boolean
var doorX : array 1 .. 2 of int
var doorY : int
var doorIsDrawn : boolean
var enemy : array 1 .. 3, 1 .. NUMBER_OF_ENEMIES_PICTURES of int
var enemyDamageStart : int
var enemyDamageEnd : int
var enemyDividentValue : int
var enemyDrawn : boolean
var enemyIsDead : boolean
var enemyHealth : int
var enemyNumber : int
var enemyStrips : array 1 .. 3 of int
var enemysType : int
var enemyX : int
var enemyY : int
var exitGame : boolean
var hero : array 1 .. 42 of int
var heroIsBack : boolean
var heroIsDead : boolean
var heroDamageValue : int
var heroDividentValue : int
var heroHealth : int
var heroHealthFont : int
var heroLevel : int
var heroNumber : int
var heroX : int
var heroY : int
var itemButtonCreated : boolean
var jumpUp : boolean
var keysWerePressed : boolean
var levelComplete : boolean
var money : int
var optionClicked : boolean
var gameLoad : boolean
var gameNew : boolean
var numberOfDoors : int
var pictureExtension : string
var savedData : string
var savedDataFile : int
var textFieldLoad : int
var textFieldNewGame : int
var totalHealth : int
var windowId : int

forward procedure changePicture
forward procedure checkIfHeroIsDead
forward function checkIfObjectCollided (object1X : int, object1Y : int,
    object2X : int, object2Y : int, object2Difference : int) : boolean
forward procedure checkIfLevelFirstIsComplete
forward procedure createDoors (numberOfDoors : int)
forward procedure drawAfterMath
forward procedure determineEnemyHealth (startHealth : int, endHealth : int)
forward procedure drawBars (dividentValue : int, enemyDividentValue : int)
forward procedure drawDroppingBall
forward procedure drawHeading
forward procedure drawMainMenu
forward procedure drawScreen
forward procedure drawStoreItems
forward procedure drawEnemyStrip (enemyNumber : int)
forward procedure enemyAttack
forward procedure enemyDead
forward procedure enemyGetHit
forward procedure enemyJump
forward procedure goToStore
forward procedure heroIsHurt
forward procedure initializeHero
forward procedure loadGame (text : string)
forward procedure moveEnemyAhead
forward procedure newGame (text : string)
forward procedure obtainHeroHealth
forward procedure obtainHeroValue
forward procedure performAttackMovements
forward procedure performComplexMovements
forward procedure performEnemyAction
forward procedure performLoadGame
forward procedure performMainAction
forward procedure performNewGame
forward procedure performPurchase
forward procedure performTuturial
forward procedure performHeroDeath
forward procedure performJumpMovements
forward procedure performKeyboardMovement
forward procedure performLevelCalculations
forward procedure performXPRegain
forward procedure resetBackground
forward procedure resetEnemy
forward procedure saveGame
forward procedure setScreenForBattleLevel

process playDeath

    % Play the death music.
    Music.PlayFile ("sounds/death.wav")

end playDeath

process playEnemyKilled

    % Play the correct audio file.
    Music.PlayFile ("sounds/enemyKilled.wav")

end playEnemyKilled

process playHeroKilled

    % Play the correct audio file.
    Music.PlayFile ("sounds/heroKilled.wav")

end playHeroKilled

process playHit

    % Play the correct audio file.
    Music.PlayFile ("sounds/hit.wav")

end playHit

process playTheme


    % Play the theme music.
    Music.PlayFileLoop ("sounds/MainMusic.wav")


end playTheme

process playThemeLocal


    % Play the local (in-game) theme music.
    Music.PlayFileLoop ("sounds/MenuMusic.mp3")

end playThemeLocal

body procedure changePicture

    % Change the pictures
    heroNumber += 1

end changePicture

body procedure checkIfHeroIsDead

    % Check if the hero's health is less than 0.
    if heroHealth <= 0 then

	% First, make the hero's health to 0, in case it was in the negatives.
	heroHealth := 0

	% Then, draw the screen appropriately. To avoid confusion towards
	% the player.

	cls

	drawScreen
	View.Update

	% Perform the death of the hero.
	performHeroDeath

    end if

end checkIfHeroIsDead

body function checkIfObjectCollided (object1X : int, object1Y : int,
	object2X : int, object2Y : int, object2Difference : int) : boolean

    % Checks if the objects collided.
    % Note that some overlapping may occur.
    if object1X + maxx div 16 >= object2X and
	    object1X + maxx div 16 <= object2X + object2Difference and
	    object1Y >= object2Y and object1Y <= object2Y + object2Difference then

	result true

    elsif object1X >= object2X and object1X <= object2X + object2Difference
	    and object1Y >= object2Y and object1Y >= object2Y + object2Difference
	    then

	result true

    else

	result false

    end if

end checkIfObjectCollided

body procedure checkIfLevelFirstIsComplete

    % Check if the level is complete
    levelComplete := checkIfObjectCollided (heroX, heroY, doorX (1), doorY, maxy div 3.3)

end checkIfLevelFirstIsComplete

body procedure createDoors (numberOfDoors : int)

    for doorNumber : 1 .. numberOfDoors

	% Local Initialization Section
	door (doorNumber) := Pic.FileNew ("pictures/door.jpeg")
	door (doorNumber) := Pic.Scale (door (doorNumber), maxx div 8, maxy div 3.3)
	doorX (1) := maxx div 1.3
	doorX (2) := maxx div 10
	doorY := maxy div 10

	% Draw the doors
	Pic.Draw (door (doorNumber), doorX (doorNumber), doorY, picCopy)

    end for

end createDoors

body procedure drawAfterMath

    % Local Declaration Section
    var coordinateClick : int
    var coordinateX : int
    var coordinateY : int
    var option : int

    % Local Initialization Section
    option := Pic.FileNew ("pictures/restart.jpeg")
    option := Pic.Scale (option, maxx div 2, maxy div 5)

    % Draw the picture.
    Pic.Draw (option, maxx div 5.33, maxy div 10, picCopy)

    % Check if the mouse is hovering over the option and perform desired action.

    loop
	% Determine mouse where.
	mousewhere (coordinateX, coordinateY, coordinateClick)

	if coordinateX >= maxx div 5.33 and coordinateX <= maxx div 1.45 and

		coordinateY >= maxy div 10 and coordinateY <= maxy div 3.3 then

	    % Now draw a different option picture.
	    Pic.Draw (option, maxx div 4.44, maxy div 10, picXor)
	    View.Update

	    % Now check if the user clicked the option.
	    if coordinateClick = 1 then

		optionClicked := true

	    end if

	else

	    % Draw the picture.
	    Pic.Draw (option, maxx div 4.44, maxy div 10, picCopy)
	    View.Update

	end if

	exit when optionClicked

    end loop

end drawAfterMath

body procedure determineEnemyHealth (startHealth : int, endHealth : int)

    % Now determine the enemy's health.
    randint (enemyHealth, startHealth, endHealth)

end determineEnemyHealth

body procedure drawBars (dividentValue : int, enemyDividentValue : int)

    % Local Declaration Section
    var enemyBarX : array 1 .. 2 of int
    var enemyBarY : array 1 .. 2 of int
    var heroBarX : array 1 .. 2 of int
    var heroBarY : array 1 .. 2 of int
    var subtractionValue : int
    var subtractionValueEnemy : int
    var totalSubtraction : int
    var totalSubtractionEnemy : int

    % Local Initialization Section
    enemyBarX (1) := maxx div 1.45
    enemyBarX (2) := maxx div 1.06
    enemyBarY (1) := maxy div 1.11
    enemyBarY (2) := maxy div 1.0
    heroBarX (1) := maxx div 16
    heroBarX (2) := maxx div 2.6
    heroBarY (1) := maxy div 1.11
    heroBarY (2) := maxy div 1.0

    % Main part of sub-program.

    % Determine the hero's bar value.
    % Check if divident value is 0 and perform appropriate action.
    if dividentValue not= 0 then

	% Determine the subtraction value.
	subtractionValue := (heroBarX (2) - heroBarX (1)) div dividentValue

    else

	subtractionValue := 0

    end if

    % Now perform other calculations
    if subtractionValue not= 0 then

	totalSubtraction := (heroBarX (2) - heroBarX (1)) - subtractionValue

    else

	totalSubtraction := subtractionValue

    end if

    % Determine the x2 value.
    heroBarX (2) -= totalSubtraction

    % Determine the enemy's bar value
    if enemyDividentValue not= 0 then

	% Determine the subtraction value.
	subtractionValueEnemy := (enemyBarX (2) - enemyBarX (1)) div enemyDividentValue

    else

	subtractionValueEnemy := 0

    end if

    % Now perform other calculations
    if subtractionValueEnemy not= 0 then

	totalSubtractionEnemy := (enemyBarX (2) - enemyBarX (1)) - subtractionValueEnemy

    else

	totalSubtractionEnemy := subtractionValueEnemy

    end if

    % Determine the x2 value.
    enemyBarX (2) -= totalSubtractionEnemy

    % Now draw the bars.
    drawfillbox (heroBarX (1), heroBarY (1), heroBarX (2), heroBarY (2), blue)

    % Check and draw only if enemy number is determined.
    if enemyHealth not= 0 then

	drawfillbox (enemyBarX (1), enemyBarY (1), enemyBarX (2), enemyBarY (2), red)

    end if

end drawBars

body procedure drawDroppingBall

    % Local Declaration Section
    const DELAY_TIME := 50

    var ball : int
    var ballX : int
    var ballY : int

    % Local Initilization Section
    ball := Pic.FileNew ("pictures/doorball.jpeg")
    ball := Pic.Scale (ball, maxx div 10, maxy div 8.33)
    ballX := maxx div 1.3
    ballY := maxy

    % Now make the ball move from the top to the bottom of the screen.
    loop

	delay (DELAY_TIME)

	cls

	drawScreen
	Pic.Draw (ball, ballX, ballY, picMerge)
	View.Update

	exit when ballY <= maxy div 10

	% Change the ball Y coordinate.
	ballY -= maxy div 50

    end loop

    % Now free the picture.
    Pic.Free (ball)

    % Draw the doors
    numberOfDoors := 2
    createDoors (numberOfDoors)

    % Now indicate that the door is created
    doorIsDrawn := true

end drawDroppingBall

body procedure drawHeading

    % Local Declaration Section
    const DELAY_TIME := 8300

    var background : int
    var heading : array 1 .. 2 of int

    % Local Initialization Section
    background := Pic.FileNew ("pictures/headingBackground.jpeg")
    background := Pic.Scale (background, maxx, maxy)

    for headingNumber : 1 .. 2

	heading (headingNumber) := Pic.FileNew ("pictures/heading" +
	    intstr (headingNumber) + ".jpeg")
	heading (headingNumber) := Pic.Scale (heading (headingNumber),
	    maxx div 2, maxy div 2)

    end for

    % Main process

    % Draw the background.
    Pic.Draw (background, 1, 1, picCopy)

    % Draw the special logo.
    Pic.DrawSpecial (heading (1), maxx div 3, maxy div 3,
	picCopy, picFadeIn, DELAY_TIME)

    % Draw the other logo.
    Pic.DrawSpecial (heading (2), maxx div 3, maxy div 3,
	picCopy, picWipeLeftToRight, DELAY_TIME)

    cls

    Pic.Free (heading (1))
    Pic.Free (heading (2))

end drawHeading

body procedure drawMainMenu

    % Local Declaration Section
    const NUMBER_OF_BACKGROUND := 3
    const WIDTH := 25

    var background : array 1 .. NUMBER_OF_BACKGROUND of int
    var backgroundNumber : int
    var buttonMainY : int
    var logo : int
    var text : string

    % Local Initialization Section
    for BackgroundNumber : 1 .. NUMBER_OF_BACKGROUND

	background (BackgroundNumber) := Pic.FileNew ("pictures/mainBackground" +
	    intstr (BackgroundNumber) + ".jpeg")
	background (BackgroundNumber) := Pic.Scale (background (BackgroundNumber),
	    maxx div 2, maxy)

    end for

    buttonMainY := maxy div 1.25
    logo := Pic.FileNew ("pictures/gameLogo.jpeg")
    logo := Pic.Scale (logo, maxx div 2, maxy div 5)
    text := "New Game"

    % Main process

    % Determine the background number.
    randint (backgroundNumber, 1, NUMBER_OF_BACKGROUND)

    % First draw the colour background.
    drawfillbox (1, 1, maxx, maxy, grey)

    % Now draw that background of the randomized number,
    Pic.Draw (background (backgroundNumber), 1, 1, picCopy)

    % Now, draw the logo.
    Pic.Draw (logo, maxx div 4, maxy div 1.25, picCopy)

    % Now draw the buttons.
    for buttonNumber : 1 .. NUMBER_OF_BUTTONS_MAIN

	buttonMain (buttonNumber) := GUI.CreateButton (maxx div 1.14, buttonMainY, WIDTH, text,
	    performMainAction)


	% Change the text.
	if text = "Load Game" then

	    text := "Exit"

	else


	    text := "Load Game"

	end if

	% Increment the y coordinate.
	buttonMainY -= maxy div 5

    end for


    loop
	exit when GUI.ProcessEvent
    end loop

    % Check if the user closed the game.
    if exitGame then


	% First delay to provide the user with a smooth transition.
	delay (DELAY_TIME_2)

	return

    end if


end drawMainMenu

body procedure drawScreen

    % Repaint the screen
    Pic.Draw (background (backgroundNumber), 1, 1, picCopy)

    % Check if the doors are visible.
    if doorVanish = false then

	for doorNumber : 1 .. numberOfDoors

	    Pic.Draw (door (doorNumber), doorX (doorNumber), doorY, picCopy)

	end for

    end if

    if enemyDrawn then

	Pic.Draw (enemy (enemyNumber, enemysType), enemyX, enemyY, picMerge)

    end if

    % Draw the hero.
    Pic.Draw (hero (heroNumber), heroX, heroY, picMerge)

    % Now draw the health bars.
    drawBars (heroDividentValue, enemyDividentValue)

    % Now draw the health number.
    Font.Draw ("HP:" + intstr (heroHealth), maxx div 8, maxy div 1.1,
	heroHealthFont, black)

    % Draw enemy health if it is not 0
    if enemyHealth not= 0 then

	Font.Draw ("HP:" + intstr (enemyHealth), maxx div 1.3, maxy div 1.1,
	    heroHealthFont, black)

    end if

end drawScreen

body procedure drawStoreItems

    % Local Declaration Section
    const NUMBER_OF_ITEMS := 3

    var buttonX : int
    var font : int
    var storeItem : array 1 .. NUMBER_OF_ITEMS of int

    % Local Initialization Section
    buttonX := maxx div 8
    font := Font.New ("serif:20:bold")

    % Initialize the items
    for itemNumber : 1 .. NUMBER_OF_ITEMS

	storeItem (itemNumber) := Pic.FileNew ("pictures/item" + intstr (itemNumber) + ".jpeg")
	storeItem (itemNumber) := Pic.Scale (storeItem (itemNumber), maxx div 8, maxy div 3.3)

    end for
    % Draw the various store items here.

    % First, check if the button was drawn before.
    if itemButtonCreated then

	% Refresh the GUI.
	GUI.Refresh

    else

	% Draw the health pack and it's name along with the price.
	for buttonNumber : 1 .. NUMBER_OF_ITEMS

	    buttonItem (buttonNumber) := GUI.CreatePictureButton (buttonX,
		maxy div 3.3, storeItem (buttonNumber), performPurchase)

	    % Increment the button's x coordinates.
	    buttonX += maxx div 4

	end for

	% Set the boolean to true.
	itemButtonCreated := true

    end if

    % Now write the name of the item long with it's price.
    Font.Draw ("Health Pack", maxx div 8, maxy div 4.2, font, black)
    Font.Draw ("$25", maxx div 8, maxy div 5, font, green)
    Font.Draw ("Health Increaser", maxx div 2.67,
	maxy div 4.2, font, black)
    Font.Draw ("$50", maxx div 2.67, maxy div 5, font, green)
    Font.Draw ("Armour Upgrade", maxx div 1.6, maxy div 4.2, font, black)
    Font.Draw ("$75", maxx div 1.6, maxy div 5, font, green)

end drawStoreItems

body procedure drawEnemyStrip (enemyNumber : int)

    % Draw the designated enemy strip.
    Pic.Draw (enemyStrips (enemyNumber), maxx div 2, maxy div 2, picMerge)
    View.Update

    % Now play the designated music.
    Music.PlayFile ("sounds/enemySound" + intstr (enemyNumber) + ".wav")

end drawEnemyStrip

body procedure enemyAttack

    % Local Declaration Section
    const DELAY_TIME := 50

    var heroHit : boolean

    % Main part of sub-program.
    % First, change the enemys type.
    enemysType := 9

    % Now continue changing the enemy type
    for enemysNumber : 1 .. 7

	% Change the enemystype
	enemysType += 1

	% Now perfrom delay and repaint the screen.
	delay (DELAY_TIME)

	cls

	drawScreen
	View.Update

    end for

    % Now change the enemy to it's original position.
    enemysType := 1

    delay (DELAY_TIME)

    cls

    drawScreen
    View.Update

    % Check if enemy hit the hero
    heroHit := checkIfObjectCollided (enemyX, enemyY,
	heroX, heroY, maxy div 3.3)

    if heroHit then

	heroIsHurt

    end if


end enemyAttack

body procedure enemyDead

    % Local Declaration Section
    const DELAY_TIME := 50
    const DELAY_TIME_2 := 500

    % Main process.

    % Play death music in parallel
    fork playEnemyKilled

    % Set the enemy type.
    enemysType := 2

    % Now, set the enemys health to 0.
    enemyHealth := 0

    % Now perform the fall to death action.
    for pictureNumber : 1 .. 7

	% Change the enemy type.
	enemysType += 1

	delay (DELAY_TIME)

	cls

	drawScreen
	View.Update

    end for

    % The enemy is not drawn now.
    enemyDrawn := false

    % Now, perform the xp regains.
    delay (DELAY_TIME_2)
    performXPRegain

    % Draw the dropping ball.
    drawDroppingBall

end enemyDead

body procedure enemyGetHit

    % Local Declaration Section
    const DELAY_TIME := 100

    var totalEnemyDamage : int

    % Now randomize the total damage the enemy will take.
    randint (totalEnemyDamage, heroDamageValue, (heroDamageValue * 2))

    % Now change the divident value.
    if enemyHealth not= 0 then

	% Now you can change the enemy's health
	enemyHealth -= totalEnemyDamage

    end if

    % Change the sprite of the enemy to hurt status if the enemy is not dead.

    if enemyIsDead = false then

	% Play the hit music in a process
	fork playHit

	% First set the hero's sprite to normal to avoid problems.
	heroNumber := 1

	% Move the enemy to the right
	enemyX += maxx div 16

	% Check to make sure that the enemy doesn't go past the limits of the screen.
	if enemyX >= maxx div 1.06 then

	    enemyX := maxx div 1.06

	end if

	% Now change the pictures of the specified enemy
	enemysType := 2

	cls

	drawScreen
	View.Update

	delay (DELAY_TIME)

	% Now change the pictures of the specified enemy
	enemysType := 1

	cls

	drawScreen
	View.Update

    end if

    % If enemy is just dead then perfrom fall to death action.
    if enemyIsDead = false and enemyHealth <= 0 then

	enemyDead

    end if

    % Check if the health is 0 and apply appropriate action.
    if enemyHealth <= 0 then

	enemyHealth := 0
	enemyDividentValue := 0
	enemyIsDead := true

    end if

end enemyGetHit

body procedure enemyJump


end enemyJump

body procedure goToStore

    % Local Declaration Section
    var font : int

    % Local Initialization Section
    font := Font.New ("serif:20:bold")

    % First of all, set no offscreenonly.
    View.Set ("nooffscreenonly")

    % Now draw the background.
    Pic.Draw (backgroundAsk, 1, 1, picCopy)

    % Now draw the total money that the user has.
    Font.Draw ("$" + intstr (money), maxx div 1.14, maxy div 1.1, font, brightgreen)

    % Now draw the items.
    drawStoreItems

    % Now redraw the older continue button.
    GUI.Refresh

    loop

	exit when GUI.ProcessEvent

    end loop

    % Reset it all to the correct position.
    % Now reset the screen.
    View.Set ("offscreenonly")
    delay (DELAY_TIME)

    cls

    drawScreen
    View.Update

    % Also, remember to refresh the gui button.
    GUI.ResetQuit

end goToStore

body procedure heroIsHurt

    % Local Declaration Section
    const DELAY_TIME := 50

    var damage : int

    % Main program

    % Check if the hero is in the front or back position.
    if heroIsBack then

	heroNumber := 9

    else

	heroNumber := 7

    end if

    % Play hit music in parallel.
    fork playHit

    % Perform neccessary action.
    heroX -= maxx div 50

    for numberOfTimes : 1 .. 2

	heroNumber += 1
	delay (DELAY_TIME)

	cls

	drawScreen
	View.Update

    end for

    % Now display the default position.
    heroNumber := 1
    delay (DELAY_TIME)

    cls

    drawScreen
    View.Update

    % Now randamize the damage
    randint (damage, enemyDamageStart, enemyDamageEnd)

    % Now reduce the hero health by a certain amount
    if damage - armour < 0 then

	heroHealth -= 0

    else

	heroHealth -= (damage - armour)

    end if

end heroIsHurt

body procedure initializeHero

    % Set the initial position of the hero
    heroX := maxx div 2

end initializeHero

body procedure loadGame (text : string)

    GUI.SetSelection (textFieldLoad, 0, 0)
    GUI.SetActive (textFieldLoad)

end loadGame

body procedure moveEnemyAhead

    % Local Declaration Section
    const DELAY_TIME := 50

    % Check to see which way the hero is facing to position the enemy.
    if heroX >= enemyX then

	% Position the enemy to face the right
	enemysType := 17

    else

	% Position the enemy to face the left.
	enemysType := 22

    end if

    % Move the enemy ahead.
    for enemyNumber : 1 .. 5

	enemysType += 1

	% Check to make sure that an appropriate incrementation occcurs.
	if enemysType = 18 then


	    enemyX += maxx div 50

	else

	    enemyX -= maxx div 50

	end if

	% Now check to make sure that the enemy does not go off the screen.
	if enemyX < 0 then

	    enemyX := 0

	elsif enemyX > maxx then

	    enemyX := maxx

	end if

	delay (DELAY_TIME)

	cls

	drawScreen
	View.Update

    end for

    % Now set the enemy to original position
    enemysType := 1

    cls

    drawScreen
    View.Update

end moveEnemyAhead

body procedure newGame (text : string)

    GUI.SetSelection (textFieldNewGame, 0, 0)
    GUI.SetActive (textFieldNewGame)

end newGame

body procedure obtainHeroHealth

    % Local Declaration Section
    var information : int
    var savedDataFile : int

    % First check if the game was loaded from a saved data file.
    if gameLoad then

	open : savedDataFile, savedData, get

	% Load the game's hero health information
	for numberOfTimes : 1 .. 5

	    get : savedDataFile, information

	    % Now check which level of information it is.
	    if numberOfTimes = 4 then

		heroHealth := information

	    elsif numberOfTimes = 5 then

		totalHealth := information

	    end if

	end for

	% Now close the window.
	close : savedDataFile

    else


	% Randomize the hero's health.
	randint (heroHealth, 50, 100)

	% Calculate total health.
	totalHealth := heroHealth

	% Now save the game.
	saveGame

    end if

end obtainHeroHealth

body procedure obtainHeroValue

    % Local Declaration Secton.
    var information : int

    % Now open the file that the user specified (saved data).
    open : savedDataFile, savedData, get

    % Now obtain the values from the saved data.
    for numberOfTimes : 1 .. 3

	get : savedDataFile, information

	% Check where the information should be stored.
	if numberOfTimes = 1 then

	    heroLevel := information

	elsif numberOfTimes = 2 then

	    armour := information

	elsif numberOfTimes = 3 then

	    money := information

	end if

    end for
    
    % Now close the file.
    close : savedDataFile

end obtainHeroValue

body procedure performAttackMovements

    % Local Declaration Section
    const DELAY_TIME_2 := 50
    const NUMBER_OF_PICTURES := 12

    var enemyHit : boolean

    % Change the pictures of the hero
    View.Set ("offscreenonly")

    % Set hero number.
    % Check the position of the hero.
    if heroIsBack then

	heroNumber := 30

    else

	heroNumber := 20

    end if

    for pictureNumber : 1 .. NUMBER_OF_PICTURES

	% Set key pressed to false to avoid problems with the arrow key.
	keysWerePressed := false

	heroNumber += 1

	% Delay, then clear screen
	delay (DELAY_TIME_2)

	cls

	drawScreen

	% Paste the images from buffer to the screeen now.
	View.Update

    end for

    % Now change the picture to default.
    % But, check if the hero is back.
    if heroIsBack then

	heroNumber := 5

    else

	heroNumber := 2

    end if

    % Delay, then clear screen
    delay (DELAY_TIME_2)

    cls

    drawScreen

    % Paste the images from buffer to the screeen now.
    View.Update

    % Now check if the enemy has been hit.
    % First, check if the enemy has been made.
    if enemyHealth not= 0 then

	% Now check if the enemy has been hit.
	enemyHit := checkIfObjectCollided (heroX, heroY, enemyX, enemyY,
	    maxy div 3.3)

	if enemyHit then

	    % Perform required actions.
	    enemyGetHit


	end if

    end if

end performAttackMovements

body procedure performComplexMovements

    % Local Declaration Section
    var choice : int

    % Now randamize and determine which execution path should be taken.
    randint (choice, 1, 10)

    % First check if the hero is within considerable range.
    if heroX + maxx div 40 = enemyX or heroX - maxx div 40 = enemyX then

	% Thus, the hero is within considerable range.
	enemyAttack

    else

	% Thus, the enemy is too far to be reached.
	% Check to make sure which execution path should be taken,
	if choice >= 1 and choice <= 8 then

	    moveEnemyAhead

	else

	    enemyJump

	end if

    end if

end performComplexMovements

body procedure performEnemyAction

    % Local Declaration Section
    var choice : int

    % Main process.

    % Check if the hero is made.
    if enemyDrawn then

	% Perform correct action to the enemy. The action should be randomized.
	% Randomize enemy action.
	randint (choice, 1, 100)

	% Perform according action.
	if choice >= 1 and choice <= 60 then

	    % Do Nothing

	elsif choice >= 61 and choice <= 80 then

	    performComplexMovements

	else

	    % For the remaining 20 percent.
	    enemyAttack

	end if

    end if

end performEnemyAction

body procedure performLoadGame

    % Declaration Section
    const TEXT := "Continue"
    const TEXT_FIELD := ""
    const WIDTH := 25
    const WIDTH_FIELD := 500

    var buttonContinue : int
    var fileExist : boolean
    var font : int
    var labelLoad : int
    var savedDataFile : int
    var times : int

    % Local Initialization Section
    font := Font.New ("serif:25")
    fileExist := false
    times := 0

    % Main process

    loop

	% First, colour the background grey.
	drawfillbox (1, 1, maxx, maxy, grey)

	% Now draw the text field.
	textFieldLoad := GUI.CreateTextField (maxx div 2.6, maxy div 1.6,
	    WIDTH_FIELD, TEXT_FIELD, loadGame)

	% Draw the label.
	labelLoad := GUI.CreateLabel (maxx div 2.6, maxy div 1.42,
	    "Enter your saved data name:")

	% Now draw the continue button.
	buttonContinue := GUI.CreateButton (maxx div 1.42, maxy div 1.90,
	    WIDTH, TEXT, GUI.Quit)

	% Now check if the user had failed to place a proper saved data title and
	% perform required operations.
	if fileExist = false and times = 1 then

	    % Draw an indicating message.
	    Font.Draw ("The saved data file that you entered does not exist",
		maxx div 2.6, maxy div 1.25, font, red)

	    % Increment times by 1.
	    times += 1

	end if

	loop
	    exit when GUI.ProcessEvent
	end loop

	% Check the saved data name.
	savedData := "savedData/" + GUI.GetText (textFieldLoad) + ".text"

	if File.Exists (savedData) then

	    fileExist := true

	else

	    fileExist := false

	end if

	% Dispose of the gui buttons.

	cls

	GUI.Dispose (textFieldLoad)
	GUI.Dispose (labelLoad)
	GUI.Dispose (buttonContinue)

	times += 1

	exit when fileExist

	% Reset the GUI.
	GUI.ResetQuit

    end loop

    % Now set the boolean to true.
    gameLoad := true

end performLoadGame

body procedure performMainAction

    % Local Declaration Section
    var widgetId : int

    % Local Initialization Section.
    widgetId := GUI.GetEventWidgetID

    % Main process.

    % First, dispose of the buttons.

    cls

    for buttonNumber : 1 .. 3

	GUI.Dispose (buttonMain (buttonNumber))

    end for

    % First, find out which button was clicked and apply appropriate actions.
    if widgetId = buttonMain (1) then

	% Now, perform the new game procedure.
	performNewGame

    elsif widgetId = buttonMain (2) then

	% Perform the load game procedure.
	performLoadGame

    elsif widgetId = buttonMain (3) then

	% Return from the procedure.
	exitGame := true
	GUI.Quit

    end if

end performMainAction

body procedure performNewGame

    % Local Declaration Section
    const TEXT := "Continue"
    const TEXT_FIELD := ""
    const WIDTH := 25
    const WIDTH_FIELD := 500

    var buttonContinue : int
    var labelButton : int

    % Main process

    % Colour the backgrounf gray.
    drawfillbox (1, 1, maxx, maxy, gray)

    % First create the text field.
    textFieldNewGame := GUI.CreateTextField (maxx div 2.6, maxy div 1.6,
	WIDTH_FIELD, TEXT_FIELD, newGame)

    % Now create the label for the text field.
    labelButton := GUI.CreateLabel (maxx div 2.6, maxy div 1.42,
	"Enter your new saved game data name")

    % Now create the button.
    buttonContinue := GUI.CreateButton (maxx div 1.42, maxy div 1.90,
	WIDTH, TEXT, GUI.Quit)

    loop
	exit when GUI.ProcessEvent
    end loop

    % Now create a file with the specified name.
    File.Copy ("savedData/example.text", "savedData/" +
	GUI.GetText (textFieldNewGame) + ".text")

    % Now initialize the saved data file name.
    savedData := "savedData/" + GUI.GetText (textFieldNewGame) + ".text"

    % First dispose of the button, text field, and label.
    GUI.Dispose (buttonContinue)
    GUI.Dispose (textFieldNewGame)
    GUI.Dispose (labelButton)

    % Set newgame to true.
    gameNew := true

end performNewGame

body procedure performPurchase

    % Local Declaration Section
    var font : int
    var purchaseValue : int
    var widgetId : int

    % Local Initialization Section
    font := Font.New ("serif:20:bold")

    % First check and assign purchase value.
    widgetId := GUI.GetEventWidgetID

    if widgetId = buttonItem (1) then

	% Perform purchase for health pack.
	purchaseValue := 25

	% Now, Check to see if the player has enough money for health pack.
	if money >= purchaseValue then

	    % Take away neccessary amount from total money.
	    money -= purchaseValue

	    % Perfrom purchase effect.
	    heroHealth := totalHealth

	end if

    elsif widgetId = buttonItem (2) then

	% Perform the purchase for the health increaser.
	purchaseValue := 50

	% Now, Check to see if the player has enough money for health pack.
	if money >= purchaseValue then

	    % Take away neccessary amount from total money.
	    money -= purchaseValue

	    % Perform the increase.
	    totalHealth += totalHealth div 5

	end if

    elsif widgetId = buttonItem (3) then

	% Perform the purchase for the health increaser.
	purchaseValue := 75

	% Now, Check to see if the player has enough money for health pack.
	if money >= purchaseValue then

	    % Take away neccessary amount from total money.
	    money -= purchaseValue

	    % Perform the increase.
	    armour += 15

	end if

    else

	% Indicate to the player that they do not have the
	% required amount of money.


    end if

    % Redraw screen.

    cls

    % Now draw the background
    Pic.Draw (backgroundAsk, 1, 1, picCopy)

    % Now draw the total money that the user has.
    Font.Draw ("$" + intstr (money), maxx div 1.14, maxy div 1.1, font, brightgreen)

    % Now write the name of the item long with it's price.
    Font.Draw ("Health Pack", maxx div 8, maxy div 4.2, font, black)
    Font.Draw ("$25", maxx div 8, maxy div 5, font, green)
    Font.Draw ("Health Increaser", maxx div 2.67,
	maxy div 4.2, font, black)
    Font.Draw ("$50", maxx div 2.67, maxy div 5, font, green)
    Font.Draw ("Armour Upgrade", maxx div 1.6, maxy div 4.2, font, black)
    Font.Draw ("$75", maxx div 1.6, maxy div 5, font, green)

    % Draw the buttons.
    GUI.Refresh

end performPurchase

body procedure performTuturial

    % Local Declaration Section
    const DELAY_TIME := 500

    var key : array char of boolean
    var tutor : array 1 .. 6 of int

    % Local Initialization Section
    for tutorNumber : 1 .. 6

	tutor (tutorNumber) := Pic.FileNew ("pictures/dialouge" +
	    intstr (tutorNumber) + ".jpeg")

	tutor (tutorNumber) := Pic.Scale (tutor (tutorNumber), maxx,
	    maxy div 3.3)

    end for

    % Main process

    % Draw the dialouges.
    for tutorNumber : 1 .. 6

	Pic.Draw (tutor (tutorNumber), 1, maxy div 1.43, picCopy)

	delay (DELAY_TIME)

	loop
	    Input.KeyDown (key)

	    if key ('a') or key ('A') then

		exit

	    end if

	end loop

    end for

    cls

    drawScreen
    View.Update

end performTuturial

body procedure performHeroDeath

    % Local Declaration Section
    const DELAY_TIME := 50
    const DELAY_TIME_2 := 5000


    var deathFont : int

    % Local Initialization Section
    deathFont := Pic.FileNew ("pictures/death.jpeg")

    % Play the hero death music in parallel.
    fork playHeroKilled

    % First, make the hero fall down.
    heroNumber := 11

    for numberOfTimes : 1 .. 8

	% Increment the hero's number by one.
	heroNumber += 1
	delay (DELAY_TIME)

	cls

	drawScreen
	View.Update

    end for

    % End the theme music.
    Music.PlayFileStop

    % Play death music in parallel.
    fork playDeath

    % Then, change the off screen settings.
    View.Set ("nooffscreenonly")

    % Now display the death logo.
    Pic.DrawSpecial (deathFont, maxx div 3, maxy div 3, picCopy, picFadeIn,
	DELAY_TIME_2)

    % Now set hero is dead to true.
    heroIsDead := true

end performHeroDeath

body procedure performJumpMovements

    % Local Declaration Section
    const DELAY_TIME := 100

    % Jump the hero up
    View.Set ("offscreenonly")

    heroY += delta
    delay (DELAY_TIME)

    cls

    drawScreen

    View.Update

    % Check if the jump is complete
    if heroY >= maxy div 1.42 then

	delta := -delta

    end if

    % Check if hero reached the ground
    if heroY <= maxy div 10 then

	delta := 0
	jumpUp := false

    end if

end performJumpMovements

body procedure performKeyboardMovement

    % Local Declaration Section
    const DELAY_TIME := 50

    var keys : array char of boolean

    % Local Initialization Section
    keysWerePressed := false

    % Check which keys, if any were pressed and apply correct action.
    View.Set ("offscreenonly")
    Input.KeyDown (keys)
    if keys (KEY_RIGHT_ARROW) then

	heroX += maxx div 50
	keysWerePressed := true

	% Check if the hero was drawn in this direction before.
	if heroNumber >= 5 and heroNumber <= 7 then

	    heroNumber := 2

	end if

	heroIsBack := false
	changePicture

	% Check if the hero is jumping.
	if jumpUp then

	    heroNumber := 2

	end if

	View.Update
	delay (DELAY_TIME)

    end if

    if keys (KEY_LEFT_ARROW) then

	heroX -= maxx div 50
	keysWerePressed := true

	% Check if the hero was drawn in this direction before.
	if heroNumber >= 1 and heroNumber <= 4 then

	    heroNumber := 5

	end if

	heroIsBack := true
	changePicture

	% Check if the hero is jumping.
	if jumpUp then

	    heroNumber := 5

	end if

	View.Update
	delay (DELAY_TIME)


    end if

    % Only work when the hero is not jumping
    if keys ('x') and jumpUp = false then

	performAttackMovements

	% Now perform the enemys move.
	performEnemyAction


    end if

    % Make the jumpUp false to avoid the hero from jumping twice.
    if keys ('z') and jumpUp = false then

	% Check if hero is back or front
	if heroIsBack then

	    heroNumber := 5

	else

	    heroNumber := 2

	end if

	% Initialize the variables
	delta := maxy div 6
	jumpUp := true

    end if

    % Check if the hero is jumping up.
    if jumpUp then

	performJumpMovements

	% Now perform enemys move.
	performEnemyAction

    end if

    % Check if heroNumber has reached a maximum
    if heroIsBack then

	if heroNumber > 7 then

	    heroNumber := 5

	end if

    else

	if heroNumber > 4 then

	    heroNumber := 2

	end if

    end if

    % If keys were pressed, clear and redraw the screen.
    if keysWerePressed then

	% First check and make sure that the hero does not go off screen.
	if heroX < 0 then

	    heroX := 0

	elsif heroX > maxx then

	    heroX := maxx

	end if

	cls

	drawScreen
	keysWerePressed := false
	View.Update

	%if jumpUp = false then

	% Free the pictures to allocate memory.
	%   freePictures

	%end if

	% Now perform the enemys move.
	performEnemyAction



    end if

end performKeyboardMovement

body procedure performLevelCalculations

    % Local Declaration Section
    var moneyAddition : int

    % Determine the new hero level.
    heroLevel += 1

    % Determine the additional money for the hero.
    randint (moneyAddition, 1, 50)

    % Now add to the hero's money.
    money += moneyAddition

end performLevelCalculations

body procedure performXPRegain

    % Local Declaration Section
    const DELAY_TIME := 50
    const TEXT_EXIT := "Continue"
    const WIDTH := 25

    var font : int
    var buttonExit : int

    % Local Initialization Section
    font := Font.New ("ravie:20")

    % First draw the ask background.
    Pic.Draw (backgroundAsk, 1, 1, picCopy)

    % Determine the change in level
    performLevelCalculations

    % Now tell the user which level they are.
    Font.Draw ("You are level " + intstr (heroLevel), maxx div 4, maxy div 1.25,
	font, red)

    % Now tell the user how much money they have.
    Font.Draw ("You have $" + intstr (money), maxx div 4, maxy div 1.6,
	font, brightgreen)

    % Now disable the off screen only.
    View.Set ("nooffscreenonly")

    % Now create the exit button.
    buttonExit := GUI.CreateButton (maxx div 1.3, maxy div 5, WIDTH,
	TEXT_EXIT, GUI.Quit)

    % Just reset the gui button, to be on the safe side.
    GUI.ResetQuit

    loop
	exit when GUI.ProcessEvent
    end loop

    % Also, remember to refresh the gui button.
    GUI.ResetQuit

    % Now go to the store.
    goToStore

end performXPRegain

body procedure resetBackground

    % Randamize the background.
    randint (backgroundNumber, 1, NUMBER_OF_BACKGROUNDS)

end resetBackground

body procedure resetEnemy

    % Local Declaration Section
    var endHealth : int
    var startHealth : int

    % Randamize enemy
    randint (enemyNumber, 1, 3)

    % Now generate the standing stance of the corresponding enemy
    enemysType := 1

    % Set the position of the enemy
    enemyX := maxx div 1.3
    enemyY := maxy div 10

    % Set the enemy drawn to true
    enemyDrawn := true

    % Now determine the health and the damage of the enemy
    % Enemy 1 is Shredder, enemy 2 is a monster, and enemy 3 is Thor.
    if enemyNumber = 1 then

	% Determien the health of the enemy.
	startHealth := 100
	endHealth := 150

	% Determine the damage of the enemy.
	enemyDamageStart := 20
	enemyDamageEnd := 30

    elsif enemyNumber = 2 then

	% Determine the health of the enemy.
	startHealth := 5
	endHealth := 50

	% Determine the damage of the enemy.
	enemyDamageStart := 0
	enemyDamageEnd := 15

    elsif enemyNumber = 3 then

	% Determine the health of the enemy.
	startHealth := 50
	endHealth := 100

	% Determine the damage of the enemy.
	enemyDamageStart := 15
	enemyDamageEnd := 25

    end if

    % Now determine the health of the enemy.
    determineEnemyHealth (startHealth, endHealth)

end resetEnemy

body procedure saveGame

    % Now add the hero's health to the saved data file.
    open : savedDataFile, savedData, put

    % Now put all the previous content first.
    put : savedDataFile, heroLevel

    put : savedDataFile, armour

    put : savedDataFile, money

    % Now enter the hero health.
    put : savedDataFile, heroHealth

    % Now enter the total hero health.
    put : savedDataFile, totalHealth

    % Close the saved data file.
    close : savedDataFile

end saveGame

body procedure setScreenForBattleLevel

    % Set the hero to the left side of the screen
    heroX := maxx div 16
    heroY := maxy div 10

    heroNumber := 1

    % Free the previous doors
    for doorNumber : 1 .. numberOfDoors

	Pic.Free (door (doorNumber))

    end for


end setScreenForBattleLevel

% Initialization Section
windowId := Window.Open ("graphics:max,max")

for BackgroundNumber : 1 .. NUMBER_OF_BACKGROUNDS

    background (BackgroundNumber) := Pic.FileNew ("pictures/background"
	+ intstr (BackgroundNumber) + ".jpeg")
    background (BackgroundNumber) := Pic.Scale (background (BackgroundNumber),
	maxx, maxy)

end for

backgroundAsk := Pic.FileNew ("pictures/backgroundAsk.jpeg")
backgroundAsk := Pic.Scale (backgroundAsk, maxx, maxy)

delta := maxy div 6
doorIsDrawn := false

% Initialize the enemy .
for numberOfEnemies : 1 .. 3

    for enemyType : 1 .. NUMBER_OF_ENEMIES_PICTURES

	enemy (numberOfEnemies, enemyType) := Pic.FileNew ("pictures/enemy" +
	    intstr (numberOfEnemies) + "movement/image" + intstr (enemyType) + ".jpeg")

	enemy (numberOfEnemies, enemyType) := Pic.Scale (enemy
	    (numberOfEnemies, enemyType), maxx div 16, maxy div 4.25)

    end for

end for

enemyDividentValue := 0
enemyDrawn := false
enemyIsDead := false
enemyHealth := 0

% Now initialize the enemy strips
for enemyStripNumber : 1 .. 3

    enemyStrips (enemyStripNumber) := Pic.FileNew ("pictures/enemyStrips/enemy" +
	intstr (enemyStripNumber) + "Strip.jpeg")
    enemyStrips (enemyStripNumber) := Pic.Scale (enemyStrips (enemyStripNumber),
	maxx div 4, maxy div 2.5)

end for

% Initialize the rest of the variables.

enemysType := 1
exitGame := false
% Initialize the hero.
hero (1) := Pic.FileNew ("pictures/hero.jpeg")
hero (1) := Pic.Scale (hero (1), maxx div 16, maxy div 4.25)

for heroNumbers : 2 .. 19

    hero (heroNumbers) := Pic.FileNew ("pictures/movementAnimations/image"
	+ intstr (heroNumbers - 1) + ".jpeg")
    hero (heroNumbers) := Pic.Scale (hero (heroNumbers), maxx div 16,
	maxy div 4.25)

end for

for heroNumbers : 20 .. 42

    hero (heroNumbers) := Pic.FileNew ("pictures/hitAnimations/image"
	+ intstr (heroNumbers - 19) + ".jpeg")
    hero (heroNumbers) := Pic.Scale (hero (heroNumbers), maxx div 16,
	maxy div 3.33)

end for

heroIsBack := false
heroIsDead := false
heroDamageValue := 5
heroDividentValue := 0
heroHealthFont := Font.New ("ravie:50")
heroNumber := 1
heroY := maxy div 10
itemButtonCreated := false
jumpUp := false
optionClicked := false
gameLoad := false
gameNew := false
pictureExtension := ""


% Main program

drawHeading

% Play main menu music.
fork playTheme

% First, draw the main menu.
drawMainMenu

% Check if the user closed the game.
if exitGame then

    % Close the window.
    Window.Close (windowId)
    
    Music.PlayFileStop
    return

end if

% End the menu music.
Music.PlayFileStop

obtainHeroValue
initializeHero

% Draw the doors (we need only one door in this level)
doorVanish := false
numberOfDoors := 1
createDoors (numberOfDoors)

% Set the first background
backgroundNumber := 1
obtainHeroHealth
drawScreen

% Play the new theme music.
fork playThemeLocal

% Check if this is a new game and perform a tuturial
if gameNew then

    performTuturial

end if

loop

    % Check if the hero is restarting from last checkpoint.
    if optionClicked then

	% First eliminate the enemy.
	enemyDrawn := false

	% Change the background.
	backgroundNumber := 1

	% Draw the doors (we need only one door in this level)
	doorVanish := false
	numberOfDoors := 1
	createDoors (numberOfDoors)

	% Change the hero's number.
	heroNumber := 1

	% Play the new theme music.
	fork playThemeLocal

	% Change hero's alive status.
	heroIsDead := false

	% Set the enemy's health to zero
	enemyHealth := 0

	% Set option clicked to false
	optionClicked := false

	% Obtain the hero's health.
	obtainHeroHealth
	drawScreen
	View.Update

    end if

    % First level (non-monster level)
    loop
	% Check if the hero moved and apply appropriate actions
	performKeyboardMovement

	% Check if level is complete
	checkIfLevelFirstIsComplete

	exit when levelComplete
    end loop

    loop

	% Now perform a save.
	saveGame

	% Set the screen for the next (battle) level

	cls

	setScreenForBattleLevel

	% Set neccessary boolean expressions to false.
	doorIsDrawn := false
	enemyIsDead := false
	levelComplete := false

	% Set the number of doors
	numberOfDoors := 2
	createDoors (numberOfDoors)
	resetBackground
	resetEnemy
	drawScreen

	% Vanish the doors
	doorVanish := true

	% Sub-Main level (Monster level)
	for numberOfTimes : 1 .. 5

	    % Check if hero moved and apply appropriate actions.
	    performKeyboardMovement

	end for

	% Now draw the enemy strip.
	drawEnemyStrip (enemyNumber)

	% Main level (Monster level)
	loop

	    % Check if hero moved and apply appropriate actions.
	    performKeyboardMovement

	    % Check if the hero is dead.
	    checkIfHeroIsDead

	    % Check if door is drawn.
	    if doorIsDrawn then

		% Check if the hero touches the door
		checkIfLevelFirstIsComplete
		doorVanish := false

		% Now update the screen.
		View.Update

		exit when levelComplete

	    end if

	    exit when heroIsDead

	end loop

	exit when heroIsDead

    end loop

    % Draw the after math options.
    drawAfterMath

    % End the theme music.
    Music.PlayFileStop

end loop
