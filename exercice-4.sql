-- USINE (NumU, NomU, VilleU)
-- PRODUIT (NumP, NomP, Couleur, Poids)
-- FOURNISSEUR (NumF, NomF, Statut, VilleF)
-- LIVRAISON (NumP, NumU, NumF, Quantité)


    -- a) Ajouter un nouveau fournisseur avec les attributs de votre choix

      -- INSERT INTO ma_table ( Préciser ce qu'on veut ajouter )  
        INSERT INTO fournisseur (nom_fournisseur, statut_fournisseur, ville_fournisseur) 
      -- VALUES pour add les valeurs  
        VALUES ( 'Maxime', 'Entrepreneur', 'Colmar');
    
    -- b) Supprimer tous les produits de couleur noire et de numéros compris entre 100 et 1999

        DELETE FROM produit 
        WHERE couleur_produit = 'noire' OR (id_produit >= 100 AND id_produit <= 1999);
    
    -- c) Changer la ville du fournisseur 3 par Mulhouse

        UPDATE fournisseur
        SET ville_fournisseur = 'Mulbach-sur-Munster'
        WHERE id_fournisseur = 1;

        