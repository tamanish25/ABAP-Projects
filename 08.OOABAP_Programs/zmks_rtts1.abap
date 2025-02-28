*&---------------------------------------------------------------------*
*& Report  ZMKS_RTTS1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_RTTS1.
PARAMETERS p1_table TYPE tabname. "Input parameter for the table name

DATA: o_typedescr   TYPE REF TO cl_abap_typedescr,  "Type descriptor object
      o_structdescr TYPE REF TO cl_abap_structdescr, "Structure descriptor object
      o_tabledescr  TYPE REF TO cl_abap_tabledescr.  "Table descriptor object

***************************************************************************
* Step 1: Get Type Description for the Given Table Name
***************************************************************************
CALL METHOD cl_abap_typedescr=>describe_by_name
  EXPORTING
    p_name      = p1_table
  RECEIVING
    p_descr_ref = o_typedescr
  EXCEPTIONS
    type_not_found = 1 "Handle error if the type is not found
    OTHERS         = 2.

IF sy-subrc = 1.
  " If the type is not found, show an error message and exit
  MESSAGE 'Type not found' TYPE 'I'.
  RETURN.
ELSEIF sy-subrc <> 0.
  " For any other unknown exceptions, show an error and exit
  MESSAGE 'Unknown exception occurred while describing the type' TYPE 'I'.
  RETURN.
ENDIF.

" If the type descriptor is successfully retrieved, proceed
IF o_typedescr IS BOUND.
  TRY.
      " Step 2: Attempt to cast the generic type descriptor to a structure descriptor
      o_structdescr ?= o_typedescr.
    CATCH cx_sy_move_cast_error.
      " If the type is not a structure, show an error message and exit
      MESSAGE 'The provided type is not a structure' TYPE 'I'.
      RETURN.
  ENDTRY.
ENDIF.

***************************************************************************
* Step 3: Create a Dynamic Table Descriptor if the Structure Descriptor is Valid
***************************************************************************
IF o_structdescr IS BOUND.
  " Use the structure descriptor to create a table descriptor
  CALL METHOD cl_abap_tabledescr=>create
    EXPORTING
      p_line_type = o_structdescr  "Line type is the structure descriptor
    RECEIVING
      p_result    = o_tabledescr.  "The table descriptor object
ENDIF.

***************************************************************************
* Step 4: Create Dynamic Work Area and Internal Table
***************************************************************************
DATA ref_wa   TYPE REF TO data.  "Reference for dynamic work area
DATA ref_itab TYPE REF TO data.  "Reference for dynamic internal table

" Create the dynamic work area and table using their respective descriptors
CREATE DATA ref_wa TYPE HANDLE o_structdescr.
CREATE DATA ref_itab TYPE HANDLE o_tabledescr.

" Assign the references to field symbols for further processing
FIELD-SYMBOLS <fwa> TYPE ANY.         "Field symbol for work area
FIELD-SYMBOLS <ftab> TYPE ANY TABLE.  "Field symbol for internal table

ASSIGN ref_wa->* TO <fwa>.  "Assign the dynamic work area
ASSIGN ref_itab->* TO <ftab>.  "Assign the dynamic internal table

***************************************************************************
* Step 5: Retrieve Data from the Provided Table
***************************************************************************
" Select all rows from the specified table dynamically into the dynamic table
SELECT * FROM (p1_table) INTO TABLE <ftab>.
IF sy-subrc = 0.
  " If data is retrieved successfully, proceed to display the data
  LOOP AT <ftab> INTO <fwa>.
    " Display each row of the dynamic table by iterating over its fields
    DATA(component_count) = o_structdescr->get_components( ). "Get structure components
    LOOP AT component_count INTO DATA(component).
      ASSIGN COMPONENT component-name OF STRUCTURE <fwa> TO FIELD-SYMBOL(<fs>).
      IF sy-subrc = 0.
        " Display the field name and its value dynamically
        WRITE: / component-name, ':', <fs>.
      ENDIF.
    ENDLOOP.
    NEW-LINE. "Start a new line for the next row
  ENDLOOP.
ELSE.
  " If no data is found or an error occurs, show a message
  MESSAGE 'No data found or the table does not exist' TYPE 'I'.
ENDIF.

***************************************************************************
* Program End: Summary of Key Steps
***************************************************************************
" 1. Input table name is provided via the parameter `p1_table`.
" 2. The program dynamically retrieves the type of the table and its structure.
" 3. A dynamic table is created based on the structure.
" 4. Data is fetched from the table and displayed dynamically.
" 5. If any error occurs, appropriate messages are shown to the user.