extends Node

func _ready():
	
	var prov_json = JSON.stringify(MapLoader.provinces_INTERNAL)
	var prov_file = FileAccess.open("provinces.json", FileAccess.WRITE)
	prov_file.store_line(prov_json)
	prov_file.close()
	
	for i in MapLoader.provinces_INTERNAL.size():
		print(MapLoader.provinces_INTERNAL[i])
