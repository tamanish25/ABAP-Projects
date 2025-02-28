*&---------------------------------------------------------------------*
*& Report  ZMKS_INTERFACES_CLASS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_INTERFACES_CLASS.

INTERFACE RECTANGLE.
  CONSTANTS : LENGTH TYPE I VALUE 10,
              BREADTH TYPE I VALUE 5.
  METHODS : AREA,
            PERIMETER.
ENDINTERFACE.

INTERFACE SQUARE.
  CONSTANTS SIDE TYPE I VALUE 10.
  METHODS : AREA,
            PERIMETER.
ENDINTERFACE.

CLASS LCL_IMPL DEFINITION.  "implementation class
  PUBLIC SECTION.
    INTERFACES : RECTANGLE,
                 SQUARE.
  PROTECTED SECTION.
    DATA RES TYPE I.
ENDCLASS.

CLASS LCL_IMPL IMPLEMENTATION.

  METHOD RECTANGLE~AREA.
    RES = RECTANGLE~LENGTH * RECTANGLE~BREADTH.
    WRITE :/ 'Area of rectangle is ',RES.
  ENDMETHOD.

  METHOD RECTANGLE~PERIMETER.
    RES = 2 * ( RECTANGLE~LENGTH * RECTANGLE~BREADTH ).
    WRITE :/ 'Perimeter of rectangle is ',RES.
  ENDMETHOD.

  METHOD SQUARE~AREA.
    RES = SQUARE~SIDE * SQUARE~SIDE.
    WRITE :/ 'Area of square is ',RES.
  ENDMETHOD.

  METHOD SQUARE~PERIMETER.
    RES = 4 * SQUARE~SIDE.
    WRITE :/ 'Perimeter of squareis ',RES.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA R TYPE REF TO RECTANGLE.
*create object r. "syntax error

  WRITE :/ 'Implementation class object ob...'.
  DATA OB TYPE REF TO LCL_IMPL.
  CREATE OBJECT OB.

  CALL METHOD : OB->RECTANGLE~AREA,
                OB->RECTANGLE~PERIMETER.

  ULINE.
  WRITE :/ 'Implementation class object ob --> assigned to interface rectangle reference r.'.
  R = OB. "narrow casting
  CALL METHOD : R->AREA,
                R->PERIMETER.

  ULINE.
  DATA S TYPE REF TO SQUARE.
*create object s. "syntax error

  WRITE :/ 'Implementation class object ob...'.

  CALL METHOD : OB->SQUARE~AREA,
                OB->SQUARE~PERIMETER.

  ULINE.
  WRITE :/ 'Implementation class object ob --> assigned to interface square reference s.'.
  S = OB. "narrow casting
  CALL METHOD : S->AREA,
                S->PERIMETER.
