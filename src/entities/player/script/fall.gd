extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	owner.animationTreePlayback.travel("NORMAL")
	owner.normalPlayback.travel("fall")
	
	owner.move(delta, abs(owner.velocity.x) > owner.maxSpeed)

func stateProcess():
	if owner.is_on_floor():
		if Input.get_axis("ui_left", "ui_right"):
			if owner.shouldRun:
				return "RUN"
			return "WALK"
		else:
			return "IDLE"
	
	if owner.shouldJump():
		return "JUMP"
	
	
