# HealthTracker

HealthTracker is an iOS application that allows users to record and visualize health-related data, such as
steps, heart rate, and other custom stats.

---

## 📌 Architecture

This project follows the **MVC (Model-View-Controller)** pattern:

- **Model**: Data structures — storing health entry data.
- **View**: Programmatical and UI components — screens and charts.
- **Controller**: View controllers handling UI logic & updating models.

MVC helps to separate UI logic from data logic, and is widely used in UIKit-based iOS apps.

---

## 🧠 Design Decisions

- **MVC pattern**
- **Programmatic / UIKit** for UI.
- Used CocoaPods for dependency management.
- Clean separation of view logic and data handling in controllers.

---

## 📦 Libraries / Tools Used

- **DGCharts** — for graph visualization.
- **Dropdown** — for selections.
- **Toast-Swift** — for toast messages.
- **CocoaPods** — for managing third-party libraries.
  ```bash
  pod install
