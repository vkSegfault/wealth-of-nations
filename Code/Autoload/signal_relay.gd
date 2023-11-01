extends Node

signal province_name_changed_signal( province_name, country_name )
func _province_name_changed( province_name, country_name ):
	province_name_changed_signal.emit( province_name, country_name )

signal province_clicked_signal( province_name, country_name, pop, resources, resources_amount, terrain: String )
func _province_clicked( province_name, country_name, pop, resources, resources_amount, terrain: String ):
	province_clicked_signal.emit( province_name, country_name, pop, resources, resources_amount, terrain )

signal next_turn_signal()
func _next_turn():
	next_turn_signal.emit()
