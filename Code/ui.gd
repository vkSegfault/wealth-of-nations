extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalRelay.province_name_changed_signal.connect(_print_test)  # args from signal are passes implictly to connected func
	$Control/PanelContainer/MarginContainer/GridContainer/ProvinceNameLabel.add_theme_font_size_override("font_size", 40)
	$Control/PanelContainer/MarginContainer/GridContainer/CountryNameLabel.add_theme_font_size_override("font_size", 40)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _print_test(province_name):
	print("Province name changed Signal received! {name}".format( {"name": province_name} ) )
	$Control/PanelContainer/MarginContainer/GridContainer/ProvinceNameLabel.text = province_name
