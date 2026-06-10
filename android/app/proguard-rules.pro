# Flutter specific ProGuard/R8 rules
# Keep Flutter embedding classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.engine.** { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep Hive classes
-keep class com.hive.** { *; }

# Keep GetX classes
-keep class com.getx.** { *; }

# Keep Google Maps / Location classes
-keep class com.google.android.gms.** { *; }
-keep class com.google.android.gms.location.** { *; }

# Keep Gson/JSON serialization
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep model classes used with JSON
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep HTTP client classes
-keep class org.apache.** { *; }
-dontwarn org.apache.**
-dontwarn javax.annotation.**
-dontwarn javax.inject.**

# Keep Kotlin classes
-keep class kotlin.** { *; }
-keep class kotlin.Metadata { *; }
-dontwarn kotlin.**
-keepclassmembers class kotlin.Metadata {
    public <methods>;
}

# General Android rules
-keep class * extends android.app.Activity
-keep class * extends android.app.Application
-keep class * extends android.app.Service
-keep class * extends android.content.BroadcastReceiver
-keep class * extends android.content.ContentProvider

# Keep all model/data classes
-keep class com.edusurvey.app.** { *; }

# Keep enum classes
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int d(...);
    public static int i(...);
}
