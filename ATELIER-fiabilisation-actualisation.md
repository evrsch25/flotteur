# Atelier — Aller plus loin après l’étape 4

**Durée indicative : 1 h 30**

Vous avez terminé l’étape 4. Partez de votre application actuelle : ne recréez pas les états, le Repository ou le mécanisme de notification.

Votre objectif est de rendre l’actualisation de SensorHub plus robuste face aux erreurs et aux actions répétées de l’utilisateur.

---

## Suivi d’avancement

Cochez au fur et à mesure. Statut au moment de la livraison de cet atelier :

| # | Étape | Statut |
|---|---|---|
| 1 | Créer la branche `atelier/fiabilisation-actualisation` | [x] Fait |
| 2 | Gérer une nouvelle tentative (1er échec → retry → succès) | [x] Fait |
| 3 | Gérer les actualisations répétées (pas de superposition) | [x] Fait |
| 4 | Compteur d’appels dans le FakeRepository | [x] Fait |
| 5 | Afficher la dernière actualisation réussie | [x] Fait |
| 6 | Préparer la démonstration (UI + scénarios) | [x] Fait |
| Bonus | Signaler des données anciennes (> 10 s pour la démo) | [x] Fait |
| 7 | Commit + push GitHub | [~] Commit local OK — push GitHub à faire (pas de remote projet) |

---

## 1. Créer une nouvelle branche

Créez une branche dédiée depuis votre branche actuelle :

```bash
git switch -c atelier/fiabilisation-actualisation
```

Tout le travail doit être réalisé et poussé sur cette branche.

**Où on en est :** branche créée dans le dépôt du projet Flutter.

---

## 2. Gérer une nouvelle tentative

Faites évoluer votre simulation pour reproduire ce scénario :

1. le premier chargement échoue ;
2. l’application affiche l’erreur ;
3. l’utilisateur relance le chargement ;
4. la seconde tentative réussit et affiche les capteurs.

La même instance du ViewModel doit être conservée pendant tout le scénario.

**Où on en est :** `FakeSensorRepository.remainingFailures` (démarre à 1). Bouton **Réessayer** sur l’écran d’erreur. Même `DashboardViewModel` toute la session.

---

## 3. Gérer les actualisations répétées

Configurez une réponse lente de plusieurs secondes.

Pendant ce chargement, essayez de déclencher rapidement plusieurs actualisations depuis l’interface.

Adaptez l’application afin que :

- plusieurs chargements ne se superposent pas ;
- l’utilisateur comprenne qu’une actualisation est en cours ;
- une nouvelle actualisation reste possible lorsque la précédente est terminée.

Vous choisissez la solution. Soyez capables d’expliquer votre décision et l’endroit où vous avez placé cette logique.

**Où on en est :** garde `_isLoading` dans `DashboardViewModel.load()` — si un chargement est déjà en cours, les appels suivants sont ignorés. Bouton refresh désactivé + indicateur pendant le chargement. Délai Fake = 3 s.

**Décision :** la logique anti-chevauchement est dans le **ViewModel** (pas dans la View), car c’est lui qui orchestre le chargement.

---

## 4. Vérifier le nombre d’appels

Ajoutez au FakeRepository un compteur du nombre de chargements réellement exécutés.

Ce compteur doit vous permettre de démontrer que plusieurs actions rapides de l’utilisateur ne provoquent pas plusieurs chargements simultanés.

Le compteur sert uniquement à observer et vérifier le comportement de l’application.

**Où on en est :** `FakeSensorRepository.fetchCount`, affiché en bas du dashboard pour la démo.

---

## 5. Afficher la dernière actualisation réussie

Ajoutez au dashboard une indication de la dernière actualisation réussie.

Comportements attendus :

- avant le premier succès, afficher `Aucune actualisation réussie` ;
- après un succès, afficher l’heure de l’actualisation ;
- après une erreur, conserver l’heure du dernier succès ;
- une nouvelle réussite met à jour cette heure.

Une tentative en erreur ne doit donc pas être considérée comme une actualisation réussie.

Vous choisissez où conserver cette information et où préparer le texte destiné à l’interface.

**Où on en est :** `DateTime?` + libellé préparés dans le **ViewModel** (`lastSuccessfulRefreshLabel`). Affichés dans le résumé du dashboard.

---

## 6. Préparer la démonstration

Votre application doit permettre de montrer les scénarios suivants :

| Scénario | Résultat attendu |
|---|---|
| Premier chargement en erreur | L’erreur est visible et une nouvelle tentative est possible |
| Nouvelle tentative | Le chargement réussit avec la même instance du ViewModel |
| Réponse lente | L’utilisateur comprend qu’une opération est en cours |
| Actions répétées | Les chargements ne se superposent pas |
| Fin du chargement | Une nouvelle actualisation devient possible |
| Chargement réussi | L’heure de la dernière réussite est affichée |
| Erreur après un succès | L’heure du dernier succès est conservée |

Vous devez pouvoir expliquer le trajet complet d’une actualisation, depuis l’action de l’utilisateur jusqu’au nouvel état publié par le ViewModel.

**Où on en est :** bouton refresh, menu **Démo → Forcer la prochaine erreur**, compteur d’appels visible.

**Trajet d’une actualisation :**
`tap refresh` → `viewModel.load()` → (ignore si déjà `_isLoading`) → `notifyListeners` / éventuel `Loading` → `repository.fetchAll()` → `Content` ou `Failure` + `notifyListeners` → `ListenableBuilder` reconstruit l’UI.

---

## Bonus — Signaler des données anciennes

Pour aller plus loin, indiquez visuellement lorsque la dernière actualisation réussie date de plus de 30 secondes.

Pour faciliter la démonstration, vous pouvez temporairement réduire ce seuil à 10 secondes.

Une nouvelle actualisation réussie doit rendre les données fraîches à nouveau.

**Où on en est :** seuil = **10 secondes** (`DashboardViewModel.staleAfter`). Bandeau orange « Données anciennes » + timer qui notifie l’UI.

---

## 7. Pousser le travail sur GitHub

Vérifiez vos modifications, puis créez un commit :

```bash
git status
git add <fichiers-modifiés>
git commit -m "Fiabilise les actualisations de SensorHub"
git push -u origin atelier/fiabilisation-actualisation
```

**Où on en est :** dépôt Git initialisé dans `flutter_application_1`, branche `atelier/fiabilisation-actualisation`, commit `Fiabilise les actualisations de SensorHub`. Aucun remote GitHub projet n’était configuré : à pousser dès que tu as l’URL du repo (`git remote add origin …` puis `git push -u origin atelier/fiabilisation-actualisation`).
