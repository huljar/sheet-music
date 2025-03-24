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
	@echo "  all     -- build all TeX files with MusiXTeX"
	@echo "  clean   -- clean up the built files"
	@echo "  docs    -- generate documentation pages"
	@echo "  help    -- print this help"

# Define helper variables for docs generation
DOCS_DIR := $(BASE_DIR)/docs
PAGES_DIR := $(DOCS_DIR)/content/pages
CATEGORY_PAGES := $(foreach directory, $(sort $(dir $(PDF_FILES))), $(patsubst $(BUILD_DIR)/%/,$(PAGES_DIR)/%.md,$(directory)))

# Helper function to capitalize the first letter of a string
capitalize = $(shell echo $(1) | sed 's/^[a-z]/\U&/')

# Generate docs for the compiled files
docs: $(CATEGORY_PAGES)
	cd "$(DOCS_DIR)" && make publish

# Build .md from all corresponding .pdf
$(PAGES_DIR)/%.md: $(BUILD_DIR)/%/*.pdf
	@echo "Generating $(notdir $@)"
	@echo "Title: $(call capitalize, $(basename $(notdir $@)))" > $@
	@echo "Author: Julian Harttung" >> $@
	@echo "" >> $@
	@echo "# $(call capitalize, $(basename $(notdir $@))) sheet music listing" >> $@
	@echo "" >> $@
	@echo "Here's a list of all the compiled PDFs for $(basename $(notdir $@)):" >> $@
	@echo "" >> $@
	@echo "$(patsubst $(BUILD_DIR)/%,%,$^)" | tr ' ' '\n' | sed 's/\([^ ]*\)/* [\1](..\/\1)/g' >> $@


.PHONY: all clean docs help
