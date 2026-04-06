extends CharacterBody2D

const SPEED =  300.0
const JUMP_VELOCITY = -400.0
@onready var spriteGizmo := $gizmo

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += 800 *  delta
	
	rotateSprite(delta)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func rotateNormal(delta):
	var floorNormal : Vector2 = get_floor_normal()
	
	if not is_on_floor():
		floorNormal.x = clamp((velocity.x / (SPEED)), -0.2, 0.2)
		floorNormal.y = -(1 - abs(floorNormal.x))
		if velocity.y > 0: floorNormal.x *= -1
	
	#if not onFloor() and (running or isRolling):
	#	floorNormal = Vector2(sin(motion.angle()), cos(motion.angle()))
	
	return floorNormal

func rotateSprite(delta):
	var floorNormal : Vector2 = rotateNormal(delta)
	var weight := 20
	
	var angle : float = max(min(atan2(float(floorNormal.x), -float(floorNormal.y)), deg_to_rad(45)), deg_to_rad(-45))
	if not is_on_floor():
		weight = 10
	
		#if running or isRolling:
			#angle = motion.angle()
			#if motion.x < 0:
				#angle += PI
	
	spriteGizmo.rotation = lerp_angle(spriteGizmo.rotation, angle, weight * delta)
