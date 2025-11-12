#include "rwmake.ch"

User Function MT103IPC()


Local _aArea     := GetArea()
Local _nItem     := Paramixb[1]    // Numero do item do aCols

GDFieldPut( "D1_ZDESCR"   , SC7->C7_DESCRI    , _nItem ) //campo é virtual 
GDFieldPut( "D1_ZFINALI"   , SC7->C7_ZFINALI   , _nItem ) 

RestArea(_aArea)
Return(.T.)
