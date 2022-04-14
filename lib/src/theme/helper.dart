import 'package:flutter_svg/svg.dart';
import 'package:ucar_app/src/theme/constraint.dart';

getSvgIcon(icon) {
  return SvgPicture.asset(icon_path + icon);
}

getImage(image) {
  return image_path + image;
}

getImageNetwork(url) {
  return url;
}