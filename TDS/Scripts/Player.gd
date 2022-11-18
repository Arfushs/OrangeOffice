extends CharacterBody3D


@export var SPEED = 10.0
@export var Bullet: PackedScene
@export var max_ammo = 10
@onready var rotator:Node3D = $Rotation
var input_dir: Vector2
@onready var anim : AnimationTree = $Rotation/main_character/AnimationTree

var ammo = max_ammo

signal ammo_spent(ammo,max_ammo)


func _physics_process(delta):
	movement_function()
	animHandle()
	shoot()
	
	if Input.is_action_just_pressed("reload") && ammo != max_ammo:
		reload()

func _process(delta):
	if ammo ==0:
		$Reload/CanvasLayer/Label.visible = true


func movement_function():
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		anim.set("parameters/Movement_vector/blend_position",Vector2(0,0))

	move_and_slide()


func shoot():
	
	if Input.is_action_just_pressed("ui_accept") && ammo != 0:
		
		$shoot.play()
		anim.set("parameters/FireGate/active",true)
		
		var new_bullet = Bullet.instantiate()
		new_bullet.global_transform = $Rotation/Marker3D.global_transform
		new_bullet.scale.x = 0.07
		new_bullet.scale.y = 0.07
		new_bullet.scale.z = 0.07
		
		var scene_root = get_tree().get_root().get_children()[0]
		ammo -=1
		scene_root.add_child(new_bullet)
		emit_signal("ammo_spent",ammo,max_ammo)
		
		
func reload():
	$Reload/CanvasLayer/Label.visible = false
	$ReloadSound.play()
	ammo = max_ammo
	emit_signal("ammo_spent",ammo,max_ammo)
		
func animHandle():
	
	var tempVector1 = rotator.global_transform.basis * Vector3(input_dir.x,0,input_dir.y)
	print(tempVector1.normalized())
	var animVector:= Vector2(tempVector1.x,tempVector1.z)
	anim.set("parameters/Movement_vector/blend_position", animVector)
	if (velocity != Vector3(0,0,0)):
		anim.set("parameters/turnblending/blend_amount", 1)
		

