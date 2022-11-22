class AppController {
  static AppController? _instance;
  AppController._();
  factory AppController() => _instance ??= AppController._();

  bool isAdminApp = false;
}