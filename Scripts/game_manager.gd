extends Node3D

@onready var _ui_country = $UI/OnScreenCountry;
@onready var _ui_timer = $UI/OnScreenTimer;

const package_entity = preload("res://Entities/Package/package.tscn");
const destination_trigger_entity = preload("res://Entities/Package/package_destination.tscn");
const spawn_location_entity = preload("res://Scripts/package_spawn_location.gd");

@export var _Spawn_Locations : Array[spawn_location_entity];

var _CURRENT_spawn_location : spawn_location_entity;
var _CURRENT_destination_location : spawn_location_entity;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_next_package();
	_spawn_package();
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass
	

# Where the Package will spawn
func _next_package() -> void:
	_CURRENT_spawn_location = _Spawn_Locations.pick_random();
	

# Instantiate Package at spawn location
func _spawn_package() -> void:
	
	# Create entity and set location
	var package = package_entity.instantiate();
	package.position = _CURRENT_spawn_location.position;
	_ui_country.set_text("Package at: " + _CURRENT_spawn_location.get_country_name());
	
	# Spawn it
	add_child(package);
	print_debug("spawned PACKAGE");
	
	# Make sure we can't use this location again
	_CURRENT_spawn_location.use();
	

# Where the Package must be delivered
func _next_destination() -> void:
	_CURRENT_destination_location = _Spawn_Locations.pick_random();
	if _CURRENT_destination_location == _CURRENT_spawn_location:
		_next_destination();
	

# Instantiate Destination at right location
func _spawn_destination() -> void:
	
	# Create entity and set location
	var destination = destination_trigger_entity.instantiate();
	destination.position = _CURRENT_destination_location.position;
	destination.can_touch = true;
	_ui_country.set_text("Deliver to: " + _CURRENT_destination_location.get_country_name());
	
	# Spawn it
	add_child(destination);
	print_debug("spawned DESTINATION");
	

# Grabbed package -> bring it to the destination now
func grabbed_package() -> void:
	# Make sure this location hasn't been used already
	_next_destination();
	# Finally, spawn in a valid location
	_spawn_destination();
	

# Delivered package -> go get the next one now
func delivered_package() -> void:
	_next_package();
	_spawn_package();
	
