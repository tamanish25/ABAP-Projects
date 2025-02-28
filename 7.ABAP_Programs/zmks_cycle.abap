class ZMKS_BIKE definition
  public
  inheriting from ZMKS_CYCLE
  final
  create public .

public section.

  methods SETBIKE .

  methods DISPLAY
    redefinition .
protected section.

  data GEARS type I .
private section.
ENDCLASS.



CLASS ZMKS_BIKE IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMKS_BIKE->DISPLAY
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method DISPLAY.
CALL METHOD SUPER->DISPLAY.
write :/ gears.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMKS_BIKE->SETBIKE
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method SETBIKE.
    wheels = 2.
    color = 'Blue'.
    brakes = 2.
    gears = 6.

  endmethod.
ENDCLASS.