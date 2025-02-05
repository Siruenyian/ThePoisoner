extends Node2D

signal turn_ended
signal turn_started(current_turn)
signal ap_changed(new_ap: int)

var current_turn = "Player"
var max_ap: int = 2
var current_ap: int  
var turnDelay:float = 1.0

func _ready():
	current_ap = max_ap  
	start_turn()

func start_turn():
	print("Turn Started! It's", current_turn, "turn")
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


func end_game():
	switch_scene_async("res://Scenes/prototype_menu.tscn")
	return
