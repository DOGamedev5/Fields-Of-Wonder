extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	owner.animationTree["parameters/walk/TimeScale/scale"] = abs(owner.velocity.x) / owner.maxSpeed
	owner.move(delta)
	if sign(owner.velocity.x) != sign(Input.get_axis("ui_left", "ui_right")):
		owner.animationTreePlayback.travel("stop")
	else:
		owner.animationTreePlayback.travel("walk")

func stateProcess():
	if not owner.is_on_floor():
		return "FALL"
	elif not Input.get_axis("ui_left", "ui_right"):
		return "IDLE"

	if owner.shouldJump():
		return "JUMP"
