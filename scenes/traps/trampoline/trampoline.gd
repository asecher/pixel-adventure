extends StaticBody2D
class_name Trampoline

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func activate(object: Node) -> void:
	animated_sprite_2d.play("jump")
	if object is Player: 
		object.launch(Vector2(object.velocity.x, -1175))
