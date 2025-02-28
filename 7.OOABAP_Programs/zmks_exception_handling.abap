*&---------------------------------------------------------------------*
*& Report  ZMKS_EXCEPTION_HANDLING
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_EXCEPTION_HANDLING.



***************************************************************************
* Class Definition
***************************************************************************
CLASS lcl_abc DEFINITION.
  PUBLIC SECTION.
    " Method to perform division with exception handling
    METHODS m1
      IMPORTING i_x TYPE i
                i_y TYPE i
      EXPORTING e_z TYPE i.
ENDCLASS.

***************************************************************************
* Class Implementation
***************************************************************************
CLASS lcl_abc IMPLEMENTATION.
  METHOD m1.
    TRY.
        " Perform the division
        e_z = i_x / i_y.
      CATCH cx_sy_arithmetic_error INTO DATA(lv_error).
        " Handle division by zero or other arithmetic errors
        WRITE: / 'Arithmetic error occurred: ', lv_error->get_text( ).
        e_z = 0. " Assign default value to prevent unexpected behavior
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
START-OF-SELECTION.
***************************************************************************
* Main Program Logic
***************************************************************************
PARAMETERS: p1 TYPE i, " Input parameter for the numerator
            p2 TYPE i. " Input parameter for the denominator

DATA: ob TYPE REF TO lcl_abc, " Object reference for the class
      lv_result TYPE i.       " Variable to store the result

" Create the object of the class
CREATE OBJECT ob.

" Call the method with exception handling
CALL METHOD ob->m1
  EXPORTING
    i_x = p1
    i_y = p2
  IMPORTING
    e_z = lv_result.

" Display the result
WRITE: / 'Result:', lv_result.