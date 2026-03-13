import io.gitlab.arturbosch.detekt.Detekt

plugins {
    alias(libs.plugins.androidApplication) apply false
    alias(libs.plugins.androidLibrary) apply false
    alias(libs.plugins.composeMultiplatform) apply false
    alias(libs.plugins.composeCompiler) apply false
    alias(libs.plugins.kotlinMultiplatform) apply false
    alias(libs.plugins.kotlinSerialization)
    alias(libs.plugins.detekt)
    alias(libs.plugins.kotlinAndroid) apply false
}


val kotlinFiles = "**/*.kt"
val resourceFiles = "**/resources/**"
val buildFiles = "**/build/**"

/**
 * Task to run Detekt analysis for all project and included modules
 */
tasks.register("detektAll", Detekt::class) {
    val autoFix = project.hasProperty("detektAutoFix")

    description = "detekt build for all modules in this project"

    parallel = true
    ignoreFailures = false
    autoCorrect = autoFix
    buildUponDefaultConfig = true

    // To generate reports with relative paths
    basePath = projectDir.canonicalPath

    setSource(file(projectDir))
    config.setFrom("config/detekt/detekt.yml")
    include(kotlinFiles)
    exclude(resourceFiles, buildFiles)
    reports {
        html.required.set(true)
        xml.required.set(true)
        txt.required.set(false)
    }
}

dependencies {
    detektPlugins(libs.detekt.formatting.plugin)
}
