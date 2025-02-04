extends Control
class_name ActionUI

@onready var switchButton = $SwitchButton
@onready var pourButton = $PourButton
@onready var interactButton = $InteractButton
func _ready():
	switchButton.pressed.connect(_on_poison_pressed)
	pourButton.pressed.connect(_on_push_pressed)
	interactButton.pressed.connect(_on_throw_pressed)

func show_actions():
	visible = true  

func hide_actions():
	visible = false 

func _on_poison_pressed():
	print("Poison action triggered")
	hide_actions()

func _on_push_pressed():
	print("Push action triggered")
	hide_actions()

func _on_throw_pressed():
	print("Throw distraction triggered")
	hide_actions()
