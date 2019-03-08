% Thus program is a game that allows the user to go on
% a journey of a warrior

% Declaration Section
var gameClose : boolean
var itemQuantity : array 1 .. 3 of int
var money : int
var moneyAmount : int
var monster : string
var monsterDamage : int
var monsterHurt : int
var monsterLife : int
var response : string
var warriorLevel : int
var warriorLevelUp : int
var warriorLife : int
var warriorPower : int


procedure checkIfLost

    if warriorLife <= 0 then
	put skip, skip, "You Lost !"
	put skip, skip, " GAME OVER!"

	gameClose := true
	return
    end if

end checkIfLost

procedure checkItem

    if response = "1" and money >= 300 then
	money := money - 300
	itemQuantity (1) += 1

    elsif response = "2" and money >= 1000 then
	money := money - 1000
	itemQuantity (2) += 1

    elsif response = "3" and money >= 10000 then
	money := money - 10000
	itemQuantity (3) += 1

    end if

end checkItem

procedure checkResponse

    if response = "atk" then
	randint (warriorPower, 25, 45)
	monsterHurt := warriorLevelUp + warriorPower
	monsterLife := monsterLife - monsterHurt

	% Determine damage to player
	randint (monsterDamage, 20, 50)

	warriorLife := warriorLife - monsterDamage

    elsif response = "item" or response = "use item" then
	put skip, skip, "HEALTH PACK quantity ( ", itemQuantity (1), " ) "
	put skip, "DYNAMITE quantity ( ", itemQuantity (2), " ) "
	put skip, "SWORD OF EARL quantity ( ", itemQuantity (3), " ) "
	put skip, skip, "exit to exit shop"
	put skip, "What do you want to do, type in lowercase: " ..
	get response : *

	if response = "health pack" and itemQuantity (1) >= 1 then
	    warriorLife += 300
	    itemQuantity (1) -= 1
	elsif response = "dynamite" and itemQuantity (2) >= 1 then
	    monsterLife -= 250
	    itemQuantity (2) -= 1
	elsif response = "sword of earl" and itemQuantity (3) >= 1 then
	    warriorLevelUp += 150
	    itemQuantity (3) -= 1
	end if
	
	% Determine damage to player
	randint (monsterDamage, 20, 50)

	warriorLife := warriorLife - monsterDamage

    elsif response = "exit" then
	gameClose := true
	return

    else
	gameClose := true
	return

    end if

end checkResponse

procedure printIntroduction

    % Local declaration section
    var heading : int

    % Local Inizialization section
    heading := Font.New ("Vedetta:20:bold")
    
    % Colour background black
    drawfillbox (0, 0, maxx, maxy, black)
    
    % Displays the heading
    Font.Draw ("Monsters", maxx div 16, maxy div 1.2, heading, blue)

    % Displays the introduction
    locate (maxrow div 4, 1)
    Text.Colour (yellow)
    colourback (black) 
    put "Welcome to the world of war and danger"

end printIntroduction

procedure randomizeMonster

    % Local Declaration
    var number : int

    % Randomize Monster
    randint (number, 1, 3)

    if number = 1 then
	monster := "dragon"
    elsif number = 2 then
	monster := "troll"
    elsif number = 3 then
	monster := "giant"
    end if

    % Determine Monster life and damage
    if monster = "dragon" then
	monsterLife := 550
	monsterDamage := 40

    elsif monster = "troll" then
	monsterLife := 320
	monsterDamage := 60

    elsif monster = "giant" then
	monsterLife := 250
	monsterDamage := 35

    end if


end randomizeMonster


% Inizialization Section
setscreen ("graphics:max,max,nobuttonbar")
gameClose := false
itemQuantity (1) := 0
itemQuantity (2) := 0
itemQuantity (3) := 0
money := 0
monsterDamage := 0
warriorLife := 400
warriorLevel := 1
warriorLevelUp := 10


% Main program

printIntroduction

loop
    % main game prompt
    randomizeMonster
    Text.Colour (yellow)
    colourback (black)
    put skip, "You are walking and have come face to face with a .. ", monster

    loop
	put skip, skip, monster, " has " ..

	Text.Colour (magenta)
	colourback (black)
	put monsterLife, " life"

	Text.Colour (yellow)
	colourback (black)
	put skip, "warrior life " ..

	Text.Colour (magenta)
	colourback (black)
	put warriorLife

	Text.Colour (yellow)
	colourback (black)
	put skip, "atk, use item, or exit game"
	put skip, "what do you want to do? " ..
	get response

	checkResponse

	% Check if game is over
	if gameClose then
	    return
	end if

	exit when monsterLife <= 0 or warriorLife <= 0
    end loop

    checkIfLost

    if gameClose then
	return
    end if

    put skip, skip, "Great job, you defeated the ", monster

    warriorLevel := warriorLevel + 1
    warriorLevelUp += 35

    put skip, "You are now " ..

    Text.Colour (red)
    colourback (black)
    put "Level ", warriorLevel

    Text.Colour (yellow)
    colourback (black)

    randint (moneyAmount, 300, 500)
    money := money + moneyAmount

    put skip, "You have $ " ..

    Text.Colour (brightgreen)
    colourback (black)
    put money

    Text.Colour (yellow)
    colourback (black)
    put skip, skip, "Do You want to continue to shop? (yes or no) " ..
    get response

    if response = "yes" or response = "y" or response = "Yes" then

	put "WELCOME TO THE ACME SHOP OF GOODS"
	put skip, skip, "HEALTH PACK (1)" ..
	put "              $ 300"
	put skip, "DYNAMITE (2)" ..
	put "                 $ 1000"
	put skip, "SWORD OF EARL (3)" ..
	put "              $ 10 0000"
	put skip, "(4) to exit"
	put skip, skip, skip, "What do you want to do? " ..
	get response

	checkItem

    end if

end loop

