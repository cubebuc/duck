extends Camera3D

const RAY_LENGTH = 1000
var last_collider

func _physics_process(delta):
	raycast_forward_and_invoke_colliders()

	
func raycast_forward_and_invoke_colliders():
		#Cast a ray and find the collider
	var space_state = get_world_3d().direct_space_state
	
	var forward_vec = self.global_basis * Vector3.FORWARD
	
	var query = PhysicsRayQueryParameters3D.create(self.position, self.position + forward_vec*RAY_LENGTH)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	var colliding_obj = result.get("collider")
	
	
	#Check if the collider exists and whether it is the camera one
	if colliding_obj and colliding_obj.is_in_group("camera_ray_collider_group"):
		#If last collider exists -> swap it for the current one if they are different
		if last_collider:
			if last_collider == colliding_obj:
				return
			last_collider.camera_ray_left()
		
		colliding_obj.camera_ray_entered()
		last_collider = colliding_obj
	
	#No collider found -> undo last collider
	elif last_collider:
		last_collider.camera_ray_left()
		last_collider = null
	
	return
