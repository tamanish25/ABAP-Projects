FUNCTION ZMKS_SUBTRACT_NUMBERS.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(GV_NUM1) TYPE  NUMC2
*"     REFERENCE(GV_NUM2) TYPE  NUMC2
*"  EXPORTING
*"     REFERENCE(GV_DIFF) TYPE  NUMC3
*"  EXCEPTIONS
*"      INPUT_NUMBER
*"----------------------------------------------------------------------
  IF GV_NUM1 > GV_NUM2.
    RAISE INPUT_NUMBER.
  ELSE.
    GV_DIFF = GV_NUM1 - GV_NUM2.
  ENDIF.


ENDFUNCTION.