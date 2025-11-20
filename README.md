# 📱 User Explorer – Flutter Task

This is the **User Explorer** Flutter application built as part of the assigned task.  
It displays a list of users fetched from an API, allows searching, supports pull-to-refresh,  
and shows cached data when the user is offline.

---

## 🚀 Setup Instructions

Follow these steps to run the project locally:

### 1️⃣ Clone the repository
git clone https://github.com/PrabhjotKaur-Developer/flutter_user_explorer_task.git

shell
Copy code

### 2️⃣ Navigate into the project folder
cd flutter_user_explorer_task

shell
Copy code

### 3️⃣ Install Flutter dependencies
flutter pub get

shell
Copy code

### 4️⃣ Run the application
flutter run

yaml
Copy code

---

## 🏗 Architecture Overview

The project follows a **clean, modular and scalable architecture**.

### 🔹 **Folder Structure**
/lib
/models → User model
/controllers → User controller, state logic (GetX)
/services → API calls, fetching users and user details
/screens → UI screens (User List, User Detail)
/widgets → Reusable UI components

yaml
Copy code

### 🔹 **State Management**
- **GetX** for reactive state management  
- Handles loading, success, error & offline states  

### 🔹 **Networking**
- Uses the `http` package for REST API calls  
- Includes proper error handling  

### 🔹 **Additional Functionality**
- **Search bar** to filter users  
- **Pull to refresh** on user list  
- **Offline support** → shows cached users when no internet  
- **Clean UI + responsive layout**  

---

## 📦 Features Implemented

✔ Fetch list of users from an API  
✔ Display user details  
✔ Search users in real-time  
✔ Pull-to-refresh  
✔ Offline caching  
✔ Error + loading state handling  
✔ Clean & maintainable folder structure  
✔ Lightweight and responsive UI  

---

## 📝 Commit Messages

The project includes **clean & meaningful commit messages**, such as:

initial commit: submit completed User Explorer task project

yaml
Copy code

---

## 👩‍💻 Developer

**Prabhjot Kaur**

---

# 🎉 Done!
