plugins {
    id("com.android.application")
}

android {
    namespace = "com.example.mobile_seminar_project"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.mobile_seminar_project"
        minSdk = 26
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}

dependencies {

    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.10.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")

    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("net.sf.scuba:scuba-sc-android:0.0.20")
    implementation("com.google.code.gson:gson:2.9.1")
    implementation("com.google.guava:guava:32.0-jre")
    implementation("com.google.guava:listenablefuture:1.100-jre")

    testImplementation("org.mockito:mockito-core:4.8.1")

    implementation("org.jmrtd:jmrtd:0.8.2")
    implementation("com.madgag.spongycastle:prov:1.66.0.0")
    implementation("com.github.mhshams:jnbis:1.1.0")

    implementation(files("libs/vnidreader-library-1.0.1.aar"))
}