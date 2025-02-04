extends Node

@export var raycast:RayCast2D
@export var actionUI:ActionUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if raycast.collide_with_areas:
		actionUI.show_actions()
	else:
		actionUI.hide_actions()
