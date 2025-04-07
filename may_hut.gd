extends CharacterBody2D

@onready var phai: RayCast2D = $qlcambien/phai
@onready var duoi: RayCast2D = $qlcambien/duoi
@onready var duoiphai: RayCast2D = $qlcambien/duoiphai
@onready var duoitrai: RayCast2D = $qlcambien/duoitrai
@onready var trai: RayCast2D = $qlcambien/trai
@onready var tren: RayCast2D = $qlcambien/tren
@onready var trentrai: RayCast2D = $qlcambien/trentrai
@onready var trenphai: RayCast2D = $qlcambien/trenphai

var cac_huong:Array[String] = ["phai","duoi","duoiphai","duoitrai","trai","tren","trentrai","trenphai"]

const SPEED = 100.0
#const JUMP_VELOCITY = -400.0
var da_in_ra:bool = false

func _physics_process(_delta: float) -> void:
	for i in cac_huong:
		if get_node("qlcambien/" + i).is_colliding() == true:
			if get_node("qlcambien/" + i).get_collider().get_parent().la_vat_can == false and get_node("qlcambien/" + i).get_collider().get_parent().da_duoc_quet == false:
				get_node("qlcambien/" + i + "/Label").text = get_node("qlcambien/" + i).get_collider().get_parent().name

			if get_node("qlcambien/" + i).get_collider().get_parent().la_vat_can == false and get_node("qlcambien/" + i).get_collider().get_parent().da_duoc_quet == true:
				get_node("qlcambien/" + i + "/Label").text = get_node("qlcambien/" + i).get_collider().get_parent().name + " đã quét"

			if get_node("qlcambien/" + i).get_collider().get_parent().la_vat_can == true:
				get_node("qlcambien/" + i + "/Label").text = get_node("qlcambien/" + i).get_collider().get_parent().name
				if get_node("qlcambien/" + i).get_collider().get_parent().la_vat_can == true:
					get_node("qlcambien/" + i + "/Label").text = "Là vật cản"

		else:
			get_node("qlcambien/" + i + "/Label").text = "Trống" 

	var vt:= Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	move_and_slide()
	velocity = vt * SPEED
	pass

func _ready() -> void:

	pass
