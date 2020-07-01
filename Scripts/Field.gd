extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var blocc_array:Array
var swipe_start
var min_drag = 72.0

onready var preblocc = preload("res://Scenes/Blocc.tscn")
onready var area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if len(blocc_array)<4:
		spawn_test()

func _input(event):
	if event is InputEventScreenTouch && event.pressed:
		swipe_start = event.position
	if event is InputEventScreenTouch && !event.pressed:
		var swipe_end = event.position
		if is_in_area(swipe_start) && is_in_area(swipe_end):
		#if swipe_start!=null && swipe_end!=null && abs(swipe_start.y-640)<450 && abs(swipe_start.x-360)<300 && abs(swipe_end.y-640)<450 && abs(swipe_end.x-360)<300:
			swipe(swipe_start,swipe_end)
	if event is InputEventKey:
		if event.pressed && !event.echo:
			if event.scancode==KEY_W || event.scancode==KEY_UP:
				swipe(Vector2.ZERO,Vector2(0,-144))
			elif event.scancode==KEY_D || event.scancode==KEY_RIGHT:
				swipe(Vector2.ZERO,Vector2(144,0))
			elif event.scancode==KEY_S || event.scancode==KEY_DOWN:
				swipe(Vector2.ZERO,Vector2(0,144))
			elif event.scancode==KEY_A || event.scancode==KEY_LEFT:
				swipe(Vector2.ZERO,Vector2(-144,0))

func spawn_blocc(row:int,column:int,digit:int):
	var blocc = preblocc.instance()
	blocc.position.x = pos_calc(row)
	blocc.position.y = pos_calc(column)
	blocc.get_child(0).get_child(0).bb_be_numbah(digit)
	add_child(blocc)

func spawn_test():
	var r = randi()%4
	var c = randi()%4
	var d = (1+randi()%2)*2
	for i in blocc_array:
		if r==i[0] && c==i[1]:
			return
	blocc_array.append([r,c,d])
	spawn_blocc(r,c,d)

func pos_calc(n:int):
	return(-125 if n==0 else 125 if n==3 else 0)+(-62.5 if n<2 else 62.5)+(n-1.5)*20

func swipe(start,end):
	var move = end - start
	if move.length()>min_drag:
		if abs(move.x)>abs(move.y):
			if move.x<0:
				print('l')
			else:
				print('r')
		else:
			if move.y>0:
				print('d')
			else:
				print('u')
func is_in_area(pos):
	return true if abs(pos.y-640)<450 && abs(pos.x-360)<300 else false
