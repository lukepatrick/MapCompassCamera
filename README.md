MapCompassCamera
================

An "augmented reality" attempt, mashing up the iPad Camera with a Map and using the compass/GPS to force the map to lock to your position. 

The [JS demonstration](https://github.com/lukepatrick/MapCompassCameraJS)

===============
### Prereq's:

[ArcGIS iOS SDK](https://developers.arcgis.com/en/ios/info/install.htm)

### Getting Started

Ideally you have your own map service to add, if not checkout [ArcGIS.com](http://www.arcgis.com) and search around for a service to try out.

Open the 
```smalltalk
MapCompassCameraViewController.m
```
and look for the
```smalltalk
NSURL *netmapUrl = [NSURL URLWithString:@""];
```
and add your own resource URL.

### Credit

This is a quick-and-dirty demonstration of a simple Augmented Reality app. It based this heavily off the original ArcGIS iOS GPS Sample.

