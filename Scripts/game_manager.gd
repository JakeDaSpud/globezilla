extends Node3D

@onready var _ui_country = $UI/OnScreenCountry;
@onready var _ui_timer = $UI/OnScreenTimer;

const package_entity = preload("res://Entities/Package/package.tscn");

@export var _Spawn_Locations : Array;

var _current_package_spawn_location : Node3D;
var _current_package_destination : Node3D;

# Called when the node enters the scene tree for the first time.
func _ready():
	_choose_next_package_spawn_location();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Where the Package will spawn
func _choose_next_package_spawn_location():
	_current_package_spawn_location = _Spawn_Locations.pick_random();
	

# Instantiate Package at spawn location
func _spawn_package():
	
	# Create entity and set location
	var package = package_entity.instantiate();
	package.position = _current_package_spawn_location;
	
	# Spawn it
	add_child(package);
	
	# Make sure we can't use this location again
	_current_package_spawn_location.use();
	

# Where the Package must be delivered
func _choose_next_package_destination():
	pass

func grabbed_package():
	while _current_package_spawn_location.has_been_used:
		_choose_next_package_destination();
	
