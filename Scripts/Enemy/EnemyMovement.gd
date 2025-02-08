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

var alpha: float = 0.2

func _draw():
	var shape:CollisionShape2D = $"../ViewArea/CollisionShape2D"
	if shape.shape is CircleShape2D:
		draw_circle(Vector2.ZERO, shape.radius, Color(1, 0, 0, alpha))
	elif shape.shape is RectangleShape2D:
		draw_rect(shape.shape.get_rect(), Color(0.949, 0.147, 0.438, 0.42))


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
signal npc_changebehavior(behavior:String)
var NPCBehavior = ["DISTRACT", "DRINK", "TALK"] 
#  and 2 ar alert
#0 is safe
# turn 0 abaikan aja gpp, player perlu maju dl
var NPCBehaviorPattern
var a=0
var currentBehavior: String=NPCBehavior[0]
func _on_turn_started(current_turn) -> void:
	if current_turn=="NPC":
		a+=1
		NPCBehaviorPattern=GameManagerThing.getBehavior()
		print(GameManagerThing.level, " is level now")
		print(NPCBehaviorPattern, " is level now")
		
		var behaviorh=NPCBehaviorPattern[(a)%NPCBehaviorPattern.size()]
		currentBehavior=NPCBehavior[behaviorh]
		#currentBehavior=NPCBehavior[randi() % 3 ]
		
		match currentBehavior:
			"DISTRACT":
				print("NPC is making IDLE")
				npc_changebehavior.emit("DISTRACT")
			"DRINK":
				print("NPC is making Poison")	
				npc_changebehavior.emit("DRINK")
							
			"TALK":
				print("NPC is making tea")
				npc_changebehavior.emit("TALK")
				
		var direction=Vector2.ZERO
		#if direction != Vector2.ZERO:
		if playerDetected:
			var aCon:PlayerAction=playerRef.get_node("ActionController")
			#print(aCon.teapotMode," "," Kill yourself idk")
			if aCon.teapotMode=="Poison":
				direction= get_move_direction()
		GameManagerThing.end_turn()
		#move(direction)
			
