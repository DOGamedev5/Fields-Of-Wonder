@abstract class_name PlayerBase extends CharacterBody2D

@export var maxSpeed := 300
@export var jumpForce := -425
@export var spriteGizmo : Node2D
@export var gravityForce := 780
@export var maxFall := 300

func gravity(delta):
	if not is_on_floor():
		velocity.y += min((gravityForce) *  delta, 300)

func getRotationNormal():
	var floorNormal : Vector2 = get_floor_normal()
	
	if not is_on_floor():
		floorNormal.x = clamp((velocity.x / (maxSpeed)), -0.2, 0.2)
		floorNormal.y = -(1 - abs(floorNormal.x))
		if velocity.y > 0: floorNormal.x *= -1
	
	#if not onFloor() and (running or isRolling):
	#	floorNormal = Vector2(sin(motion.angle()), cos(motion.angle()))
	
	return floorNormal

func rotateSprite(delta):
	if not spriteGizmo: return
	var floorNormal : Vector2 = getRotationNormal()
	var weight := 20
	
	var angle : float = max(min(atan2(float(floorNormal.x), -float(floorNormal.y)), deg_to_rad(45)), deg_to_rad(-45))
	if not is_on_floor():
		weight = 10
	
		#if running or isRolling:
			#angle = motion.angle()
			#if motion.x < 0:
				#angle += PI
	
	spriteGizmo.rotation = lerp_angle(spriteGizmo.rotation, angle, weight * delta)

func shouldFlip(old : bool) -> bool:
	if velocity.x:
		return velocity.x < 0
	
	var input = Input.get_axis("ui_left", "ui_right")
	if input:
		return input < 0
	
	return old
