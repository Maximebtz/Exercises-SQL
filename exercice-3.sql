-- Donnez le résultat SQL des éléments suivants :
    -- a) Liste de tous les étudiants

        SELECT *
        FROM Etudiant e;
    
    -- b) Liste de tous les étudiants, classée par ordre alphabétique inverse

        SELECT e.nom, e.premon
        FROM Etudiant e
        ORDER BY e.nom DESC;
    
    -- c) Libellé et coefficient (exprimé en pourcentage) de chaque matière

    
    -- d) Nom et prénom de chaque étudiant

        SELECT e.nom, e.premon
        FROM Etudiant e;
    
    -- e) Nom et prénom des étudiants domiciliés à Lyon

        SELECT e.nom, e.premon, e.ville
        FROM Etudiant e
        WHERE e.ville = "lyon";
    
    -- f) Liste des notes supérieures ou égales à 10

        SELECT n.note
        FROM Notation n
        WHERE n.note >= 10;
    
    -- g) Liste des épreuves dont la date se situe entre le 1er janvier et le 30 juin 2014

        SELECT ep.id_epreuve, ep.datepreuve, ep.lieu
        FROM Epreuve ep
        WHERE ep.datepreuve BETWEEN '2004/01/01' AND '30/06/2014';

    -- h) Nom, prénom et ville des étudiants dont la ville contient la chaîne "ll" (LL)

        SELECT e.nom, e.premon, e.ville
        FROM Etudiant e
        WHERE e.ville LIKE 'LL%'
    
    -- i) Prénoms des étudiants de nom Dupont, Durand ou Martin


    
    -- j) Somme des coefficients de toutes les matières

        SELECT SUM(m.coef) as sommeCoef
        FROM Matiere m
    
    -- k) Nombre total d'épreuves

        SELECT SUM(e.id_epreuve) as NbPreuves
        FROM Epreuve e
    
    -- l) Nombre de notes indéterminées (NULL)

        SELECT n.note
        FROM Notation n
        WHERE n.note IS NULL
    
    -- m) Liste des épreuves (numéro, date et lieu) incluant le libellé de la matière

        SELECT e.id_epreuve, e.date, e.lieu
        FROM Epreuve e
        INNER JOIN Matiere m ON m.codemat  -- Probleme dans le cours ? Pas de cle code mat dans Epreuve
    
    -- n) Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue

        SELECT n.note
        FROM Notation n

    -- p) Nom et prénom des étudiants qui ont obtenu au moins une note égale à 20
    
        SELECT e.nom, e.premon
        FROM Etudiant e
        WHERE n.note = 20

    -- q) Moyennes des notes de chaque étudiant (indiquer le nom et le prénom)

      -- Utilisation d'une vue   
        CREATE VIEW Moyennes AS  
        SELECT e.nom, e.prenom, SUM(ev.note) / SUM(m.codemat) AS moyenne
        FROM etudiant e
        INNER JOIN evaluer ev ON e.etudiant_id = ev.etudiant_id
        INNER JOIN matiere m ON ev.codemat = m.codemat 
        GROUP BY e.etudiant_id, e.nom, e.prenom;

      -- * Indique que nous souhaitons retounrer toute les colonnes de 'Moyenne'  
        SELECT *
        FROM Moyennes;
    
    -- r) Moyennes des notes de chaque étudiant (indiquer le nom et le prénom), classées de la meilleure à la moins bonne
          
        CREATE VIEW Moyennes AS  
        SELECT e.nom, e.prenom, SUM(ev.note * m.coeffmat) / SUM(m.coeffmat) AS moyenne 
        FROM etudiant e
        INNER JOIN evaluer ev ON e.etudiant_id = ev.etudiant_id
        INNER JOIN matiere m ON ev.codemat = m.codemat  
        GROUP BY e.etudiant_id, e.nom, e.prenom;
  
        SELECT *
        FROM Moyennes;
    
    -- s) Moyennes des notes pour les matières (indiquer le libellé) comportant plus d'une épreuve
    
        CREATE VIEW MoyennesMatimatieres AS
        SELECT m.libellemat, SUM(EV.NOTE * M.COEFFMAT) / SUM(M.COEFFMAT) AS moyenne
        FROM etudiant e
        INNER JOIN evaluer ev ON e.etudiant_id = ev.etudiant_id
        INNER JOIN matiere m ON ev.codemat = m.codemat
        GROUP BY m.libellemat;

        SELECT *
        FROM MoyennesMatieres;

    -- t) Moyennes des notes obtenues aux épreuves (indiquer le numéro d'épreuve) où moins de 6 étudiants ont été notés
