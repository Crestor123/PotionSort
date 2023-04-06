extends Node2D


@onready var bottle = $Bottle
@onready var left = $LeftBottle
@onready var right = $RightBottle

var PotionColors = Global.PotionColors

signal selected(bottle)

func ready():
	left.connect("selected", select)
	
func select():
	pass
