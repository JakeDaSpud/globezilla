extends Node3D

@export var country_name : String;
@export var has_been_used : bool = false;

func get_country_name() -> String:
	return country_name;

func use():
	has_been_used = true;
