## CredTrack
CredTrack is an application that demonstrates an end-to-end complaint/ticket tracking workflow for a fintech context. 
It supports email/password and Google authentication, email verification, a user dashboard to create and manage tickets with optional attachments, an in app chat system, and a lightweight admin side to view and update ticket statuses. 
The app is designed for an offline first experience using a local SQLite database, while Firebase is used for authentication and basic user profile storage

## App ScreenShots
<details>
<summary> Click Here</summary>

<table> 
<tr> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_025214.png" width="300"/> </th>
<th> <img src="assets/app_screenshots/Screenshot_20251101_025252.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_025303.png" width="300"/> </th>
<th> <img src="assets/app_screenshots/Screenshot_20251101_025320.png" width="300"/> </th>
</tr>

<tr>
<th>Launcher Icon</th>
<th>Splash Screen</th>
<th>Login Screen</th>
<th>Signup Screen</th>
</tr>


<tr> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_025722.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_030020.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_030052.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_030125.png" width="300"/> </th> 
</tr>

<tr>
<th>Email Verification</th>
<th>Email Verified</th>
<th>Homescreen(User)</th>
<th>FAQ Dialog</th>
</tr>

<tr> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_030154.png" width="300"/> </th>
<th> <img src="assets/app_screenshots/Screenshot_20251101_030502.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_030514.png" width="300"/> </th>  
<th> <img src="assets/app_screenshots/Screenshot_20251101_030532.png" width="300"/> </th>  
</tr>  

<tr>
<th>Create Ticket</th>
<th>Create Ticket</th>
<th>Homescreen(Updated)</th>
<th>Ticket Details</th>
</tr>

<tr> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_030547.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_030702.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_030728.png" width="300"/> </th>  
<th> <img src="assets/app_screenshots/Screenshot_20251101_030753.png" width="300"/> </th>  
</tr>

<tr>
<th>Edit Ticket Sheet</th>
<th>ChatScreen(User)</th>
<th>Profile Screen</th>
<th>Admin Login Dialog</th>
</tr>

<tr>
<th> <img src="assets/app_screenshots/Screenshot_20251101_030825.png" width="300"/> </th>
<th> <img src="assets/app_screenshots/Screenshot_20251101_031131.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_031401.png" width="300"/> </th>   
<th> <img src="assets/app_screenshots/Screenshot_20251101_031426.png" width="300"/> </th>   
</tr> 

<tr>
<th>Homescreen(Admin)</th>
<th>Ticket Details(Admin)</th>
<th>ChatScreen(Admin)</th>
<th>Ticket Status</th>
</tr>

<tr> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_031457.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_031528.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_031804.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_031816.png" width="300"/> </th> 
</tr> 

<tr>
<th>Updated Homescreen(Admin)</th>
<th>Updated Homescreen(Admin)</th>
<th>ChatScreen(Admin)</th>
<th>HomeScreen(User)</th>
</tr>

<tr> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_031834.png" width="300"/> </th> 
<th> <img src="assets/app_screenshots/Screenshot_20251101_031849.png" width="300"/> </th>
</tr> 

<tr>
<th>Deleting Ticket</th>
<th>Updated Homescreen(User)</th>
</tr>

</table>
</details>


## Features
- **Authentication**: Email/password sign up & login, Google sign-in, email verification flow.
- **Offline-first data**: Local persistence with SQLite (`sqflite`) for users, tickets, and ticket updates


## Tech stack
- **Flutter & Dart**
- **Material 3, responsive UI**
- **State management/DI/Navigation**: GetX
- **Auth & Backend**: Firebase Auth, Google Sign-In, Cloud Firestore user profiles
- **Local storage**: SQLite (`sqflite`), secure key/value storage (`flutter_secure_storage`)
- **Media and device**: `image_picker`, `path_provider`
- **Utilities**: `intl`, `uuid`, `connectivity_plus`


## Architecture overview
The app is structured around two primary layers: `core` and `features`
### **`core`**
  - **auth** — Authentication repository wrapping Firebase Auth + Google Sign-In (`AuthenticationRepo`)
  - **bindings** — GetX bindings for dependency setup at app start (`CredTrackBindings`)
  - **credtrack-theme** — Centralized Material 3 light/dark themes and typography utilities and others
  - **data** — Local database and models:
    - **local/app_database.dart** — SQLite DB initialization and schema (users, tickets, ticket_updates)
    - **local/dao/** — DAOs for `UserDao` and `TicketDao`
    - **models** —  `TicketModel`, `TicketUpdateModel`, `UserModel`
    - **repositories/user_repo.dart** — Firestore user profile operations
  - **utils** — network manager, snackbars, screen loader, validators, device storage, helpers, assets constants

### **`features`**
  - **splash** — Animated splash screen and controller, then navigation based on auth status
  - **authentication** — Login, Sign Up, Email Verification flows and controllers
  - **main**:
    - **dashboard** — Ticket list, FAQ scroller
    - **create** — Create ticket form, attachment preview
    - **details** — Ticket details, edit bottom sheet, chat-like updates view
    - **profile** — User profile and admin gateway.
    - **admin** — Admin dashboard, ticket details, status update.


### State management & Navigation
- GetX 
  - Controller's manage state and side effects
  - Dependencies are registered in `CredTrackBindings` and lazily injected where appropriate

### Data persistence
- Local database (SQLite via `sqflite`):
  - `users` (id, name, email, credPalId, image)
  - `tickets` (ticket_id, user_id, category, title, description, status, created_at, tx_ref, evidence_path)
  - `ticket_updates` (update_id, ticket_id, message, sender, timestamp)
- Device storage via `flutter_secure_storage` for simple key/value
- Firestore used to persist basic user profiles upon sign-up/Google sign-in.

### Usage guide
Admin login (demo only):
- **Admin ID**: 21110591134
- **Password**: Qwerty@1

