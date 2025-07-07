## **TP — Déployer 3 VMs avec Terraform sur GCP**

1. **Créer trois machines virtuelles** nommées `web-vm-1`, `web-vm-2`, `web-vm-3` dans le subnet `subnet-europe` (région `europe-west1`) à l’aide de Terraform et du provider Google. Ce subnet existe déjà. Il avait déjà été crée dans la phase d'avant.
2. **Configurer la clé SSH fournie** dans toutes les VMs pour pouvoir s’y connecter à distance.
3. **Installer automatiquement nginx** sur la première VM (`web-vm-1`) grâce à un script d’initialisation.
4. **Afficher en sortie (`output`) les adresses IP publiques** des trois VMs.
5. **Vérifier que la page d’accueil nginx s’affiche** sur l’adresse IP publique de la première VM.
6. **livrable** : main.tf, outputs.tf, provider.tf et variables.tf.