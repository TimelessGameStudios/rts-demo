extends AnimatedSprite2D

var animationType = 1
var animationRun = 1
var loopAmount = 5

var animation_dictionary = {
	1:"avoid",
	2:"bite",
	3:"dash",
	4:"dead",
	5:"hurt",
	6:"idle",
	7:"jump",
	8:"kick",
	9:"run",
	10:"scan"
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_playing():
		pass
	else:
		play(animation_dictionary[animationType])


func _on_animation_looped():
	animationRun += 1
	if animationRun > loopAmount:
		stop()
		animationType += 1
		animationRun = 1
	if animationType > 10:
		animationType = 1
