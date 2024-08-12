# Palindrome Project

This is a simple Flutter application that allows users to fetch a list of users from the `reqres.in` API, select a user, and display their details on another screen. The app is built using Flutter 3.22 and leverages the Provider package for state management.

## Features

- **State Management**: Implemented using the Provider package.
- **API Integration**: Fetches users from the `reqres.in` API with pagination.
- **User Selection**: Allows users to select a user from the list and view their details.
- **Pull-to-Refresh**: Refreshes the list of users.
- **Pagination**: Supports paginated API requests with next and previous buttons.

## Screens

### First Screen

- **Input Fields**: Two input fields for name and palindrome check.
- **Buttons**: A 'Check' button for palindrome validation and a 'Next' button to navigate to the second screen.

### Second Screen

- **Display**: Displays a welcome message, the entered name, and the selected user details (name, email, avatar).
- **Choose User Button**: Navigates to the third screen to select a user.

### Third Screen

- **User List**: Displays a list of users fetched from the API.
- **Pagination**: Supports pagination with next and previous buttons.
- **User Selection**: Allows users to select a user and return to the second screen with the selected user's details.

## State Management

This application uses the `Provider` package for state management. The `UserProvider` class is used to manage the state of the user list and pagination.

## Getting Started

### Prerequisites

- **Flutter**: Ensure that Flutter 3.22 or above is installed on your machine.

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/flutter-user-selection-app.git
   cd flutter-user-selection-app

2. **Install Dependencies:**:
   ```bash
   flutter pub get

3. **Run the Application:**:
   ```bash
   flutter run

### Dependencies

- **Flutter**: Displays a list of users fetched from the API.
- **Provider**: ^6.1.2 (for state management).
- **HTTP**: ^0.13.5 (for API calls)