\
# Makefile for managing Nix Darwin configuration

# Variables
FLAKE_TARGET = .#Svyatogors-MacBook-Pro

# Phony targets (targets that don't represent files)
.PHONY: build update switch gc all

# Default target
all: build

# Build the Darwin configuration
build:
	nix --extra-experimental-features 'nix-command flakes'  build ".#darwinConfigurations.Svyatogors-MacBook-Pro.system"

# Update flake inputs
update:
	nix flake update

# Switch to the new configuration
switch:
	./result/sw/bin/darwin-rebuild switch --flake ".#"

# Collect garbage (delete old generations)
gc:
	nix-collect-garbage -d

