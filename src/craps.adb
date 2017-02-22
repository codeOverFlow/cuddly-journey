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
   Partie.miser(PorteFeuille);

   WHILE Partie.Get_Mise /= 0 LOOP
      Partie.Lance_De;
      Partie.Calcul_De(PorteFeuille);
      Partie.Miser(PorteFeuille);
   END LOOP;

END Craps;
