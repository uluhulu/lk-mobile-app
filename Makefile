.PHONY : clean build intl prod_android dev_android
clean:
	flutter clean
	flutter pub get
	cd ./ios; pod install; cd ../
	cd ./macos; pod install; cd ../
build:
	flutter pub run build_runner build --delete-conflicting-outputs 
intl:
	flutter pub global run intl_utils:generate
prod_android:
	flutter build apk --release -v
prod_appbundle:
	flutter build appbundle --release -v
dev_android:
	flutter build apk --release -v
prod_ios:
	flutter build ipa --release -v

	