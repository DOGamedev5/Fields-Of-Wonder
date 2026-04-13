extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	owner.animationTreePlayback.travel("RUN")
	owner.animationTree["parameters/RUN/to_run/TimeScale/scale"] = abs(owner.velocity.x) / owner.maxSpeed
	owner.move(delta, true)
	if abs(owner.velocity.x) > owner.maxSpeed:
		owner.runPlayback.travel("run")
	else:
		
		owner.runPlayback.travel("to_run")
	
func stateProcess():
	if owner.shouldJump():
		return "JUMP"
	
	if owner.is_on_floor():
		if Input.get_axis("ui_left", "ui_right"):
			if not owner.shouldRun: return "WALK"
		else:
			return "IDLE"
	else:
		return "FALL"
	
	
	
	
