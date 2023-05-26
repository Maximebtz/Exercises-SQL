-- A partir du script SQL Gaulois fourni par votre formateur, écrivez et exécutez les 
-- requêtes SQL suivantes:


    -- 1. Nom des lieux qui finissent par 'um'.
            
        SELECT li.id_lieu, li.nom_lieu
        FROM lieu li
        WHERE li.nom_lieu LIKE '%um';
    
    -- 2. Nombre de personnages par lieu (trié par nombre de personnages décroissant).

        SELECT li.nom_lieu, COUNT(pe.id_personnage) AS NbPersonnage
        FROM personnage pe
        INNER JOIN lieu li ON pe.id_lieu = li.id_lieu
        GROUP BY pe.id_lieu
        ORDER BY NbPersonnage DESC;        
    
    -- 3. Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nomde personnage.

        SELECT pe.nom_personnage, sp.nom_specialite, pe.adresse_personnage, li.nom_lieu
        FROM personnage pe
        INNER JOIN specialite sp ON pe.id_specialite = sp.id_specialite
        INNER JOIN lieu li ON pe.id_lieu = li.id_lieu
        GROUP BY pe.nom_personnage, sp.nom_specialite, pe.adresse_personnage, li.nom_lieu
        ORDER BY li.nom_lieu ASC, pe.nom_personnage ASC;
    
    -- 4. Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant).
    
        SELECT sp.nom_specialite, COUNT(pe.id_personnage) AS NbPersonnage
        FROM specialite sp
        INNER JOIN personnage pe ON sp.id_specialite = pe.id_specialite
        GROUP BY sp.nom_specialite
        ORDER BY NbPersonnage DESC;
    
    -- 5. Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa).

        SELECT ba.nom_bataille, ba.date_bataille, li.nom_lieu
        FROM bataille ba
        INNER JOIN lieu li ON ba.id_lieu = li.id_lieu
        ORDER BY ba.date_bataille DESC;    
    
    -- 6. Nom des potions + coût de réalisation de la potion (trié par coût décroissant).
    
        SELECT po.nom_potion, SUM(ing.cout_ingredient * co.qte) AS PrixPotion
        FROM composer co
        INNER JOIN ingredient ing ON co.id_ingredient = ing.id_ingredient
        INNER JOIN potion po ON co.id_potion = po.id_potion
        GROUP BY po.nom_potion 
        ORDER BY PrixPotion DESC;

    -- 7. Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'.
    
        SELECT ing.nom_ingredient, ing.cout_ingredient, co.qte
        FROM composer co
        INNER JOIN ingredient ing ON co.id_ingredient = ing.id_ingredient
        INNER JOIN potion po ON co.id_potion = po.id_potion
        WHERE po.nom_potion = 'Santé';
    
    -- 8. Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du villagegaulois'.
    
        
    
    -- 9. Nom des personnages et leur quantité de potion bue (en les classant du plus grand buveur au plus petit).
    
    
    -- 10. Nom de la bataille où le nombre de casques pris a été le plus important.
    
    
    -- 11. Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)
    
    
    -- 12. Nom des potions dont un des ingrédients est le poisson frais.
    
    
    -- 13. Nom du / des lieu(x) possédant le plus d'habitants, en dehors du village gaulois.
    
    
    -- 14. Nom des personnages qui n'ont jamais bu aucune potion.
    
    
    -- 15. Nom du / des personnages qui n'ont pas le droit de boire de la potion 'Magique'.