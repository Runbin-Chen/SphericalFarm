extends Node

const turn_per_day = 48

var current_turn = 0
var current_day = 0

signal time_flash(day:int,count:int)

func get_current_turn()->int:
	return current_turn

func get_current_day()->int:
	return current_day

func next_count()->int:
	current_turn = current_turn + 1
	if current_turn == turn_per_day :
		current_turn = 0
		current_day = current_day +1
	time_flash.emit(current_day,current_turn)
	return current_turn

func next_day()->int:
	current_day = current_day + 1
	time_flash.emit(current_day,current_turn)
	return current_day
