extends Node2D


@onready var player = %player
var value
var valuemana


@onready var mana = $mana
@onready var health_ = $health_


func _process(delta):
	var value = player.health
	var valuemana = player.mana
	mana.value = valuemana
	health_.value = value

