## ❌ Erreur

```
Error 403: Compute Engine API has not been used in project ... or it is disabled.
```

---

## ✅ Solution étape par étape

### 🔗 Active l’API Compute Engine

1. Ouvre ce lien dans ton navigateur (il est fourni dans le message d'erreur) :

👉 [Activer Compute Engine API pour ton projet](https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=avid-phoenix-464816-f4)

2. Clique sur **"Activer"** (ou **"Enable"**).

3. Attends quelques secondes à 2 minutes que la propagation soit effective.

---

### 🧪 Ensuite

Retourne dans ton terminal et relance :

```bash
terraform apply -var="project_id=avid-phoenix-464816-f4"
```

---

### 📌 Astuce : activer automatiquement des APIs avec Terraform

Si tu veux automatiser cela dans ton code, ajoute ce bloc (à utiliser une seule fois par projet) :

```hcl
resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"

  disable_on_destroy = false
}
```

Tu peux le mettre **en haut de ton `main.tf`**, puis ajouter une dépendance comme ceci :

```hcl
resource "google_compute_network" "vpc" {
  depends_on = [google_project_service.compute]

  name                    = var.vpc_name
  auto_create_subnetworks = false
}
```

