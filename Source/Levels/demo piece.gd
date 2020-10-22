extends Node2D
func _ready():
	var musicp = AudioStreamPlayer.new()
	self.add_child(musicp)
	musicp.stream = load("res://game assets/Great Little Challenge.wav")
	musicp.play()


func _on_MenuScreen_pressed():
	get_tree().change_scene("res://Source/Levels/Menu.tscn")
