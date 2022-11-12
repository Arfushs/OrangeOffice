extends Node3D

@onready var player : CharacterBody3D = $CharacterBody3D 
@onready var camera : Camera3D = $Camera3D
@onready var mesh : Node3D = $"Debug Pointer"

var ray_origin = Vector3()
var ray_target = Vector3()

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
		player.look_at(pos,Vector3.UP)
		
