import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RemoteConfigApp());
}

class RemoteConfigApp extends StatelessWidget {
  const RemoteConfigApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote Config Example',
      home: const HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  static const String _welcomeMessageKey = 'welcome_message';
  static const String _featureEnabledKey = 'new_feature_enabled';
  static const String _colorKey = 'theme_color';

  String _welcomeMessage = 'Welcome!';
  bool _featureEnabled = false;
  Color _themeColor = Colors.blue;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    try {
      // Set default values
      await _remoteConfig.setDefaults({
        _welcomeMessageKey: 'Welcome to the Remote Config Example!',
        _featureEnabledKey: false,
        _colorKey: '#0000FF', // Blue in hex
      });

      // Set cache expiration
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));

      // Fetch and activate
      await _remoteConfig.fetchAndActivate();

      // Apply fetched values
      _applyRemoteConfig();
    } catch (e) {
      print('Error initializing Remote Config: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _applyRemoteConfig() {
    setState(() {
      _welcomeMessage = _remoteConfig.getString(_welcomeMessageKey);
      _featureEnabled = _remoteConfig.getBool(_featureEnabledKey);

      // Convert hex color string to Color
      final String colorHex = _remoteConfig.getString(_colorKey);
      try {
        if (colorHex.isNotEmpty) {
          final String formattedColor = colorHex.startsWith('#')
              ? colorHex
              : '#$colorHex';
          _themeColor = Color(int.parse(formattedColor.substring(1, 7), radix: 16) + 0xFF000000);
        }
      } catch (e) {
        print('Error parsing color: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Remote Config'),
        backgroundColor: _themeColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _welcomeMessage,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (_featureEnabled)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: _themeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'This is a new feature enabled by Remote Config!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    await _remoteConfig.fetchAndActivate();
                    _applyRemoteConfig();
                  } catch (e) {
                    print('Error refreshing values: $e');
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _themeColor,
                ),
                child: const Text('Refresh Values'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}