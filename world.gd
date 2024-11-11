extends Node2D

@onready var previous_button: TextureButton = $"../Navigation/MarginContainer/HBoxContainer/PreviousButton"
@onready var next_button: TextureButton = $"../Navigation/MarginContainer/HBoxContainer/NextButton"
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var levels: ResourcePreloader = $Levels

var current_level: Level
var current_level_ressource_name: String

func _ready() -> void:
	GameManager.camera = camera_2d
	load_level("level_1")
	
func _process(_delta: float) -> void:
	if not current_level:
		pass
	
	previous_button.visible = true if current_level.previous_level else false
	if current_level.next_level and current_level.is_completed:
		next_button.visible = true
	else:
		next_button.visible = false

func load_level(level_name: String) -> void:
	unload_current_level()
	current_level = levels.get_resource(level_name).instantiate()
	current_level_ressource_name = level_name
	add_child(current_level)

func unload_current_level() -> void:
	if current_level:
		current_level.queue_free()
	current_level = null

func previous() -> void:
	if current_level and current_level.previous_level:
		load_level(current_level.previous_level)

func next() -> void:
	if current_level and current_level.next_level:
		load_level(current_level.next_level)
	
func restart() -> void:
	load_level(current_level_ressource_name)


func _on_restart_button_pressed() -> void:
	restart()

func _on_next_button_pressed() -> void:
	next()

func _on_previous_button_pressed() -> void:
	previous()
