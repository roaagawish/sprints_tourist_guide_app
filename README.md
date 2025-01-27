# sprints_tourist_guide_app

A new Flutter project.

## Overview

This project is a mobile application designed for tourists visiting Egypt. The app helps users explore landmarks, museums, and attractions across various Egyptian governorates, providing a user-friendly interface and engaging features. Different states of the app are managed using Bloc State Management.

## Features

1. Authentication

   - Signup Page:

     Input fields: Full Name, Email, Password, Phone Number (optional).  
      A "Signup" button navigates to the Login Page.

   - Login Page:

     Input fields: Email and Password.
     Validatesccessful login.

2. Home Page

   Suggested Places to Visit:
   Displays a grid view of recommended places.
   Popular Places Section:
   Horizontally scrollable cards with:
   Image of the place.
   Name of the place.
   Governorate name.
   A toggleable favorite icon.

3. Governments Page

   A list of three Egyptian governorates.
   Selecting a governorate navigates to a details page showing two landmarks specific to that governorate.

4. Profile Page

   Displays user information:
    - Full Name.
    - Email.
    - Password (hashed for security).
    - Avatar.

   Enable the user to edit his information (Full Name - Phone)  and set avatar.
   Enable the user to toggle between Arabic and English.
   Enable the user to toggle between light and dark mode.

6. Favorites Page

   Displays static cards similar to the "Popular Places" section from the Home Page.

7. Navigation

   Bottom Navigation Bar visible on all main pages:
   Includes icons for Home, Governments, Favorites, and Profile.

8. Page Navigation Animations

   Smooth animations when transitioning between pages.

## Dependencies

1. fluttertoast: ^8.2.10
2. easy_localization: ^3.0.7
3. country_flags: ^3.2.0
4. provider: ^6.1.2
5. lottie: ^3.3.0
6. shared_preferences: ^2.3.5
7. cupertino_icons: ^1.0.8
8. animated_toggle_switch: ^0.8.4
9. flutter_bloc: ^9.0.0
10. bloc: ^9.0.0
11. meta: ^1.15.0
12. skeletonizer: ^1.4.3
13. cached_network_image: ^3.4.1
14. internet_connection_checker: ^3.0.1
15. shimmer: ^3.0.0
16. dio: ^5.7.0
17. image_picker: ^1.1.2

## 📸 Screens
 
 App 0.0.1

 <div style="display: flex; gap: 10px;">
    <img src="readme/vol1/login_1.jpg" alt="splash Screen" width="200">
    <img src="readme/vol1/login_2.jpg"alt="home" width="200">
    <img src="readme/vol1/home_1.jpg" alt="bottom sheet" width="200">
    <img src="readme/vol1/home_2.jpg" alt="bottom sheet" width="200">
 </div>

 <div style="display: flex; gap: 10px;">
    <img src="readme/vol1/home_3.jpg" alt="home" width="200">
    <img src="readme/vol1/home_4.jpg" alt="home" width="200">
    <img src="readme/vol1/home_5.jpg" alt="home" width="200">
    <img src="readme/vol1/home_6.jpg" alt="home" width="200">
 </div>

 <div style="display: flex; gap: 10px;">
    <img src="readme/vol1/home_7.jpg" alt="home" width="200">
    <img src="readme/vol1/home_8.jpg" alt="home" width="200">
    <img src="readme/vol1/home_9.jpg" alt="home" width="200">
    <img src="readme/vol1/home_10.jpg" alt="home" width="200">
 </div>


 
 App 0.0.2

    
   <div style="display: flex; gap: 10px;">
     <img src="readme/vol2/Login1.jpg" alt="login" width="150">
     <img src="readme/vol2/Login2.jpg" alt="login" width="150">
     <img src="readme/vol2/Login3.jpg" alt="login" width="150">
     <img src="readme/vol2/Signup1.jpg" alt="signup" width="150">
     <img src="readme/vol2/Signup2.jpg" alt="signup" width="150">
     <img src="readme/vol2/Signup3.jpg" alt="signup" width="150">
   </div>
   light mode
   <div style="display: flex; gap: 10px;">
     <img src="readme/vol2/HomeLight1.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeLight2.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeLight3.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeLight4.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeLight5.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeLight6.jpg" alt="home" width="150">
   </div>
   dark mode
   <div style="display: flex; gap: 10px;">
     <img src="readme/vol2/HomeDark1.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeDark2.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeDark3.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeDark4.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeDark5.jpg" alt="home" width="150">
     <img src="readme/vol2/HomeDark6.jpg" alt="home" width="150">
   </div>
   edit user info
   <div style="display: flex; gap: 10px;">
     <img src="readme/vol2/edit1.jpg" alt="edit" width="150">
     <img src="readme/vol2/edit2.jpg" alt="edit" width="150">
     <img src="readme/vol2/edit3.jpg" alt="edit" width="150">
     <img src="readme/vol2/edit4.jpg" alt="edit" width="150">
     <img src="readme/vol2/edit5.jpg" alt="edit" width="150">
     <img src="readme/vol2/edit6.jpg" alt="edit" width="150">
   </div>
   auth messages / loading
   <div style="display: flex; gap: 10px;">
     <img src="readme/vol2/loginload.jpg" alt="edit" width="150">
     <img src="readme/vol2/loginerr.jpg" alt="edit" width="150">
     <img src="readme/vol2/loginerr2.jpg" alt="edit" width="150">
     <img src="readme/vol2/signupload.jpg" alt="edit" width="150">
     <img src="readme/vol2/logoutload.jpg" alt="edit" width="150">
     <img src="readme/vol2/logout.jpg" alt="edit" width="150">
   </div>
