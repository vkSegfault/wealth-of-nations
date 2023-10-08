extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# ProvinceView
	SignalRelay.province_name_changed_signal.connect(_print_province_info)  # args from signal are passes implictly to connected func
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/ProvinceNameLabel.add_theme_font_size_override("font_size", 40)
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/CountryNameLabel.add_theme_font_size_override("font_size", 40)
	
	# CountryStats
	for c in $CountryStats/PanelContainer/MarginContainer/GridContainer.get_children():
		c.add_theme_font_size_override("font_size", 40)
	_print_country_info( 
		WorldState.player_country._name, 
		WorldState.player_country._pop, 
		WorldState.player_country._capital, 
		WorldState.player_country._production
	)


@warning_ignore("unused_parameter")
func _process(delta):
	pass


func _print_province_info(province_name, country_name):
	print("Province name changed Signal received! {name}".format( {"name": province_name} ) )
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/ProvinceNameLabel.text = province_name
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/CountryNameLabel.text = country_name


func _print_country_info( country_name, pop, capital, production ):
	var country_stats = $CountryStats/PanelContainer/MarginContainer/GridContainer
	country_stats.get_node("CountryNameLabel").text = country_name
	country_stats.get_node("PopLabel").text = "Population: " + str(pop)
	country_stats.get_node("CapitalLabel").text = "Capital: " + capital
	country_stats.get_node("ProductionLabel").text = "Produced goods: " + "\n" + str(production)
