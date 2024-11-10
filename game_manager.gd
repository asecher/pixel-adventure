extends Node

var death := 0
var score := 0

var player
var camera: Camera2D

func increment_score() -> void:
	score += 1
