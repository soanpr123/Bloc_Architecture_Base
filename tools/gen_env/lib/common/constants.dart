import 'flavor_model.dart';

const flavorKey = 'FLAVOR';
const launchJsonPath = './.vscode/launch.json';
const settingsJsonPath = './.vscode/settings.json';
const workspaceXmlPath = './.idea/workspace.xml';

const flavorsList = [
  Flavor(flavorEnum: FlavorsEnum.develop, name: 'develop', prefix: 'DEV', envPath: './env/develop.env'),
  Flavor(flavorEnum: FlavorsEnum.production, name: 'production', prefix: 'PROD', envPath: './env/production.env'),
];
