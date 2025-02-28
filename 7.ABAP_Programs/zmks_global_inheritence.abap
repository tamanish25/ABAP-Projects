*&---------------------------------------------------------------------*
*& Report  ZMKS_GLOBAL_INHERITENCE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMKS_GLOBAL_INHERITENCE.

Write: / ' Cycle class object ob'.
 data ob type ref to zmks_cycle.
 create object ob.

 call method ob->setcycle.
 call method ob->display.


 Write: / ' Bike class object ob'.
 data ob1 type ref to zmks_bike.
 create object ob1.
 call method ob1->setbike.
 call method ob1->display.