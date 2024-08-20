extends Node3D

@onready var _ui_country = $UI/OnScreenCountry;
@onready var _ui_timer = $UI/OnScreenTimer;
@onready var _ui_final_time = $UI/OnScreenFinalTime;

@onready var _sfx_hint = $SFX_Hint;
@onready var _sfx_package = $SFX_Package;
@onready var _sfx_delivery = $SFX_Delivery;

const package_entity = preload("res://Entities/Package/package.tscn");
const destination_trigger_entity = preload("res://Entities/Package/package_destination.tscn");
const spawn_location_entity = preload("res://Scripts/package_spawn_location.gd");
const hint_arrow_entity = preload("res://Entities/Hint_Arrow/hint_arrow.tscn");

@export var _Spawn_Locations : Array[spawn_location_entity];

var _CURRENT_spawn_location : spawn_location_entity;
var _CURRENT_destination_location : spawn_location_entity;

var _final_time_string : String = "";
var _final_time : String = "";
var _round : int = 0;
@export var _round_max : int = 15;
var _game_end = false;

var _hint_is_active : bool = false;
var _CURRENT_arrow : Node3D;
var _used_hint : bool = false;
var _can_spawn_arrow : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var country_spawn_locations = get_node("Country_Spawn_Locations");
	
	# Populate locations array
	for spawn_location in country_spawn_locations.get_children():
		if spawn_location is spawn_location_entity:
			_Spawn_Locations.append(spawn_location);
	print_debug("spawn locations loaded: ", _Spawn_Locations.size());
	
	_ui_final_time.set_text("");
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
	
	_can_spawn_arrow = false;
	
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
	_sfx_package.play();
	
	# Make sure this location hasn't been used already
	_next_destination();
	# Finally, spawn in a valid location
	_spawn_destination();
	
	_can_spawn_arrow = true;
	

# Delivered package -> go get the next one now
func delivered_package() -> void:
	_sfx_delivery.play();
	
	if _hint_is_active:
		_CURRENT_arrow.queue_free();
		_CURRENT_arrow = null;
		_hint_is_active = false;
		_can_spawn_arrow = false;
	_next_round();
	_next_package();
	_spawn_package();
	

func _update_ui_round() -> void:
	# If game is done, add Final Time
	if _game_end:
		_final_time_string = " Final Time: " + _final_time + " |";
		
		if _used_hint:
			_final_time_string += " Hint |";
		
		_final_time_string += str(" ", _round, "/", _round_max);
	
	else:
		_final_time_string = str(" ", _round, "/", _round_max);
	
	_ui_final_time.set_text(_final_time_string);

func _next_round() -> void:
	_round += 1;
	if _round >= _round_max && !_game_end:
		_set_final_time();
	_update_ui_round();

func _set_final_time() -> void:
	_game_end = true;
	_final_time = _ui_timer._label.text;
	

func hint() -> void:
	if (!_CURRENT_destination_location) || (_hint_is_active) || (!_can_spawn_arrow):
		return;
	
	_sfx_hint.play();
	
	_used_hint = true;
	_hint_is_active = true;
	
	# Create entity and set location
	var arrow = hint_arrow_entity.instantiate();
	arrow.position = _CURRENT_destination_location.position;
	
	# Spawn it
	add_child(arrow);
	print_debug("spawned HINT ARROW");
	
	_CURRENT_arrow = arrow;
	
