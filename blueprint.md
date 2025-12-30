
# Blueprint: FIMA Mobile App

## Overview

This document outlines the architecture, features, and design of the FIMA mobile application. The app provides users with a secure way to log in and access a dashboard with various features.

## Implemented Features

### 1. Secure User Authentication
- **Login Screen**: A clean and intuitive login screen with fields for username and password.
- **API Integration**: The app securely communicates with the backend API for user authentication.
- **Authorization**: The app uses Basic Authentication with Base64 encoded credentials for secure API requests.
- **Error Handling**: The app provides clear error messages to the user in case of failed login attempts (e.g., "NIK atau password tidak sesuai").
- **Logging**: All API requests and responses are logged for debugging and monitoring purposes.

### 2. Centralized API Client
- **`ApiClient`**: A centralized client handles all API interactions, ensuring consistent logging and error handling.
- **`ApiException`**: A custom exception class is used to handle API-specific errors, extracting and displaying meaningful error messages from the API response.

## Current Task: Dashboard and Navigation

### Plan
1.  **Create Dashboard Page**: Design a `DashboardView` with a `Scaffold` that includes a `Drawer` for sidebar navigation and an `AppBar`.
2.  **Create Dashboard Controller**: Implement a `DashboardController` to manage the state of the dashboard, such as the currently selected page.
3.  **Create Dashboard Binding**: Create a `DashboardBinding` to connect the `DashboardController` with the `DashboardView`.
4.  **Define Routes**: Add a new route for the dashboard in the app's routing configuration.
5.  **Update Login Flow**: Modify the `LoginController` to navigate to the dashboard page upon successful login, clearing the navigation stack.
