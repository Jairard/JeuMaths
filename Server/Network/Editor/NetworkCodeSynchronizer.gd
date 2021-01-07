tool
extends Node

# This MUST be an absolute path, else the folder creation won't work
var common_files_root = ProjectSettings.globalize_path("res://") + "../Common"
const network_scripts_root = "Network"
const include_all_regexes = [".*"]
const include_regexes = ["Network/.*"]
const exclude_regexes = [".*PlayerIdDatabase\\.gd", ".*Server\\.gd"]

var plugin : EditorPlugin = EditorPlugin.new()
var compiled_include_all_regexes : Array = []
var compiled_include_regexes : Array = []
var compiled_exclude_regexes : Array = []
const is_enabled : bool = true

func _ready():
	#init()
	#fetch_common_files()
	pass

func init() -> void:
	var file_system = plugin.get_editor_interface().get_resource_filesystem()
	safe_connect(file_system, "filesystem_changed", self, "update_common_files")
	compiled_include_all_regexes = compile_regexes(include_all_regexes)
	compiled_include_regexes = compile_regexes(include_regexes)
	compiled_exclude_regexes = compile_regexes(exclude_regexes)

func update_common_files():
	if is_enabled:
		print("[NetworkCodesynchronizer] Copying local project files to common directory")
		# We redo the init since the script may have been changed and its variables detroyed
		init()
		var script_files = get_files_to_copy(network_scripts_root, compiled_include_regexes, compiled_exclude_regexes)
		copy_files_to(network_scripts_root, common_files_root, script_files)

func fetch_common_files() -> void:
	if is_enabled:
		print("[NetworkCodesynchronizer] Copying common files to local project")
		var common_files = get_files_to_copy(common_files_root, compiled_include_all_regexes)
		copy_files_to(common_files_root, network_scripts_root, common_files)

# This should be moved to an utility file
func safe_connect(source : Node, signal_name : String, target : Node, func_name : String) -> void:
	if source.is_connected(signal_name, target, func_name):
		source.disconnect(signal_name, target, func_name)
	source.connect(signal_name, target, func_name)

func get_files_to_copy(root : String,  incl_regexes : Array = [], excl_regexes : Array = []) -> Array:
	var files : Array = list_files_in_directory(root, true)
	return filter_files_with_regex(files, incl_regexes, excl_regexes)

# Creates regexes from string
func compile_regexes(regexes : Array) -> Array:
	var result : Array = []

	for regex_str in regexes:
		var regex = RegEx.new()
		print("compiling regex '", regex_str, "'...")
		var success = regex.compile(regex_str)
		if success == OK:
			result.append(regex)

	return result

# Returns the files the are contained in the given path
func list_files_in_directory(path : String, recursive : bool = false) -> Array:
	var dir : Directory = Directory.new()
	var success = dir.open(path)
	if success != OK:
		print("couldn't open directory '", path, "'")
		return []

	dir.list_dir_begin(true, true)
	var files : Array = []
	var item : String = dir.get_next()

	while len(item) > 0:
		var item_path : String =  path + "/" + item
		if !dir.current_is_dir():
			files.append(item_path)
		elif recursive:
			files += list_files_in_directory(item_path, recursive)
		item = dir.get_next()

	dir.list_dir_end()
	return files

# Returns the files that match at least one include regex and don't match any exclude regex
func filter_files_with_regex(files : Array, incl_regexes : Array, excl_regexes : Array) -> Array:
	var included_files : Array = []

	for file in files:
		for regex in incl_regexes:
			if regex.search(file) != null:
				included_files.append(file)
				break

	var result : Array = []
	for file in included_files:
		var is_valid : bool = true
		for regex in excl_regexes:
			if regex.search(file):
				is_valid = false
				break
		if is_valid:
			result.append(file)

	return result

# Copies all the files at given relative paths to an absolute directory
func copy_files_to(src_folder : String, dst_folder : String, files : Array) -> void:
	var dir : Directory = Directory.new()
	for path in files:
		if !path.begins_with(src_folder):
			print("File path '", path, "' does not start with its root '", src_folder, "'")
			continue
		var dst_path : String = dst_folder + path.right(len(src_folder))
		ensure_path_exists(dst_path)
		var success = dir.copy(path, dst_path)
		if success != OK:
			print("couldn't copy file '", path, "' to '", dst_path, "'")
		else:
			print("'", path, "' -> '", dst_path, "'")

# Creates all the folders that don't exist in the given path
func ensure_path_exists(path : String) -> void:
	var last_separator = path.find_last("/")
	# There is no separator in path, so there is no folder to create
	if last_separator == -1:
		return

	# Get folder-only path
	var folder_path = path.left(last_separator)

	var dir : Directory = Directory.new()
	# File or directory already exists, nothing to do
	if dir.file_exists(path) || dir.dir_exists(folder_path):
		return

	# Create the needed folders
	if dir.make_dir_recursive(folder_path) == OK:
		print("created folders for directory '", folder_path, "'")
	else:
		print("couldn't create folders for directory '", folder_path, "'")
