*&---------------------------------------------------------------------*
*& Report  ZMKS_GLOBAL_INTERFACE_REC
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_GLOBAL_INTERFACE_REC.

data r type ref to zmks_rectangle_interface.
Write : / ' Implementation class object ob'.

data ob type ref to zmks_rectangle_interface_class.
create object ob.

call method : ob->zmks_rectangle_interface~area,ob->zmks_rectangle_interface~perimeter.