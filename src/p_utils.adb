PACKAGE BODY P_Utils IS

   -- initialise la partie (surtout le random chiant en fait)
   PROCEDURE Init_Partie(Partie : OUT T_Partie) IS
   BEGIN
      Reset(Partie.Hasard);
   END;

   -- Prend la mise
   PROCEDURE Miser(Partie : OUT T_Partie; Portefeuille : IN Natural) IS
   BEGIN
      <<TRY>>
      BEGIN
         Partie.Mise := Prend_La_Mise(PorteFeuille);
      EXCEPTION
         WHEN Constraint_Error =>
            Put_Line("tu peux pas miser plus que ce que tu as abruti !!!");
            GOTO TRY;
      END;
   END Miser;

   -- Getter sur la mise
   FUNCTION Get_Mise(Partie : IN T_Partie) RETURN Natural IS
   BEGIN
      RETURN Partie.Mise;
   END Get_Mise;

   -- Lance les Des
   PROCEDURE Lance_De(Partie : OUT T_Partie) IS
   BEGIN
      Partie.De_1 := Random(Partie.Hasard);
      Partie.De_2 := Random(Partie.Hasard);
   END Lance_De;

   -- calcul les Des
   PROCEDURE Calcul_De(Partie : OUT T_Partie; Portefeuille: IN OUT Natural) IS
   BEGIN
      Partie.De_1 := Random(Partie.Hasard);
      Partie.De_2 := Random(Partie.Hasard);
   END Calcul_De;

   -- Prend la mise
   FUNCTION Prend_La_Mise(Portefeuille: IN Natural) RETURN Natural IS
      Mise : Natural;
   BEGIN
      <<TRY>>
      BEGIN
         Put("Mise: ");
         Get(Mise); Skip_Line;
         RETURN Mise;
      EXCEPTION
         WHEN Constraint_Error =>
            Put_Line("La mise doit etre positive ou nulle !");
            GOTO TRY;
      END;
   END Prend_La_Mise;

END P_Utils;
