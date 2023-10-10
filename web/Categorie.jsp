<%@page import="ma.projet.services.CategorieService"%>
<%@page import="ma.projet.entities.Categorie"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Categorie Page</title>
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
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: grid;
            grid-template-columns: 1fr 1fr; /* Deux colonnes égales */
            gap: 20px;
                        margin-top: 90px;  //Ajoutez une marge supérieure de 20 pixels 

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
            color: #8B0000;
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
        Gestion des Catégories
    </header>
     <script>
            function validateForm() {
                var code = document.getElementsByName("code")[0].value;
                var libelle = document.getElementsByName("libelle")[0].value;
                var id = document.getElementsByName("id")[0].value;
                var valider = document.getElementsByName("valider")[0].value;

                // Vérifier si les champs Code et Libelle sont vides
                if (code.trim() === '' && libelle.trim() === '') {
                    alert("Les champs Code et Libelle ne peuvent pas être vides.");
                    return false; // Empêcher la soumission du formulaire
                }

                // Vérifier la valeur du bouton "valider"
                if (valider === "Modifier") {
                    // Si le bouton est "Modifier", rediriger avec l'ID
                    console.log(id);
                    window.location.href = "CategorieController?op=update&id=" + id + "&code=" + code + "&libelle=" + libelle;;
                    return false; // Empêcher la soumission du formulaire
                } else if (valider === "Ajouter") {
                    // Si le bouton est "Ajouter", permettre la soumission du formulaire
                    return true;
                }

                // Si aucune des conditions précédentes n'est satisfaite, par défaut, empêcher la soumission du formulaire
                return false;
            }

            function confirmDelete(id, libelle) {
                var confirmation = confirm("Etes-vous sûr de vouloir supprimer la catégorie " + libelle + " ?");
                if (confirmation) {
                    // User confirmed, redirect to the delete URL
                    window.location.href = "CategorieController?op=delete&id=" + id;
                }
            }
            function updateCategory(id, code, libelle) {
                // Pre-fill the code and libelle fields with the category data
                document.getElementsByName("code")[0].value = code;
                document.getElementsByName("libelle")[0].value = libelle;
                document.getElementsByName("id")[0].value = id;
                document.getElementsByName("valider")[0].value = "Modifier";
            }

        </script>

    <div class="container">
        <div class="left-column">
            <form action="CategorieController" onsubmit="return validateForm()" id="categorieForm">
                <h1>Ajouter une Catégorie</h1>
                <table>
                    <tr>
                        <td>Code:</td>
                        <td><input type="text" name="code" value="" /></td>
                        <td style="display: none;"><input type="text" name="id" value="" hidden/></td>
                    </tr>
                    <tr>
                        <td>Libelle:</td>
                        <td><input type="text" name="libelle" value="" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Ajouter" name="valider" class="button btn-blue" /></td>
                    </tr>
                </table>
            </form>
        </div>

        <div class="right-column">
            <h1>Liste des Catégories</h1>
            <table>
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Libelle</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        CategorieService cs = new CategorieService();
                        for (Categorie c : cs.findAll()) {
                    %>
                    <tr>
                        <td><%= c.getCode()%></td>
                        <td><%= c.getLibelle()%></td>
                        <td>
                            <button class="button" style="background-color: #B22222; color: #fff;" onclick="confirmDelete(<%=c.getId()%>, '<%=c.getLibelle()%>')">Supprimer</button>
                            <button class="button btn-green" onclick="updateCategory(<%=c.getId()%>, '<%=c.getCode()%>', '<%=c.getLibelle()%>')">Modifier</button>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>