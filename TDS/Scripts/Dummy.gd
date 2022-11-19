extends CharacterBody3D

@export var health : float = 40

@onready var anim : AnimationPlayer = $Mannequin/AnimationPlayer

var doOnce = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	death()


func death():
	
	if health<=0 && doOnce:
		doOnce = false
		hit()
		anim.play("MannequinDead")
		frame_freeze(0.05,0.3)
		await get_tree().create_timer(0.5).timeout
		queue_free()
		
func hit():
	anim.play("Mannequin_Hit")

		


func _on_hitbox_area_entered(area):
	
	if area.is_in_group("Bullet"):
		
		health -= area.damage
		##print(health)
		hit()
		
func knockback(direction):
	
	global_translate(direction * -0.35)
	
	
func frame_freeze(time_scale,duration):
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale).timeout 
	Engine.time_scale = 1.0
	
