import '../../app_theme.dart';
import '../../elements/app_data_theme.dart';
import '../../elements/app_text_theme.dart';
import '../app_data_theme_impl.dart';
import '../app_text_theme_impl.dart';
import 'app_colors_light.dart';
import '../../elements/app_colors.dart';

///
class AppThemeLight extends AppTheme {
  const AppThemeLight();

  @override
  AppColors get colors => AppColorsLight();

  @override
  AppTextTheme get textTheme => AppTextThemeImpl(colors);

  @override
  AppDataTheme get dataTheme => AppDataThemeImpl(colors);
}
