# Weather Application

## Overview

This Flutter-based weather application delivers real-time weather data by interacting with a reliable weather API. The app provides up-to-date information such as temperature, weather conditions, humidity, and more, with a focus on performance, simplicity, and a user-centric design. The application has been optimized for responsiveness and ease of use, making it accessible for all types of users.

## Key Features

### 1. **Real-Time Weather Data**
   - The app fetches current weather information from a weather API by accessing the user’s location or by manually entering a location. The data includes temperature, humidity, wind speed, and weather conditions like rain, snow, or clear skies.

### 2. **Internet Connectivity Monitoring**
   - Implemented using the `connectivity_plus` package, the app continuously monitors internet connection status. It alerts the user in case of a lost connection and ensures a smooth experience by handling offline situations gracefully.

### 3. **Dark and Light Theme Support**
   - The application comes with both dark and light mode options, offering users the ability to switch between themes based on their preferences or system settings. The themes are managed using the Provider package, making theme switching seamless and maintaining the current state across the app.

### 4. **Responsive UI Design**
   - Special attention has been given to the user interface (UI) and user experience (UX). The layout adapts to different screen sizes, providing an engaging experience on both mobile and tablet devices. The design is intuitive, with clear visual cues and easy navigation to ensure that users can quickly access weather information.

### 5. **Location-Based Weather**
   - By utilizing device location services (with proper permissions), the app automatically detects the user's location and provides real-time weather data based on their current position.

### 6. **Error Handling**
   - The app is built with robust error handling for both API failures and connectivity issues. It ensures the user is informed in case of any issues like invalid location searches or weather data fetching failures.

### 7. **State Management**
   - Provider package is used for efficient state management, including controlling the theme, handling connectivity status, and managing the API data. This results in better performance and maintainability.

<!DOCTYPE html>
<html lang="en">
<body>
    <h1>weather App</h1>
    <div class="gallery">
        <img src="https://github.com/user-attachments/assets/d1c32d19-1918-42b6-86fb-f1dbce761433" alt="Image 1" style="width: 200px; height: 450px;">
        <img src="https://github.com/user-attachments/assets/858a0bf7-fb5b-4a1a-9f06-ae3f583c3005" alt="Image 2" style="width: 200px; height: 450px;">
        <img src="https://github.com/user-attachments/assets/57935038-381c-4d16-a89d-dd458a2aed2f" alt="Image 3" style="width: 200px; height: 450px;">
        <img src="https://github.com/user-attachments/assets/edb1f80b-d269-486f-b8e0-087142151e74" alt="Image 4" style="width: 200px; height: 450px;">
    </div>
</body>
</html>

## Packages Used

- **Flutter**: The core framework for building the application.
- **Provider**: For managing app-wide state such as theming and API data.
- **connectivity_plus**: To monitor internet connectivity status in real time.
- **http**: To make API requests and fetch weather data from the web.

## Future Enhancements
- **Forecast Data**: Add a feature to display weather forecasts for upcoming days.

## Here I am also sharing you the Screen-Recording Drive Link of My Weather Application So kindly click on Drive Link To See the Video of Weather Application
**Link for ScreenRecording Video** => https://drive.google.com/file/d/1B9v9ywGlhzNU9LWGaunvP9v1ERK50r-f/view?usp=sharing
