extends Control


func _ready():
	print( WorldState.RESOURCES )
	for r in WorldState.RESOURCES:
		var resource_row = VFlowContainer.new()
		resource_row.alignment = FlowContainer.ALIGNMENT_CENTER
		
		var resource_name_label = Label.new()
		resource_name_label.text = r
		resource_row.add_child( resource_name_label )
		
		var space_panel = Panel.new()
		space_panel.custom_minimum_size.x = 60
		resource_row.add_child( space_panel )
		
		var demand_name_label = Label.new()
		var demand =  WorldState.RESOURCES[r]["demand"]
		demand_name_label.text = str( demand )
		resource_row.add_child( demand_name_label )
		
		var space_panel2 = Panel.new()
		space_panel2.custom_minimum_size.x = 80
		resource_row.add_child( space_panel2 )
		
		var supply_name_label = Label.new()
		var supply = WorldState.RESOURCES[r]["supply"]
		supply_name_label.text = str( supply )
		resource_row.add_child( supply_name_label )
		
		var space_panel3 = Panel.new()
		space_panel3.custom_minimum_size.x = 60
		resource_row.add_child( space_panel3 )
		
		var price_name_label = Label.new()
		price_name_label.text = str( demand / supply )
		resource_row.add_child( price_name_label )
		
		$PanelContainer/MarginContainer/GridContainer.add_child( resource_row )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_button_pressed():
	self.visible = false
