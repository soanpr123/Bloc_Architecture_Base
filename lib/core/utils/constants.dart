const UIAPI = 'UIAPIDomain';
const DEV_ENVIRONMENT = 'dev_environment';
const UAT_ENVIRONMENT = 'uat_environment';
const PROD_ENVIRONMENT = 'prod_environment';

const String regexEmail = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const String codePayment = "d027b407af65087107af498c6e2ae711";

class StorageBox {
  StorageBox._();
  static const String currentToken = 'token';
}
