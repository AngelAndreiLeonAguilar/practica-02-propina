import 'package:flutter_test/flutter_test.dart';
import 'package:practica_02_dart_estado/main.dart';

void main() {
  testWidgets('muestra la calculadora de combustible', (tester) async {
    await tester.pumpWidget(const PracticaDosApp());

    expect(find.text('Calculadora de consumo de combustible'), findsOneWidget);
    expect(find.text('Calcular'), findsOneWidget);
  });

  testWidgets('calcula kilometros por litro', (tester) async {
    await tester.pumpWidget(const PracticaDosApp());
    await tester.enterText(find.byType(TextField).at(0), '300');
    await tester.enterText(find.byType(TextField).at(1), '20');
    await tester.tap(find.text('Calcular'));
    await tester.pump();

    expect(find.text('15.00 km/L'), findsOneWidget);
    expect(find.text('Nivel: Excelente'), findsOneWidget);
  });
}
