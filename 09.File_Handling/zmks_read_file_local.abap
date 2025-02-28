*&---------------------------------------------------------------------*
*& Report  ZMKS_READ_FILE_LOCAL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_READ_FILE_LOCAL.

TYPES: BEGIN OF lty_booking,
         ticket_id(10) TYPE N,
         customer_name(20) TYPE c,
         flight_number(10) TYPE N,

       END OF lty_booking.

DATA:
      lt_booking TYPE TABLE OF lty_booking,
      wa_booking TYPE lty_booking,
      lv_filename TYPE string.

PARAMETERS: p_file TYPE localfile.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

                 CALL FUNCTION 'F4_FILENAME'
                  EXPORTING
                    PROGRAM_NAME        = SYST-CPROG
                    DYNPRO_NUMBER       = SYST-DYNNR
                    FIELD_NAME          = ' '
                 IMPORTING
                    FILE_NAME           = p_file.
                           .

START-OF-SELECTION.
  " Check if file is provided
  IF p_file IS INITIAL.
    WRITE: 'Please provide the CSV file path.'.
    EXIT.
  ENDIF.
lv_filename = p_file.
  " Upload the CSV file
  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename = lv_filename
      filetype = 'ASC'
    TABLES
      data_tab = lt_booking
    EXCEPTIONS
      others = 1.
  IF sy-subrc <> 0.
    WRITE: 'Error uploading the file.'.
    EXIT.
  ENDIF.
  " Display the data
  LOOP AT lt_booking INTO wa_booking.
    WRITE: / wa_booking-ticket_id, wa_booking-customer_name,
             wa_booking-flight_number.
  ENDLOOP.