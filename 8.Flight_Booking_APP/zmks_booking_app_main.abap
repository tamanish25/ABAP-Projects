*&---------------------------------------------------------------------*
*& Report  ZMKS_BOOKING_APP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_BOOKING_APP.

" Declare parameters for booking data
PARAMETERS: p_tid    TYPE ZDEks_TICKET_ID.
PARAMETERS: p_cname  TYPE ZDEks_CUST_NAME.
PARAMETERS: p_fno    TYPE ZDEks_FLIGHT_NO.
PARAMETERS: p_ddate  TYPE ZDEks_DATE.
PARAMETERS: p_amt    TYPE ZDEks_FARE.
PARAMETERS: p_curr   TYPE ZDEks_CURR.

" Add radio buttons for actions
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECTION-SCREEN BEGIN OF LINE.
  PARAMETERS: r_save TYPE c RADIOBUTTON GROUP grp1 DEFAULT 'X'.
  SELECTION-SCREEN COMMENT (15) text-002 FOR FIELD r_save. " Save Booking

  PARAMETERS: r_fetch TYPE c RADIOBUTTON GROUP grp1.
  SELECTION-SCREEN COMMENT (15) text-003 FOR FIELD r_fetch. " Fetch Booking

  PARAMETERS: r_delete TYPE c RADIOBUTTON GROUP grp1.
  SELECTION-SCREEN COMMENT (15) text-004 FOR FIELD r_delete. " Delete Booking

  PARAMETERS: r_update TYPE c RADIOBUTTON GROUP grp1.
  SELECTION-SCREEN COMMENT (15) text-005 FOR FIELD r_update. " Update Booking

  PARAMETERS: r_report TYPE c RADIOBUTTON GROUP grp1.
  SELECTION-SCREEN COMMENT (15) text-006 FOR FIELD r_report. " Generate Report

  PARAMETERS: r_print TYPE c RADIOBUTTON GROUP grp1.
  SELECTION-SCREEN COMMENT (15) text-007 FOR FIELD r_print. " Print All Records
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

" Local variables
DATA: lo_booking_manager TYPE REF TO ZCLks_FETCH_BOOKING,
      ls_booking_data    TYPE Zks_BOOKING_DATA, "Work AREA
      ls_booking         TYPE Zks_BOOKING_DATA,
      lv_message         TYPE string,
      lv_total_bookings  TYPE I,
      lv_total_revenue   TYPE ZDEks_FARE,
      lt_bookings        TYPE TABLE OF Zks_BOOKING_DATA."Internal table

START-OF-SELECTION.

" Create an instance of the class once
CREATE OBJECT lo_booking_manager.

" Handle actions based on selected radio button
IF r_save = 'X'.

  " Populate the booking structure with user input
  CLEAR ls_booking_data.
  ls_booking_data-TICKET_ID = p_tid.
  ls_booking_data-CUSTOMER_NAME = p_cname.
  ls_booking_data-FLIGHT_NO = p_fno.
  ls_booking_data-DEPARTURE_DT = p_ddate.
  ls_booking_data-TOTAL_AMOUNT = p_amt.
  ls_booking_data-CURRENCY_CODE = p_curr.

  " Call the SAVE_BOOKING method
  lo_booking_manager->SAVE_BOOKING(
    EXPORTING
      I_BOOKING_DATA = ls_booking_data
    IMPORTING
      E_MESSAGE = lv_message ).

  " Display the message
  WRITE: / lv_message.

ELSEIF r_fetch = 'X'.

  " Check if TICKET_ID is provided
  IF p_tid IS INITIAL.
    WRITE: / 'Please provide a valid Ticket ID.'.
    RETURN.
  ENDIF.

  " Call the FETCH_BOOKING method
  lo_booking_manager->FETCH_BOOKING(
    EXPORTING
      I_TICKET_ID = p_tid
    IMPORTING
      E_BOOKING_DATA = ls_booking
      E_MESSAGE = lv_message ).

  " Display the message
  WRITE: / lv_message.

  " Display booking details if available
  IF lv_message = 'Booking fetched successfully.'.
    WRITE: / 'Booking Details:',
           / 'Ticket ID: ', ls_booking-TICKET_ID,
           / 'Customer Name: ', ls_booking-CUSTOMER_NAME,
           / 'Flight Number: ', ls_booking-FLIGHT_NO,
           / 'Departure Date: ', ls_booking-DEPARTURE_DT,
           / 'Total Amount: ', ls_booking-TOTAL_AMOUNT,
           / 'Currency Code: ', ls_booking-CURRENCY_CODE.
  ENDIF.

ELSEIF r_delete = 'X'.

  " Check if TICKET_ID is provided
  IF p_tid IS INITIAL.
    WRITE: / 'Please provide a valid Ticket ID for deletion.'.
    RETURN.
  ENDIF.

  " Call the DELETE_BOOKING method
  lo_booking_manager->DELETE_BOOKING(
    EXPORTING
      I_TICKET_ID = p_tid
    IMPORTING
      E_MESSAGE = lv_message ).

  " Display the message
  WRITE: / lv_message.

ELSEIF r_update = 'X'.

  " Populate the booking structure with user input
  CLEAR ls_booking_data.
  ls_booking_data-CUSTOMER_NAME = p_cname.
  ls_booking_data-FLIGHT_NO = p_fno.
  ls_booking_data-DEPARTURE_DT = p_ddate.
  ls_booking_data-TOTAL_AMOUNT = p_amt.
  ls_booking_data-CURRENCY_CODE = p_curr.

  " Check if TICKET_ID is provided
  IF p_tid IS INITIAL.
    WRITE: / 'Please provide a valid Ticket ID for updating.'.
    RETURN.
  ENDIF.

  " Call the UPDATE_BOOKING method
  lo_booking_manager->UPDATE_BOOKING(
    EXPORTING
      I_TICKET_ID = p_tid
      I_BOOKING_DATA = ls_booking_data
    IMPORTING
      E_MESSAGE = lv_message ).

  " Display the message
  WRITE: / lv_message.

ELSEIF r_report = 'X'.

  " Call the GENERATE_REPORT method
  lo_booking_manager->GENERATE_REPORT(
    IMPORTING
      E_TOTAL_BOOKINGS = lv_total_bookings
      E_TOTAL_REVENUE = lv_total_revenue ).

  " Display the report
  WRITE: / 'Report:',
         / 'Total Bookings: ', lv_total_bookings,
         / 'Total Revenue: ', lv_total_revenue.

ELSEIF r_print = 'X'.

  " Fetch all records from the table
  SELECT *
    INTO TABLE lt_bookings
    FROM Zks_BOOKING_DATA.

  " Check if the table contains any records
  IF lt_bookings IS INITIAL.
    WRITE: / 'No records found in the table.'.
    RETURN.
  ENDIF.

  " Use ALV to display the records
  DATA: lo_alv TYPE REF TO cl_salv_table. " ALV object reference

  TRY.
      " Create ALV object using the factory method
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = lt_bookings ).

      " Display the ALV table
      lo_alv->display( ).

    CATCH cx_salv_msg INTO DATA(lx_msg).
      " Handle ALV errors
      WRITE: / 'Error displaying ALV: ', lx_msg->get_text( ).
  ENDTRY.


ENDIF.