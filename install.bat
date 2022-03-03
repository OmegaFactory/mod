echo Initialisation du mod dépot
git init
echo Prise en compte des fichier déjà présent
git add .
echo Initialisation du dépot
git commit -m'initial'
echo Connexion au dépot principale
git remote add origin https://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@github.com/OmegaFactory/mod.git
echo Récupération du fichier du dépot
git pull origin main --allow-unrelated-histories