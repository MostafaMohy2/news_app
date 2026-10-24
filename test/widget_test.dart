import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/config/app_config.dart';
import 'package:news_app/core/l10n/app_localizations.dart';
import 'package:news_app/main.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App loads and initializes localization', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppConfig(),
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();
  });

  test('AppLocalizations loads English and Arabic strings', () async {
    final en = await AppLocalizations.delegate.load(const Locale('en'));
    expect(en.appTitle, 'News App');
    expect(en.language, 'Language');

    final ar = await AppLocalizations.delegate.load(const Locale('ar'));
    expect(ar.appTitle, 'تطبيق الأخبار');
    expect(ar.language, 'اللغة');
  });

  testWidgets('Changing language in AppConfig updates locale', (WidgetTester tester) async {
    final config = AppConfig();
    expect(config.locale.languageCode, 'en');

    config.changeLanguage('ar');
    expect(config.locale.languageCode, 'ar');
  });
}
