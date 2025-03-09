# Define the source directory, build directory, and the musixtex command
BASE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
SRC_DIR := $(BASE_DIR)
BUILD_DIR := $(BASE_DIR)/build
MUSIXTEX := musixtex
INCLUDE_PATHS := $(BASE_DIR)/musixbag:$(BASE_DIR)/musixtab

# Find all .tex files in the subdirectories
TEX_FILES := $(shell find "$(SRC_DIR)" -type f -name "*.tex" -not -path "$(BASE_DIR)/musixbag/*" -not -path "$(BASE_DIR)/musixtab/*")

# Define the corresponding .pdf files in the build directory
PDF_FILES := $(patsubst $(SRC_DIR)/%.tex,$(BUILD_DIR)/%.pdf,$(TEX_FILES))


# Default target
all: $(PDF_FILES)

# Build .pdf from .tex
$(BUILD_DIR)/%.pdf: $(SRC_DIR)/%.tex
	@mkdir -p "$(dir $@)"
	cd "$(dir $<)" && TEXINPUTS="$(INCLUDE_PATHS):" $(MUSIXTEX) "$(notdir $<)" && mv "$(basename $(notdir $<)).pdf" "$(abspath $@)"

# Clean all artifacts
clean:
	rm -rf "$(BUILD_DIR)"

# Print some help
help:
	@echo "Usage:"
	@echo "  all       -- build all TeX files with MusiXTeX"
	@echo "  clean     -- clean up the built files"
	@echo "  help      -- print this help"

.PHONY: all clean help
