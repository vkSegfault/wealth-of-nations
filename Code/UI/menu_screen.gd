extends CanvasLayer


func _ready():
	for i in MapLoader.countries_INTERNAL:
		$PanelContainer/MarginContainer/GridContainer/ItemList.add_item(i)



func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	print( "Clicked index: {i}".format({'i': index}) )
	var country_name = $PanelContainer/MarginContainer/GridContainer/ItemList.get_item_text(index)
	print( "Choosen country: {c}".format({'c': country_name}) )
	get_tree().change_scene_to_file("res://Scenes/root.tscn")
