import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FiestaFinderApp());
}

class FiestaFinderApp extends StatelessWidget {
  const FiestaFinderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.deepPurple,
      ),
      home: const FiestaFinderHome(),
    );
  }
}

class FiestaFinderHome extends StatefulWidget {
  const FiestaFinderHome({Key? key}) : super(key: key);

  @override
  FiestaFinderHomeState createState() => FiestaFinderHomeState();
}

class FiestaFinderHomeState extends State<FiestaFinderHome> {
  String location = "";
  final List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "name": "Fiesta Electrónica en Downtown",
      "location": "Club Nocturno X",
      "rating": 4.8,
      "status": "Intermedio",
    },
    {
      "id": 2,
      "name": "Concierto de Rock Alternativo",
      "location": "Teatro Central",
      "rating": 4.5,
      "status": "Lleno",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎉 Livit 🎉"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Ubicación actual",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  location = value;
                });
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Buscar"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(event["name"],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ubicación: ${event["location"]}"),
                          Text("Estado: ${event["status"]}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text(event["rating"].toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.notifications_active),
              label: const Text("Activar Notificaciones"),
            ),
          ],
        ),
      ),
    );
  }
}
