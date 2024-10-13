FLUTTER="/Users/junioroliveira/Documents/development/flutter/bin/flutter"

cd flutter-app

$FLUTTER pub get && \
$FLUTTER pub run flutter_launcher_icons && \
$FLUTTER packages pub run build_runner build --delete-conflicting-outputs && \
$FLUTTER build appbundle && \
$FLUTTER build apk

