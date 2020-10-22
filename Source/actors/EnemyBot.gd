extends KinematicBody2D
#enemy bots move from top-->bottom of level and jump up after colliding with wall
#enemies kill players on contact unless bubbled
export var GRAVITY = 50.0
export var WALK_SPEED = 200
const FLOOR = Vector2(0,-1)

#waiting for u to call it

var facing = 1
var been_shot = false
#to move where its facing afte colliding with wall

var veloc = Vector2()


func shot():
	been_shot= true
	veloc = Vector2(0,0) #stop enemy from movin
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	
func _physics_process(delta):
	
	if been_shot ==false: #enemy still move about till dead
		veloc.x= WALK_SPEED * facing
		
		veloc.y += GRAVITY
		
		veloc = move_and_slide(veloc, FLOOR)
		
		if is_on_wall():
			facing = facing *-1
		#once it hits wall will go oppsiite way

		if get_slide_count()>0: #checks collisions
				for i in range(get_slide_count()):
					if "Bubble" in get_slide_collision(i).collider.name:
						shot()

func _on_Timer_timeout():
	queue_free()
