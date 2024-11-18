extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var hit_direction = (body.global_position - global_position).sign().x
	if body.has_method("hit"):
		body.hit(hit_direction)
