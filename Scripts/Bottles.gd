extends Node2D

#Serves as a container for all current bottles in play
#Receives information about selected bottles

var bottle = preload("res://Objects/Bottle.tscn")
var PotionColors = Global.PotionColors

#Listed top to bottom
@export var bottles = {
	1: [PotionColors.RED, PotionColors.BLUE, PotionColors.GREEN, PotionColors.RED], 
	2: [PotionColors.GREEN, PotionColors.GREEN, PotionColors.BLUE],
	3: [PotionColors.RED],
	4: [null]
	}

var selectedBottle = null

func _ready():
	var bottlePosition = Vector2(500, 300)
	for item in bottles:
		var newBottle = bottle.instantiate()
		newBottle.PotionColors = PotionColors
		newBottle.slots.clear()
		for unit in bottles[item]:
			print(unit)
			newBottle.slots.append(unit)
		newBottle.position = bottlePosition
		bottlePosition.x += 64
		add_child(newBottle)
		newBottle.connect("selected", bottleSelected)

func bottleSelected(bottle : Node2D):
	print(bottle.position, " ", bottle.slots)
	if selectedBottle == null:
		selectedBottle = bottle
		bottle.select()
	elif selectedBottle == bottle:
		selectedBottle = null
		bottle.pour(bottle)
	else: 
		transfer(selectedBottle, bottle)
		selectedBottle = null
	pass

func transfer(from : Node2D, to : Node2D):
	var toValid = false
	var fromValid = false
	
	var color = null
	var count = 0
	
	var fromBottle = from.top()
	var toBottle = to.top()
	print(fromBottle)
	print(toBottle)
	
	#Check the destination bottle to make sure it has enough open slots
	if toBottle.empty >= fromBottle.count:
		toValid = true
	
	#Check the source bottle to make sure it has something to transfer
	if fromBottle.color != null:
		fromValid = true
	
	#Process the transfer
	if !toValid or !fromValid:
		from.pour(null)
		print("Cannot transfer")
	
	if toValid and fromValid:
		from.pour(to)
		to.fill(fromBottle.color, fromBottle.count)
