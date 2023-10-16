extends CanvasLayer

var bg_style = StyleBoxFlat.new()
var province_short_info_bg_color = "0000009e"
var province_short_info_corner_radius = 5  # in px


func _ready():
	bg_style.bg_color = Color( province_short_info_bg_color )
	bg_style.corner_radius_top_left = province_short_info_corner_radius
	bg_style.corner_radius_top_right = province_short_info_corner_radius
	bg_style.corner_radius_bottom_left = province_short_info_corner_radius
	bg_style.corner_radius_bottom_right = province_short_info_corner_radius
	$ProvinceShortInfo/ProvinceName.add_theme_font_size_override("font_size", 26)
	
	# ProvinceShortCursorView
	SignalRelay.province_name_changed_signal.connect( _print_province_info )  # number of func args MUST match those of signal  
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/ProvinceNameLabel.add_theme_font_size_override("font_size", 40)
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/CountryNameLabel.add_theme_font_size_override("font_size", 40)
	
	# Province Details Window
	SignalRelay.province_clicked_signal.connect( _show_province_details )
	
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


func _print_province_info( province_name, country_name ):
	print("Province name changed Signal received! {name}".format( {"name": province_name} ) )
	
	$ProvinceShortInfo.set_position( get_viewport().get_mouse_position() )
	$ProvinceShortInfo/ProvinceName.add_theme_stylebox_override( "normal", bg_style )
	$ProvinceShortInfo/ProvinceName.text = province_name
	$ProvinceShortInfo/CountryName.add_theme_stylebox_override( "normal", bg_style )
	$ProvinceShortInfo/CountryName.text = country_name
	$ProvinceShortInfo.visible = true

func _show_province_details( province_name, country_name, pop ):
	$ProvinceView.visible = true
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/ProvinceNameLabel.text = province_name
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/CountryNameLabel.text = country_name
	$ProvinceView/PanelContainer/MarginContainer/GridContainer/PopLabel.text = "Pop: " + str(pop)

func _print_country_info( country_name, pop, capital, production ):
	var country_stats = $CountryStats/PanelContainer/MarginContainer/GridContainer
	country_stats.get_node("CountryNameLabel").text = country_name
	country_stats.get_node("PopLabel").text = "Population: " + str(pop)
	country_stats.get_node("CapitalLabel").text = "Capital: " + capital
	country_stats.get_node("ProductionLabel").text = "Produced goods: " + "\n" + str(production)


func _on_next_turn_button_pressed():
	WorldState.next_turn()


func _on_market_view_button_pressed():
	$MarketView.visible = true
