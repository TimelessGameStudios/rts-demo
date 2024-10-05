extends Camera2D

var mousePosition = Vector2()
var mousePositionGlobal = Vector2()
var startPosition = Vector2()
var startVector = Vector2()
var endPosition = Vector2()
var endVector = Vector2()
var isDragging = false
var zoom_min = Vector2(1,1)
var zoom_max = Vector2(5,5)
var zoom_speed = Vector2(0.2,0.2)


signal areaSelected
signal startMoveSelection

func _process(delta):
	
	
	
	
	if Input.is_action_just_pressed("click"):
		startPosition = mousePositionGlobal
		startVector = mousePosition
		isDragging = true
		
	if isDragging:
		endPosition = mousePositionGlobal
		endVector = mousePosition
		draw_area()
	
	if Input.is_action_just_released("click"):
		if startVector.distance_to(mousePosition) > 20:
			
			endPosition = mousePositionGlobal
			endVector = mousePosition
			isDragging = false
			draw_area(false)
			emit_signal("areaSelected")
		else:
			endPosition = startPosition
			isDragging = false
			draw_area(false)

func _input(event):
	if event is InputEventMouse or event is InputEvent:
		mousePosition = event.position
		mousePositionGlobal = get_global_mouse_position()
	
	if Input.is_action_just_pressed("zoom_in"):
		if zoom > zoom_min:
			var viewportsize = get_viewport().get_visible_rect().size
			print(viewportsize)
			zoom -= zoom_speed
			position = mousePosition
			
	if Input.is_action_just_pressed("zoom_out"):
		if zoom < zoom_max:
			var viewportsize = get_viewport().get_visible_rect().size
			print(viewportsize)
			zoom += zoom_speed
			position = mousePosition

func draw_area(draw = true):
	get_node("../ColorRect").size = Vector2(
		abs(startVector.x - endVector.x),
		abs(startVector.y - endVector.y)
	)
	var position = Vector2()
	position.x = min(startVector.x,endVector.x)
	position.y = min(startVector.y,endVector.y)
	get_node("../ColorRect").position = position
	get_node("../ColorRect").size *= int(draw)
