extends Node

var scenario_data = null

func load_scenario(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file != null:
		var json_text = file.get_as_text()

		scenario_data = JSON.parse_string(json_text)
	else:
		print("Failed to load scenario file.")

func get_scene_by_id(scene_id):
	for scene in scenario_data.scenes:
		if str(scene.id) == str(scene_id):
			return scene
	return null
