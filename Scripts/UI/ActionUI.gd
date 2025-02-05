extends Control
class_name ActionUI

@onready var switchButton = $SwitchButton
@onready var pourButton = $PourButton
@onready var interactButton = $InteractButton
@onready var modeLabel = $"../ModeLabel"
@onready var turnLabel = $"../TurnLabel"
@onready var playerAc:PlayerAction=$"../../Player/ActionController"
@onready var ap_bar = $"../APBar"


func _ready():
	switchButton.pressed.connect(_on_switch_mode_pressed)
	pourButton.pressed.connect(_on_pour_pressed)
	interactButton.pressed.connect(_on_interact_pressed)
	GameManagerThing.ap_changed.connect(update_ap_bar)
	GameManagerThing.turn_started.connect(update_turn_label)
	turnLabel.text=GameManagerThing.current_turn
	ap_bar.value=float(GameManagerThing.current_ap) / GameManagerThing.max_ap * 100 
	
	
func update_turn_label(current_turn):
	print("turn label being updated")
	#if current_turn!="Player":
		#ap_bar.hide()
	#else:
		#ap_bar.show()
	turnLabel.text=current_turn
	
func update_ap_bar(current_ap):
	ap_bar.value = float(current_ap) / GameManagerThing.max_ap * 100 

func show_actions():
	visible = true  

func hide_actions():
	visible = false 

func _on_switch_mode_pressed():
	print("Poison action triggered")
	playerAc.switchteamode()
	GameManagerThing.use_ap(1)
	hide_actions()

func _on_pour_pressed():
	print("Push action triggered")
	GameManagerThing.use_ap(1)
	playerAc._on_interact_button_pressed()
	hide_actions()

func _on_interact_pressed():
	print("Throw interaction triggered")
	hide_actions()

func _on_teamodechanged(teapotmode):
	modeLabel.text="Mode: %s"%teapotmode 
