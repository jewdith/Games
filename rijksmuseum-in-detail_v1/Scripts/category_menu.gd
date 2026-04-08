extends Node2D
func _ready():
	$CategoryControlMenu/CenterContainer/CatButtons/Cat1Button.pressed.connect(func(): start_game("voc"))
	$CategoryControlMenu/CenterContainer/CatButtons/Cat2Button.pressed.connect(func(): start_game("bil"))
	$CategoryControlMenu/CenterContainer/CatButtons/Cat3Button.pressed.connect(func(): start_game("kind"))

func start_game(category: String):
	var game_scene = load("res://Scenes/guessing_game.tscn").instantiate()
	game_scene.selected_category = category
	get_tree().root.add_child(game_scene)
	queue_free()
