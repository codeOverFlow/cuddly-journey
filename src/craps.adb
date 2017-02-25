WITH Ada.Text_IO;
USE Ada.Text_IO;

WITH P_Utils;
USE P_Utils;


PROCEDURE Craps IS
   PorteFeuille : Natural := 20;
   Partie : T_Partie;
BEGIN
   Partie.Init_Partie;
   Put_Line("Bienvenue au craps ! vous avez un portefeuille de " & Natural'Image(PorteFeuille) & "$");

   WHILE PorteFeuille /= 0 LOOP
      Partie.miser(PorteFeuille);
      IF Partie.Get_Mise = 0 THEN
         EXIT;
      END IF;
      Partie.Jouer(PorteFeuille);
   END LOOP;

END Craps;
