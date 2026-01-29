# Module Refactoring Plan

## Overview
This document outlines a plan to standardize the folder structure across all modules in the Livinglands codebase to improve consistency, maintainability, and developer experience.

## Current State Analysis

### Module Complexity Levels
1. **Fully Developed**: Leveling, Metabolism, Claims
2. **Partially Developed**: Balancing
3. **Minimal Implementation**: Economy, Groups, Traders

### Current Structural Inconsistencies
- No standardized directory structure across modules
- Mixed package organization approaches
- Varying levels of separation of concerns
- Inconsistent naming conventions

## Proposed Standard Structure

```
src/main/java/com/livinglands/modules/{module-name}/
├── {ModuleName}Module.java          # Main module class
├── config/                          # Configuration classes
│   ├── {ModuleName}ModuleConfig.java # Module configuration
│   └── *Additional config classes*   
├── commands/                        # Command handlers
│   ├── *Command classes*
│   └── subcommands/                 # Subcommand classes if needed
├── data/                            # Data models and persistence
│   ├── *Data model classes*
│   └── persistence/                 # Persistence classes
├── systems/                         # ECS systems and core logic
│   ├── *System classes*
│   └── processors/                  # Data processors if needed
├── listeners/                       # Event listeners
│   ├── *Listener classes*
│   └── handlers/                    # Event handlers if needed
├── ui/                              # User interface components
│   ├── *UI component classes*
│   └── panels/                      # Panel/UI element classes
├── services/                        # Business logic services
│   ├── *Service classes*
│   └── managers/                    # Service managers
├── domain/                          # Domain-specific logic (unique to module)
│   ├── *Domain classes*
│   └── *Subdomain folders*
└── util/                            # Utility classes
    ├── *Utility classes*
    └── helpers/                     # Helper classes
```

## Migration Strategy

### Phase 1: Template Creation
1. Create template structure for new modules
2. Document standards and guidelines
3. Establish naming conventions

### Phase 2: New Module Implementation
1. All new modules follow standardized structure
2. Create documentation for module structure standards
3. Team training on new standards

### Phase 3: Legacy Module Refactoring
1. Refactor modules one at a time in order of complexity
2. Maintain backward compatibility during transition
3. Update imports and references systematically

## Per-Module Refactoring Approach

### Claims Module (Most Complex)
**Primary Focus Areas:**
- Move `ClaimDataPersistence.java` to `data/persistence/`
- Organize map-related classes under `services/map/`
- Separate command handlers into `commands/subcommands/`

### Leveling Module
**Primary Focus Areas:**
- Move profession-specific classes to `domain/profession/`
- Organize ability system under `services/ability/`
- Separate UI components into `ui/panels/`

### Metabolism Module
**Primary Focus Areas:**
- Organize buff/debuff systems under `services/`
- Separate consumable handling into `services/consumables/`
- Move data models to `data/`

### Balancing Module
**Primary Focus Areas:**
- Already mostly compliant with structure
- Consider moving config classes to separate files if needed

### Economy/Groups/Traders Modules
**Primary Focus Areas:**
- Implement basic structure when modules are expanded
- Follow template for consistency

## Implementation Guidelines

### Golden Rules
1. **Never break existing functionality** - All changes must maintain current behavior
2. **Minimal logical changes** - Only move files, don't alter business logic
3. **Update all references** - Every moved file must have corresponding import updates
4. **Test after each change** - Verify compilation succeeds after each move
5. **Document changes** - Keep track of what was moved where

### Safe Refactoring Process
1. **Analysis Phase**: Identify all references to target files
2. **Backup Phase**: Create backup of current state
3. **Move Phase**: Move files and update package declarations
4. **Update Phase**: Update all imports referencing moved files
5. **Verification Phase**: Compile and verify no errors
6. **Documentation Phase**: Record changes made

## Directory Structure Definitions

### config/
Contains all module configuration classes and JSON mapping objects.

### commands/
Contains all command handler classes and subcommands. Split complex commands into subcommands.

### data/
Contains data model classes representing the module's core entities. Persistence classes go in `data/persistence/`.

### systems/
Contains ECS system classes that operate on entities. Processing logic goes in `systems/processors/`.

### listeners/
Contains event listener classes that respond to game/server events.

### ui/
Contains all user interface related classes including UI elements and panels.

### services/
Contains business logic service classes organized by功能域.

### domain/
Contains domain-specific logic that's unique to the module's purpose.

### util/
Contains utility classes that don't fit in other categories.

## Risk Mitigation

### High-Risk Changes
- Moving core system files
- Updating widely-referenced imports
- Changing package structures

### Prevention Strategies
- Small incremental changes
- Thorough testing after each step
- Version control checkpoints
- Backup copies before major moves

## Success Metrics
1. All modules follow consistent directory structure
2. No compilation errors after refactoring
3. All existing functionality preserved
4. Improved code discoverability
5. Easier onboarding for new developers

## Timeline Estimate
- **Phase 1**: 1-2 days (template creation)
- **Phase 2**: Ongoing (new modules)
- **Phase 3**: 2-3 weeks (legacy refactoring)

This phased approach ensures minimal disruption while achieving long-term consistency goals.