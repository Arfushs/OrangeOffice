extends Node3D

@onready var player : CharacterBody3D = $CharacterBody3D 
@onready var camera : Camera3D = $CharacterBody3D/Camera3D
@onready var mesh : Node3D = $"Debug Pointer"
@onready var Text : Label = $PlayerUI/CanvasLayer/Bullet/Label

var ray_origin = Vector3()
var ray_target = Vector3()

var time = 0

func _process(delta): #Time
	time +=delta
	var secs = fmod(time,60)
	var min = fmod(time,60*60) / 60
	var time_passed = "%02d : %02d" % [min,secs]
	$PlayerUI/CanvasLayer/Time/time_label.text = time_passed
	
	var enemy_number = get_tree().get_nodes_in_group("Enemy").size()
	$PlayerUI/CanvasLayer/Dummy/Label.text = str(enemy_number)

func _physics_process(delta):
	
	
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 100
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	
	
	if raycast_result.position != null:
		mesh.position = raycast_result.position
		var pos : Vector3 = raycast_result.position
		pos.y = self.rotation.y
		##player.look_at(pos,Vector3.UP)
		$CharacterBody3D/Rotation.look_at(pos,Vector3.UP)
	
	
	end_game()


func _on_character_body_3d_ammo_spent(ammo, max_ammo): ## Mermi Sayısı
	
	if ammo <10:
		Text.text = "  " + str(ammo) + "/" + str(max_ammo)
	else:
		Text.text = str(ammo) + "/" + str(max_ammo)

func end_game():
	
	if get_tree().get_nodes_in_group("Enemy"): ## Sahnede Enemy var mı yok mu
		pass
	
		



