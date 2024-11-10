extends ParallaxBackground

@onready var parallax_layer: ParallaxLayer = $ParallaxLayer
@onready var sprite_2d: Sprite2D = $ParallaxLayer/Sprite2D

func _ready() -> void:
	get_random_background()

func _process(delta: float) -> void:
	parallax_layer.motion_offset.y += delta * 64

func get_random_background() -> void:
	var list = $Backgrounds.get_resource_list()
	sprite_2d.texture = $Backgrounds.get_resource(list[randi() % list.size()])
