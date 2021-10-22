# project_testing

This project is the geolocation and google map integration

## Dependencies
<ul>
    <li>geolocator</li>
    <li>google_maps_flutter</li>
</ul>

## Setting Up Geolocation Permissions
Add a permissions to use geolocation

<ul>For Android <code>android/app/src/main/AndroidManifest.xml</code></ul>
<pre>android.permission.ACCESS_FINE_LOCATION</pre>
<pre>android.permission.ACCESS_COARSE_LOCATION</pre>
<ul>iOS <code>-</code></ul>

## Setting Up API Key for Google Map Integration
Get your API key on <a href="https://cloud.google.com/maps-platform/">Here</a> (Click <a href="https://pub.dev/packages/google_maps_flutter">here</a> to read the complete tutorial and documentation) <br>

<ul>For Android <code>android/app/src/main/AndroidManifest.xml</code></ul>
<ul>iOS <code>ios/runner/AppDelegate.swift</code></ul>
change:
<pre>YOUR API KEY</pre>
