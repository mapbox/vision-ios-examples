#!/usr/bin/env bash
dev_input_file="scripts/dev-carthage-input.xcfilelist"

if [ -f "${dev_input_file}" ]; then
	export SCRIPT_INPUT_FILE_0="${dev_input_file}"
fi

source "scripts/list_to_files.sh"
