<%@page import="ma.projet.entities.LigneCommandeProduit"%>
<%@page import="java.util.List"%>
<%@page import="ma.projet.services.ProduitService"%>
<%@page import="ma.projet.entities.Produit"%>
<%@page import="ma.projet.services.CommandeService"%>
<%@page import="ma.projet.services.CategorieService"%>
<%@page import="ma.projet.entities.Commande"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Commande Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>        

    <style>
        /* Style CSS avec deux colonnes */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
             
        }

        header {
            background-color: #1E90FF; /* Bleu clair */
            color: #fff;
            text-align: center;
            padding: 20px 0;
            font-size: 32px;
        }

        .container {
          
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: grid;
            grid-template-columns: 1fr 1fr; /* Deux colonnes égales */
            gap: 20px;
        }

        .left-column {
            padding: 20px;
            border-right: 1px solid #ccc; /* Séparation entre les colonnes */
        }

        .right-column {
            padding: 20px;
        }

        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Bouton Ajouter (bleu) */
        .btn-blue {
            background-color: #007bff; /* Bleu */
            color: #fff;
        }

        /* Bouton Modifier (vert) */
        .btn-green {
            background-color: #4CAF50; /* Vert */
            color: #fff;
        }

        /* Bouton Supprimer (rouge) */
        .btn-red {
            background-color: #FF0000; /* Rouge */
            color: #fff;
        }

        .button {
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            border-radius: 4px;
            transition: background-color 0.2s;
        }

        .button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <header>
        Gestion des Commandes
    </header>
    
     <script>
            function afficherPopup(id) {
                document.getElementsByName("id")[0].value = id;
                
                var popup = document.getElementById("listeProduitsPopup");
                popup.style.display = "block";
            }

            function fermerPopup() {
                var popup = document.getElementById("listeProduitsPopup");
                popup.style.display = "none";
            }

            function afficherProduitPopup(id) {
                document.getElementsByName("id")[0].value = id;
                $(document).ready(function () {
                    // Remplacez 7 par la valeur de votre choix
                    $.ajax({
                        type: "POST",
                        url: "CommandeController?op=afficherProduitsDeCommande&id=" + id,
                        data: {id: id},
                        success: function (response) {
                            $("#l").html(response)
                            // Le code ici sera exécuté lorsque la requête au serveur aura réuss
                        }
                    });
                });
                var popup = document.getElementById("listeProduitsPopupDeCommande");
                popup.style.display = "block";
            }

            function fermerProduitPopup() {
                var popup = document.getElementById("listeProduitsPopupDeCommande");
                popup.style.display = "none";
            }
            function validateForm() {
                var code = document.getElementsByName("code")[0].value;
                var date = document.getElementsByName("date")[0].value;
//                var client = document.getElementsByName("client")[0].value;
                var id = document.getElementsByName("id")[0].value;
                var valider = document.getElementsByName("valider")[0].value;

                // Vérifier si les champs Code et Libelle sont vides
                if (code.trim() === '') {
                    alert("Les champs ne peuvent pas être vides.");
                    return false; // Empêcher la soumission du formulaire
                }

                // Vérifier la valeur du bouton "valider"
                if (valider === "Modifier") {
                    // Si le bouton est "Modifier", rediriger avec l'ID
                    window.location.href = "CommandeController?op=update&id=" + id + "&code=" + code + "&date=" + date ;
                    ;
                    return false; // Empêcher la soumission du formulaire
                } else if (valider === "Ajouter") {
                    // Si le bouton est "Ajouter", permettre la soumission du formulaire
                    return true;
                }

                // Si aucune des conditions précédentes n'est satisfaite, par défaut, empêcher la soumission du formulaire
                return false;
            }

            function confirmDelete(id, code) {
                var confirmation = confirm("Etes-vous sûr de vouloir supprimer la commande " + code + " ?");
                if (confirmation) {
                    // User confirmed, redirect to the delete URL
                    window.location.href = "CommandeController?op=delete&id=" + id;
                }
            }
           function updateCommande(id, code, date) {
    document.getElementsByName("code")[0].value = code;
    document.getElementsByName("date")[0].value = date;
    document.getElementsByName("id")[0].value = id;
    document.getElementsByName("valider")[0].value = "Modifier"; // Ajoutez cette ligne
}


            function addProductToCommande(produit_id) {
                console.log("Fonction addProductToCommande appelée avec produit_id =", produit_id);
                var id = document.getElementsByName("id")[0].value;
                var quantite = document.getElementsByName("quantite")[0].value;
                window.location.href = "CommandeController?op=ajouterProduit&commande=" + id + "&produit=" + produit_id + "&quantite=" + quantite;
                alert("Produit ajouté avec succés");
            }
            function supprimerProduitDeCommande(produit, commande, quantite) {
                window.location.href = "CommandeController?op=supprimerProduit&commande=" + commande + "&produit=" + produit + "&quantite=" + quantite;
                alert("Produit supprimé de la commande avec succés");

            }

        </script>

    <div class="container">
        <div class="left-column">
            <form action="CommandeController" onsubmit="return validateForm()">
                <h1>Ajouter une Commande</h1>
                <table border="0">
                    <tr>
                        <td>Code:</td>
                        <td><input type="text" name="code" value="" /></td>
                    </tr>
                    <tr>
                        <td>Date:</td>
                        <td><input type="date" name="date" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="id" value="" hidden/></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Ajouter" name="valider" class="button btn-blue" /></td>
                        <td></td>
                    </tr>
                </table>
            </form>
        </div>

        <div class="right-column">
            <h1>Liste des Commandes</h1>
            <table>
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Date</th>
                       
                        <th>Supprimer</th>
                        <th>Modifier</th>
                         <th>Voir Produits</th>
                        <th>Ajouter Produit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        CommandeService cs = new CommandeService();
                        for (Commande c : cs.findAll()) {
                    %>
                    <tr>
                        <td><%= c.getCode()%></td>
                        <td><%= c.getDate()%></td>
                        <td><button type="button" onclick="confirmDelete(<%=c.getId()%>, '<%=c.getCode()%>')" class="button btn-red">Supprimer</button></td>
                        <td><button type="button" onclick="updateCommande(<%=c.getId()%>, '<%=c.getCode()%>', '<%=c.getDate()%>')" class="button btn-green">Modifier</button></td>
                        <td><button type="button" class="button btn-blue" onclick="afficherProduitPopup(<%=c.getId()%>)">Voir produits</button></td>
                        <td><button type="button" class="button btn-green" onclick="afficherPopup(<%=c.getId()%>)">Ajouter produit</button></td>
                        </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </div>
                 <div id="listeProduitsPopup" style="display: none;" class="container">
    <fieldset>
        <legend>Liste des produits</legend>
        <table border="0">
            <thead>
                <tr>
                    <th>Reference</th>
                    <th>Prix</th>
                    <th>Quantité(stocke)</th>
                    <th>Categorie</th>
                    <th>Quantité</th>
                    <th>Ajouter </th>
                </tr>
            </thead>
            <tbody>
                <%
                    ProduitService pps = new ProduitService();
                    for (Produit p : pps.findAll()) {
                %>
                <tr>
                    <td><%= p.getReference()%></td>
                    <td><%= p.getPrix()%></td>
                    <td><%= p.getqStock()%></td>
                    <td><%= p.getCategorie().getLibelle()%></td>
                    <td><input type="number" name="quantite" value="1" /></td>
                    <td><button type="button" class="button btn-blue" onclick="addProductToCommande(<%=p.getId()%>)">Ajouter</button></td>
                </tr>
                <%}%>
            </tbody>
        </table>
        <button onclick="fermerPopup()">Fermer</button>
    </fieldset>
</div>
<div id="listeProduitsPopupDeCommande" style="display: none;" class="container">
    <fieldset>
        <legend>Liste des produits</legend>
        <table border="0">
            <thead>
                <tr>
                    <th>Reference</th>
                    <th>Prix</th>
                    <th>Categorie</th>
                    <th>Quantité </th>
                    <th>supprimer </th>
                </tr>
            </thead>
            <tbody id="l">
            </tbody>
        </table>
        <button type="button" class="button btn-blue" onclick="fermerProduitPopup()">Fermer</button>
    </fieldset>
</div>


</body>
</html>