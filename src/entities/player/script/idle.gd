extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	
	if owner.velocity.x and not Input.get_axis("ui_left", "ui_right"):
		owner.move(delta)
		owner.animationTreePlayback.travel("stop")
	else:
		owner.animationTreePlayback.travel("idle")

func stateProcess():
	if not owner.is_on_floor():
		return "FALL"
	elif Input.get_axis("ui_left", "ui_right"):
			return "WALK"
	if owner.shouldJump():
		return "JUMP"
