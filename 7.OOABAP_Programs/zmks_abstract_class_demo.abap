*&---------------------------------------------------------------------*
*& Report  ZMKS_ABSTRACT_CLASS_DEMO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_ABSTRACT_CLASS_DEMO.

CLASS LCL_RESTAURANT DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: STORE,
             DISPLAY,
             PAYMENT ABSTRACT.
  PROTECTED SECTION.
    DATA: TABLENO TYPE I,
          STEWARD TYPE STRING.
ENDCLASS.

CLASS LCL_RESTAURANT IMPLEMENTATION.
  METHOD STORE.
    TABLENO = 3.
    STEWARD = 'ABC'.
  ENDMETHOD.

  METHOD DISPLAY.
    WRITE: / 'Table No:', TABLENO,
            / 'Steward:', STEWARD,/.
  ENDMETHOD.
ENDCLASS.

CLASS LCL_CHEQUE DEFINITION INHERITING FROM LCL_RESTAURANT.
  PUBLIC SECTION.
    METHODS: PAYMENT REDEFINITION,
             M1.
  PROTECTED SECTION.
    DATA: CQNO TYPE I,
          CQDATE TYPE D,
          CQAMT TYPE I.
ENDCLASS.

CLASS LCL_CHEQUE IMPLEMENTATION.
  METHOD PAYMENT.
    CQNO = 123.
    CQDATE = SY-DATUM.
    CQAMT = 455.
    WRITE: / 'Details of Cheque:',
           / 'Cheque No:', CQNO,
           / 'Cheque Date:', CQDATE,
           / 'Cheque Amount:', CQAMT,/.
  ENDMETHOD.

  METHOD M1.
    WRITE: / 'This is inside method M1 of LCL_CHEQUE class'.
  ENDMETHOD.
ENDCLASS.

  " Subclass: LCL_CREDITCARD
CLASS LCL_CREDITCARD DEFINITION INHERITING FROM LCL_CHEQUE.
  PUBLIC SECTION.
    METHODS: cheque_details.
  PROTECTED SECTION.
    DATA: CCNO TYPE STRING,
          CCEXPDATE TYPE STRING,
          CCAMOUNT TYPE I.
ENDCLASS.

CLASS LCL_CREDITCARD IMPLEMENTATION.
  METHOD cheque_details.
    CCNO = '1234-5678-9876-5432'.
    CCEXPDATE = '12/26'.
    CCAMOUNT = 1000.
    WRITE: / 'Details of Credit Card Payment:',
           / 'Credit Card No:', CCNO,
           / 'Expiry Date:', CCEXPDATE,
           / 'Amount:', CCAMOUNT,/.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: LO_CHEQUE TYPE REF TO LCL_CHEQUE,
        r type ref to lcl_restaurant.

  " Create the object of the LCL_CHEQUE class
  CREATE OBJECT LO_CHEQUE.

  " Call methods
  LO_CHEQUE->STORE( ).        " Call STORE method
  LO_CHEQUE->DISPLAY( ).      " Call DISPLAY method
  LO_CHEQUE->PAYMENT( ).      " Call PAYMENT method
  LO_CHEQUE->M1( ).           " Call M1 method




  DATA: LO_RESTAURANT TYPE REF TO LCL_RESTAURANT,
        LO_CREDITCARD TYPE REF TO LCL_CREDITCARD.

  " Create object of LCL_CREDITCARD
  CREATE OBJECT LO_CREDITCARD.

  " Narrow casting: Assign LCL_CREDITCARD object to LCL_RESTAURANT reference
  LO_RESTAURANT = LO_CREDITCARD.
    " Call abstract class methods using LCL_RESTAURANT reference
  WRITE: / 'This is cedit card object assingned to Abstracgt class ',/.
  LO_RESTAURANT->STORE( ).
  LO_RESTAURANT->DISPLAY( ).
  LO_RESTAURANT->PAYMENT( ).