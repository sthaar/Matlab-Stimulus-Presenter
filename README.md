# Matlab-Stimulus-Presenter
A matlab based modular stimulus presenter with DIO support. Psychtoolbox incl.
Status: Non-Working version.

Current development:
- Events

Planned features:
- Compatible file type list 
- File type association with datasets (only jpeg, bmp etc in images)
- Settings.m file functioning as a registery
- Lots of events

Known problems:
- Error thrown when dataset exists in DatasetEditor
- DatasetEditor: Dataset name not displayed
- DatasetEditor: Error when list is empty
- Error on missing folder Data & Experiments
- Remove Block editor gaat naar Value 1 ipv lenght -1
- ExperimentEditor: Long text warps
- Dataset not found line 44 (second event)


Various todos:
-Dataset dependencies

-Experiment repeats
-variable start delay
-start message
-block repeats
-variable inter trial delay

-experimentEditor: Rename block option

-Change event structure to cell (core engine)

- PLotter
	- TTLs plotten (dio events)
	- PLot events er door? EN hoe?
	- Per block function
	- PLotter button in BLock editor
	


- Screen flip (dont clear ipv clear)
- Save to CSV: APpend struct in block runner
- Add dio line in event struct (questionDialog)
- TTL plotter