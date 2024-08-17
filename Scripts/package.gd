extends Node3D

@export var game_manager : Node3D;
@onready var mesh : Node3D = $Mesh;

@export var _rotation_speed : float = 1.5;
@export var _floating_bounds_amplitude : float = 2.0;
var _frequency : float = 1;
var _timer : int = 0;

func _ready():
	game_manager = get_parent();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mesh.rotation.y += _rotation_speed * delta;
	mesh.position.y = self.position.y + sin(_timer * _frequency) * _floating_bounds_amplitude;
	

func _on_area_3d_body_entered(body):
	print_debug("touched package");
	game_manager.grabbed_package();
	queue_free();
	
