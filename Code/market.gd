extends Control


func _ready():
	#print_debug( WorldState.RESOURCES )
	for r in WorldState.RESOURCES:
		
#		print("printing resources")
#		print(r)
		var demand: int =  WorldState.RESOURCES[r]["demand"]
		var supply: int = WorldState.RESOURCES[r]["supply"]
		if supply == 0:
			# no one is producing such resource so don't display it
			continue
		
		var resource_row = VFlowContainer.new()
		resource_row.alignment = FlowContainer.ALIGNMENT_CENTER
		
		var resource_name_label = Label.new()
		resource_name_label.text = r
		resource_row.add_child( resource_name_label )
		
		var space_panel = Panel.new()
		space_panel.custom_minimum_size.x = 60
		resource_row.add_child( space_panel )
		
		var demand_name_label = Label.new()
		demand_name_label.name = "demand_name_label"
		demand_name_label.text = str( demand )
		resource_row.add_child( demand_name_label )
		
		var space_panel2 = Panel.new()
		space_panel2.custom_minimum_size.x = 80
		resource_row.add_child( space_panel2 )
		
		var supply_name_label = Label.new()
		supply_name_label.name = "supply_name_label"
		supply_name_label.text = str( supply )
		resource_row.add_child( supply_name_label )
		
		var space_panel3 = Panel.new()
		space_panel3.custom_minimum_size.x = 60
		resource_row.add_child( space_panel3 )
		
		var price_name_label = Label.new()
		price_name_label.name = "price_name_label"
		price_name_label.text = str( demand / supply )
		resource_row.add_child( price_name_label )
		
		resource_row.name = r
		$PanelContainer/MarginContainer/GridContainer/resources_rows.add_child( resource_row )


func _process(_delta):
	pass


func _on_close_button_pressed():
	var resources_rows = $PanelContainer/MarginContainer/GridContainer/resources_rows
	print( "There are " + str( resources_rows.get_child_count() ) + " resource rows" )
	for row in resources_rows.get_children():
		print( row.name )
	for r in WorldState.RESOURCES:
		var demand =  WorldState.RESOURCES[r]["demand"]
		var supply = WorldState.RESOURCES[r]["supply"]
		#print( resource_row.name )
	var resource_row = get_node("PanelContainer/MarginContainer/GridContainer/resources_rows/oil")
	print( resource_row )


	self.visible = false
