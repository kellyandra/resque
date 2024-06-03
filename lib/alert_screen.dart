import 'package:flutter/material.dart';

// Entry point of the Flutter application.
void main() {
  runApp(MaterialApp(home: AlertHistoryScreen()));
}

// StatefulWidget for managing the state of the AlertHistoryScreen.
class AlertHistoryScreen extends StatefulWidget {
  @override
  AlertHistoryScreenState createState() => AlertHistoryScreenState();
}

// State class for AlertHistoryScreen to handle dynamic data and UI changes.
class AlertHistoryScreenState extends State<AlertHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Sets a transparent background for the AppBar.
        elevation: 0, // Removes the shadow under the AppBar.
        title: const Text("ALERT HISTORY", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true, // Centers the title within the AppBar.
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Gradient starts from the top center.
            end: Alignment.bottomCenter, // Gradient ends at the bottom center.
            colors: [Colors.pink.shade600, Colors.red.shade800], // Gradient colors.
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(30), // Rounded corners for the TextField.
                elevation: 5, // Elevation for a slight shadow.
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Alert", // Placeholder text for the TextField.
                    prefixIcon: const Icon(Icons.search), // Icon on the left side of the TextField.
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none, // No border side.
                    ),
                    filled: true, // Enables the fillColor to be effective.
                    fillColor: Colors.white, // Background color of the TextField.
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Number of items in the list.
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    title: Text("Alert ${index + 1}"), // Dynamic title based on the index.
                    subtitle: Text("Detail of Alert ${index + 1}"), // Dynamic subtitle.
                    trailing: TextButton(
                      onPressed: () {}, // Placeholder function for button press.
                      child: const Text("See details"), // Button text.
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
