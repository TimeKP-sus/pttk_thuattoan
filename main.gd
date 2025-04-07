extends Control

var ngan_cho:Array[Vector2]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for i in range(1,101):
		#ngan_cho.append(get_node("NinePatchRect/GridContainer/O" + str(i)).vi_tri)
		#print(str(get_node("NinePatchRect/GridContainer/O" + str(i)).vi_tri))
	#print(ngan_cho)
	pass # Replace with function body.
func kiem_tra():
	var trangthai :PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var thongtin :PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	thongtin.collide_with_areas = true
	thongtin.collision_mask = 1
	var ketqua:Array = trangthai.intersect_point(thongtin)
	if ketqua.size() > 0:
		#ngan_cho.append(ketqua[0].collider.get_parent().position)
		print(ketqua[0].collider.get_parent(),ketqua[0].collider.get_parent().position)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
				print("Bấm")
				check_o(get_local_mouse_position())
				check_may_hut()
				print("ngan cho" , ngan_cho)
		else:
				print("Thả")
	pass

func check_o(_vi_tri_o:Vector2):
	var trangthai :PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var thongtin :PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	thongtin.position = _vi_tri_o
	thongtin.collide_with_areas = true
	thongtin.collision_mask = 1
	var ketqua:Array = trangthai.intersect_point(thongtin)
	if ketqua.size() > 0:
		#ngan_cho.append(ketqua[0].collider.get_parent().position)
		print(ketqua[0].collider.get_parent(),ketqua[0].collider.get_parent().position)
	pass
	
func check_may_hut():
	var trangthai :PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var thongtin := PhysicsPointQueryParameters2D.new()
	thongtin.position = get_global_mouse_position()
	thongtin.collide_with_areas = true
	thongtin.collision_mask = 2
	var ketqua:Array = trangthai.intersect_point(thongtin)
	if ketqua.size() > 0:
		print(ketqua[0].collider.get_parent(),ketqua[0].collider.get_parent().position)
	pass


func _on_button_pressed() -> void:
	var tw:Tween = create_tween()
	print(ngan_cho)
	if ngan_cho.size() > 0:
		for i in ngan_cho:
			tw.tween_property($NinePatchRect/GridContainer/may_hut,"position",i,1.0)
	pass # Replace with function body.


func _on_kiem_tra_o_pressed() -> void:
	if ngan_cho.size() < 100:
		for i in range(1,101):
			print(str(get_node("NinePatchRect/GridContainer/O" + str(i)).name),str(get_node("NinePatchRect/GridContainer/O" + str(i)).position))
			ngan_cho.append(get_node("NinePatchRect/GridContainer/O" + str(i)).position)
		
	pass # Replace with function body.
