plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.nihongo_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.nihongo_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // --- THÊM ĐOẠN NÀY VÀO ---
    signingConfigs {
        create("release") {
            // Tạm thời gán bằng debug để Shorebird init không báo lỗi
            // Khi nào bạn có file keystore thật (.jks), hãy quay lại cập nhật ở đây
            val debugConfig = getByName("debug")
            storeFile = debugConfig.storeFile
            storePassword = debugConfig.storePassword
            keyAlias = debugConfig.keyAlias
            keyPassword = debugConfig.keyPassword
        }
    }
    // ------------------------

    buildTypes {
        release {
            isMinifyEnabled = true 
            isShrinkResources = true
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // Bây giờ "release" đã tồn tại nên dòng này sẽ không lỗi nữa
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}