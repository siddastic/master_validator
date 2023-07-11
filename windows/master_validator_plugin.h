#ifndef FLUTTER_PLUGIN_MASTER_VALIDATOR_PLUGIN_H_
#define FLUTTER_PLUGIN_MASTER_VALIDATOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace master_validator {

class MasterValidatorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MasterValidatorPlugin();

  virtual ~MasterValidatorPlugin();

  // Disallow copy and assign.
  MasterValidatorPlugin(const MasterValidatorPlugin&) = delete;
  MasterValidatorPlugin& operator=(const MasterValidatorPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace master_validator

#endif  // FLUTTER_PLUGIN_MASTER_VALIDATOR_PLUGIN_H_
