// Import necessary packages to build your app.
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/models/task.dart'; // Import the Task model that helps define each task

// This is the main homepage of your app, where tasks are listed and you can add, update, or delete tasks.
class HomePage extends StatefulWidget {
  HomePage(); // This constructor is created to initialize HomePage.

  @override
  // This creates the state for your homepage to allow dynamic updates (state management).
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

// This is the state for your HomePage, where the actual task management happens.
class _HomePageState extends State<HomePage> {
  // Variables for device height and width to adjust UI based on the device's screen size.
  late double _deviceHeight, _deviceWidth;
  String? _newTaskContent; // This holds the content for the new task you want to add.
  Box? _box; // This is used to store your tasks from Hive.
// This is where the actual logic happens. _HomePageState defines how the homepage behaves when something changes. It is used to manage the list of tasks and update the UI when tasks are changed. The variables here are used to store information about the tasks and device screen size.

// Why it's here:

// This class holds all the data, like screen size and tasks, that your HomePage needs to show.
// It is also responsible for managing state, meaning every time you add or mark a task as done, this state will update and reflect those changes on the screen.
  _HomePageState(); // Constructor that doesn't have any extra purpose here.

  @override
  // The build function returns the visual layout of this screen (UI).
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height; // Get device screen height.
    _deviceWidth = MediaQuery.of(context).size.width; // Get device screen width.

    // Scaffold provides the basic structure for the screen (AppBar, body, floating action button, etc.)
    return Scaffold(
      // AppBar is the top section with title "TASKLY".
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.05, // Height of the app bar based on device height.
        title: const Text(
          "TASKLY",
          style: TextStyle(fontSize: 24), // Style the text to look bigger and bolder.
        ),
      ),
      // The body of the screen, which displays your tasks using the '_tasksview' widget.
      body: _tasksview(),
      // The floating button to add new tasks, calling the '_addtaskbutton' method.
      floatingActionButton: _addtaskbutton(),
    );
  }

  // This widget builds a list view of tasks asynchronously by loading data from Hive database.
  Widget _tasksview() {
    return FutureBuilder(
      future: Hive.openBox('tasks'), // Asynchronously open the 'tasks' Hive box.
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // When the data is ready, proceed with building the UI to show tasks.
        if (snapshot.hasData) {
          _box = snapshot.data; // Store the reference to the 'tasks' box from Hive.
          return _tasklist(); // Return the task list once the data is loaded.
        } else {
          // If the tasks are still loading, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // The FutureBuilder helps wait for data before proceeding.
      },
    );
  }

  // This widget displays the list of tasks from the Hive database.
  Widget _tasklist() {
    List tasks = _box!.values.toList(); // Convert the stored tasks into a list.
    // 'ListView.builder' is used to dynamically build the list of tasks as they are displayed.
    return ListView.builder(
      itemCount: tasks.length, // Define the total number of tasks in the list.
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(tasks[_index]); // Convert each task from map to Task object.
        // Return a list tile with task details, like title, status, and actions.
        return ListTile(
            title: Text(
              task.content, // Display the task's description.
              style: TextStyle(
                  decoration: task.done ? TextDecoration.lineThrough : null),
              // Strikethrough the text if the task is done (shows visually).
            ),
            subtitle: Text(
              task.timestamp.toString(), // Show the timestamp of when the task was added.
            ),
            trailing: Icon(
              task.done
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              // Change the checkbox icon depending on whether the task is completed.
              color: Colors.red,
            ),
            onTap: () {
              task.done = !task.done; // Toggle the task's "done" status when clicked.
              _box?.putAt(_index, task.tomap()); // Update the task in Hive storage with the new "done" status.
              setState(() {}); // Refresh the screen to show updated data.
            },
            onLongPress: () {
              _box?.deleteAt(_index); // Delete the task from Hive when long pressed.
              setState(() {}); // Refresh the screen to show updated data after deletion.
            });
      },
    );
  }

  // Floating action button to open a dialog to add new tasks.
  Widget _addtaskbutton() {
    return FloatingActionButton(
      onPressed: _displayTaskpopeup, // Show the "Add Task" popup when pressed.
      child: const Icon(Icons.add), // Display a '+' icon.
    );
  }

  // Displays a popup to let the user enter a new task.
  void _displayTaskpopeup() {
    showDialog(
      context: context,
      builder: (Build_context) {
        return AlertDialog(
          title: const Text("Add New Task"), // Title of the dialog box.
          content: TextField(
            onSubmitted: (_value) {
              // Once the user enters a task and submits, create and add the task to Hive.
              if (_newTaskContent != null) {
                var _task = Task(
                    content: _newTaskContent!,
                    done: false,
                    timestamp: DateTime.now()); // Create a new Task object.
                _box?.add(_task.tomap()); // Add the new task to the Hive database.
                setState(() {
                  _newTaskContent = null; // Clear the input field for next task.
                  Navigator.pop(context); // Close the dialog box.
                });
              }
            },
            onChanged: (_value) {
              setState(() {
                _newTaskContent = _value; // Store the new task content.
              });
            },
          ),
        );
      },
    );
  }
}
//Alright, let's break it down in a very simple way!

// 1. What this code does:

// Imagine you're building a to-do list app. It's like having a little notebook where you write down all the tasks you want to do, like "Go to the park" or "Feed the dog."

// 2. What happens in this code?

// This code helps you build a task list in the app where you can:

// See all your tasks.
// Add new tasks.
// Mark tasks as done.
// Remove tasks if you don't want them anymore.
// Let's look at some parts:
// A. HomePage:

// The HomePage is like the main page of your app where everything happens.

// When you open the app, you see a screen where you can add, check, or delete tasks.
// The build() function tells what the screen will look like.
// B. FutureBuilder: This part is like waiting for your food to be cooked. The FutureBuilder waits for the app to get the list of tasks from its storage (like your notebook) before it shows them.

// It opens a special box (Hive) that stores all the tasks.
// When it's ready, the app shows your task list.
// C. The Task List (_tasklist()):

// This part makes sure that all your tasks are displayed in a list, just like reading through your notebook.
// When you click on a task, you can mark it as done, or if it's no longer needed, you can delete it.
// D. Adding New Tasks (_addtaskbutton() and _displayTaskpopeup()):

// There's a big plus button (FloatingActionButton), like a magic button that lets you add new tasks.
// When you tap the button, a box (or popup) opens, asking you to type your task in.
// Why this helps the app:
// This code makes it so that you can keep your task list safe, add new tasks easily, and change or remove them when needed! Every time you change something, it remembers everything you did, so your list is always up to date.

// In short:
// You can see your tasks.
// You can add more tasks.
// You can check off tasks when done.
// You can remove tasks if you don't need them.







