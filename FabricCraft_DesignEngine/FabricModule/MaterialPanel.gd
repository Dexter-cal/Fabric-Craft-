extends PanelContainer

# --- Material Panel Logic ---
# Manages the UI for selecting fabrics and adjusting material properties.

@onready var gloss_slider = $VBoxContainer/GlossSlider
@onready var transparency_slider = $VBoxContainer/TransparencySlider

# This signal will be emitted when a material property changes.
# The main DesignEngine scene can connect to this to update the garment.
signal material_updated(material_properties: Dictionary)

var current_properties = {
	"gloss": 0.5,
	"transparency": 0.0
}

func _ready():
	# Connect slider signals to a handler function.
	gloss_slider.value_changed.connect(_on_slider_value_changed.bind("gloss"))
	transparency_slider.value_changed.connect(_on_slider_value_changed.bind("transparency"))

	# Set initial slider values.
	gloss_slider.value = current_properties.gloss
	transparency_slider.value = current_properties.transparency

func _on_slider_value_changed(value, property_name):
	current_properties[property_name] = value
	material_updated.emit(current_properties)
	print("Material property '", property_name, "' updated to: ", value)
	pass
