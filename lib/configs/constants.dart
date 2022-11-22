import 'package:fit_board/backend/common/firestore_controller.dart';
import 'package:fit_board/configs/typedefs.dart';

class SharedPreferenceVariables {
  static const String darkThemeModeEnabled = "darkThemeModeEnabled";
  static const String isUserLoggedIn = "isUserLoggedIn";
}

class FirebaseNodes {
  static const String boardCollection = 'board';
  static const String boardDataDocument = 'data';

  static MyFirestoreDocumentReference get boardDataDocumentReference => FirestoreController.documentReference(
    collectionName: FirebaseNodes.boardCollection,
    documentId: FirebaseNodes.boardDataDocument,
  );
}

class AppUIConfiguration {
  static double borderRadius = 7;
}