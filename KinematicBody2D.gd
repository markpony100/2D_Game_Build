extends KinematicBody2D
const UP=Vector2(0,-1)
const MAX_SPEED=125
const GRAVITY=10
const JUMP_HIGHT=-300
const ACCELERATION=30
var doublejump_count=0
var motion=Vector2()

func _physics_process(delta):
	var friction=false
	motion.y+=GRAVITY
	if (Input.is_action_pressed("ui_right") ):
		motion.x=min(motion.x+ACCELERATION,MAX_SPEED)	
		$Sprite.flip_h=false
		$Sprite.play("run")
	elif(Input.is_action_pressed('ui_left')):
		motion.x=max(motion.x-ACCELERATION,-MAX_SPEED)		
		$Sprite.flip_h=true
		$Sprite.play("run")
	else:
		$Sprite.play("idle")
		friction=true
	if is_on_floor():
		doublejump_count=0
		#print("i am on floor")
		if friction==true:
			motion.x=lerp(motion.x,0,0.2)
		if Input.is_action_pressed("ui_up"):
			$Sprite.play("jump")
			motion.y=JUMP_HIGHT
	else:
		if motion.y<0:
			$Sprite.play("jump")
		else:
			$Sprite.play("fall")
		if friction==true:
				motion.x=lerp(motion.x,0,0.05)
		if Input.is_action_just_pressed("ui_up") and doublejump_count<1:
			#print("i double jumped")
			motion.y=JUMP_HIGHT
			doublejump_count+=1
		
	#print("doublejump=",doublejump_count)
	motion=move_and_slide(motion,UP)	
	pass
