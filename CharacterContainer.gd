extends Node2D

func add_character(character_data):
	var character_sprite = Sprite2D.new()
	character_sprite.texture = load(character_data.image)
	character_sprite.name = character_data.name
	
	# Configure character size
	character_sprite.scale = Vector2(1, 1)  # Adjust the scale as needed
	
	# Configure character position
	if character_data.position == "left":
		character_sprite.position = Vector2(300, 200)  # Adjust the position as needed
	elif character_data.position == "right":
		character_sprite.position = Vector2(1000, 200)  # Adjust the position as needed
	# Add more positions if needed
	
	add_child(character_sprite)

func remove_all_characters():
	for child in get_children():
		child.queue_free()
