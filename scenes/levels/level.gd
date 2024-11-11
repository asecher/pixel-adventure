extends Node2D
class_name Level

@export var previous_level: String
@export var next_level: String

signal completed

var is_completed := false
var fruits_collected := 0
var fruits_to_collect := 0

func _ready() -> void:
	var collectibles = get_tree().get_nodes_in_group("fruit_collectible")
	for fruit in collectibles:
		fruits_to_collect += 1
		fruit.connect("collected", collect_fruit)
	print("fruits_to_collect: ", fruits_to_collect)

func collect_fruit() -> void:
	fruits_collected += 1
	print("fruit collected")
	
	if fruits_collected == fruits_to_collect:
		print("collected all fruits in level")
		emit_signal("completed")
		is_completed = true
