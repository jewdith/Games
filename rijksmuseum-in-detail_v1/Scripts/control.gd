extends Control

#maak input mogelijk
@onready var image_display: TextureRect = $TextureRect
@onready var answer_input: LineEdit = $AnswerInput
@onready var submit_button: Button = $SubmitButton
@onready var feedback_label: Label = $FeedbackLabel
@onready var back_button: Button = $BackButton

#Hou score bij
@onready var score_label = $ScoreLabel 
var score: int = 0

#geef aan hoe snel je iets toont
var reveal_step: float = 0.1
var reveal_radius: float = 0.1

#vragen reeks. uitbreiden waar nodig is. 
var current_question = {}
var questions = [
	{"image": "res://assets/Paintings/The milkmaid.png", "answer": "1", "category": "cat1"},
	{"image": "res://assets/Paintings/The Night Watch.png", "answer": "2", "category": "cat2"},
	{"image": "res://assets/Paintings/The Threatened Swan.png", "answer": "3", "category": "cat3"}
]
#start direct alle benodigde functies
func _ready():
	submit_button.pressed.connect(_on_submit_pressed)
	back_button.pressed.connect(_on_back_pressed)
	start_new_round()
	update_score_display()

func start_new_round():
	feedback_label.text = ""
	answer_input.text = ""
	reveal_radius = 0.05

	current_question = questions.pick_random()
	image_display.texture = load(current_question["image"])

#Voorwaardelijke animatie in de vorm van een shader
	if not image_display.material:
		var shader = load("res://assets/shaders/center_reveal.gdshader")
		var mat = ShaderMaterial.new()
		mat.shader = shader
		image_display.material = mat
	update_shader()

func update_shader():
	var mat = image_display.material
	mat.set_shader_parameter("reveal_radius", reveal_radius)

#beoordeel gebruiker input
func _on_submit_pressed():
	check_answer(answer_input.text)

func check_answer(answer: String):
	var correct = current_question["answer"]
	if answer.strip_edges().to_lower() == correct.to_lower():
		feedback_label.text = "✅ Correct!"
		score += 1
		
	else:
		feedback_label.text = "❌ Wrong! Revealing more..."
		reveal_more()
	update_score_display()
	
func update_score_display():
	score_label.text = "Score: " + str(score)

func reset_score():
	score = 0
	update_score_display()

func reveal_more():
	reveal_radius += reveal_step
	reveal_radius = clamp(reveal_radius, 0.0, 1.0)
	# Optional: Tween for smooth animation
	var tween = create_tween()
	tween.tween_property(image_display.material, "shader_parameter/reveal_radius", reveal_radius, 0.5)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
