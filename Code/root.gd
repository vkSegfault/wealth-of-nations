extends Node

var provinces_INTERNAL = []

func _ready():
	var args = Array(OS.get_cmdline_args())
	if args.has("-exportProvinces"):
		print(">>> Cmd Line Arg deteced: \"-exportProvinces\"")
		_prepare_provinces_to_export()
		_export_provinces()


@warning_ignore("unused_parameter")
func _process(delta):
	pass
	
	
func _prepare_provinces_to_export():
	for i in get_node("/root/Root/WorldDrawDebug/Node2D").get_children():
		
		# if it's not Polygon2D then it's some debug temp shit probably and we don't care
		for j in i.get_children():
			if not (j is Polygon2D):
				continue
		
			var provName = j.name
			var shape = j.polygon
			provinces_INTERNAL.append( { "name" = provName, "shape" = shape } )
		
	print(">>> Prepared {p} provinces to be exported".format({"p": provinces_INTERNAL.size() }))
	

func _export_provinces():
	print(">>> Exporting provinces...")
	var prov_json = JSON.stringify(provinces_INTERNAL)
	var prov_file = FileAccess.open("provinces.json", FileAccess.WRITE)
	prov_file.store_line(prov_json)
	prov_file.close()
	print(">>> Exporting finished succesfully")
