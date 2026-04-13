extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	owner.animationTreePlayback.travel("NORMAL")
	owner.animationTree["parameters/NORMAL/walk/TimeScale/scale"] = abs(owner.velocity.x) / owner.maxSpeed
	owner.move(delta)
	if sign(owner.velocity.x) != sign(Input.get_axis("ui_left", "ui_right")):
		owner.normalPlayback.travel("stop")
	else:
		
		owner.normalPlayback.travel("walk")

func stateProcess():
	if not owner.is_on_floor():
		return "FALL"
	elif not Input.get_axis("ui_left", "ui_right"):
		return "IDLE"
	elif owner.shouldRun:
		return "RUN"

	if owner.shouldJump():
		return "JUMP"
