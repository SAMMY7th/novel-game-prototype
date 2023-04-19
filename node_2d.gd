extends Node2D

@onready var text_box = $Control/RichTextLabel
@onready var choice_container = $Control/ChoiceContainer
@onready var background_sprite = $Control/Background
@onready var character_container = $Control/CharacterContainer
@onready var bgm_player = $Control/AudioStreamPlayer

var scenario_manager = preload("res://scripts/main/scenario_manager.gd").new()

func _ready():
	scenario_manager.load_scenario("res://assets/scenario/scenario.json")
	display_scene(1)  # Display the first scene (assuming scene ID 1)

func display_scene(scene_id):
	var scene_data = scenario_manager.get_scene_by_id(scene_id)

	if scene_data:
		# Update text box
		text_box.bbcode_text = scene_data.text
		
		# Update background
		set_background(scene_data.background)

		# Update characters
		character_container.remove_all_characters()
		for character_data in scene_data.characters:
			character_container.add_character(character_data)

		# Update BGM
		if bgm_player.stream != null and bgm_player.stream.resource_path != scene_data.bgm:
			bgm_player.stop()
			bgm_player.stream = load(scene_data.bgm)
			bgm_player.volume_db = -10
			bgm_player.play()
		elif bgm_player.stream == null and scene_data.bgm != "":
			bgm_player.stream = load(scene_data.bgm)
			bgm_player.volume_db = -10
			bgm_player.play()

		# Clear existing choices
		for choice_button in choice_container.get_children():
			choice_button.queue_free()

		# Create new choice buttons
		for choice in scene_data.choices:
			var choice_button = Button.new()
			choice_button.text = choice.text
			var callback = Callable(self, "_on_choice_pressed").bind(choice.next)
			choice_button.connect("pressed", callback)
			choice_container.add_child(choice_button)
	else:
		print("Invalid scene ID: ", scene_id)

func _on_choice_pressed(next_scene_id):
	if str(next_scene_id) == "exit":
		get_tree().change_scene_to_file("res://menu.tscn")  # メニューシーンへ遷移
	else:
		display_scene(next_scene_id)

func set_background(background_path):
	background_sprite.texture = load(background_path)
	
	# Get the window size
	var window_size = DisplayServer.window_get_size()
	
	# Calculate the scale factors
	var scale_x = float(window_size.x) / background_sprite.texture.get_width()
	var scale_y = float(window_size.y) / background_sprite.texture.get_height()
	
	# Set the scale to fit the window size
	background_sprite.scale = Vector2(scale_x, scale_y)
	
	# Set the position to the center of the window
	background_sprite.position = window_size / 2
	
	add_child(background_sprite)
	
