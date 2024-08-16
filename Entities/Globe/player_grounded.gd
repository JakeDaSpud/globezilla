extends CharacterBody3D

@export var _move_speed : float = 5.0;
@export var _turning_speed : float = 0.1;
@export var _smooth_turn : bool = true;

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back");
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	
	if direction:
		velocity.x = direction.x * _move_speed;
		velocity.z = direction.z * _move_speed;
		
		var target_direction : Vector3 = self.global_position + direction;
		target_direction.y = 0;
		
		if _smooth_turn:
			# Slerp to new direction
			self.rotation = self.rotation;
		
		else:
			# Snap to the new direction
			self.look_at(target_direction, Vector3.UP);
	
	else:
		velocity.x = move_toward(velocity.x, 0, _move_speed)
		velocity.z = move_toward(velocity.z, 0, _move_speed)
	
	move_and_slide()
	
