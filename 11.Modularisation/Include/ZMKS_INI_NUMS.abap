*&---------------------------------------------------------------------*
*&  Include           ZMKS_DATADEC_ORDER
*&---------------------------------------------------------------------*
DATA: gv_num1 TYPE i,
      gv_num2 TYPE i.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.

START-OF-SELECTION.
  gv_num1 = p_num1.
  gv_num2 = p_num2.