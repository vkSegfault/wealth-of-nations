extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var args = Array(OS.get_cmdline_args())
	print("CMD LINE ARGS:")
	if args.has("-exportProvinces"):
		print("Exporting provinces...")
		_export_provinces()
	for i in args:
		print(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _export_provinces():
	var prov_json = JSON.stringify(MapLoader.provinces_INTERNAL)
	var prov_file = FileAccess.open("provinces.json", FileAccess.WRITE)
	prov_file.store_line(prov_json)
	prov_file.close()
