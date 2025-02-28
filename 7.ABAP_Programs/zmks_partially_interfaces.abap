*&---------------------------------------------------------------------*
*& Report  ZMKS_PARTIALLY_INTERFACES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_PARTIALLY_INTERFACES.
INTERFACE INTF1.
  METHODS : M1,
            M2,
            M3.
ENDINTERFACE.

CLASS LCL_IMPL DEFINITION ABSTRACT.
  PUBLIC SECTION.
    INTERFACES INTF1 ABSTRACT METHODS M2 M3. "exclude method m2 m3
ENDCLASS.

CLASS LCL_IMPL IMPLEMENTATION.
  METHOD INTF1~M1.
    WRITE :/ 'Inside method m1...'.
  ENDMETHOD.
ENDCLASS.

CLASS LCL_IMPL2 DEFINITION INHERITING FROM LCL_IMPL.
  PUBLIC SECTION.
    METHODS : INTF1~M2 REDEFINITION,
              INTF1~M3 REDEFINITION.
ENDCLASS.

CLASS LCL_IMPL2 IMPLEMENTATION.

  METHOD INTF1~M2.
    WRITE :/ 'Inside method m2...'.
  ENDMETHOD.

  METHOD INTF1~M3.
    WRITE :/ 'Inside method m3...'.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA OB TYPE REF TO LCL_IMPL2.
  CREATE OBJECT OB.

  CALL METHOD : OB->INTF1~M1,
                OB->INTF1~M2,
                OB->INTF1~M3.