extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var digit = 2048
var dcount = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func adapt_format():
	match dcount:
		1,2:theme = load("res://Themes/2digits.tres")
		3:theme = load("res://Themes/3digits.tres")
		4:theme = load("res://Themes/4digits.tres")
		5:theme = load("res://Themes/5digits.tres")
		_:
			theme = load("res://Themes/8digits.tres")

func bb_be_numbah(d:int):
	digit=d
	dcount=len(str(digit))
	adapt_format()
	if dcount>5:
		var long_digit = str(digit)
		long_digit = long_digit.insert(len(long_digit)/2,"\n")
		bbcode_text="[center][b][tornado radius=1 freq=%d]%s[/tornado][/b][/center]"%[-8 if randi()%2!=randi()%2 else 8,long_digit]
	else:
		bbcode_text="[center][b][tornado radius=1 freq=%d]%d[/tornado][/b][/center]"%[-8 if randi()%2!=randi()%2 else 8,digit]

func reposition_label():
	dcount = len(str(digit))
	margin_top = 0 if dcount<3 or dcount>5 else 25
