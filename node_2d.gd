extends Node2D

@onready var text_box = $Control/RichTextLabel
@onready var choice_container = $Control/ChoiceContainer
var scenario_manager = preload("res://scripts/main/scenario_manager.gd").new()

func _ready():
	scenario_manager.load_scenario("res://assets/scenario/scenario.json")
	display_scene(1)  # Display the first scene (assuming scene ID 1)

func display_scene(scene_id):
	var scene_data = scenario_manager.get_scene_by_id(scene_id)

	if scene_data:
		# Update text box
		text_box.bbcode_text = scene_data.text

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
	display_scene(next_scene_id)
