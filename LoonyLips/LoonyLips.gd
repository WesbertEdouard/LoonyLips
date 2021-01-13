extends Control

var player_words = []
var template = [
			{
			"prompts": ["A name", "a noun", "adverb", "adjective"],
			"story": "Once upon a time someone called %s ate a %s flavored sandwhich which made him feel all %s inside and it was %s"
			},
			{
			"prompts": ["A name", "a noun", "adverb", "color"],
			"story": "There once lived a man called %s who lived in a %s size room which made them sligthly %s and %s"
			},
			]
var current_story


onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var Story = $VBoxContainer/Story

func _ready():
	set_current_story()
	Story.text = "Welcome to Loony Lips\n"
	check_player_words_length()
	PlayerText.grab_focus()

func set_current_story():
	randomize()
	current_story = template[randi() % template.size()]
	
	
func _on_PlayerText_text_entered(data):
	add_to_player_words()

func _on_Button_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()


func add_to_player_words():
	if PlayerText.text != "":
		player_words.append(PlayerText.text)
		Story.text = ""
		PlayerText.clear()
		check_player_words_length()
	elif player_words.size() >= current_story.prompts.size():
		end_game()
	else:
		Story.text = "Please Enter " + current_story.prompts[player_words.size()] + " to play" 

func is_story_done():
	return player_words.size() == current_story.prompts.size()

func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
		
		
func tell_story():
	Story.text = current_story.story % player_words

func end_game():
	tell_story()
	PlayerText.queue_free()
	Story.text += "\n\nThank You For Playing!"
	$VBoxContainer/HBoxContainer/ButtonText.text = "Play Again?"
	
func prompt_player():
	Story.text += "May I have " + current_story.prompts[player_words.size()] + " please?"



	
	
	
	
	
	
	
	
	
	






