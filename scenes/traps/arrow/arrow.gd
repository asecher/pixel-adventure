extends Area2D
class_name Arrow

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func activate(object: Node2D) -> void:
	animation_player.play("hit")
	if object is Player: 
		object.launch(Vector2(object.velocity.x, -875))

func _on_body_entered(body: Node2D) -> void:
	activate(body)
