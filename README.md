# HealthTracker

HealthTracker is an iOS application built using UIKit that allows users to record and visualize health-related data such as steps, heart rate, sleep, blood pressure, and other custom metrics.

The app focuses on clean UI design, structured architecture, and clear data visualization.

---

## 📌 Architecture

This project follows the **MVC (Model-View-Controller)** pattern.

### 🔹 Model
- Represents health data structures.
- Stores and manages metric-related information.

### 🔹 View
- Built completely using **Programmatic UIKit** (no Storyboards).
- Custom UI components and chart views.
- Responsible only for layout and presentation.

### 🔹 Controller
- ViewControllers manage:
  - User interactions
  - Filtering logic
  - Chart updates
  - UI state handling

### ✅ Why MVC?

- Simple and effective for UIKit-based apps.
- Clear separation between UI and data.
- Easy to understand and maintain.

---

## 🧠 Design Decisions

- Used **Programmatic UI** for better layout control and reusability.
- Followed MVC for clear responsibility separation.
- Created reusable UI components.
- Avoided force unwrapping to improve safety.
- Structured filtering and chart logic clearly inside controllers.

---

## 📦 Libraries / Tools Used

- **DGCharts** – For health metric graph visualization.
- **DropDown** – For dropdown selection UI.
- **Toast-Swift** – For toast messages.
- **CocoaPods** – Dependency management.

---
