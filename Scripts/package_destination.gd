extends Node3D

@export var game_manager : Node3D;
var can_touch : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager = get_parent();

func activate_touch():
	can_touch = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_3d_body_entered(_body):
	if (can_touch):
		print_debug("delivered package");
		game_manager.delivered_package();
		queue_free();
	
