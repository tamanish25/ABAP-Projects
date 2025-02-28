class ZCLKS_FETCH_BOOKING definition
  public
  final
  create public .

public section.

  methods FETCH_BOOKING
    importing
      !I_TICKET_ID type ZDEKS_TICKET_ID
    exporting
      !E_BOOKING_DATA type ZKS_BOOKING_DATA
      !E_MESSAGE type STRING .
  methods SAVE_BOOKING
    importing
      !I_BOOKING_DATA type ZKS_BOOKING_DATA
    exporting
      !E_MESSAGE type STRING .
  methods DELETE_BOOKING
    importing
      !I_TICKET_ID type ZDEKS_TICKET_ID
    exporting
      !E_MESSAGE type STRING .
  methods UPDATE_BOOKING
    importing
      !I_TICKET_ID type ZDEKS_TICKET_ID
      !I_BOOKING_DATA type ZKS_BOOKING_DATA
    exporting
      !E_MESSAGE type STRING .
  methods GENERATE_REPORT
    exporting
      !E_TOTAL_BOOKINGS type I
      !E_TOTAL_REVENUE type ZDEKS_FARE .
protected section.
private section.
ENDCLASS.



CLASS ZCLKS_FETCH_BOOKING IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCLKS_FETCH_BOOKING->DELETE_BOOKING
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_TICKET_ID                    TYPE        ZDEKS_TICKET_ID
* | [<---] E_MESSAGE                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
 METHOD DELETE_BOOKING.

  " Check if TICKET_ID is provided
  IF I_TICKET_ID IS INITIAL.
    E_MESSAGE = 'Ticket ID is required for deletion.'.
    RETURN.
  ENDIF.

  " Attempt to delete the record
  DELETE FROM Zks_BOOKING_DATA
    WHERE TICKET_ID = I_TICKET_ID.

  " Check the result of the deletion
  IF sy-subrc = 0.
    E_MESSAGE = 'Booking deleted successfully.'.
  ELSE.
    E_MESSAGE = 'No booking found with the provided Ticket ID.'.
  ENDIF.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCLKS_FETCH_BOOKING->FETCH_BOOKING
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_TICKET_ID                    TYPE        ZDEKS_TICKET_ID
* | [<---] E_BOOKING_DATA                 TYPE        ZKS_BOOKING_DATA
* | [<---] E_MESSAGE                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
    METHOD FETCH_BOOKING.


  " Check if TICKET_ID is provided
  IF I_TICKET_ID IS INITIAL.
    E_MESSAGE = 'Please provide a valid Ticket ID.'.
    RETURN.
  ENDIF.

  " Fetch data from the table
  SELECT SINGLE *
    INTO E_BOOKING_DATA
    FROM Zks_BOOKING_DATA
    WHERE TICKET_ID = I_TICKET_ID.

  " Check if data exists
  IF sy-subrc = 0.
    E_MESSAGE = 'Booking fetched successfully.'.
  ELSE.
    CLEAR E_BOOKING_DATA.
    E_MESSAGE = 'No booking found for the provided Ticket ID.'.
  ENDIF.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCLKS_FETCH_BOOKING->GENERATE_REPORT
* +-------------------------------------------------------------------------------------------------+
* | [<---] E_TOTAL_BOOKINGS               TYPE        I
* | [<---] E_TOTAL_REVENUE                TYPE        ZDEKS_FARE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GENERATE_REPORT.

  " Declare local variables
  DATA: lv_total_bookings TYPE I VALUE 0,
        lv_total_revenue  TYPE ZDEks_FARE VALUE 0,
        ls_booking        TYPE Zks_BOOKING_DATA.

  " Loop through all records to calculate totals
  SELECT * FROM Zks_BOOKING_DATA INTO ls_booking.
    ADD 1 TO lv_total_bookings.
    lv_total_revenue = lv_total_revenue + ls_booking-TOTAL_AMOUNT.
  ENDSELECT.

  " Return the results
  E_TOTAL_BOOKINGS = lv_total_bookings.
  E_TOTAL_REVENUE = lv_total_revenue.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCLKS_FETCH_BOOKING->SAVE_BOOKING
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_BOOKING_DATA                 TYPE        ZKS_BOOKING_DATA
* | [<---] E_MESSAGE                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD SAVE_BOOKING.

  " Check if mandatory fields are provided
  IF I_BOOKING_DATA-TICKET_ID IS INITIAL OR
     I_BOOKING_DATA-CUSTOMER_NAME IS INITIAL OR
     I_BOOKING_DATA-FLIGHT_NO IS INITIAL OR
     I_BOOKING_DATA-DEPARTURE_DT IS INITIAL OR
     I_BOOKING_DATA-TOTAL_AMOUNT IS INITIAL.
    E_MESSAGE = 'Mandatory fields are missing!'.
    RETURN.
  ENDIF.

  " Insert data into the table
  TRY.
      INSERT INTO Zks_BOOKING_DATA
        VALUES I_BOOKING_DATA.

      " Success message
      E_MESSAGE = 'Booking saved successfully.'.

    CATCH CX_SY_OPEN_SQL_DB INTO DATA(lx_sql_error).
      " Error message
      E_MESSAGE = lx_sql_error->get_text( ).
  ENDTRY.

ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCLKS_FETCH_BOOKING->UPDATE_BOOKING
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_TICKET_ID                    TYPE        ZDEKS_TICKET_ID
* | [--->] I_BOOKING_DATA                 TYPE        ZKS_BOOKING_DATA
* | [<---] E_MESSAGE                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD UPDATE_BOOKING.

  " Declare a local work area
  DATA: ls_existing TYPE Zks_BOOKING_DATA.

  " Fetch the existing record based on TICKET_ID
  SELECT SINGLE *
    INTO ls_existing
    FROM Zks_BOOKING_DATA
    WHERE TICKET_ID = I_TICKET_ID.

  " Check if the record exists
  IF sy-subrc <> 0.
    E_MESSAGE = 'No booking found for the provided Ticket ID.'.
    RETURN.
  ENDIF.

  " Update fields only if they are provided
  IF NOT I_BOOKING_DATA-CUSTOMER_NAME IS INITIAL.
    ls_existing-CUSTOMER_NAME = I_BOOKING_DATA-CUSTOMER_NAME.
  ENDIF.

  IF NOT I_BOOKING_DATA-FLIGHT_NO IS INITIAL.
    ls_existing-FLIGHT_NO = I_BOOKING_DATA-FLIGHT_NO.
  ENDIF.

  IF NOT I_BOOKING_DATA-DEPARTURE_DT IS INITIAL.
    ls_existing-DEPARTURE_DT = I_BOOKING_DATA-DEPARTURE_DT.
  ENDIF.

  IF NOT I_BOOKING_DATA-TOTAL_AMOUNT IS INITIAL.
    ls_existing-TOTAL_AMOUNT = I_BOOKING_DATA-TOTAL_AMOUNT.
  ENDIF.

  IF NOT I_BOOKING_DATA-CURRENCY_CODE IS INITIAL.
    ls_existing-CURRENCY_CODE = I_BOOKING_DATA-CURRENCY_CODE.
  ENDIF.

  " Modify the table with the updated record
  MODIFY Zks_BOOKING_DATA FROM ls_existing.

  " Check the result of the modification
  IF sy-subrc = 0.
    E_MESSAGE = 'Booking updated successfully.'.
  ELSE.
    E_MESSAGE = 'Failed to update the booking.'.
  ENDIF.

ENDMETHOD.
ENDCLASS.