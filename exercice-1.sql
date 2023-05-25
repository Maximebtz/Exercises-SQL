-- ETUDIANT (N°ETUDIANT, NOM, PRENOM) 
-- MATIERE (CODEMAT, LIBELLEMAT, COEFFMAT) 
-- EVALUER (N°ETUDIANT*, CODEMAT*, DATE, NOTE)

-- Affichez les résultats suivants avec une solution SQL :

    -- a) Quel est le nombre total d'étudiants ?
        
        SELECT count(etudiant_id) as NbEtudiants
        FROM etudiant 


    -- b) Quelles sont, parmi l'ensemble des notes, la note la plus haute et la note la plus basse ?
        
        SELECT MIN(note), MAX(note)
        FROM evaluer


    -- c) Quelles sont les moyennes de chaque étudiant dans chacune des matières ? (utilisez CREATE VIEW)
      
      -- Utilisation d'une vue   
        CREATE VIEW Moyennes AS
      -- Selection des colonnes "nom" et "prenom" de la table "etudiant", la colonne "libellemat" de la table matiere utilisatien de SUM() et des notes + coef pour faire le caclcul de moyennes ainsi que "AS MOYENNE" pour donner un nom altérnatif à la colonne calculée  
        SELECT e.nom, e.prenom, m.libellemat, SUM(ev.note * m.coeffmat) / SUM(m.coeffmat) AS moyenne
      -- Tables à partir des quelles nous selectionnons les données  
        FROM etudiant e
      -- ON == jointure lors de combinaison de plusieur stables, = == cmparer les valeurs des colonnes correspondantes lors de la jointure  
        INNER JOIN evaluer ev ON e.etudiant_id = ev.etudiant_id
        INNER JOIN matiere m ON ev.codemat = m.codemat
      -- Groupement des colonnes pour obtenir une ligne  
        GROUP BY e.etudiant_id, e.nom, e.prenom, m.libellemat;

      -- * Indique que nous souhaitons retounrer toute les colonnes de 'Moyenne'  
        SELECT *
        FROM Moyennes;
    

    -- d) Quelles sont les moyennes par matière ? (cf. question c)
    
        CREATE VIEW MoyennesMatimatieres AS
        SELECT m.libellemat, SUM(EV.NOTE * M.COEFFMAT) / SUM(M.COEFFMAT) AS moyenne
        FROM etudiant e
        INNER JOIN evaluer ev ON e.etudiant_id = ev.etudiant_id
        INNER JOIN matiere m ON ev.codemat = m.codemat
        GROUP BY m.libellemat;

        SELECT *
        FROM MoyennesMatieres;

    
    -- e) Quelle est la moyenne générale de chaque étudiant ? (utilisez CREATE VIEW + cf. question 3)   

        CREATE VIEW MoyennesGeneralEtudiants AS
        SELECT e.nom, e.prenom, e.etudiant_id, SUM(EV.NOTE * M.COEFFMAT) / SUM(M.COEFFMAT) AS moyenne_generale
        FROM etudiant e
        INNER JOIN evaluer ev ON e.etudiant_id = ev.etudiant_id
        INNER JOIN matiere m ON ev.codemat = m.codemat
        GROUP BY e.etudiant_id, e.nom, e.prenom;

        SELECT *
        FROM MoyennesGeneralEtudiants;

   
    -- f) Quelle est la moyenne générale de la promotion ? (cf. question e)
    
        CREATE VIEW MoyennesGeneralEtudiants AS
        SELECT e.nom, e.prenom, e.etudiant_id, SUM(EV.NOTE * M.COEFFMAT) / SUM(M.COEFFMAT) AS moyenne_generale
        FROM etudiant e
        INNER JOIN evaluer ev ON e.etudiant_id = ev.etudiant_id
        INNER JOIN matiere m ON ev.codemat = m.codemat
        GROUP BY e.etudiant_id, e.nom, e.prenom;

        SELECT AVG(moyenne_generale) AS moyenne_generale_promotion
        FROM MoyennesGeneralEtudiants;
    

    -- g) Quels sont les étudiants qui ont une moyenne générale supérieure ou égale à la moyenne générale de la promotion ? (cf. question e)

        CREATE VIEW MoyennesGeneralEtudiants AS
        SELECT e.nom, e.prenom, e.etudiant_id, SUM(EV.NOTE * M.COEFFMAT) / SUM(M.COEFFMAT) AS moyenne_generale
        FROM etudiant e
        INNER JOIN evaluer ev ON e.etudiant_id = ev.etudiant_id
        INNER JOIN matiere m ON ev.codemat = m.codemat
        GROUP BY e.etudiant_id, e.nom, e.prenom;

        SELECT *
        FROM MoyenneGeneraleEtudiants
      -- Chercher où les moyennes sont sup ou egales et reprendre le SELECT avg(m_g) ainsi que le FROM M.G.E. utilisés haut dessus 
        WHERE moyenne_generale >= (
        SELECT AVG(moyenne_generale)
        FROM MoyenneGeneraleEtudiants
        );
