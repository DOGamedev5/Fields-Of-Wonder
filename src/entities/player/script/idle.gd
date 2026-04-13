extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	owner.animationTreePlayback.travel("NORMAL")
	
	if owner.velocity.x and not Input.get_axis("ui_left", "ui_right"):
		owner.move(delta)
		owner.normalPlayback.travel("stop")
	else:
		owner.normalPlayback.travel("idle")

func stateProcess():
	if not owner.is_on_floor():
		return "FALL"
	elif Input.get_axis("ui_left", "ui_right"):
		if owner.shouldRun:
			return "RUN"
			
		return "WALK"
	if owner.shouldJump():
		return "JUMP"
