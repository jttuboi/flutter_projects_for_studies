# google_maps_sample


Em: android\app\src\main\AndroidManifest.xml

adicionar:
        <meta-data android:name="com.google.android.geo.API_KEY"
            android:value="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"/>


também criar o arquivo: lib\.env.dart

e adicionar:
const String googleAPIKey = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';



o xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx é o Google API KEy que é gerado no 

https://console.cloud.google.com/google/maps-apis/credentials
