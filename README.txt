Projet NovaTech — reprise du travail
Abdelah EL HARSAL, Ostrean BONNET, Firas BENMANSOUR
État au 20/11/2026

J’ai fait l’installation du labo et les manipulations de la phase 1.
Le rapport PDF répond à Q1–Q6. Le DOCX permet de reprendre le texte dans Word ou Google Docs.
Ce dossier est un dossier de travail pour nous trois, PAS le rendu final au prof.

DÉJÀ FAIT
- Kali : réseau NAT + hôte seul, outils demandés installés, Greenbone contrôlé OK, Nessus Essentials activé.
- srv-web : Debian 13, audit avec sudo, SSH, Apache, MariaDB, PHP et DVWA fonctionnels, Lynis installé.
- srv-legacy : Metasploitable 2, uniquement réseau hôte seul.
- Instantanés installation-base présents sur les trois VM. Celui de Kali précède Nessus : ne pas le restaurer pour reprendre notre état actuel.
- Nmap, Masscan, découverte réseau et six recherches Shodan réalisés. Résultats et captures joints.

À REPRENDRE
- Qualys : compte créé et mot de passe changé, mais la connexion boucle après Please wait. Agent NON installé. Ostrean/Firas : résoudre l’accès puis installer l’agent Debian AMD64 sur srv-web, activation VM, contrôler la remontée console (sujet étape 7).
- Phase 2 Q7–Q11 : Greenbone puis Nessus, chacun sur legacy, web et web-auth (SSH audit + sudo). Greenbone : exports CSV ; Nessus : captures ; Qualys : résultat srv-web. Comparer gravités/durées, écarts, authentification, faux positifs et paquets Debian.
- Phase 3 Q12–Q15 : Nikto, ZAP avec session DVWA Low, vérifications Burp Low/Medium et code ; justifier les exclusions. Ne pas lancer cette phase pendant les scans de phase 2.
- Phase 4 Q16–Q17 : Lynis avant/après une correction, capture HTTP et règle Suricata sid 1000002 en plus de celle fournie.
- Phase 5 Q18–Q20 : top 10, CVSS/EPSS/KEV/SSVC, vecteur SQLi et plan de correction sur 4 h.
- Compléter puis condenser le rapport : 15 pages MAXIMUM au total, synthèse DSI d’une page incluse. La version intermédiaire prend de la place pour faciliter la reprise : ne pas simplement lui ajouter toutes les phases.
- Rendu avant le 23/11/2026 à 16 h Paris : projet_DV_EL_HARSAL_BONNET_BENMANSOUR.zip, pièces demandées page 1 du sujet.

POINTS À NE PAS OUBLIER
- Masscan legacy : 30 ports mais pas de durée finale conservée (blocage après 100 %, arrêt manuel). Ne pas inventer cette durée. Si vous refaites une mesure, garder l’ancienne et dater la nouvelle.
- Masscan web : 146,13 s ; Nmap legacy : 151,62 s ; Nmap web : 15,86 s.
- Le journal n’est pas exhaustif : le scan Masscan web a été fait dans un autre terminal, sa sortie dédiée est conservée.
- Au début Kali était en -05:00, ensuite Europe/Paris ; Masscan affiche GMT. Tenir compte des fuseaux.
- Debian a été installé automatiquement avec un bureau et vboxuser, puis audit a été ajouté. Écart au serveur sans bureau prévu dans le sujet : à signaler, peut influencer les scans authentifiés. Ne pas présenter le poste comme une installation minimale.
- Le réseau Debian est géré par NetworkManager : profil labo lié à enp0s8, profil internet lié à enp0s3. Ne pas ajouter une configuration concurrente dans /etc/network/interfaces.
- Les bannières Nmap ne prouvent pas une vulnérabilité ; pas de système exact reconnu par -O.
- Le compte Qualys et Nessus sont partagés pour le groupe. Éviter plusieurs instances clonées simultanées utilisant les mêmes activations. Si réactivation Nessus nécessaire, utiliser le parcours officiel.
- Le fichier d’accès est transmis séparément en privé, jamais dans Git ou le rendu.

REPRENDRE APRÈS IMPORT DES VM
1. Lire GUIDE_GIT_VM.txt. Vérifier tous les réseaux avant démarrage, surtout legacy sans NAT/pont.
2. Démarrer les 3 VM. Kali 8 Go, web 2 Go, legacy 512 Mo ; un scanner à la fois.
3. Vérifier ip -br a sur Kali/web et ip addr sur legacy. Adresses connues : Kali .101, web .20 fixe, legacy .103 ; DHCP peut changer .101/.103.
4. Vérifier /etc/hosts dans Kali ; modifier les lignes si les adresses ont changé. Vérifier http://srv-web/DVWA/.
5. Copier ce dépôt dans ~/projet de Kali sans écraser les nouveaux travaux ; les trois ressources sont dans ressources/ et doivent aussi être dans ~/projet pour les commandes du sujet.
6. Dans Kali : cd ~/projet ; script -a journal.txt ; exit en fin de séance. Créer un nouvel instantané des trois VM avant chaque phase.
7. Greenbone : sudo gvm-start ; interface https://127.0.0.1:9392. Nessus : sudo systemctl start nessusd ; interface https://127.0.0.1:8834.
8. Tester le compte audit : ssh audit@srv-web puis sudo -v. Pour Nessus authentifié : SSH password + élévation sudo avec même mot de passe.

FICHIERS
rapport/ : PDF intermédiaire et DOCX modifiable.
nmap/ et masscan_*.txt : sorties brutes des scans.
captures/ : 17 preuves originales.
journal.txt : copie partagée avec mot de passe Greenbone masqué.
ressources/ : sujet PDF et fichiers originaux du prof.
scans/, web/, suricata/ : à remplir lors des prochaines phases.
outils/ : export des VM et nettoyage du journal Kali avant export.
