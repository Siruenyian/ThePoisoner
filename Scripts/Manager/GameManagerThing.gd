extends Node2D

signal turn_ended
signal turn_started(current_turn)
signal ap_changed(new_ap: int)
signal game_ended(condition:String)
var current_turn = "Player"
var max_ap: int = 2
var current_ap: int  
var turnDelay:float = 1.0
var turnCount:int=0
var playerturnCount:int=0
var levelBehaviorPattern=[[0,0,0,0,0,0,0,0],[0,1,2,2,0,0,0,1]]
var level:int=-1
var istutPlayed:bool=false

func getBehavior()->Array:
	print(level)
	print(levelBehaviorPattern[0])
	if level==-1:
		return levelBehaviorPattern[0]
	return levelBehaviorPattern[level]
	
func _ready():
	pass
	#current_ap = max_ap  
	#start_turn()
func is_tutorial_scene() -> bool:
	return get_tree().current_scene.scene_file_path == "res://Scenes/Tutorial.tscn"
func start_turn():
	if playerturnCount>6:
		if is_tutorial_scene():
			end_tut("LOSE")
			return
		end_game("LOSE")
		return
	if current_turn == "Player":
		playerturnCount+=1
	print("Turn Started! It's", current_turn, "turn")
	turnCount+=1
	restore_ap()
	turn_started.emit(current_turn)
	
func end_turn():
	print("Turn Ended!")
	turn_ended.emit()
		
	await get_tree().create_timer(turnDelay).timeout
	if current_turn == "Player":
		current_turn = "NPC"  
	else:
		current_turn = "Player"
	start_turn()
	
func use_ap(amount: int):
	if current_ap >= amount:
		current_ap -= amount
		ap_changed.emit(current_ap)
		if current_ap <= 0:
			end_turn()  
		return true
	return false 

func restore_ap():
	current_ap = max_ap
	ap_changed.emit(current_ap)

func switch_scene(target_scene: String) -> void:
	var resource := load(target_scene)
	
	if resource is PackedScene:
		await get_tree().create_timer(0.1).timeout  
		get_tree().change_scene_to_packed(resource) 
	else:
		print("Failed to load scene: ", target_scene)

func switch_scene_async(target_scene: String) -> void:
	ResourceLoader.load_threaded_request(target_scene)

	while ResourceLoader.load_threaded_get_status(target_scene) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame  # Yield to avoid freezing the game

	var resource = ResourceLoader.load_threaded_get(target_scene)
	
	if resource is PackedScene:
		get_tree().change_scene_to_packed(resource)
	else:
		print("Error loading scene:", target_scene)


func start_tut():
	current_ap = max_ap  
	level=-1
	current_turn = "Player"
	start_turn()

func end_tut(gameCondition):
	restore_ap()
	current_turn = "Player"
	
	#end_turn()
	game_ended.emit(gameCondition)
	await get_tree().create_timer(5).timeout  
	turnCount=0
	playerturnCount=0
	get_tree().paused = false
	switch_scene_async("res://Scenes/prototype_menu.tscn")
	return

func skip_tut():
	restore_ap()
	current_turn = "Player"
	#game_ended.emit(gameCondition)
	turnCount=0
	playerturnCount=0
	get_tree().paused = false
	switch_scene("res://Scenes/Prototype.tscn")
	start_game(1)
	return
	
func start_game(lvl:int):
	current_ap = max_ap  
	level=lvl
	current_turn = "Player"
	start_turn()

func end_game(gameCondition):
	restore_ap()
	current_turn = "Player"
	#end_turn()
	game_ended.emit(gameCondition)
	await get_tree().create_timer(5).timeout  
	turnCount=0
	playerturnCount=0
	get_tree().paused = false
	switch_scene_async("res://Scenes/prototype_menu.tscn")
	return
