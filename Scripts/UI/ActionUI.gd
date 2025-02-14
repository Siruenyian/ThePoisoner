extends Control
class_name ActionUI

@onready var switchButton = $SwitchButton
@onready var pourButton = $PourButton
@onready var interactButton = $InteractButton
@onready var modeLabel = $"../ModeLabel"
@onready var turnLabel = $"../TurnLabel"
@onready var turncountLabel = $"../TurnCountLabel"
@onready var playerAc:PlayerAction=$"../../Player/ActionController"
@onready var ap_bar = $"../APBar"
@onready var sfx_player = $"../../SFXPlayer"

func _ready():
	switchButton.pressed.connect(_on_switch_mode_pressed)
	pourButton.pressed.connect(_on_pour_pressed)
	interactButton.pressed.connect(_on_interact_pressed)
	GameManagerThing.ap_changed.connect(update_ap_bar)
	GameManagerThing.turn_started.connect(update_turn_label)
	turnLabel.text="Turn: "+GameManagerThing.current_turn
	ap_bar.value=float(GameManagerThing.current_ap) / GameManagerThing.max_ap * 100 
	turncountLabel.text="Phase: %d/7" % GameManagerThing.playerturnCount
	#modeLabel.text="Mode: %s"%GameManagerThing
	
	#GameManagerThing.skip_tut.connect(_on_skip_pressed)
	
	
	
func update_turn_label(current_turn):
	print("turn label being updated")
	if current_turn!="Player":
		switchButton.disabled=true
		pourButton.disabled=true
		interactButton.disabled=true
		ap_bar.hide()
	else:
		switchButton.disabled=false
		pourButton.disabled=false
		interactButton.disabled=false
		ap_bar.show()
		turncountLabel.text="Phase: %d/7" % GameManagerThing.playerturnCount
		AudioManagerThing.play_sfx("turnchange",sfx_player)
		
	turnLabel.text="Turn: "+current_turn
	
	
func update_ap_bar(current_ap):
	ap_bar.value = float(current_ap) / GameManagerThing.max_ap * 100 

func show_actions():
	visible = true  

func hide_actions():
	visible = false 
var lastswitchTurn:int=GameManagerThing.playerturnCount
func _on_switch_mode_pressed():
	print(GameManagerThing.playerturnCount)
	print(lastswitchTurn)
	if (GameManagerThing.playerturnCount-lastswitchTurn)<=1:
		return
	lastswitchTurn=GameManagerThing.playerturnCount
	print("Switch action triggered")
	playerAc.switchteamode()
	GameManagerThing.use_ap(1)
	hide_actions()

func _on_pour_pressed():
	print("Push action triggered")
	GameManagerThing.use_ap(1)
	playerAc._on_interact_button_pressed()
	hide_actions()

func _on_interact_pressed():
	print("interaction triggered")
	hide_actions()

func _on_teamodechanged(teapotmode):
	modeLabel.text="Mode: %s"%teapotmode 
	
func _on_skip_pressed():
	GameManagerThing.skip_tut()
