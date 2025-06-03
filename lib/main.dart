import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typing_trainer/presentation/pages/home_page.dart';
import 'package:typing_trainer/presentation/providers/typing_providers.dart';
import 'package:typing_trainer/presentation/theme/app_therme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TypingProvider())],
      child: const TypingTrainerApp(),
    ),
  );
}

class TypingTrainerApp extends StatelessWidget {
  const TypingTrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing Trainer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<TypingProvider>().themeMode,
      home: HomePage(),
    );
  }
}
