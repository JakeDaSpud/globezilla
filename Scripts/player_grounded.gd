extends CharacterBody3D

var game_manager : Node3D;

@onready var animation_tree : AnimationPlayer = $Mesh/globe_animated/AnimationPlayer;

@export var _move_speed : float = 5.0;
@export var _acceleration_speed : float = 5.0;

@export var _turning_speed : float = 10;
@export var _smooth_turn : bool = true;

func _ready():
	game_manager = get_parent();
	animation_tree.play("Idle");

func _physics_process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene();
	
	if Input.is_action_just_pressed("hint"):
		game_manager.hint();
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back");
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized();
	
	if direction:
		animation_tree.play("Walking");
		
		var target_direction : Vector3 = direction;
		var target_rotation : Basis = Transform3D().looking_at(target_direction, Vector3.UP).basis;
		var current_rotation : Basis = self.global_basis;
	
		velocity.x = direction.x * _move_speed;
		velocity.z = direction.z * _move_speed;
		
		if !_smooth_turn:
			# Snap to the new direction
			self.look_at(target_direction);
		else:
			var smooth_rotation : Basis = current_rotation.slerp(target_rotation, _turning_speed * delta);
			self.global_basis = smooth_rotation;
	
	else:
		if velocity == Vector3.ZERO:
			animation_tree.play("Idle");
		
		velocity.x = move_toward(velocity.x, 0, _acceleration_speed);
		velocity.z = move_toward(velocity.z, 0, _acceleration_speed);
	
	move_and_slide()
	
