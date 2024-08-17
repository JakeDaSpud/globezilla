extends Node3D

@export var country_name : String;
@export var has_been_used : bool = false;

func use():
	has_been_used = true;
