WITH Ada.Numerics.Discrete_Random;

WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;

WITH Ada.Text_IO;
USE Ada.Text_IO;

PACKAGE P_Utils IS

   TYPE T_Partie IS TAGGED LIMITED PRIVATE;

   PROCEDURE Init_Partie(Partie : OUT T_Partie);

   PROCEDURE Miser(Partie : OUT T_Partie; Portefeuille : IN Natural);

   FUNCTION Get_Mise(Partie : IN T_Partie) RETURN Natural;

   PROCEDURE Lance_De(Partie : OUT T_Partie);

   PROCEDURE Calcul_De(Partie : OUT T_Partie; Portefeuille: IN OUT Natural);

-- Parti privee !
PRIVATE
   SUBTYPE T_Intervalle IS Integer RANGE 1..6;

   PACKAGE Aleatoire IS NEW Ada.Numerics.Discrete_Random(T_Intervalle);
   USE Aleatoire;

   TYPE T_Partie IS TAGGED LIMITED RECORD
      Hasard : Generator;
      De_1 : T_Intervalle;
      De_2 : T_Intervalle;
      Mise : Natural;
      Point : Boolean := False;
   END RECORD;

   FUNCTION Prend_La_Mise(Portefeuille : IN Natural) RETURN Natural
   WITH Post => Prend_La_Mise'Result <= Portefeuille;
END P_Utils;
