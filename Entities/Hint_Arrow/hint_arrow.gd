extends Node3D

@onready var mesh : Node3D = $Mesh;

@export var _rotation_speed : float = 1.5;
@export var _floating_bounds_amplitude : float = 0.1;
@export var _frequency : float = 2;
var _timer : float = 0;
var _initial_pos : Vector3;
var _initial_scale : Vector3;

func _ready():
	_initial_pos = mesh.position;
	_initial_scale = mesh.scale;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mesh.rotation.y -= _rotation_speed * delta;
	
	_timer += delta * _frequency;
	var _delta_change = sin(_timer) * _floating_bounds_amplitude;
	mesh.scale.x = _initial_scale.x + _delta_change;
	mesh.scale.y = _initial_scale.y + _delta_change;
	mesh.scale.z = _initial_scale.z + _delta_change;
	mesh.position.y = _initial_pos.y + _delta_change;
	
