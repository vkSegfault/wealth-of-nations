extends Node

signal province_name_changed_signal( province_name, country_name )
func _province_name_changed( province_name, country_name ):
	province_name_changed_signal.emit( province_name, country_name )

signal province_clicked_signal( province_name, country_name, pop )
func _province_clicked( province_name, country_name, pop ):
	province_clicked_signal.emit( province_name, country_name, pop )
