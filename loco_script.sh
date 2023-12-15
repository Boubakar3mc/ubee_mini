#!/bin/bash

# Votre clé API Localizely
LOCALIZELY_API_KEY="b0dfb808d1e94c48b55a9619eee82aeb9da51b65edf248eaa2ee3a695fdcec6e"

# ID de votre projet Localizely
LOCALIZELY_PROJECT_ID="e4e382d4-9454-4f73-80a0-e1aed793d62c"

URL="https://api.localizely.com/v1/projects/$PROJECT_ID/files/download"

# Téléchargement des fichiers de langue
response=$(curl -s -w "%{http_code}" -X POST $URL -H "X-Api-Token: $API_KEY" -o "localization.zip")

# Vérifiez la réponse de l'API
if [ "${response}" -ne 200 ]; then
    echo "Erreur lors du téléchargement des fichiers de langue : ${response}"
    exit 1
fi

# Vérifiez si le fichier ZIP est vide
if [ ! -s "localization.zip" ]; then
    echo "Le fichier téléchargé est vide"
    exit 1
fi

# Décompression des fichiers
unzip localization.zip -d path/to/your/flutter/project/lib/l10n
