# covid19 dashboard app

A simple dashboard app on covid 19 pandemic data. I'm not a novice in flutter but managed to complete my first flutter app just because of Flutter community blogs and tutorials. Huge thanks to them!

**#What it has?**
This app contains:
 - Overview 
	 - It's a landing screen
	 - Shows global confirmed and death total in a card widget
	 - Shows India confirmed and death total in a card widget
	 - Shows individual countries death total in list view (Asc. order)
 - Information
	 - Carousel with static info images
 - COVID in News
	 - Used webview to list the tweets on COVID
 - Use by Map
	 - This page will open up google map with markers.
	 - Each marker represents a country
	 - On tapping marker, show bottom modal sheet with country name and it's count on confirmed, recovered and death.

**#Important Note**
I've implemented google map in "Use by Map" page. To get the map in your screen please, replace the "YOUR_API_KEY" text in below places.
Android:
android/app/src/main/AndroidManifest.xml

    <meta-data android:name="com.google.android.geo.API_KEY"android:value="YOUR_API_KEY"/>

iOS:
ios/Runner/AppDelegate.m

    [GMSServices provideAPIKey:@"YOUR_API_KEY"];
