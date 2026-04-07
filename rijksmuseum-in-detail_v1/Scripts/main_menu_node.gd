extends Node2D

@onready var start_button: Button = $CenterContainer/MainButtons/StartButton
@onready var quit_button: Button = $CenterContainer/MainButtons/QuitButton

const GUESS_GAME_SCENE = "res://Scenes/guessing_game.tscn"

func _ready():
	start_button.pressed.connect(_on_start_pressed)

func _on_start_pressed():
	get_tree().change_scene_to_file(GUESS_GAME_SCENE)

func _on_quit_pressed():
	get_tree().quit()
