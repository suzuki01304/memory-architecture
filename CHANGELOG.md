# Changelog

All notable changes to this project will be documented in this file.

## [2.2.0] - 2026-03-10

### Added
- **Memory Health Metrics** inspired by dependency-auditor
  - Memory freshness (average update time)
  - Memory density (information/file size ratio)
  - Memory redundancy (duplicate content percentage)
  - Memory accessibility (query success rate)
- **Maintenance Scripts** inspired by dependency-auditor's audit system
  - `scripts/memory-health-check.sh` - Comprehensive health assessment
  - `scripts/memory-cleanup.sh` - Clean outdated and redundant memories
  - `scripts/memory-optimize.sh` - Optimize memory structure and performance
- **Best Practices Guide**
  - Memory write frequency recommendations
  - Memory classification standards
  - Memory archival strategies
  - Memory backup solutions
- **Troubleshooting Guide**
  - Memory query failures
  - Memory conflict resolution
  - Memory loss recovery
- **Use Case Scenarios**
  - Personal assistant scenarios
  - Team collaboration scenarios
  - Project management scenarios
  - Knowledge management scenarios

### Changed
- Enhanced memory architecture documentation with practical examples
- Improved maintenance workflow with health scoring system
- Added automated optimization and cleanup procedures

### Inspiration
This update was inspired by [dependency-auditor](https://clawhub.com/skills/dependency-auditor) and [git-secrets-scanner](https://clawhub.com/skills/git-secrets-scanner). We adapted their comprehensive metrics systems, automated maintenance workflows, and practical tooling approach to create a robust memory health management system.

## [2.1.0] - 2026-03-10

### Added
- Memory classification system inspired by memory-hygiene's vector database design
- Four-category classification: Preferences | Facts | Decisions | Lessons
- Clear exclusion rules for noise reduction (heartbeat status, transient info, raw logs, credentials)
- Storage guidelines: <100 words per entry, importance rating 0.7-1.0, one concept per record

### Changed
- Enhanced memory maintenance workflow with classification-based organization
- Improved memory structure for better searchability and reduced redundancy

### Inspiration
This update was inspired by the [memory-hygiene](https://github.com/xdylanbaker/memory-hygiene) skill's vector database classification system. While memory-hygiene is designed for LanceDB vector storage, we adapted its core principles to our file-based memory architecture, demonstrating how design patterns can be successfully transferred across different storage paradigms.

## [2.0.0] - 2026-03-10

### Changed
- Refactored to skill-creator spec v2.0.0
- Proper YAML frontmatter structure
- Organized scripts/ and references/ directories
- Complete anonymization of personal information

## [1.0.0] - Initial Release

### Added
- Initial memory architecture documentation
- Basic memory structure guidelines
