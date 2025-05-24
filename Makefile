\
# Makefile for managing Nix Darwin configuration
 
# Variables
# FLAKE_TARGET = .#Svyatogors-MacBook-Pro

# Phony targets (targets that don't represent files)
.PHONY: build update switch clean all

# Default target
all: build

# Build the Darwin configuration
init:
	nix --extra-experimental-features 'nix-command flakes'  build ".#darwinConfigurations.Svyatogors-MacBook-Pro.system"

build:
	nh darwin build ".#"

# Update flake inputs
update:
	nix flake update

# Switch to the new configuration
switch:
	nh darwin switch ".#"

# Collect garbage (delete old generations)
clean:
	nix-collect-garbage -d

