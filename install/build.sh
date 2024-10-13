FLUTTER="/Users/junioroliveira/Documents/development/flutter/bin/flutter"

cd flutter-app

$FLUTTER pub get && \
$FLUTTER pub run flutter_launcher_icons && \
$FLUTTER packages pub run build_runner build --delete-conflicting-outputs && \
$FLUTTER build appbundle && \
#$FLUTTER build apk && \
#$FLUTTER build ipa
$FLUTTER build apk

cp build/app/outputs/bundle/release/app-release.aab ../install
cp build/app/outputs/flutter-apk/app-release.apk ../install
cp -r build/ios ../install

