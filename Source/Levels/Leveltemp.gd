extends Node2D
#Music credit score by Patrick de Arteaga
func _ready():
	var musicp = AudioStreamPlayer.new()
	self.add_child(musicp)
	musicp.stream = load("res://game assets/Interplanetary Odyssey.wav")
	musicp.play()


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Source/Levels/Menu.tscn")
