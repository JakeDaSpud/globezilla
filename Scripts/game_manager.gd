extends Node3D

@export var _Spawn_Locations : Array;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Where the Package will spawn
func _choose_next_package_spawn():
	pass

func _spawn_package(spawn_location : Transform3D):
	pass

# Where the Package must be delivered
func _choose_next_package_destination():
	pass

func grabbed_package():
	pass
