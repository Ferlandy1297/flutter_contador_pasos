import 'package:flutter/material.dart';

// Función principal que inicia la aplicación
void main() {
  runApp(MyApp());
}

// Clase principal que define la estructura de la aplicación
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
      title: 'Contador de Pasos', // Título de la app
      theme: ThemeData(primarySwatch: Colors.blue), // Tema de la aplicación
      home: HomeScreen(), // Define la pantalla principal
    );
  }
}

// Pantalla principal de la aplicación
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Estado de la pantalla principal
class _HomeScreenState extends State<HomeScreen> {
  int _pasos = 0; // Contador de pasos
  int _metaPasos = 10000; // Meta predeterminada de pasos
  final TextEditingController _metaController =
      TextEditingController(); // Controlador para ingresar la meta

  // Método para incrementar el contador de pasos
  void _sumarPaso() {
    setState(() {
      _pasos++;
    });
  }

  // Método para decrementar el contador de pasos
  void _restarPaso() {
    if (_pasos > 0) {
      setState(() {
        _pasos--;
      });
    }
  }

  // Método para actualizar la meta de pasos ingresada por el usuario
  void _actualizarMeta() {
    setState(() {
      _metaPasos = int.tryParse(_metaController.text) ?? 10000;
    });
  }

  // Método para reiniciar el contador de pasos a cero
  void _reiniciarContador() {
    setState(() {
      _pasos = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progreso = (_pasos / _metaPasos).clamp(
      0.0,
      1.0,
    ); // Calcula el progreso de la meta
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador de Pasos'),
      ), // Barra superior con título
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ), // Espaciado alrededor de los elementos
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra los elementos en la pantalla
          children: [
            Text(
              'Pasos: $_pasos',
              style: TextStyle(fontSize: 24),
            ), // Muestra la cantidad de pasos
            SizedBox(height: 20), // Espaciado entre elementos
            // Campo de entrada para la meta de pasos
            TextField(
              controller: _metaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Meta de Pasos',
                border: OutlineInputBorder(),
              ),
              onSubmitted:
                  (_) =>
                      _actualizarMeta(), // Actualiza la meta cuando el usuario presiona Enter
            ),
            SizedBox(height: 20),

            // Barra de progreso que muestra el avance hacia la meta
            LinearProgressIndicator(
              value: progreso, // Valor de progreso
              color:
                  progreso >= 1.0
                      ? Colors.green
                      : Colors.blue, // Cambia de color al alcanzar la meta
              minHeight: 10,
            ),
            SizedBox(height: 20),

            // Botones para aumentar y disminuir los pasos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _sumarPaso, child: Text('+ Paso')),
                ElevatedButton(onPressed: _restarPaso, child: Text('- Paso')),
              ],
            ),
            SizedBox(height: 20),

            // Botón para reiniciar el contador de pasos
            ElevatedButton(
              onPressed: _reiniciarContador,
              child: Text('Reiniciar'),
            ),
          ],
        ),
      ),
    );
  }
}
