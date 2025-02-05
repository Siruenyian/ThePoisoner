extends Node2D

var susBar:ProgressBar
var stateLabel:Label

# Called when the node enters the scene tree for the first time.
func _ready():
	susBar=self.get_parent().get_node("SusBar")
	stateLabel=self.get_parent().get_node("StateLabel")
	stateLabel.text="DRINK"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_suspicion_changed(new_value):
	susBar.value=new_value
	
func _on_enemy_state_changed(new_label):
	stateLabel.text=new_label
