const UIAPI = 'UIAPIDomain';
const DEV_ENVIRONMENT = 'dev_environment';
const UAT_ENVIRONMENT = 'uat_environment';
const PROD_ENVIRONMENT = 'prod_environment';

const String regexEmail = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

class StorageBox {
  StorageBox._();
  static const String currentToken = 'token';
}
