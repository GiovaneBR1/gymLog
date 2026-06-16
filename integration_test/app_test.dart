import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gymlog/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Fluxo completo: abrir app, criar treino, navegar de volta',
      (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // 1. App abre na home
    expect(find.text('GymLog'), findsOneWidget);

    // 2. Acha o botão + pelo tooltip
    final addButton = find.byWidgetPredicate(
      (widget) => widget is IconButton && widget.tooltip == 'Novo treino',
    );
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);

    // Espera a navegação acontecer
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    // 3. Tela de criar treino — verifica pelo TextFormField
    expect(find.byType(TextFormField), findsOneWidget);

    // 4. Preenche o nome
    await tester.enterText(find.byType(TextFormField), 'Treino Integração');
    await tester.pump();

    // 5. Seleciona um dia — tenta Segunda que é o padrão já selecionado
    await tester.tap(find.text('Quarta').first);
    await tester.pump();

    // 6. Cria o treino — acha o FilledButton
    final createButton = find.byType(FilledButton);
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // 7. Voltou pra home e treino aparece
    expect(find.text('Treino Integração'), findsOneWidget);

    // 8. Navega pro detalhe
    await tester.tap(find.text('Treino Integração'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
