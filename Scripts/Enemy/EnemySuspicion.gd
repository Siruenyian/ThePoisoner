extends Node2D

@export var area2d: Area2D 
@export var baseNode: Node2D 



@export var suspicion_rate: float = 20  # How fast suspicion rises
@export var suspicion_decay: float = 5  # How fast it decreases


var suspicion:float = 0.0
var playerRef: Node2D = null
var playerDetected :bool=false

signal suspicion_changed(new_value)

func _ready():
	area2d.area_exited.connect(_on_body_exited)
	area2d.area_entered.connect(_on_body_entered)
	GameManagerThing.turn_started.connect(_on_turn_started)
	

func _on_body_entered(body):
	if body.is_in_group("player"): 
		playerDetected = true
		playerRef=body.get_parent()

func _on_body_exited(body):
	if body.is_in_group("player"):
		playerDetected = false
		playerRef=null

func _on_turn_started(current_turn):
	print(current_turn," ini on turn start ya")
	if current_turn == "Player":
		update_suspicion()

func update_suspicion():
	print(suspicion)
	if playerDetected:
		var aCon:PlayerAction=playerRef.get_node("ActionController")
		if aCon.teapotMode=="Poison":
			suspicion += suspicion_rate
	else:
		suspicion -= suspicion_decay

	suspicion = clamp(suspicion, 0, 100)
	suspicion_changed.emit(suspicion)

	if suspicion >= 100:
		print("Suspicion Maxed! You going to jail ha")
		GameManagerThing.end_game()
