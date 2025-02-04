extends Area2D
class_name HitBoxComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_entered(body):
	print(body.name)
	

func _on_exited(body):
	print("exited")
	
func _process(delta: float) -> void:
	pass
