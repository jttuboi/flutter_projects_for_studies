# Follow my tracks

This an simple add to test bloc pattern and maps.

- Flutter 2.5.2 / Dart 2.14.3
- Bloc 7.3.1 (state management pattern)
- Google maps flutter 2.0.11 (to show map)
- Geocoding 2.0.1 (for find location by address)
- Location 4.3.0 (for GPS)

## **Description of project**

###### **Maps page**
Show the map with track select in Tracks page.
User can open Tracks page clicking in floating button with track icon.
User can redirect to device location clicking in floating button with location icon.

###### **Tracks page**
Show the list of tracks created by user.
User can delete track swiping right to left.
User can add a track clicking on add button.
User can select a track to show in map with a simple tap on track item.
User can edit a track with double tap or long tap on track item.

###### **Add track page/Edit track page**
Show the map and user can add markers clicking on map to create an track.
User can save the track clicking on save button in tracks list.
User can redirect to device location clicking in floating button with location icon.

## **Execute the project**
For test, you need change the file `android\app\src\main\AndroidManifest.xml` and `lib\domain\core.dart`. Here you will find `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`, you need change to Google maps API key.

This API key you can find in https://developers.google.com/maps/documentation/embed/get-api-key. Don't forget to enable Directions API (to create directions for track) and Maps SDK for Android (to access the google maps in app).

To execute, you need get the packages and you need build apk to deploy.
```
flutter pub get
flutter build apk
```
