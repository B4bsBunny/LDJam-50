extends Node2D

class_name SleepEnemies

var count = 0


var sleep_attack :NodePath = "res://enemies/Sleep_Attack.tscn"

var attack_count = 0
var attack_instance
var targets = []
var spot = 0
var look_for_kills :bool 

func _ready():
	look_for_kills = false
	count = 5
	randomize()
	$Label.visible = false

func _process(_delta):
	if look_for_kills == true:
		can_free_player()
	else:
		return


func _on_Hit_Box_body_entered(body):
	if body is KinematicBody2D and Settings.curGameState != Settings.GAME_STATES.BATTLE:
		body.path = []
		Settings.curGameState = Settings.GAME_STATES.BATTLE
		$Label.visible = true
		attack_position()

func _on_Hit_Box_body_exited(_body):
	$Label.visible = false

func attack_position():
	targets = []
	for i in count:
		var pick
		pick = randi() % count + 1
		var cur_target = get_node('Target_Locations/Position2D'+str(pick))
		targets.append(cur_target)
	$Label.text = 'I am going to attack you with sleep things!!! BWAHAHAHA SLEEP THINGS!!'
	$AnimationPlayer.play("Attacking")

func spawn_attacks():
	attack_instance = load(str(sleep_attack))
	var attack = attack_instance.instance()
	attack.position = targets[spot].global_position
	$Attacks.add_child(attack)
	spot = spot + 1

func insert_dead_baby_joke():
	look_for_kills = true

func can_free_player():
	var pool = $Attacks.get_children()
	if pool.size() == 0:
		Settings.curGameState = Settings.GAME_STATES.PLAY
		$AnimationPlayer.play("Dying")
		terminator()


func terminator():
	$Label.text = "I'll be back Bwahahaha!!"
	$Label.visible = true

func byeeeeee():
	queue_free()

