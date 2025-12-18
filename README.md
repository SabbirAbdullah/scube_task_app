# Scube Task App

This is the **Flutter Developer Assessment Submission** for the Flutter Developer role at **Scube Technologies Ltd.**

The app is built based on the provided Figma design & prototype, implementing all required screens and UI elements.

---

## 📌 Features

✨ Screens implemented based on Figma design  
📱 Responsive UI for both Android & iOS  
🧠 Clean and structured code  
📂 Well organized project structure

---

## 📁 Project Structure
lib/
├── main.dart
├── core/
│ ├── constants/ # colors, strings, font sizes
│ ├── theme/ # helpers, extensions, util functions
│ └── services/ # services like navigation, storage, etc.
├── data
   ├── models/# data classes / response models
   ├──remote/  # api handle
   ├── repository/ # data/repo logic if needed
   
├── Presentation 
  ├──  viewmodels/ # view model classes (business logic)
├ ├── views/
│    ├── screens/ # screen files
│    └── widgets/ # reusable widgets
├── routes/ # app navigation/routes
└── resources/ # images, fonts, assets

