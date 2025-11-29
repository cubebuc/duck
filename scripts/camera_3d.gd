extends Camera3D

const RAY_LENGTH = 1000
#var last_collider
var detected_colliders: Array = []

func _physics_process(delta):
	raycast_forward_and_invoke_colliders()

	
func raycast_forward_and_invoke_colliders():
		#Cast a ray and find the collider
	var space_state = get_world_3d().direct_space_state

	var box_shape = BoxShape3D.new()
	box_shape.size = Vector3(0.01, 0.01, RAY_LENGTH)

	var query = PhysicsShapeQueryParameters3D.new()
	query.shape = box_shape
	query.transform = global_transform
	query.collide_with_areas = true

	var results = space_state.intersect_shape(query, 20)

	for result in results:
		var colliding_obj = result.get("collider")
		#Check if it is the camera one
		var in_group = colliding_obj.is_in_group("camera_ray_collider_group")
		var already_detected = detected_colliders.has(colliding_obj)
		if in_group and not already_detected:
			colliding_obj.camera_ray_entered()
			detected_colliders.append(colliding_obj)

	#Check for colliders that are no longer detected
	var colliders_to_remove: Array = []
	for detected in detected_colliders:
		var still_detected = false
		for result in results:
			var colliding_obj = result.get("collider")
			if colliding_obj == detected:
				still_detected = true
				break
		if not still_detected:
			detected.camera_ray_left()
			colliders_to_remove.append(detected)
	for collider in colliders_to_remove:
		detected_colliders.erase(collider)

			
	'''
	var query = PhysicsRayQueryParameters3D.create(self.global_position, self.global_position + forward_vec * RAY_LENGTH)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	var colliding_obj = result.get("collider")
	print(result)

	print(results)
	
	for result in results:
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

'''
