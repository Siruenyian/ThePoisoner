extends Sprite2D

@export var moveSpeed: float = 1  
@onready var tileMap: TileMapLayer = $"../TileMapLayer"
@onready var character= $"Sprite2D"
var targetPosition: Vector2
var isMoving: bool = false
@onready var ap_manager: APManager = $"../APManager"


func _process(delta):
	handle_input()

func handle_input():
	print(ap_manager.current_ap)
	if isMoving or ap_manager.current_ap <= 0:
		return 
	#if character.global_position!=global_position:
		#return
	var direction = Vector2.ZERO
	if Input.is_action_just_pressed("ui_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2.DOWN
		
	if direction != Vector2.ZERO:
		move(direction)
	
func move(direction:Vector2):
	if not ap_manager.use_ap(1):  # Check if AP is available
		return 
	var currentTile:Vector2i=tileMap.local_to_map(global_position)
	var targetTile:Vector2i=Vector2i(
		currentTile.x+direction.x,
		currentTile.y+direction.y		
	)
	var tileData:TileData=tileMap.get_cell_tile_data(targetTile)
	#if tileData.get_custom_data("walkable")==false:
		#return
	var targetPosition: Vector2 = tileMap.map_to_local(targetTile)
	global_position=tileMap.map_to_local(targetTile)
	character.global_position=tileMap.map_to_local(currentTile)
	var tween = create_tween()
	tween.tween_property(character, "global_position",targetPosition , 0.2).set_trans(Tween.TRANS_SINE)
	#await tween.finished
	await tween.tween_callback(stopmoving)

func stopmoving():
	isMoving = false
	

	
	
