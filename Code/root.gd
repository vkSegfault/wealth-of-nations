extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var args = Array(OS.get_cmdline_args())
	if args.has("-exportProvinces"):
		print(">>> Cmd Line Arg deteced: \"-exportProvinces\"")
		_prepare_provinces_to_export()
		_export_provinces()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _prepare_provinces_to_export():
	for i in get_node("/root/Root/WorldDrawDebug/Node2D").get_children():
		
		# if it's not Polygon2D then it's some debug temp shit probably and we don't care
		if not (i is Polygon2D):
			continue
		
		var provName = i.name
		var shape = i.polygon
		MapLoader.provinces_INTERNAL.append( { "name" = provName, "shape" = shape } )
		
	print(">>> Prepared {p} provinces to be exported".format({"p": MapLoader.provinces_INTERNAL.size() }))
	
func _export_provinces():
	print(">>> Exporting provinces...")
	var prov_json = JSON.stringify(MapLoader.provinces_INTERNAL)
	var prov_file = FileAccess.open("provinces.json", FileAccess.WRITE)
	prov_file.store_line(prov_json)
	prov_file.close()
	print(">>> Exporting finished succesfully")
