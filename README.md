# Explore Github

A flutter application to search for github users and repositories.

<p float="left">
  <img src="https://github.com/FarhanNanoCoder/heartify/blob/main/e-g-1.jpg" width="200" />
  <img src="https://github.com/FarhanNanoCoder/heartify/blob/main/e-g-2.jpg" width="200" />
  <img src="https://github.com/FarhanNanoCoder/heartify/blob/main/e-g-3.jpg" width="200" />
  <img src="https://github.com/FarhanNanoCoder/heartify/blob/main/e-p-4.jpg" width="200" />
  <img src="https://github.com/FarhanNanoCoder/heartify/blob/main/e-p-5.jpg" width="200" />
  <img src="https://github.com/FarhanNanoCoder/heartify/blob/main/e-p-6.jpg" width="200" />
  <img src="https://github.com/FarhanNanoCoder/heartify/blob/main/e-p-7.jpg" width="200" />
</p>

Features:
1. Authetication : Firebase authentication (Email, Password based registration and login).
2. Dashboard: Three sections-(i) Users Section, (ii)Repositoires Section, (iii) Settings section.
-- Users Section:
    - Search users by username
    - Lazy loading
    - User details screen
    - Navigation to user specific repository screen
-- Repositories Section:
    - Search by repository name
    - Lazy loading
    - Repository details screen
    - Navigation to User Deatils screen
  
Design Pattern:
- Used MVC design pattern.
- Providers(COntroller) holds the satte of variables for specific models.
- Local Repository section for caching.
- Repository for holding api calls.
- .env.dev for loading Environment variables
