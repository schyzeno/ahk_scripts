Author:  Jody Holmes (Skwire)
Date:    2009-09-02
Contact: skwire@dcmembers.com
Forum:   http://www.donationcoder.com/Forums/bb/index.php?topic=19785.0

+ added
* changed
- deleted
! bug fixed

v1.0.3 - 2010-05-02
	+ Added ability to specify a custom cursor.  (Thanks, nudone)

v1.0.2 - 2009-09-27
    * Changed "mode" to "accel" for more consistency.  (Thanks, Kamel)

v1.0.1 - 2009-09-27
    + Added ability to set mouse speed.
    * Changed up the parameter syntax.  Please adjust any of your scripts
      accordingly.

v1.0.0 - 2009-09-03
    + Initial forum build.
    
; --------------------------------------------------------------------------
; Installation & use -------------------------------------------------------
; --------------------------------------------------------------------------

1) Unpack archive to a folder of your choice.

2) Run MouseAccelToggler.exe with one or both of the following parameters:

    accel=[on|off|toggle]  This will turn mouse acceleration on, off, or toggle its state.
    
    speed=[1-20]           This will set the mouse speed.
    
    cursor=[path to ani/cur file|Default] This allows you to set a custom mouse cursor.
                                          Pass "Default" to restore cursor.
    
    Example:  c:\path\to\MouseAccelToggler.exe accel=on speed=8
    Example:  c:\path\to\MouseAccelToggler.exe accel=off cursor="c:\path\to\cursor.cur"
    Example:  c:\path\to\MouseAccelToggler.exe accel=off cursor="Default"
    
    If you run the exe without any parameters, it will pop up a box showing
    your current speed setting.
    
; --------------------------------------------------------------------------
; Icon copyright -----------------------------------------------------------
; --------------------------------------------------------------------------

Program icon copyright Zeus Box (Kuswanto) @ http://www.zeusboxstudio.com/
License: GNU General Public License.  Commercial usage: Allowed
http://www.iconarchive.com/category/system/blankon-icons-by-zeusbox.html
