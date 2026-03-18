import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
    alias(libs.plugins.kotlinSerialization)
    alias(libs.plugins.ksp)
    alias(libs.plugins.moko.resources)
}

kotlin {

    targets.all {
        compilations.all {
            compilerOptions.configure {
                freeCompilerArgs.add("-Xexpect-actual-classes")
            }
        }
    }

    androidTarget {
        compilerOptions {
            jvmTarget.set(JvmTarget.JVM_11)
        }
    }
    
    listOf(
        iosArm64(),
        iosSimulatorArm64()
    ).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "Shared"
            isStatic = true
            export(libs.moko.resources)
        }
    }
    
    sourceSets {
        commonMain.dependencies {
            implementation(libs.kable)
            implementation(libs.bundles.koin.core)
            implementation(libs.bundles.kotlinx)
            api(libs.moko.resources)
        }

        androidMain.dependencies {
            implementation(libs.bundles.koin.android)
        }
    }
}

android {
    namespace = "com.gorman.archimed.shared"
    compileSdk = libs.versions.android.compileSdk.get().toInt()
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    defaultConfig {
        minSdk = libs.versions.android.minSdk.get().toInt()
    }
}

multiplatformResources {
    resourcesPackage.set("com.gorman.archimed.shared")
}