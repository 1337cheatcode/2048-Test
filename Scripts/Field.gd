extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var blocc_array:Dictionary
var swipe_start:Vector2
var min_drag:float = 72
var r4c4_vacant:Array

onready var preblocc = preload("res://Scenes/Blocc.tscn")
onready var area

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(4):
		for j in range(4):
			r4c4_vacant.append("%d%d"%[i,j])
	spawn_test() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

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
	blocc_array["%d%d"%[row,column]]=blocc
	add_child(blocc)

func spawn_test():
	var rc = r4c4_vacant[randi()%len(r4c4_vacant)]
	r4c4_vacant.erase(rc)
	var d = (1+randi()%2)*2
	blocc_array[rc]=d
	spawn_blocc(str2var(rc[0]),str2var(rc[1]),d)

func pos_calc(n:int)->float:
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
		spawn_test()

func is_in_area(pos)->bool:
	return true if abs(pos.y-640)<450 && abs(pos.x-360)<300 else false

func left():
	for i in range(3,-1,-1):
		for j in range(3):
			var rowcol:String = "%d%d"%[i,j]
			for k in range(j,4):
				var slidrc:String = "%d%d"%[i,k]
				if slidrc in blocc_array:
					if rowcol in blocc_array && blocc_array[rowcol]==blocc_array[slidrc]:
						blocc_array[rowcol]
						break
					else:
						blocc_array[rowcol]

func h_gravity(i,j):
	pass

func v_gravity(i,j):
	pass
