extends State

func enter(_lastState : String):
	pass

func exit():
	pass

func physicsProcess(delta):
	owner.animationTreePlayback.travel("idle")
	if owner.velocity.x and not Input.get_axis("ui_left", "ui_right"):
		owner.move(delta)

func stateProcess():
	if Input.get_axis("ui_left", "ui_right"):
		return "WALK"
