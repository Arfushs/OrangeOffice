extends Area3D

@export var Speed : float = 10




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * Speed * delta *-1)
	
	
	
func _on_timer_timeout():
	
	queue_free()
