abstract class IDeviceService {
  Future<String> getProductsDeviceFolderPath();

  Future<String> getFullDevicePicturePath(String filename);

  Future<String> createPictureOnProductsDeviceFolder(String picturePath);
}
