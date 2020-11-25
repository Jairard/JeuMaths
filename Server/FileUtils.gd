extends Node

func safe_open_file(path : String, flags : int, function_name : String) -> File:
	var file = File.new()
	var res = file.open(path, flags)
	if (res == OK):
		return file
	push_error("An error occurend while opening '" + path + "' in " + function_name + ": " + get_error_msg(res))
	return null

func load_json(path : String):
	var file = safe_open_file(path, File.READ, "load_json")
	if file == null:
		return null
	var text = file.get_as_text()
	file.close()
	return parse_json(text)

func save_json(data, path : String) -> bool:
	var file = safe_open_file(path, File.WRITE, "save_json")
	if file == null:
		return false
	file.store_string(to_json(data))
	file.close()
	return true

func get_error_msg(error) -> String:
	match error:
		OK:
			return "OK"
		FAILED:
			return "Generic error"
		ERR_UNAVAILABLE:
			return "Unavailable error"
		ERR_UNCONFIGURED:
			return "Unconfigured error"
		ERR_UNAUTHORIZED:
			return "Unauthorized error"
		ERR_PARAMETER_RANGE_ERROR:
			return "Parameter range error"
		ERR_OUT_OF_MEMORY:
			return "Out of memory (OOM) error"
		ERR_FILE_NOT_FOUND:
			return "File: Not found error"
		ERR_FILE_BAD_DRIVE:
			return "File: Bad drive error"
		ERR_FILE_BAD_PATH:
			return "File: Bad path error"
		ERR_FILE_NO_PERMISSION:
			return "File: No permission error"
		ERR_FILE_ALREADY_IN_USE:
			return "File: Already in use error"
		ERR_FILE_CANT_OPEN:
			return "File: Can't open error"
		ERR_FILE_CANT_WRITE:
			return "File: Can't write error"
		ERR_FILE_CANT_READ:
			return "File: Can't read error"
		ERR_FILE_UNRECOGNIZED:
			return "File: Unrecognized error"
		ERR_FILE_CORRUPT:
			return "File: Corrupt error"
		ERR_FILE_MISSING_DEPENDENCIES:
			return "File: Missing dependencies error"
		ERR_FILE_EOF:
			return "File: End of file (EOF) error"
		ERR_CANT_OPEN:
			return "Can't open error"
		ERR_CANT_CREATE:
			return "Can't create error"
		ERR_QUERY_FAILED:
			return "Query failed error"
		ERR_ALREADY_IN_USE:
			return "Already in use error"
		ERR_LOCKED:
			return "Locked error"
		ERR_TIMEOUT:
			return "Timeout error"
		ERR_CANT_CONNECT:
			return "Can't connect error"
		ERR_CANT_RESOLVE:
			return "Can't resolve error"
		ERR_CONNECTION_ERROR:
			return "Connection error"
		ERR_CANT_ACQUIRE_RESOURCE:
			return "Can't acquire resource error"
		ERR_CANT_FORK:
			return "Can't fork process error"
		ERR_INVALID_DATA:
			return "Invalid data error"
		ERR_INVALID_PARAMETER:
			return "Invalid parameter error"
		ERR_ALREADY_EXISTS:
			return "Already exists error"
		ERR_DOES_NOT_EXIST:
			return "Does not exist error"
		ERR_DATABASE_CANT_READ:
			return "Database: Read error"
		ERR_DATABASE_CANT_WRITE:
			return "Database: Write error"
		ERR_COMPILATION_FAILED:
			return "Compilation failed error"
		ERR_METHOD_NOT_FOUND:
			return "Method not found error"
		ERR_LINK_FAILED:
			return "Linking failed error"
		ERR_SCRIPT_FAILED:
			return "Script failed error"
		ERR_CYCLIC_LINK:
			return "Cycling link (import cycle) error"
		ERR_INVALID_DECLARATION:
			return "Invalid declaration error"
		ERR_DUPLICATE_SYMBOL:
			return "Duplicate symbol error"
		ERR_PARSE_ERROR:
			return "Parse error"
		ERR_BUSY:
			return "Busy error"
		ERR_SKIP:
			return "Skip error"
		ERR_HELP:
			return "Help error"
		ERR_BUG:
			return "Bug error"
		ERR_PRINTER_ON_FIRE:
			return "Printer on fire error"
	return "Unknown error"
