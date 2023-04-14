extends Node2D


@onready var bottle = $Bottle
@onready var left = $LeftBottle
@onready var right = $RightBottle

var PotionColors = Global.PotionColors

signal selected(bottle)

func _ready():
	left.selected.connect(select)
	left.type = "mix"
	right.selected.connect(select)
	right.type = "mix"
	
func select(bottle : Node2D):
	emit_signal("selected", bottle)
	pass
