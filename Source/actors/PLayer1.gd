extends KinematicBody2D

export var GRAVITY = 40.0
export var WALK_SPEED = 300
export var Jump_FORCE = 800
export var FALL_SPEED = 800

var ammo = 0

var is_dead = false #lets kil this dude

const bubble = preload("res://Source/actors/Bubble.tscn")
#bubble weapon
#sets walk movement to 200 px/sec jump to 400 (changeable in interf) etc etc
var y_velocity=0
#up/down speed
func _physics_process(delta):
	if is_dead == false:
		var directionm = 0
		#which direction is actor moving
		if Input.is_action_pressed("move_left"):
			directionm -= 1
			if sign($Position2D.position.x)==1:
				$Position2D.position.x*= -1
		if Input.is_action_pressed("move_right"):
			directionm += 1
			#move shoot position around
			if sign($Position2D.position.x)==-1:
				$Position2D.position.x*= -1
		if Input.is_action_just_pressed("shoot"):
			var bub = bubble.instance()
			if sign($Position2D.position.x) ==1:
				bub.move_bubble_direction(1)
			else:
				bub.move_bubble_direction(-1)
			get_parent().add_child(bub)
			bub.position= $Position2D.global_position
			#we created one bubble in mem
			
			
		move_and_slide(Vector2(directionm * WALK_SPEED, y_velocity), Vector2(0,-1))
		
		#actor to jump requisite to be on platform
		var floored = is_on_floor()
		y_velocity += GRAVITY
		if floored and Input.is_action_just_pressed("jump"):
			y_velocity= -Jump_FORCE #this way character springs upward
		if floored and y_velocity >= 6:
			y_velocity = 6 #prevent infinite acceleration
		if y_velocity> FALL_SPEED:
			y_velocity=FALL_SPEED #ensuring falling has a cap
	
		#if shooting: play_anim("shoot")
		if get_slide_count()>0: #checks collisions
			for i in range(get_slide_count()):
				if "enemy" in get_slide_collision(i).collider.name:
					playerDead()
		
func playerDead():
	is_dead = true
	y_velocity = Vector2(0,0)
	$CollisionShape2D.disabled = true
	$Timer.start()
	#resets game to title screen when collides w enemy
	
func _on_Cakey_body_entered(body):
	ammo+=1
#increases ammo based on food consumed


func _on_Timer_timeout():
	get_tree().change_scene("res://Source/Levels/Menu.tscn")
