PACKAGE BODY P_Utils IS

   -- initialise la partie (surtout le random chiant en fait)
   PROCEDURE Init_Partie(Partie : OUT T_Partie) IS
   BEGIN
      Reset(Partie.Hasard);
   END Init_Partie;

   -- Prend la mise
   PROCEDURE Miser(Partie : OUT T_Partie; Portefeuille : IN Natural) IS
   BEGIN
      <<TRY>>
      BEGIN
         Partie.Mise := Prend_La_Mise(PorteFeuille);
      EXCEPTION
         WHEN System.Assertions.Assert_Failure =>
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
   PROCEDURE Lance_De(Hasard : IN OUT Generator; De_1 : OUT T_Intervalle; De_2 : OUT T_Intervalle) IS
   BEGIN
      De_1 := Random(Hasard);
      De_2 := Random(Hasard);
   END Lance_De;

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

   -- joue joue
   PROCEDURE Jouer(Partie : OUT T_Partie; Portefeuille : IN OUT Natural) IS
      De_1 : T_Intervalle;
      De_2 : T_Intervalle;
   BEGIN
      Lance_De(Partie.Hasard, De_1, De_2);
      CASE De_1 + De_2 IS
         WHEN 7 | 11 =>
            Put_Line("gagne !");
            Portefeuille := Portefeuille + Partie.Mise;
         WHEN 2 | 3 | 12 =>
            Put_Line("Perdu !");
            Portefeuille := Portefeuille - Partie.Mise;
         WHEN OTHERS =>
            Partie.Point := De_1 + De_2;
            Partie.Phase_2(Portefeuille);
      END CASE;
      Put_Line("Il vous reste " & Natural'Image(Portefeuille) & "$");
   END Jouer;

   PROCEDURE Phase_2(Partie : IN OUT T_Partie; Portefeuille : IN OUT Natural) IS
      De_1 : T_Intervalle;
      De_2 : T_Intervalle;
   BEGIN
      WHILE Partie.Point > 0 LOOP
         Lance_De(Partie.Hasard, De_1, De_2);
         IF De_1+De_2 = 7 THEN
            Put_Line("Perdu !");
            Portefeuille := Portefeuille - Partie.Mise;
            Partie.Point := 0;
         ELSIF De_1+De_2 = Partie.Point THEN
            Put_Line("gagne !");
            Portefeuille := Portefeuille + Partie.Mise;
            Partie.Point := 0;
         END IF;
      END LOOP;
   END Phase_2;
END P_Utils;
