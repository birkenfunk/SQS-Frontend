test:
	flutter test

integration_test_linux: setup_integration_test
	flutter test -d linux integration_test/switch_server_test.dart
	flutter test -d linux integration_test/get_weather_test.dart

build_linux:
	flutter build linux

run_linux:
	flutter run -d linux

build_web:
	flutter build web

run_web:
	flutter run -d web

build_android:
	flutter build apk

clean:
	flutter clean

setup_integration_test:
	./startDockerOrPodmanCompose.sh

get_package:
	flutter pub get

build_all: build_android build_linux build_web

.PHONY: test integration_test_linux build_linux run_linux build_web run_web build_android clean setup_integration_test build_all