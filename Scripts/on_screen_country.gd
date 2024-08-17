extends Control

@onready var _label = $Country_Text;

func set_text(new_text : String) -> void:
	_label.text = new_text;
	
