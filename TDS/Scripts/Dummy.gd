extends CharacterBody3D

@export var health : float = 40

@onready var anim : AnimationPlayer = $Anim


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	death()


func death():
	if health<=0:
		hit()
		await get_tree().create_timer(0.2).timeout
		queue_free()
		
func hit():
	anim.play("Hit")
		


func _on_hitbox_area_entered(area):
	
	if area.is_in_group("Bullet"):
		
		health -= area.damage
		print(health)
		hit()
		
func knockback(direction):
	
	global_translate(direction * -0.35)
