extends Node2D

const LEVEL_1 := preload("res://scenes/levels/level_1.tscn")
const LEVEL_3 := preload("res://scenes/levels/level_3.tscn")
const LEVEL_6 := preload("res://scenes/levels/level_6.tscn")
const LEVEL_7 := preload("res://scenes/levels/level_7.tscn")

@onready var previous_button: TextureButton = $"../Navigation/MarginContainer/HBoxContainer/PreviousButton"
@onready var next_button: TextureButton = $"../Navigation/MarginContainer/HBoxContainer/NextButton"
@onready var camera_2d: Camera2D = $"../Camera2D"

var current_level_idx := 0
var current_level: Node
var levels := [
	LEVEL_1,
	LEVEL_3,
	LEVEL_6,
	LEVEL_7
]

func _ready() -> void:
	GameManager.camera = camera_2d
	
	current_level = LEVEL_7.instantiate()
	previous_button.visible = false
	add_child(current_level)
	
func _process(_delta: float) -> void:
	if current_level_idx == 0:
		next_button.visible = true
		previous_button.visible = false
	elif current_level_idx == levels.size() - 1:
		next_button.visible = false
		previous_button.visible = true
	else:
		next_button.visible = true
		previous_button.visible = true

func goto(index: int) -> void:
	current_level.queue_free()
	var level = levels[index].instantiate()
	current_level = level
	add_child(level)

func previous() -> void:
	current_level_idx -= 1
	goto(current_level_idx)

func next() -> void:
	current_level_idx += 1
	goto(current_level_idx)
	
func restart() -> void:
	goto(current_level_idx)


func _on_restart_button_pressed() -> void:
	restart()

func _on_next_button_pressed() -> void:
	next()

func _on_previous_button_pressed() -> void:
	previous()
