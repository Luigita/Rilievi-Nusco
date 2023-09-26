import 'package:in_app_update/in_app_update.dart';

Future<AppUpdateInfo?> _checkForUpdate() async {
try {
return await InAppUpdate.checkForUpdate();
} catch (e) {
//Throwing the exception so we can catch it on our UI layer
throw e.toString();
}
}

Future<void> checkForImmediateUpdate() async {
try {
//Call and get the result from the initial function
final AppUpdateInfo? info = await _checkForUpdate();

//Because info could be null
if (info != null) {
if (info.updateAvailability == UpdateAvailability.updateAvailable) {
InAppUpdate.performImmediateUpdate();
}
}
} catch (e) {
throw e.toString();
}
}