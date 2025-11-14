import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'models/database.dart';
import 'providers/edit_mode_provider.dart';
import 'providers/photos_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/communication_board_screen.dart';
import 'services/audio_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  final database = AppDatabase();
  
  // Initialize audio service
  final audioService = AudioService();
  await audioService.initialize();
  
  runApp(MainApp(database: database, audioService: audioService));
}

class MainApp extends StatelessWidget {
  final AppDatabase database;
  final AudioService audioService;

  const MainApp({
    super.key,
    required this.database,
    required this.audioService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EditModeProvider()),
        ChangeNotifierProvider(create: (_) => PhotosProvider(database)),
        ChangeNotifierProvider(create: (_) => SettingsProvider()..loadSettings()),
        Provider.value(value: audioService),
        Provider.value(value: database),
      ],
      child: const CupertinoApp(
        title: 'Stardust AAC',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.systemBlue,
          brightness: Brightness.light,
        ),
        home: CommunicationBoardScreen(),
      ),
    );
  }
}
