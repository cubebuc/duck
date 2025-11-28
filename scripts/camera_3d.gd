extends Camera3D

const RAY_LENGTH = 1000

func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	
	var forward_vec = self.transform.basis.z
	
	var query = PhysicsRayQueryParameters3D.create(self.position, self.position + forward_vec*10)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	var colliding_obj = result.collider
	if colliding_obj.is_in_group("camera_ray_collider_group"):
		colliding_obj.camera_ray_entered()
	
	return
	
