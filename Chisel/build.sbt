// See README.md for license details.

ThisBuild / scalaVersion := "2.13.8"
ThisBuild / version      := "0.1.0"
ThisBuild / organization := "liuyic00"

resolvers ++= Seq(
  Resolver.sonatypeRepo("snapshots"),
  Resolver.sonatypeRepo("releases")
)

val chiselVersion     = "3.6-SNAPSHOT"
val chiselTestVersion = "0.6-SNAPSHOT"

lazy val root = (project in file("."))
  .settings(
    name := "minic",
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3"    % chiselVersion,
      "edu.berkeley.cs" %% "chiseltest" % chiselTestVersion % "test"
    ),
    scalacOptions ++= Seq(
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit"
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % chiselVersion cross CrossVersion.full)
  )
