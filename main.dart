// Importing Flutter's Material Design library to use various UI components in the app.
import 'package:flutter/material.dart';

// Importing the home page widget where you define the main screen of your app.
import 'package:flutter_application_1/Pages/home_page.dart';

// Importing Hive's Flutter plugin for using the Hive database to store task data.
import "package:hive_flutter/hive_flutter.dart";

// main() is where the program starts. We need to call it when the app is run.
void main() async {
  // This line initializes Hive and creates the necessary folders for the database to be stored in "hive_boxes".
  await Hive.initFlutter("hive_boxes");

  // This line launches the app and tells it to start by displaying the MyTask widget.
  runApp(MyTask(null));
}

// Defining the main MyTask widget class, which is a StatelessWidget, meaning it doesn't change over time.
class MyTask extends StatelessWidget {
  // Constructor to allow the MyTask widget to be used with a key (which is passed down to its superclass).
  const MyTask(Key? key) : super(key: key);

  // The build() method is where the UI of this widget is created.
  @override
  Widget build(BuildContext context) {
    // Returning the main MaterialApp widget that wraps the entire UI.
    return MaterialApp(
      // Title of the app, displayed on the phone's title bar and for other internal purposes.
      title: "TASKLY",

      // Defining the theme (color scheme, font, etc.) for the app. Here we choose a red theme.
      theme: ThemeData(
        primarySwatch: Colors
            .red, // Sets the primary color of the app as red for consistency in UI.
      ),

      // Specifies which screen/widget to show when the app is first opened; it's set to the HomePage widget.
      home: HomePage(),
    );
  }
}
//Breakdown of What Each Line Does:
// Import statements:

// What: This brings in some essential packages: flutter/material.dart for the UI, home_page.dart for the main screen of your app, and hive_flutter.dart for saving data.
// Why: You need these libraries to use various UI components (like buttons, text, etc.) and to store user data (tasks) securely.
// How: import makes these libraries available so you can use them throughout your app.
// Main function:

// What: This function is the starting point of your app. It's like the "engine start" of a car.
// Why: This is where you need to set up Hive (the storage) and launch your app.
// How: runApp() takes the widget (the main structure of the app) and displays it when the app starts. await Hive.initFlutter("hive_boxes") prepares the app to store data in a specific folder.
// MyTask class (stateless widget):

// What: This class represents your entire app. It doesn't change based on user interactions (stateless means it doesn’t keep track of changes in the app state).
// Why: Since the app's look and feel doesn't need to change during runtime, it's perfect for this widget type.
// How: You define a stateless widget by extending StatelessWidget. Inside it, you set up the app's UI.
// Constructor:

// What: This constructor is part of the MyTask class, but we don't need to change anything, so we don't use it in our code.
// Why: It's included in case the app needs to handle some extra logic when creating the widget.
// How: It’s automatically created by Flutter and passed to super(key: key), which is a required step for the widget creation.
// Build method:

// What: The build() method returns the actual UI of the app. This is the layout, themes, and widgets shown to the user.
// Why: The build method is necessary to tell Flutter how to build and structure the app visually.
// How: Inside this method, we use the MaterialApp widget, which is essential to use Material Design and create a consistent UI.
// MaterialApp widget:

// What: MaterialApp is the foundation for Flutter apps that use Material Design. It creates the overall structure.
// Why: It defines essential app-wide elements like the title, theme (look and feel), and the starting screen (HomePage).
// How: MaterialApp manages things like the app bar color, navigation, routes, and makes the app look good with predefined widgets.
// Why this contributes to your task app:
// Hive Setup: Setting up Hive will allow you to store tasks (like "Go to Gym" or "Buy groceries") on the phone so that they stay saved even after the app is closed.
// Theming: You’ve applied a red theme to your app, which will make it visually unique and consistent for the user.
// Starting Screen: The HomePage is set as the first screen of your app. This is the screen where you'll display your tasks. It’s the starting point for users to interact with the app.
// Simple Explanation for a 5-year-old:
// Imagine you're building a toy car with a red body. You first need to build the "engine" (main part of the app) that gets everything ready to move. You then paint the car red (set the theme). Once the engine is ready, you tell the car where it should go when you turn it on (show the homepage screen).

// Does this explanation make things clearer? Let me know if you'd like any more clarifications!