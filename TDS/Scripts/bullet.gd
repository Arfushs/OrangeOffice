extends Area3D

@export var Speed : float = 10
@export var damage: float = 10
@export var death_time : float = 1


func _ready():
	$Timer.wait_time = death_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * Speed * delta *-1)
	
	rotation.z += .2
	
func _on_timer_timeout():
	
	queue_free()
	
	

func _on_body_entered(body):
	
	if body.is_in_group("Enemy"):
		var forward_direction = global_transform.basis.z.normalized()
		body.knockback(forward_direction)
		queue_free()
