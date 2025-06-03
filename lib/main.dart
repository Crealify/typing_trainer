import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:typing_trainer/data/repositories/stats_repository.dart';
import 'package:typing_trainer/data/repositories/sentences_repository.dart';
import 'package:typing_trainer/presentation/pages/home_page.dart';
import 'package:typing_trainer/presentation/providers/typing_provider.dart';
import 'package:typing_trainer/presentation/providers/theme_provider.dart';
import 'package:typing_trainer/presentation/providers/stats_provider.dart';
import 'package:typing_trainer/presentation/theme/app_theme.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize repositories
  final statsRepo = StatsRepository(sharedPreferences);
  final sentencesRepo = SentencesRepository();

  runApp(
    MultiProvider(
      providers: [
        // State Providers
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(sharedPreferences),
        ),
        ChangeNotifierProvider(
          create: (_) => StatsProvider(statsRepo),
        ),
        ChangeNotifierProvider(
          create: (context) => TypingProvider(
            statsRepository: statsRepo,
            sentencesRepository: sentencesRepo,
            themeProvider: Provider.of<ThemeProvider>(context, listen: false),
          ),
        ),
      ],
      child: const TypingTrainerApp(),
    ),
  );
}

class TypingTrainerApp extends StatelessWidget {
  const TypingTrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Pro Typing Trainer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const HomePage(),
      // Global app configurations
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0), // Disable text scaling
          ),
          child: child!,
        );
      },
    );
  }
}