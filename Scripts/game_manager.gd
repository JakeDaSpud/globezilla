extends Node3D

@onready var _ui_country = $UI/OnScreenCountry;
@onready var _ui_timer = $UI/OnScreenTimer;

const package_entity = preload("res://Entities/Package/package.tscn");
const destination_trigger_entity = preload("res://Entities/Package/package_destination.tscn");

@export var _Spawn_Locations : Array[Node3D];

var _CURRENT_spawn_location : Node3D;
var _CURRENT_destination_location : Node3D;

# Called when the node enters the scene tree for the first time.
func _ready():
	_next_package();
	_spawn_package();
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

# Where the Package will spawn
func _next_package():
	_CURRENT_spawn_location = _Spawn_Locations.pick_random();
	

# Instantiate Package at spawn location
func _spawn_package():
	
	# Create entity and set location
	var package = package_entity.instantiate();
	package.position = _CURRENT_spawn_location.position;
	
	# Spawn it
	add_child(package);
	print_debug("spawned PACKAGE");
	
	# Make sure we can't use this location again
	_CURRENT_spawn_location.use();
	

# Where the Package must be delivered
func _next_destination():
	_CURRENT_destination_location = _Spawn_Locations.pick_random();
	if _CURRENT_destination_location == _CURRENT_spawn_location:
		_next_destination();
	

# Instantiate Destination at right location
func _spawn_destination():
	
	# Create entity and set location
	var destination = destination_trigger_entity.instantiate();
	destination.position = _CURRENT_destination_location.position;
	destination.can_touch = true;
	
	# Spawn it
	add_child(destination);
	print_debug("spawned DESTINATION");
	

# Grabbed package -> bring it to the destination now
func grabbed_package():
	# Make sure this location hasn't been used already
	_next_destination();
	# Finally, spawn in a valid location
	_spawn_destination();
	

# Delivered package -> go get the next one now
func delivered_package():
	_next_package();
	_spawn_package();
	
