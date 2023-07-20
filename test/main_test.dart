import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login/main.dart';
import 'package:login/screens/Incidencias_screen.dart'; // Importa el archivo main.dart de tu aplicación
import 'package:login/screens/login_screen.dart';

void main() {
  testWidgets('Prueba de inicio de la aplicación', (WidgetTester tester) async {
    // Construye el widget de la aplicación.
    await tester.pumpWidget(MyApp());

    // Verifica que la aplicación se haya construido correctamente
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verifica que el widget LoginScreen sea el widget inicial
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Prueba de navegación a la pantalla de incidencias', (WidgetTester tester) async {
    // Construye el widget de la aplicación.
    await tester.pumpWidget(MyApp());

    // Toca el botón de inicio de sesión
    await tester.tap(find.text('Ingresar'));

    // Espera a que la animación termine
    await tester.pumpAndSettle();

    // Verifica que se haya navegado a la pantalla de incidencias
    expect(find.byType(IncidenciasScreen), findsOneWidget);
  });

  // Puedes agregar más pruebas para otros escenarios y widgets
}
