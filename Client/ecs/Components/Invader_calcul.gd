extends Component

class_name InvaderCalculComponent

var invader : InvaderComponent = null

func get_invader() -> InvaderComponent:
	return invader

func init(_invader : InvaderComponent) -> void:
	invader = _invader

