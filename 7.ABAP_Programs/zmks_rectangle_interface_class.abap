class ZMKS_RECTANGLE_INTERFACE_CLASS definition
  public
  final
  create public .

public section.

  interfaces ZMKS_RECTANGLE_INTERFACE .
protected section.

  data RESULT type I .
private section.
ENDCLASS.



CLASS ZMKS_RECTANGLE_INTERFACE_CLASS IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMKS_RECTANGLE_INTERFACE_CLASS->ZMKS_RECTANGLE_INTERFACE~AREA
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method ZMKS_RECTANGLE_INTERFACE~AREA.
    result = zmks_rectangle_interface~length * zmks_rectangle_interface~breadth.
    Write : / 'Area of rectangle is :' ,result.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZMKS_RECTANGLE_INTERFACE_CLASS->ZMKS_RECTANGLE_INTERFACE~PERIMETER
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method ZMKS_RECTANGLE_INTERFACE~PERIMETER.
    result = 2 * ( zmks_rectangle_interface~length + zmks_rectangle_interface~breadth ).
    Write : / 'Perimeter of rectangle is :' ,result.
  endmethod.
ENDCLASS.