# Keep Flutter classes
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# Firebase (Crashlytics, Messaging...)
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Gson
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# Retrofit
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# Dio (لو كانت تستخدم native calls)
-dontwarn okhttp3.**
-keep class okhttp3.** { *; }

# JSON serialization
-keep class * implements java.io.Serializable { *; }
