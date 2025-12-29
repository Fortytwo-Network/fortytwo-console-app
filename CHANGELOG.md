# Changelog

## [v2025.12.30.0] - 2025-12-30
### Added
Added new featured models: 
- **Kimi-K2-Thinking**: Efficient Mixture of Experts reasoning; balanced accuracy, coherence, and efficiency across general and technical tasks.
*REPO = unsloth/Kimi-K2-Thinking-GGUF*<br />
*MODEL NAME = Q4_K_M/Kimi-K2-Thinking-Q4_K_M-000XX-of-00013.gguf*
- **MiniMax-M2.1**: Versatile generalist with standout coding, creative and complex reasoning skills.
*REPO = unsloth/GLM-4.7-GGUF*
*MODEL NAME = GLM-4.7-Q4_K_M-0000X-of-00005.gguf*
- **Rnj-1 8B**: Long-context reasoning abilities for science and technical questions; strong capabilities in code and maths.
*REPO = bartowski/EssentialAI_rnj-1-instruct-GGUF*
*MODEL NAME = EssentialAI_rnj-1-instruct-Q4_K_M.gguf*
- **Nanbeige4-3B-Thinking-2511**: Thoughtful step-by-step solver; excels at competition math, graduate science, and function calling.
*REPO = bartowski/Nanbeige_Nanbeige4-3B-Thinking-2511-GGUF*
*MODEL NAME = Nanbeige_Nanbeige4-3B-Thinking-2511-Q4_K_M.gguf*
### Changed
- **Kimi-K2-Thinking** added to #3 position.
- **MiniMax-M2.1** added to #4 position.
- Models in EXTREME TIER, HEAVY TIER, and LIGHT TIER get +2 in numeration (e.g. 3 -> 5) up to #20 **Rnj-1-8B**.
- **Rnj-1-8B** added to position #20 and all models after it have shifted by +1 in numeration, becoming +3 in total relatively to the past version order (e.g. 18 -> 21, 19 -> 22) up to #25 **Nanbeige4-3B-Thinking-2511**.
- **Nanbeige4-3B-Thinking-2511** added to position #25 and all models after it have shifted by +1 in numeration, becoming +4 in total relatively to the past version order (e.g. 22 -> 26, 23 -> 27).
### Fixed
- **Gemma-3 4B Q4** -> **Gemma-3 12B Q4**. The old name was incorrect and pointed to the 12B repository.

## [v2025.12.19.0] - 2025-12-19
### Changed
- (Windows) Resolved script execution warnings

## [v2025.11.20.0] - 2025-11-20
### Added
- Added new low memory model: VibeThinker 1.5B

## [v2025.11.13.0] - 2025-11-13
### Changed
- (Windows) Extend cleanup when updating the capsule

## [v2025.10.28.0] - 2025-10-28
### Added
- (Windows) SETTINGS symbol added instead of the illegal symbol that caused visualization issues.
- The old '[1]' option selection confirmation format has been changed to '1 :'.
- Settings now have a header when activated.
- Auto-Select mode now have a header when activated.
- The text "You chose" has been changed to the more abstract "Model selected" in the model selection option.
- Spacings between choosing an option and CLI feedback fixed.

## [v2025.10.17.0] - 2025-10-17
### Added
- Added new rust model Fortytwo-Network/Strand-Rust-Coder-14B-v1 instead of Tesslate/Tessa-Rust-T1-7B.

## [v2025.10.09.0] - 2025-10-09
### Added
- Added KV Cache setup.  
- Added support for local GGUF model.

## [v2025.10.08.0] - 2025-10-08
### Added
- Added connection validation.
