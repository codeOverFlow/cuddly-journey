WITH Ada.Numerics.Discrete_Random;

WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;

WITH Ada.Text_IO;
USE Ada.Text_IO;

WITH System.Assertions;

PACKAGE P_Utils IS
   pragma Assertion_Policy(Check);

   TYPE T_Partie IS TAGGED LIMITED PRIVATE;

   PROCEDURE Init_Partie(Partie : OUT T_Partie);

   FUNCTION Get_Mise(Partie : IN T_Partie) RETURN Natural;

   PROCEDURE Jouer(Partie : OUT T_Partie; Portefeuille : IN OUT Natural);

   PROCEDURE Miser(Partie : OUT T_Partie; Portefeuille : IN Natural);


-- Parti privee !
PRIVATE
   SUBTYPE T_Intervalle IS Integer RANGE 1..6;

   PACKAGE Aleatoire IS NEW Ada.Numerics.Discrete_Random(T_Intervalle);
   USE Aleatoire;

   TYPE T_Partie IS TAGGED LIMITED RECORD
      Hasard : Generator;
      Mise : Natural;
      Point : Natural;
   END RECORD;

   FUNCTION Prend_La_Mise(Portefeuille : IN Natural) RETURN Natural
   WITH Post => Prend_La_Mise'Result <= Portefeuille;

   PROCEDURE Lance_De(Hasard : IN OUT Generator; De_1 : OUT T_Intervalle; De_2 : OUT T_Intervalle);

   PROCEDURE Phase_2(Partie : IN OUT T_Partie; Portefeuille : IN OUT Natural);
END P_Utils;
