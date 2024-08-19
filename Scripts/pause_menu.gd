extends Control

func _ready():
	$AnimationPlayer.play("RESET");

func _resume():
	get_tree().paused = false;
	$PanelContainer/VBoxContainer/Resume_Button.disabled = true;
	$PanelContainer/VBoxContainer/Restart_Button.disabled = true;
	$PanelContainer/VBoxContainer/Resume_Button.mouse_default_cursor_shape = CURSOR_ARROW;
	$PanelContainer/VBoxContainer/Restart_Button.mouse_default_cursor_shape = CURSOR_ARROW;
	$AnimationPlayer.play_backwards("blur");

func _pause():
	get_tree().paused = true;
	$PanelContainer/VBoxContainer/Resume_Button.disabled = false;
	$PanelContainer/VBoxContainer/Restart_Button.disabled = false;
	$PanelContainer/VBoxContainer/Resume_Button.mouse_default_cursor_shape = CURSOR_POINTING_HAND;
	$PanelContainer/VBoxContainer/Restart_Button.mouse_default_cursor_shape = CURSOR_POINTING_HAND;
	$AnimationPlayer.play("blur");

func _handle_pause():
	if Input.is_action_just_pressed("pause") && get_tree().paused == false:
		_pause();
	elif Input.is_action_just_pressed("pause") && get_tree().paused:
		_resume();

func _on_resume_button_pressed():
	_resume();

func _on_restart_button_pressed():
	_resume();
	get_tree().reload_current_scene();

func _process(_delta):
	_handle_pause();
