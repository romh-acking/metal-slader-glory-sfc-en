::Roms
set baseImage=roms\Metal Slader Glory - Director's Cut (Japan) (NP).sfc
set newImage=roms\Metal Slader Glory - Director's Cut (NEW).sfc

::Folders
set projectFolder=%cd%
set spiroFolder=%cd%\tools\spiro
set XkasFolder=%cd%\tools\xkas

del "%newImage%"

copy "%baseImage%" "%newImage%"

::Write script
"%SpiroFolder%\Spiro.exe" /ProjectDirectory "%projectFolder%" /Write

::Apply Patches
"%XkasFolder%\xkas.exe" -o "%newImage%" "asm\main.asm"
"%XkasFolder%\xkas.exe" -o "%newImage%" "asm\graphics.asm"
"%XkasFolder%\xkas.exe" -o "%newImage%" "asm\password.asm"
"%XkasFolder%\xkas.exe" -o "%newImage%" "asm\palette.asm"

"%newImage%"
@pause