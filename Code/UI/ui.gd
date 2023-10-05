extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalRelay.province_name_changed_signal.connect(_print_province_info)  # args from signal are passes implictly to connected func
	$Control/PanelContainer/MarginContainer/GridContainer/ProvinceNameLabel.add_theme_font_size_override("font_size", 40)
	$Control/PanelContainer/MarginContainer/GridContainer/CountryNameLabel.add_theme_font_size_override("font_size", 40)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass

func _print_province_info(province_name, country_name):
	print("Province name changed Signal received! {name}".format( {"name": province_name} ) )
	$Control/PanelContainer/MarginContainer/GridContainer/ProvinceNameLabel.text = province_name
	$Control/PanelContainer/MarginContainer/GridContainer/CountryNameLabel.text = country_name
