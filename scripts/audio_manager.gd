extends Node3D


@export var music_tracks: SoundCollection
@export var animal_sounds: Dictionary[AnimalConfig.AnimalType, SoundCollection]
@export var min_music_volume_db: float = -10.0
@export var max_music_volume_db: float = 10.0
@export var music_volume_db_step: float = 2.0

var music_player: AudioStreamPlayer3D
var animal_player: AudioStreamPlayer3D
var sfx_player: AudioStreamPlayer3D

var current_music_index: int = 0


func _ready() -> void:
    music_player = $Music
    animal_player = $Animals
    sfx_player = $SFX

    play_music(current_music_index)


func play(player: AudioStreamPlayer3D, stream: AudioStream) -> void:
    player.stream = stream
    player.play()


func play_music(index: int) -> void:
    play(music_player, music_tracks.sounds[index])


func pause_unpause_music() -> void:
    music_player.stream_paused = not music_player.stream_paused


func play_music_next() -> void:
    current_music_index = (current_music_index + 1) % music_tracks.sounds.size()
    play_music(current_music_index)


func play_music_previous() -> void:
    current_music_index = (current_music_index - 1 + music_tracks.sounds.size()) % music_tracks.sounds.size()
    play_music(current_music_index)


func music_volume_down() -> void:
    music_player.volume_db = max(music_player.volume_db - 2.0, min_music_volume_db)


func music_volume_up() -> void:
    music_player.volume_db = min(music_player.volume_db + 2.0, max_music_volume_db)


func play_animal_sound(animal_type: AnimalConfig.AnimalType) -> void:
    var collection: SoundCollection = animal_sounds.get(animal_type)
    var index: int = randi() % collection.sounds.size()
    play(animal_player, collection.sounds[index])


func play_sfx(stream: AudioStream) -> void:
    play(sfx_player, stream)
