*&---------------------------------------------------------------------*
*& Report  ZMKS_DEMO_PLUS_MINUS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_DEMO_PLUS_MINUS.


DATA: LV_SUM  TYPE NUMC3,
      LV_DIFF TYPE NUMC3.

PARAMETERS: P_NUM1 TYPE NUMC2,
            P_NUM2 TYPE NUMC2.

* Call function module for addition

CALL FUNCTION 'ZMKS_ADD_NUMBERS'
  EXPORTING
    GV_NUM1  = P_NUM1
    GV_NUM2  = P_NUM2
  IMPORTING
    GV_SUM   = LV_SUM
  EXCEPTIONS
    NOT_ZERO = 1
    OTHERS   = 2.
IF SY-SUBRC <> 0.
* Implement suitable error handling here
  MESSAGE E000(ZMKS_MESSAGE).
ELSE.
  WRITE: / 'Addition Result:', LV_SUM.
ENDIF.



* Call function module for subtraction
CALL FUNCTION 'ZMKS_SUBTRACT_NUMBERS'
  EXPORTING
    GV_NUM1      = P_NUM1
    GV_NUM2      = P_NUM2
  IMPORTING
    GV_DIFF      = LV_DIFF
  EXCEPTIONS
    INPUT_NUMBER = 1
    OTHERS       = 2.
IF SY-SUBRC <> 0.
* Implement suitable error handling here
  MESSAGE E001(ZMKS_MESSAGE).
ELSE.
  WRITE: / 'Subtraction Result:', LV_DIFF.
ENDIF.