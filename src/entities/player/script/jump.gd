extends State

var jumping := false

func enter(_lastState : String):
	owner.velocity.y = owner.jumpForce
	jumping = true

func exit():
	jumping = false

func physicsProcess(delta):
	owner.animationTreePlayback.travel("NORMAL")
	owner.normalPlayback.travel("jump")
	
	owner.move(delta, abs(owner.velocity.x) > owner.maxSpeed)
	if not Input.is_action_pressed("jump") and jumping:
		owner.velocity.y /= 2
		jumping = false

func stateProcess():
	if owner.is_on_floor():
		if Input.get_axis("ui_left", "ui_right"):
			if owner.shouldRun:
				return "RUN"
			return "WALK"
		else:
			return "IDLE"
	elif owner.velocity.y >= 0:
		return "FALL"
