.PHONY: init setup clean help

# Default target
help:
	@echo "Day 2 Workshop Commands"
	@echo "======================="
	@echo "  make init    - Check dependencies and set up claude-scaffolding"
	@echo "  make setup   - Alias for init"
	@echo "  make clean   - Remove generated plugin directory"
	@echo "  make help    - Show this help"

# Initialize the workshop
init:
	@./init.sh

# Alias for init
setup: init

# Clean up
clean:
	@echo "Removing my-plugin directory..."
	@rm -rf my-plugin
	@echo "Done."
