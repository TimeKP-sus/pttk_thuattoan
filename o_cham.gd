extends Panel

@export var la_vat_can:bool = false;
@export var o_so:int
var dang_bi_cham:bool = false
var da_duoc_quet:bool = false

var o_da_cham:Array = []

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed() and dang_bi_cham == true:
				print("bam vao o")
				if la_vat_can == false && dang_bi_cham:
					print("da bat")
					$Control/ColorRect.color = Color.BLACK
					la_vat_can = true
				# if la_vat_can == true:
				# 	print("da tat")
				# 	$Control/ColorRect.color = Color.hex(787878)
				# 	la_vat_can = false
	pass


func _on_color_rect_mouse_entered() -> void:
	dang_bi_cham = true
	pass # Replace with function body.


func _on_color_rect_mouse_exited() -> void:
	dang_bi_cham = false
	pass # Replace with function body.


func _on_area_2d_body_entered(_body: Node2D) -> void:
	$Control/ColorRect.color = Color.DARK_GREEN
	da_duoc_quet = true
	pass # Replace with function body.
