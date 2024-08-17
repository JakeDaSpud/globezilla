extends Camera3D

@export var target : Node3D;
@export var distance_from_target : Vector3 = Vector3(0.0, 3.0, 3.0);

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = self.position + distance_from_target;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = target.position + distance_from_target;
	
