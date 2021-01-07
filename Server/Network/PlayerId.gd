extends Node

# This id uniquely identifies a player
# It is only composed of integers which can be translated into strings via corresponding tables
# See PlayerIdUtils.gd
class_name PlayerId

var teacherId : int
var schoolId : int
var classId : int
var studentId : int

func _init(teacherId : int, schoolId : int, classId : int, studentId : int) -> void:
	self.teacherId = teacherId
	self.schoolId = schoolId
	self.classId = classId
	self.studentId = studentId
