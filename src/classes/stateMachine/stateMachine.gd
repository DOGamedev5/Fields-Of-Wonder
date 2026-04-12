class_name StateMachine
extends Node

@onready var statesPath = {}
@onready var currentState : String

func init(initialState : String):
	for state in get_children():
		statesPath[state.name] = state
	if statesPath.has(initialState): currentState = initialState 

func changeState(state : String):
	statesPath[currentState].exit()
	statesPath[state].enter(currentState)
	currentState = state

func insertState(state : State, stateName):
	state.name = stateName
	add_child(state)
	statesPath[stateName] = state

func process(delta):
	stateProcess(delta)
	stateMachineProcess()

func stateProcess(delta):
	statesPath[currentState].physicsProcess(delta)
	
func stateMachineProcess():
	var newState = statesPath[currentState].stateProcess()
	
	if newState: changeState(newState)
