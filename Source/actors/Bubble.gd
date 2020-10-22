extends Area2D

var speed = 300
var velocity = Vector2()
var direction = 1 #facin right bubble


func move_bubble_direction(dir):
	direction = dir
	#if dir == -1:
	#	pass
		#$kinematicbody
func _physics_process(delta):
	velocity.x = speed*delta*direction
	translate(velocity)
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #destroys object from memory no longe tracked
	
func _on_Bubble_body_entered(body):
	if body.name!= "PLayer1":
		if "enemy" in body.name:
			body.shot()
	queue_free()
	
