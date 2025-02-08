extends Node2D



const SOUND_LIBRARY = {
	"step": preload("res://Assets/Audio/SFX/card-place-1.ogg"),
	"turnchange": preload("res://Assets/Audio/SFX/impactMining_003.ogg"),
	
}
func _ready():
	pass

func play_sfx(sound_name: String, sfx_player):
	if SOUND_LIBRARY.has(sound_name):
		sfx_player.stream = SOUND_LIBRARY[sound_name]
		sfx_player.play()
	else:
		print("Error: Sound '%s' not found!" % sound_name)
