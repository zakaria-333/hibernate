<%-- 
    Document   : gestion
    Created on : 10 oct. 2023, 01:25:50
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestion Page</title>
    <style>
        /* Reset some default styles */
        body {
    font-family: 'Arial', sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
    overflow-x: hidden; /* Ajoutez cette ligne */
}



        /* Sidebar styles */
/* Sidebar styles */

/* Sidebar styles */
#sidebar {
    width: 100%;
    background-color: #0056b3;
    color: white;
    position: absolute;
    top: 0;
    display: flex;
    justify-content: space-evenly; /* Espacement égal entre les éléments */
    align-items: center; /* Centrez verticalement les éléments */
    padding: 3px 8px; /* Ajoutez un peu de marge intérieure */
}

.menu-item a {
    text-decoration: none;
    color: white;
    padding: 10px 20px; /* Ajustez la largeur des liens */
}

/* ... */


.menu-item {
    /* Supprimez la marge droite pour un espacement égal */
}



.menu-item a:hover {
    background-color: #007bff;
}

        /* Content styles */
        #content {
            margin-left: 250px; /* Adjust for the sidebar width */
            padding: 20px;
            height: 100vh;
            background-color: #ccc; /* Add a background color for content */
        }

        /* Add your CSS styles for form elements and tables here */

        .hidden {
            display: none;
        }

        iframe {
            border: none;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <div id="sidebar">
        <h2 style="background-color: #0056b3; padding: 10px; text-align: center; margin-bottom: 20px; color: white;">Gestion App</h2>
        <div class="menu-item">
            <a href="Categorie.jsp" target="contentFrame">Gestion des Catégories</a>
        </div>
        <div class="menu-item">
            <a href="Commande.jsp" target="contentFrame">Gestion des Commandes</a>
        </div>
        <div class="menu-item">
            <a href="Produit.jsp" target="contentFrame">Gestion des Produits</a>
        </div>
    </div>

    <div id="content">
        <iframe id="contentFrame" name="contentFrame" src="Categorie.jsp"></iframe>
    </div>

    <script>
        // Add click event listeners to menu items
        document.querySelectorAll('.menu-item a').forEach(function (item) {
            item.addEventListener('click', function (e) {
                e.preventDefault();

                // Set the iframe source to the clicked menu item's href
                document.getElementById('contentFrame').src = item.getAttribute('href');

                // Scroll to the top of the content section
                document.getElementById('content').scrollTop = 0;
            });
        });
    </script>
</body>
</html>