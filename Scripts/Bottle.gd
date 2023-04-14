extends Node2D

class_name Bottle

@onready var liquid = $Mask/Liquid
@onready var button = $Button
@onready var anim = $AnimationPlayer

var potionUnit = preload("res://Objects/PotionUnit.tscn")
var PotionColors = Global.PotionColors

#Listed top to bottom
@export var slots = [null, null, null, null]
var liquidSlots = [null, null, null, null]

var liquidPosition = 24
var type = "normal"

signal selected(bottle)

func _ready():
	print(global_position)
	print(slots)
	while slots.size() != 4:
		slots.push_front(null)
	
	var i = slots.size() - 1
	while i >= 0:
		if slots[i] != null:
			var newPotion = potionUnit.instantiate()
			newPotion.color = slots[i]
			newPotion.position = Vector2(0, liquidPosition)
			liquid.add_child(newPotion)
			liquidSlots[i] = newPotion
			liquidPosition -= 16
		i = i - 1

func select():
	#Called by the node's parent to confirm the selection
	#Play an animation of the bottle raising up slightly
	anim.play("select")
	pass

func top():
	#Return the number and color of the topmost layer
	var topLayer = {"color": null, "count": 0, "empty": 0}
	for slot in slots:
		if slot == null:
			topLayer.empty = topLayer.empty + 1
		if slot != null and topLayer.color == null:
			topLayer.color = slot
	
	if topLayer.color != null:
		for slot in slots:
			if slot == null: continue
			if slot == topLayer.color:
				topLayer.count = topLayer.count + 1
			else: break
			
	return topLayer
	pass
	
func pour(target : Node2D):
	#Play an animation of the bottle pouring into the target
	#Remove the topmost layer of the bottle
	var topLayer = top()
	var firstSlot = slots.find(topLayer.color)
	
	if target == self:
		anim.play_backwards("select")
		return
	if target == null:
		anim.play("invalid")
		return
	
	if topLayer.count > 0:
		for i in range(firstSlot, firstSlot + topLayer.count):
			if liquidSlots[i] != null:
				liquidSlots[i].queue_free()
				liquidSlots[i] = null
				liquidPosition += 16
			slots[i] = null
			
	anim.play_backwards("select")
	pass
	
func fill(color : int, count : int):
	#Fill a number of slots with the given color, starting from the bottom
	#Play an animation of the slots filling up
	var firstSlot = slots.rfind(null) + 1
	
	for i in range(firstSlot - count, firstSlot):
		slots[i] = color
		var newPotion = potionUnit.instantiate()
		newPotion.color = color
		newPotion.position = Vector2(0, liquidPosition)
		liquid.add_child(newPotion)
		liquidSlots[i] = newPotion
		liquidPosition -= 16
	pass

func updateBottle():
	pass

func _on_button_pressed():
	emit_signal("selected", self)
