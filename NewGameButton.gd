extends Node2D

# ボタンへの参照を追加
@onready var new_game_button = $Control/VBoxContainer/NewGameButton

# ゲームシーンへのパス
const GAME_SCENE_PATH = "res://node_2d.tscn"

func _ready():
	# ボタンにシグナル接続を追加
	var callback = Callable(self, "_on_new_game_button_pressed")
	new_game_button.connect("pressed", callback)

func _on_new_game_button_pressed():
	get_tree().change_scene_to_file(GAME_SCENE_PATH)

