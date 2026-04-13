extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	owner.animationTreePlayback.travel("fall")
	
	owner.move(delta)

func stateProcess():
	if owner.is_on_floor():
		if Input.get_axis("ui_left", "ui_right"):
			return "WALK"
		else:
			return "IDLE"
	
	if owner.shouldJump():
		return "JUMP"
	
	
