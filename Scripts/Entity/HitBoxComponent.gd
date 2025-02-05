extends Area2D
class_name HitBoxComponent
signal on_hit(body)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_entered)
	self.area_exited.connect(_on_exited)
	
	pass # Replace with function body.

func _on_entered(body):
	print(body.name)
	#on_hit.emit(body)
	

func _on_exited(body):
	print("exited")
	
func _process(delta: float) -> void:
	pass
