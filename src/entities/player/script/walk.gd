extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	owner.animationTree["parameters/walk/TimeScale/scale"] = abs(owner.velocity.x) / owner.maxSpeed
	owner.animationTreePlayback.travel("walk")
	owner.move(delta)

func stateProcess():
	if not Input.get_axis("ui_left", "ui_right"):
		return "IDLE"
