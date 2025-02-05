extends Node2D

@export var moveSpeed: float = 0.3  # Movement speed in seconds
@export var tileMap: TileMapLayer  # Assign the tilemap in the Inspector

@export var area2d: Area2D 
@export var sprite: Sprite2D 
@export var baseNode: Node2D 

var suspicion:float = 0.0
var isMoving: bool = false
var targetTile: Vector2i
var playerRef: Node2D = null
var playerDetected :bool=false

func _ready():
	area2d.area_exited.connect(_on_body_exited)
	area2d.area_entered.connect(_on_body_entered)
	GameManagerThing.turn_started.connect(_on_turn_started)

func _on_body_entered(body):
	if body.is_in_group("player"): 
		playerDetected = true
		#print(body.name)
		playerRef=body.get_parent()
		var direction = get_move_direction()
		#if direction != Vector2.ZERO:
			#move(direction)

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("player exited")
		playerDetected = false
		playerRef=null
		
func is_walkable(tile: Vector2i) -> bool:
	var tile_data = tileMap.get_cell_tile_data(tile)
	return tile_data != null  
	
	
func get_move_direction() -> Vector2:
	if playerRef == null:
		return Vector2.ZERO  

	var enemy_tile = tileMap.local_to_map(baseNode.global_position)
	var player_tile = tileMap.local_to_map(playerRef.global_position)

	var direction = Vector2.ZERO

	if enemy_tile.x < player_tile.x:
		direction = Vector2.RIGHT
	elif enemy_tile.x > player_tile.x:
		direction = Vector2.LEFT
	elif enemy_tile.y < player_tile.y:
		direction = Vector2.DOWN
	elif enemy_tile.y > player_tile.y:
		direction = Vector2.UP

	return direction

func move(direction: Vector2):
	var current_tile:Vector2 = tileMap.local_to_map(global_position)
	var targetTile = current_tile + direction

	isMoving = true
	var target_position = tileMap.map_to_local(targetTile)
	baseNode.global_position=target_position
	var tween = create_tween()
	tween.tween_property(baseNode, "global_position", target_position, moveSpeed).set_trans(Tween.TRANS_SINE)

	await tween.tween_callback(GameManagerThing.end_turn)
	print("ismoving false")
	isMoving = false
	#if playerRef!=null:
		#move(get_move_direction())


func _on_turn_started(current_turn) -> void:
	if current_turn=="NPC":
		var direction=Vector2.ZERO
		#if direction != Vector2.ZERO:
		if playerDetected:
			var aCon:PlayerAction=playerRef.get_node("ActionController")
			print(aCon.teapotMode," "," Kill yourself idk")
			if aCon.teapotMode=="Poison":
				direction= get_move_direction()
		move(direction)
		#GameManagerThing.end_turn()
		
			
