# 📱 flutter_posts

## 📖 Project Description
This project is built with **Flutter** following **Clean Architecture** principles to ensure scalability, maintainability, and a clear separation of concerns.

## 🏗️ Key Features of the Architecture
- **Clean Architecture**
    - Divided into `domain`, `data`, and `presentation` layers.
    - Improves testability and keeps business logic independent from frameworks.

- **State Management**
    - **BLoC** → used for complex, event-driven flows.
    - **GetX** → used for lightweight state management and dependency injection.
    - Each state management implementation is organized in a **separate Git branch** for clarity and experimentation.

- **Data Handling**
    - **REST API integration** for remote data communication.
    - **Local Storage** for caching and offline support.
