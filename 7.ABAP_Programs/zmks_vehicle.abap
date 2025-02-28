class ZMKS_VEHICLE definition
  public
  create public .

public section.

  methods DISPLAY .
protected section.

  data WHEELS type I .
  data BRAKES type I .
private section.
ENDCLASS.



CLASS ZMKS_VEHICLE IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMKS_VEHICLE->DISPLAY
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method DISPLAY.
    write: / wheels, brakes.
  endmethod.
ENDCLASS.