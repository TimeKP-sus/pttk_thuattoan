extends GridContainer

var o_cham:PackedScene = preload("res://o_cham.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1,101):
		var oCham = o_cham.instantiate()
		oCham.get_node("Control/Label").text = str(i)
		oCham.name = "O" + str(i)
		add_child(oCham)
		print("Ô số ",str(i)," đã được thêm")
	pass # Replace with function body.
