extends Control

@onready var _label = $Time;

@onready var _total_cs : int = 0;
@onready var _total_s : int = 0;

func _physics_process(delta) -> void:
	_total_cs += int(100 * delta);
	
	if (_total_cs >= 100):
		_total_cs = 0;
		_total_s += 1;
	
	_label.text = '%02d.%02ds' % [_total_s, _total_cs];

func get_final_time() -> String:
	return str(_total_s, ".", _total_cs, "s");
