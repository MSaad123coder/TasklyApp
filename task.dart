// Importing the 'foundation.dart' package. This provides some basic utility functions and classes.
// It's important when working with fundamental Flutter features, especially for debugging and the type system.
import 'package:flutter/foundation.dart';

// The Task class represents a task, with information about its content (what to do),
// whether it's done or not, and the timestamp (time when it was created or updated).
class Task {
  // These are the properties of a Task. They describe what the task is about.
  String content; // The task's description (what needs to be done).
  bool done; // Indicates whether the task is finished or not.
  DateTime timestamp; // The time when this task was created or updated.

  // This constructor sets up a new Task by passing content, done, and timestamp when creating a task.
  // "required" ensures that these values must be provided when creating a Task.
  Task({required this.content, required this.done, required this.timestamp});

  // This is a factory constructor. It's used to create a new Task from a Map (a kind of key-value structure).
  // A Map is usually used when reading or writing data (from a file, database, etc.). Here, it's used to build a Task object.
  factory Task.fromMap(Map task) {
    // This code extracts the values from the map and creates a Task with the values retrieved.
    return Task(
        content: task["content"], // Extracting content value from the map
        timestamp: task["timestamp"], // Extracting timestamp value from the map
        done: task[
            "done"]); // Extracting done status from the map (fixed typo here)
  }

  // This method converts the Task into a Map. It's used when you need to save or send the Task's data.
  Map tomap() {
    // The Map created contains the task's information in a key-value format, making it easier to store or send.
    return {
      "Content": content, // Store the task content
      "done": done, // Store the task's done status
      "timestamp":
          timestamp, // Store the task's timestamp (when it was created or updated)
    };
  }
}
