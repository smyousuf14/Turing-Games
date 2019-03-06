
% programmer : Syed Yousuf

%       date : 2014-05-13

%  file name : TheWarriorsQuest.t

%    purpose : This is an RPG game that allows players to interact with an
%              imense world. Players can engage in combat against foes such
%              monsters and various other creatures.



% Declaration Section
const DELAY_TIME := 50
const NUMBER_OF_BACKGROUNDS := 13
const NUMBER_OF_DOORS := 2
const NUMBER_OF_ENEMIES_PICTURES := 22

var background : array 1 .. NUMBER_OF_BACKGROUNDS of int
var backgroundNumber : int
var delta : int
var door : array 1 .. NUMBER_OF_DOORS of int
var doorVanish : boolean
var doorX : array 1 .. 2 of int
var doorY : int
var doorIsDrawn : boolean
var enemy : array 1 .. 3, 1 .. NUMBER_OF_ENEMIES_PICTURES of int
var enemyAttacked : boolean
var enemyDividentValue : int
var enemyDrawn : boolean
var enemyIsDead : boolean
var enemyHealth : int
var enemyNumber : int
var enemyStrips : array 1 .. 3 of int
var enemysType : int
var enemyX : int
var enemyY : int
var hero : array 1 .. 34 of int
var heroAttacked : boolean
var heroIsBack : boolean
var heroDamageValue : int
var heroDividentValue : int
var heroHealth : int
var heroHealthFont : int
var heroNumber : int
var heroX : int
var heroY : int
var jumpUp : boolean
var keysWerePressed : boolean
var levelComplete : boolean
var numberOfDoors : int
var pictureExtension : string

forward procedure changePicture
forward function checkIfObjectCollided (object1X : int, object1Y : int,
    object2X : int, object2Y : int, object2Difference : int) : boolean
forward procedure checkIfEnemyIsHurt
forward procedure checkIfHeroHurt
forward procedure checkIfLevelFirstIsComplete
forward procedure createDoors (numberOfDoors : int)
forward procedure determineEnemyHealth (startHealth : int, endHealth : int)
forward procedure drawBars (dividentValue : int, enemyDividentValue : int)
forward procedure drawDroppingBall
forward procedure drawScreen
forward procedure drawEnemyStrip (enemyNumber : int)
forward procedure enemyAttack
forward procedure enemyDead
forward procedure enemyGetHit
forward procedure enemyIsHurt
forward procedure enemyJump
forward procedure heroIsHurt
forward procedure initializeHero
forward procedure moveEnemyAhead
forward procedure obtainHeroHealth
forward procedure performAttackMovements
forward procedure performJumpMovements
forward procedure performKeyboardMovement
forward procedure resetBackground
forward procedure resetEnemy
forward procedure setScreenForBattleLevel

process performEnemyAction

    % Local Declaration Section
    const DELAY_TIME := 2000
    var choice : int

    % Main process.
    loop
	% Check if the enemy is at zero health
	

	% Perform correct action to the enemy. The action should be randomized.

	% Randomize enemy action.
	randint (choice, 1, 100)

	% Perform according action.
	if choice >= 1 and choice <= 70 then

	    %moveEnemyAhead

	    % Check if the enemy is hurt.
	    checkIfEnemyIsHurt
	    
	    delay (DELAY_TIME)


	elsif choice >= 71 and choice <= 90 then

	    %enemyAttack

	    % Check if the enemy is hurt.
	    checkIfEnemyIsHurt
	    
	    delay (DELAY_TIME)


	elsif choice >= 91 and choice <= 100 then

	    enemyJump

	    % Check if the enemy is hurt.
	    checkIfEnemyIsHurt
	    
	    delay (DELAY_TIME)


	end if

	% Check if the enemy is hurt.
	checkIfEnemyIsHurt

    end loop

end performEnemyAction

body procedure changePicture

    % Change the pictures
    heroNumber += 1

end changePicture

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

body procedure checkIfEnemyIsHurt

    % Local Declaration Section
    var enemyHit : boolean

    % Check if the enemy attacked
    if heroAttacked then

	enemyHit := checkIfObjectCollided (heroX, heroY, enemyX,
	    enemyY, maxy div 3.3)

	if enemyHit then

	    enemyGetHit

	end if
	
     heroAttacked := false   

    end if

end checkIfEnemyIsHurt

body procedure checkIfHeroHurt

    % Local Declaration Section
    var heroHit : boolean

    % Check if the enemy attacked
    if enemyAttacked then

	% Check if the enemy hit the hero.
	heroHit := checkIfObjectCollided (enemyX, enemyY,
	    heroX, heroY, maxy div 3.3)

	if heroHit then

	    heroIsHurt

	end if

	% Change the value of the boolean expression.
	enemyAttacked := false

    end if


end checkIfHeroHurt

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

    % Main part of sub-program.
    % First, change the enemys type.
    enemysType := 9

    % Now set the value of boolean to true.
    enemyAttacked := true

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

    % Check if the enemy is hurt.
    checkIfEnemyIsHurt

end enemyAttack

body procedure enemyDead

    % Local Declaration Section
    const DELAY_TIME := 50

    % Main process.

    % Set the enemy type.
    enemysType := 2

    % Now perform the fall to death action.
    for pictureNumber : 1 .. 7

	% Change the enemy type.
	enemysType += 1

	delay (DELAY_TIME)

	cls

	drawScreen
	View.Update

    end for

    % Draw the dropping ball.
    drawDroppingBall

end enemyDead

body procedure enemyGetHit

    % Local Declaration Section
    const DELAY_TIME := 100
    const DELAY_TIME_2 := 600

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

    delay (DELAY_TIME_2)

end enemyGetHit

body procedure enemyIsHurt

    %

end enemyIsHurt

body procedure enemyJump


end enemyJump

body procedure heroIsHurt

    % Local Declaration Section
    const DELAY_TIME := 50
    const DELAY_TIME_2 := 200

    % Change the picture accordingly.
    for heroPicNumber : 31 .. 34

	% Set the hero's number
	heroNumber := heroPicNumber

	delay (DELAY_TIME)

	cls

	drawScreen
	View.Update

    end for

    % Delay extra time to allow enemy to finish theri attack.
    delay (DELAY_TIME_2)

end heroIsHurt

body procedure initializeHero

    % Set the initial position of the hero
    heroX := maxx div 2

end initializeHero

body procedure moveEnemyAhead

    % Local Declaration Section
    const DELAY_TIME := 50
    var randomizeNumber : int

    % Now randomize if the enemy should move forwards or backwards.
    randint (randomizeNumber, 0, 100)

    % There is 50 percent chance of either forward or backwards.
    if randomizeNumber >= 0 and randomizeNumber <= 50 then

	enemysType := 17

	% Move the enemy ahead.
	for enemyNumber : 18 .. 22

	    enemysType += 1
	    enemyX += maxx div 50

	    delay (DELAY_TIME)

	    cls

	    drawScreen
	    View.Update

	    % Check if the enemy is hurt.
	    checkIfEnemyIsHurt


	end for

    end if

    % Now set the enemy to original position
    enemysType := 1

    cls

    drawScreen
    View.Update

end moveEnemyAhead

body procedure obtainHeroHealth

    % Randomize the hero's health.
    randint (heroHealth, 50, 100)

end obtainHeroHealth

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

	heroNumber := 18

    else

	heroNumber := 7

    end if

    % Set the value of the boolean
    heroAttacked := true

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

end performAttackMovements

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

	% Check if the enemy hit the hero
	checkIfHeroHurt

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

	% Check if the enemy hit the hero
	checkIfHeroHurt


    end if

    % Only work when the hero is not jumping
    if keys ('x') and jumpUp = false then

	performAttackMovements

	% Check if the enemy hit the hero
	checkIfHeroHurt

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

	% Check if the enemy hit the hero
	checkIfHeroHurt

    end if

    % Check if the hero is jumping up.
    if jumpUp then

	performJumpMovements

	% Check if the enemy hit the hero
	checkIfHeroHurt

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

    % Check if the enemy hit the hero
    checkIfHeroHurt

    % If keys were pressed, clear and redraw the screen.
    if keysWerePressed then

	cls

	drawScreen
	keysWerePressed := false
	View.Update

	%if jumpUp = false then

	% Free the pictures to allocate memory.
	%   freePictures

	%end if

	% Check if the enemy hit the hero
	checkIfHeroHurt

    end if

end performKeyboardMovement

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

    % Now determine the health of the enemy
    if enemyNumber = 1 then

	startHealth := 100
	endHealth := 150

    elsif enemyNumber = 2 then

	startHealth := 5
	endHealth := 50

    elsif enemyNumber = 3 then

	startHealth := 50
	endHealth := 100

    end if

    % Now determine the health of the enemy.
    determineEnemyHealth (startHealth, endHealth)

end resetEnemy

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
setscreen ("graphics:max,max")

for BackgroundNumber : 1 .. NUMBER_OF_BACKGROUNDS

    background (BackgroundNumber) := Pic.FileNew ("pictures/background"
	+ intstr (BackgroundNumber) + ".jpeg")
    background (BackgroundNumber) := Pic.Scale (background (BackgroundNumber),
	maxx, maxy)

end for

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

enemyAttacked := false
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
% Initialize the hero.
hero (1) := Pic.FileNew ("pictures/hero.jpeg")
hero (1) := Pic.Scale (hero (1), maxx div 16, maxy div 4.25)

for heroNumbers : 2 .. 7

    hero (heroNumbers) := Pic.FileNew ("pictures/movementAnimations/image"
	+ intstr (heroNumbers - 1) + ".jpeg")
    hero (heroNumbers) := Pic.Scale (hero (heroNumbers), maxx div 16,
	maxy div 4.25)

end for

for heroNumbers : 8 .. 30

    hero (heroNumbers) := Pic.FileNew ("pictures/hitAnimations/image"
	+ intstr (heroNumbers - 7) + ".jpeg")
    hero (heroNumbers) := Pic.Scale (hero (heroNumbers), maxx div 16,
	maxy div 3.33)

end for

for heroNumbers : 31 .. 34

    hero (heroNumbers) := Pic.FileNew ("pictures/movementAnimations/image"
	+ intstr (heroNumbers - 24) + ".jpeg")
    hero (heroNumbers) := Pic.Scale (hero (heroNumbers), maxx div 16,
	maxy div 4.25)

end for

heroAttacked := false
heroIsBack := false
heroDamageValue := 5
heroDividentValue := 0
heroHealthFont := Font.New ("ravie:50")
heroNumber := 1
heroY := maxy div 10
jumpUp := false
pictureExtension := ""



% Main program
initializeHero

% Draw the doors (we need only one door in this level)
doorVanish := false
numberOfDoors := 1
createDoors (numberOfDoors)

% Set the first background
backgroundNumber := 1
obtainHeroHealth
drawScreen

% First level (non-monster level)
loop
    % Check if the hero moved and apply appropriate actions
    performKeyboardMovement

    % Check if level is complete
    checkIfLevelFirstIsComplete

    exit when levelComplete
end loop

loop

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
    
	% Run the process in another thread
	fork performEnemyAction

	% Check if hero moved and apply appropriate actions.
	performKeyboardMovement

	% Check if the enemy hit the hero
	checkIfHeroHurt

	% Check if door is drawn.
	if doorIsDrawn then

	    % Check if the hero touches the door
	    checkIfLevelFirstIsComplete
	    doorVanish := false

	    % Now update the screen.
	    View.Update

	    exit when levelComplete

	end if

    end loop

end loop
