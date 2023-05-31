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
        GROUP BY pe.id_personnage
        ORDER BY li.nom_lieu ASC, pe.nom_personnage ASC;
    
    -- 4. Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant).
    
        SELECT sp.id_specialite, sp.nom_specialite, COUNT(pe.id_personnage) AS NbPersonnage
        FROM specialite sp
        INNER JOIN personnage pe ON sp.id_specialite = pe.id_specialite
        GROUP BY sp.id_specialite
        ORDER BY NbPersonnage DESC;
    
    -- 5. Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa).

        SELECT ba.nom_bataille, DATE_FORMAT(ba.date_bataille, "%d/%m/%Y"), li.nom_lieu
        FROM bataille ba
        INNER JOIN lieu li ON ba.id_lieu = li.id_lieu
        ORDER BY ba.date_bataille DESC;    
    
    -- 6. Nom des potions + coût de réalisation de la potion (trié par coût décroissant).
    
        SELECT po.nom_potion, SUM(ing.cout_ingredient * co.qte) AS PrixPotion
        FROM composer co
        INNER JOIN ingredient ing ON co.id_ingredient = ing.id_ingredient
        INNER JOIN potion po ON co.id_potion = po.id_potion
        GROUP BY po.id_potion 
        ORDER BY PrixPotion DESC;

    -- 7. Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'.
    
        SELECT ing.nom_ingredient, ing.cout_ingredient, co.qte
        FROM composer co
        INNER JOIN ingredient ing ON co.id_ingredient = ing.id_ingredient
        INNER JOIN potion po ON co.id_potion = po.id_potion
        WHERE po.nom_potion = 'Santé';
    
    -- 8. Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du villagegaulois'.
    
        SELECT pe.nom_personnage, MAX(pe_ca.qte) AS PlusDeCasquePris
        FROM prendre_casque pe_ca
        INNER JOIN personnage pe ON pe.id_personnage = pe_ca.id_personnage
        INNER JOIN bataille ba ON pe_ca.id_bataille = ba.id_bataille
        WHERE ba.nom_bataille = 'Bataille du village gaulois'
        GROUP BY pe.nom_personnage
        ORDER BY PlusDeCasquePris DESC;
    
    -- 9. Nom des personnages et leur quantité de potion bue (en les classant du plus grand buveur au plus petit).
    
        SELECT pe.nom_personnage, SUM(bo.dose_boire) AS sommeDose
        FROM boire bo
        INNER JOIN personnage pe ON bo.id_personnage = pe.id_personnage
		GROUP BY bo.id_personnage
		ORDER BY sommeDose DESC
    
    -- 10. Nom de la bataille où le nombre de casques pris a été le plus important.
        
        SELECT ba.nom_bataille 
        FROM prendre_casque pc
        INNER JOIN bataille ba ON pc.id_bataille = ba.id_bataille
        WHERE 
            pc.qte = (
                SELECT MAX(qte) 
                FROM prendre_casque
            );
    
    -- 11. Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)
    
        SELECT tc.nom_type_casque, COUNT(ca.id_casque) AS Count, SUM(ca.cout_casque) AS TotalCost
        FROM casque ca
        INNER JOIN type_casque tc ON ca.id_type_casque = tc.id_type_casque
        GROUP BY tc.id_type_casque
        ORDER BY Count DESC;
    
    -- 12. Nom des potions dont un des ingrédients est le poisson frais.

        SELECT po.nom_potion, ing.nom_ingredient
        FROM composer co
        INNER JOIN potion po ON co.id_potion = po.id_potion
        INNER JOIN ingredient ing ON co.id_ingredient = ing.id_ingredient
        WHERE ing.nom_ingredient = 'Poisson frais';
    
    -- 13. Nom du / des lieu(x) possédant le plus d'habitants, en dehors du village gaulois.
    
        SELECT l.nom_lieu, COUNT(pe.id_personnage) AS NombreVillageois
        FROM personnage pe
        INNER JOIN lieu l ON pe.id_lieu = l.id_lieu
        WHERE l.nom_lieu != 'Village gaulois'
        GROUP BY l.nom_lieu
        HAVING COUNT(pe.id_personnage) = (
            SELECT COUNT(pe2.id_personnage)
            FROM personnage pe2
            INNER JOIN lieu l2 ON pe2.id_lieu = l2.id_lieu
            WHERE l2.nom_lieu != 'Village gaulois'
            GROUP BY l2.nom_lieu
            ORDER BY COUNT(pe2.id_personnage) DESC
            LIMIT 1
        );
    
    -- 14. Nom des personnages qui n'ont jamais bu aucune potion.
    
        SELECT pe.nom_personnage
        FROM personnage pe
        LEFT JOIN  boire bo ON pe.id_personnage = bo.id_personnage
        WHERE bo.id_personnage IS NULL; -- or -> NOT IN boire;

    -- 15. Nom du / des personnages qui n'ont pas le droit de boire de la potion 'Magique'.

        SELECT p.nom_personnage
        FROM personnage p
        LEFT JOIN autoriser_boire ab ON p.id_personnage = ab.id_personnage
        WHERE ab.id_potion IS NULL;


-- En écrivant toujours des requêtes SQL, modifiez la base de données comme suit :
    
    -- A. Ajoutez le personnage suivant : Champdeblix, agriculteur résidant à la ferme Hantassion de Rotomagus.
    
        INSERT INTO personnage (nom_personnage, adresse_personnage,id_lieu, id_specialite)
        VALUE ('Chamdeblix', 'Ferme Hantassion',6 , 12);
    
    -- B. Autorisez Bonemine à boire de la potion magique, elle est jalouse d'Iélosubmarine...

        INSERT INTO autoriser_boire (id_potion, id_personnage)
        VALUE (1, 12);
    
    -- C. Supprimez les typcasques grecs qui n'ont jamais été pris lors d'une bataille.
    
        DELETE FROM type_casque
        WHERE id_type_casque IN (
            SELECT tc.id_type_casque
            FROM type_casque tc
            LEFT JOIN casque c ON tc.id_type_casque = c.id_type_casque
            WHERE c.id_casque IS NULL
        );

    -- D. Modifiez l'adresse de Zérozérosix : il a été mis en prison à Condate.
    
        UPDATE personnage pe 
        SET pe.adresse_personnage = 'Prison', pe.id_lieu = 9
        WHERE pe.nom_personnage = 'Zérozérosix';
    
    -- E. La potion 'Soupe' ne doit plus contenir de persil.

        DELETE FROM composer co
        WHERE co.id_potion = 9 AND co.id_ingredient = 19;
    
    -- F. Obélix s'est trompé : ce sont 42 casques Weisenau, et non Ostrogoths, qu'il a pris lors de la bataille 'Attaque de la banque postale'. Corrigez son erreur !

        UPDATE casque
        SET nom_casque = 'Weisenau'
        WHERE nom_casque = 'Ostrogoths' AND id_bataille = (
            SELECT id_bataille
            FROM bataille
            WHERE nom_bataille = 'Attaque de la banque postale'
        ) AND qte = 42;
