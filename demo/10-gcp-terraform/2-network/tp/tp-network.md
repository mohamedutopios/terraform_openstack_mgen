## TP — Bastion SSH et Sous-réseaux GCP avec Terraform

Déployer un réseau GCP avec **3 sous-réseaux** et **3 VM** (une par sous-réseau) :

* **VM1 (bastion)** : seule VM avec IP publique, accessible en SSH uniquement depuis ton IP.
* **VM2 & VM3** : privées, accessibles uniquement depuis VM1 (pas d’IP publique).
* **Les 3 VM** doivent pouvoir se ping et se ssh mutuellement en interne.

---

### Consignes

1. **Définis les variables** dans `variables.tf` (projet, région, zone, IP, clé SSH).
2. **Renseigne tes valeurs** dans `terraform.tfvars` (project, my\_ip, ssh\_pub\_key\_path).
3. **Déploie le réseau principal**, les **3 sous-réseaux**, et les **3 VMs** (une par sous-réseau).
4. **Configure les firewalls** :

   * SSH (22) ouvert sur VM1 seulement depuis **ton IP**.
   * SSH et ICMP autorisés entre toutes les IPs privées du VPC.
5. **Utilise le tag "bastion"** pour VM1 pour la règle SSH.
6. **Configure l’accès SSH** via la clé publique indiquée.
7. **Affiche les IPs** : publique de VM1, privées de VM2 et VM3 avec des outputs Terraform.

---

### Validation

* **Connexion SSH** :
  Depuis ta machine, connecte-toi à VM1 (bastion) :

  ```bash
  ssh debian@<vm1_public_ip>
  ```

* **Depuis VM1** :
  Ping et SSH vers VM2 et VM3 :

  ```bash
  ping <vm2_private_ip>
  ping <vm3_private_ip>
  ssh debian@<vm2_private_ip>
  ssh debian@<vm3_private_ip>
  ```

* **SSH direct sur VM2/VM3 depuis Internet** doit être impossible.

---

**Livrables attendus** :

* Les fichiers Terraform propres (`main.tf`, `variables.tf`, `terraform.tfvars`, `outputs.tf`)
* Un test de connexion SSH via VM1 et ping interne


