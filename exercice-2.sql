

-- Affichez les résultats suivants avec une solution SQL :

    -- a) Numéros et libellés des articles dont le stock est inférieur à 10 ?
        
        SELECT a.art_id, a.libelle, a.stock
        FROM article a
        WHERE a.stock < 10;
    
    -- b) Liste des articles dont le prix d'inventaire est compris entre 100 et 300 ?
    
        SELECT a.art_id, a.libelle, a.stock, a.prix_invent
        FROM article a
        WHERE a.prix_invent >= 100 AND a.prix_invent <= 300;
    
    -- c) Liste des fournisseurs dont on ne connaît pas l'adresse ?
    
        SELECT f.four_id, f.nom_four
        FROM fournisseur f
        WHERE f.adr_four IS NULL AND f.ville_four IS NULL;
    
    -- d) Liste des fournisseurs dont le nom commence par "STE" ?
    
    
    -- e) Noms et adresses des fournisseurs qui proposent des articles pour lesquels le délai d'approvisionnement est supérieur à 20 jours ?
    
    
    -- f) Nombre d'articles référencés ?
    
    
    -- g) Valeur du stock ?
    
    
    -- h) Numéros et libellés des articles triés dans l'ordre décroissant des stocks ?
    
    
    -- i) Liste pour chaque article (numéro et libellé) du prix d'achat maximum, minimum et moyen ?
    
    
    -- j) Délai moyen pour chaque fournisseur proposant au moins 2 articles ?
