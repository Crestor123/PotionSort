extends Node2D

@export var color = Global.PotionColors.RED

@onready var sprite = $Sprite2D

func _ready():
	if color != Global.PotionColors.RED:
		if color == Global.PotionColors.BLUE:
			sprite.modulate = Color(0, 3, 100)
		if color == Global.PotionColors.GREEN:
			sprite.modulate = Color(0, 10, 0)
