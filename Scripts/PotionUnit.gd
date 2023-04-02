extends Node2D

@export var color = Global.PotionColors.RED

@onready var sprite = $Sprite2D

func _ready():
	match color:
		Global.PotionColors.RED:
			sprite.self_modulate = Color("RED")
		Global.PotionColors.ORANGE:
			sprite.self_modulate = Color("DARK_ORANGE")
		Global.PotionColors.BLUE:
			sprite.self_modulate = Color("ROYAL_BLUE")
		Global.PotionColors.GREEN:
			sprite.self_modulate = Color("GREEN")
