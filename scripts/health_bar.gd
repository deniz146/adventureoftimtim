extends Node2D


@onready var player = %player
var value
var valuemana
@onready var mana_1 = $mana1
@onready var mana_2 = $mana2
@onready var mana_3 = $mana3
@onready var health = $health
@onready var health_2 = $health2
@onready var health_3 = $health3



func _process(delta):
	value = player.health
	valuemana = player.mana
	health.value = value
	health_2.value = value
	health_3.value = value
	mana_1.value = valuemana
	mana_2.value = valuemana
	mana_3.value = valuemana


