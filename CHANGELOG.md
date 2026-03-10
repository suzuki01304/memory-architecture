# Changelog

All notable changes to this project will be documented in this file.

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
