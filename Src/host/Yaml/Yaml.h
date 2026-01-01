// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define YAML_EXTENSION_NAME "ReYaml"

#define YAML_COMMAND_PARSE_STRING "parse_string"
#define YAML_COMMAND_HAS_PARTS "has_parts"
#define YAML_COMMAND_READ_PART "next_read"

#define YAML_COMMAND_FREE_PARTS "free_parts"
#define YAML_COMMAND_GET_LEFT_PARTS_COUNT "get_left_parts_count"

#define YAML_COMMAND_SET_DEBUG_PRINT "set_debug"

#define YAML_DEFAULT_CHAR_REPLACER ""

#define YAML_OUTPUT_PREFIX_EXCEPTION "$EX$:"
#define YAML_OUTPUT_SANITIZE_EXCEPTION(val) ((val) select [count YAML_OUTPUT_PREFIX_EXCEPTION,count (val)])
#define YAML_OUTPUT_PREFIX_PARTIAL "$PART$"