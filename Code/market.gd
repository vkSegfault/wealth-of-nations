extends Control


func _ready():
	
	SignalRelay.next_turn_signal.connect( update )
	
	#print_debug( WorldState.RESOURCES )
	for r in WorldState.RESOURCES:
		
#		print("printing resources")
#		print(r)
		var demand: float = WorldState.RESOURCES[r]["demand"]
		var supply: float = WorldState.RESOURCES[r]["supply"]
		var demand_domestic: float = 0
		var supply_domestic: float = 0
		if WorldState.PLAYER_COUNTRY._demand.has(r):
			demand_domestic = WorldState.PLAYER_COUNTRY._demand[r]
		if WorldState.PLAYER_COUNTRY._production.has(r):
			supply_domestic = WorldState.PLAYER_COUNTRY._production[r]
		if supply == 0:
			# no one is producing such resource so just don't display it
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
		demand_name_label.mouse_filter = Control.MOUSE_FILTER_STOP
		demand_name_label.tooltip_text = "World Demand ( Domestic Demand )"
		var demand_to_display: String = str( demand ) + ( "(" + str(demand_domestic) + ")"  if demand_domestic != 0 else "" )
		demand_name_label.text = str( demand_to_display )
		resource_row.add_child( demand_name_label )
		
		var space_panel2 = Panel.new()
		space_panel2.custom_minimum_size.x = 80
		resource_row.add_child( space_panel2 )
		
		var supply_name_label = Label.new()
		supply_name_label.name = "supply_name_label"
		supply_name_label.mouse_filter = Control.MOUSE_FILTER_STOP
		supply_name_label.tooltip_text = "World Supply ( Domestic Supply )"
		var supply_to_display: String = str( supply ) + ( "(" + str(supply_domestic) + ")" if supply_domestic != 0 else "" )
		supply_name_label.text = str( supply_to_display )
		resource_row.add_child( supply_name_label )
		
		var space_panel3 = Panel.new()
		space_panel3.custom_minimum_size.x = 60
		resource_row.add_child( space_panel3 )
		
		var price_name_label = Label.new()
		price_name_label.name = "price_name_label"
		price_name_label.text = str( demand / supply )
		resource_row.add_child( price_name_label )
		
		var space_panel4 = Panel.new()
		space_panel4.custom_minimum_size.x = 60
		resource_row.add_child( space_panel4 )
		
		var stock_name_label = Label.new()
		stock_name_label.name = "stock_name_label"
		resource_row.add_child( stock_name_label )
		
		var gather_resource_button = CheckButton.new()
		gather_resource_button.tooltip_text = "Accumulate resource instead selling it"
		resource_row.add_child( gather_resource_button )
		# dynamically instanced node connecting signal to func
		# here we don't create signal because signal already exists and is emitted when we press below button
		## 'pressed' is pre-made signal and with `.bind()` we can add extra args to pre-made ones
		gather_resource_button.toggled.connect( _on_accumulate_resources_button_pressed.bind(r) )
		
		resource_row.name = r
		$PanelContainer/MarginContainer/GridContainer/resources_rows.add_child( resource_row )


func _process(_delta):
	pass

func update():
#	var resources_rows = $PanelContainer/MarginContainer/GridContainer/resources_rows
#	print( "There are " + str( resources_rows.get_child_count() ) + " resource rows" )
#	for row in resources_rows.get_children():
#		print( row.name )
	for r in WorldState.RESOURCES:
		var demand =  WorldState.RESOURCES[r]["demand"]
		var supply = WorldState.RESOURCES[r]["supply"]
		var demand_domestic: float = 0
		var supply_domestic: float = 0
		var stock: float = 0
		if WorldState.PLAYER_COUNTRY._demand.has(r):
			demand_domestic = WorldState.PLAYER_COUNTRY._demand[r]
		if WorldState.PLAYER_COUNTRY._production.has(r):
			supply_domestic = WorldState.PLAYER_COUNTRY._production[r]
		if WorldState.PLAYER_COUNTRY._stock.has(r):
			stock = WorldState.PLAYER_COUNTRY._stock[r]
			
		var resource_row = get_node_or_null("PanelContainer/MarginContainer/GridContainer/resources_rows/" + r)
		if resource_row:
			var demand_label = get_node_or_null("PanelContainer/MarginContainer/GridContainer/resources_rows/" + r +"/demand_name_label")
			var demand_to_display: String = str( demand ) + ( "(" + str(demand_domestic) + ")"  if demand_domestic != 0 else "" )
			demand_label.text = str( demand_to_display )
			
			var supply_label = get_node_or_null("PanelContainer/MarginContainer/GridContainer/resources_rows/" + r +"/supply_name_label")
			var supply_to_display: String = str( supply ) + ( "(" + str(supply_domestic) + ")" if supply_domestic != 0 else "" )
			supply_label.text = str( supply_to_display )
			
			var price_label = get_node_or_null("PanelContainer/MarginContainer/GridContainer/resources_rows/" + r +"/price_name_label")
			price_label.text = str( demand/supply )
			
			var stock_label = get_node_or_null("PanelContainer/MarginContainer/GridContainer/resources_rows/" + r +"/stock_name_label")
			stock_label.text = str( stock )
			

func _on_close_button_pressed():
	self.visible = false

# note that `button_pressed: bool` is needed to pre-made signal requirements, we don't pass any value here
func _on_accumulate_resources_button_pressed( button_pressed: bool, resource: String ):
	# true if button checked, false if unchecked
	if button_pressed:
		#print( "Accumulate: " + resource )
		WorldState.PLAYER_COUNTRY._resources_to_stock.append( resource )
	else:
		#print( "Stop accumulating: " + resource )
		WorldState.PLAYER_COUNTRY._resources_to_stock.erase( resource )
