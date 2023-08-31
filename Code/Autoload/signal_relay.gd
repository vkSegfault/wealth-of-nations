extends Node

signal province_name_changed_signal(province_name)
func _province_name_changed(province_name):
	province_name_changed_signal.emit(province_name)

