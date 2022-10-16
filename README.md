# AndroidMemoryTracker
This is a simple CLI utility to track the memory usage of an Android application using `adb shell` and `dumpsys meminfo`.

## Usage
```bash
$ ./AndroidMemoryTracker <package.id>
```
This will monitor the memory usage of the application with the given package id by running `dumpsys meminfo <package.id>` once every second and displaying the changes in memory usage.