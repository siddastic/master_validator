#include "include/master_validator/master_validator_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "master_validator_plugin.h"

void MasterValidatorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  master_validator::MasterValidatorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
