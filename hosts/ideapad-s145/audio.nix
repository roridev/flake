{ config, pkgs, ... }:

let
  clock = {
    rate = 48000;
    quantum = {
      default = 128;
      min = 128;
      max = 128;
    };
  };
in
{

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = clock.rate;
      "default.clock.quantum" = clock.quantum.default;
      "default.clock.min-quantum" = clock.quantum.min;
      "default.clock.max-quantum" = clock.quantum.max;
    };
  };

  services.pipewire.extraConfig.pipewire-pulse."92-low-latency" = {
    context.modules = [
      {
        name = "libpipewire-module-protocol-pulse";
        args = {
          pulse.min.req = "${builtins.toString clock.quantum.min}\/${builtins.toString clock.rate}";
          pulse.default.req = "${builtins.toString clock.quantum.default}\/${builtins.toString clock.rate}";
          pulse.max.req = "${builtins.toString clock.quantum.max}\/${builtins.toString clock.rate}";
          pulse.min.quantum = "${builtins.toString clock.quantum.min}\/${builtins.toString clock.rate}";
          pulse.max.quantum = "${builtins.toString clock.quantum.max}\/${builtins.toString clock.rate}";
        };
      }
    ];
    stream.properties = {
      node.latency = "${builtins.toString clock.quantum.min}\/${builtins.toString clock.rate}";
      resample.quality = 1;
    };
  };

}
