extends Node2D

@onready var leftLiquid = $Mask/LeftLiquid
@onready var rightLiquid = $Mask/RightLiquid
@onready var leftButton = $LeftButton
@onready var rightButton = $RightButton

var potionUnit = preload("res://Objects/PotionUnit.tscn")
var PotionColors = Global.PotionColors

#listed top to bottom
@export var leftSlots = [null, null]
@export var rightSlots = [null, null]
var leftLiquidSlots = [null, null]
var rightLiquidSlots = [null, null]

var leftLiquidPosition = Vector2(-16, 0)
var rightLiquidPosition = Vector2(16, 0)

signal selected(bottle)
