[//]: <> (This readme is in the markdown format. Please preview in a markdown parser.)

# Metal Slader Glory SFC: English Translation

## About
This repository contains source code for patches and tools to compile an English translation of Metal Slader for the Super Famicom.

## Support the Creator
Apparently, a prequel to this game was intended to be released on the 64DD but was cancelled. If you want the series to continue, consider showing your appreciation for it to the game's creator, Yoshimiru. You can do this by buying some Metal Slader Glory merch from his store and giving him a follow on Twitter:

Store: [https://mc-berrys.booth.pm/](https://mc-berrys.booth.pm/)

Twitter: [https://twitter.com/yoshimiru_SS/](https://twitter.com/yoshimiru_SS/)

He sells books detailing the games' development, including the 64DD prequel. You can't find scans of these books anywhere online.

## Folders

* asm
	* Contains the asm files which are to be compiled with xkas
    * There's also asm patch files that are commented out in the Write.bat script.

* roms
	* Use this to store your roms
* script
	* Contains the dump script in `Script.json`. It contains the Japanese script and the English translation.
	* You can also store xlsx backups of the script here.
* tables
	* Contains table files
		* Files prefixed with "CHR" specify byte to character mapping.
		* Files prefixed with "Dictionary" specify dictionary mapping. A dictionary can be mapped to multiple character values.
		* Files prefixed with "SquishyText" do some find and replace functions
			* "SquishyText - New.tbl" replaces character patterns to be in one tile. For example, "ll" is converted to the character "[ll]".
			* "SquishyText - Original.tbl" merges the dakuten and handakuten diacritics into the Japanese characters to form a single character. The game is weird about diactrics. For one, the diactrics appear before the character they belong to. Also, dictionaries can contain diactrics that aren't associated with a character in the dictionary itself. This means we can't simply specify "が" in a table file, but apply the conversation after the script has been dumped.
		* Files with "Length" let you specify how wide, in pixels, characters are. This affects `spiro.exe`'s autolinebreaking logic. For a game without VWF, most characters should have a length of `8`. 
* tools
	* cyproAce
		* A script editor 
	* spiro
		* Script dumper and inserter
	* xkas
		* Applies the assembly patches

## Instructions
The tools are coded in C#. You'll have to mess with Wine if you want them to run in Linux. You'll also have to rewrite the bat files, which aren't complicated at all.

* If you want to dump the script for whatever reason (the Japanese and English script are already included in this repository), you can dump it by executing the bat file "Dump.bat" by double clicking it.
* To generate an NES rom file with the translation and patches included:
    * Apply the Expand.bps patch to a Japanese rom, rename the result to "Metal Slader Glory (Japan) (Trans).nes", and place it in the roms folder. (This should probably be handled by xkas...)
    * Execute the bat file "Write.bat" by double clicking it.

### Translation Notes
The development team is willing to provide guidance and assistance for other translation projects, however, we ask that you at least have basic technical skills, knowledge about romhacking (6502 assembly language knowledge, the capability to use a debugger, etc.), and the ability to ask intelligence questions.

If you desire to use this repository as a base for another translation in a language other than English, some work will have to be done.

* To add support for more characters:
	1. Add the characters to some table files: `CHR - New.tbl` and `CHR - Length.tbl`.
	1. The translation currently assumes the top and bottom graphics for a character are on top of each other. Some 6502 knowledge is required to change this limitation. The routine to adjust is called `Font8x16`. You'll want to create a table which maps a character value to the desired tiles in the PPU.
* You'll probably want to remove the asm code that disables the autolinebreaking on the top of the screen. This will let you have multiple lines for the top text for the final battle in stage 7. Having meaningful text all fit in one line for certain languages can be difficult.

You'll have to change the text on the following screens:
* Game Over
* Screen timing tweak
* Credits

The tilemaps are compressed. You'll either have to edit this by hand or create a compressor.

You'll want to create a script to verify if you accidently deleted or added control codes from your translation. The original Japanese and your translation are on the same node in the script json so it makes it a bit easier to programmatically compare. This translaton intentionally adds control codes. For example:
* Enkai's lines have a few added `(WAIT)` tags since he talks fast and uses complex vocabulary (because he's the stereptyical smart character)
	* You may wan to remove these and opt on slowing his text down. All character's text speed's are located in the namecard.
* Some control codes were added to the intro's green text to make it scroll.
* `(CODE 05)` is a control code for pauses. It was added or had it argument changed to adjust the timing of cutscenes.  

Don't remove the `(End quote)` control code. The end quote character is already invisible and there's a few adjustements that make this character as if it doesn't exist:
* The length table file has this character's length set to 0
* There's an asm code patch that disables autolinebreaking in the game's engine.

Removing the end quotes will mess with various character animations. Most apparent are the character's mouths never closing. Certain character animations won't play at times and in rare instances obvious onscreen graphical glitching will occur.

## Changelog
* 2025 September 1st, 1.1
    * One of the passwords incorrectly displayed as "Let's go to Colony 35" instead of "Let's go back to Colony 35".
	* Thanks to @solrocknroll for spotting this.
* 2025 March 10th, 1.0
    * Initial release

## Credits

### Main Team
See the Famicom version for the original's credits, as the credits there apply here too.

* FCandChill
    * Initial ASM work
    * Utilities
    * Localizer
    * Proofreader
    * Manual
* Her-saki
    * Advanced ASM work
    * Font
    * Initial translation
    * SNES translation
* TheMajinkZenki
    * SNES translation

### Beta Testers
* dogbrainludus (Ludus)
