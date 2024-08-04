{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config/${namespace}.security.auditd;
in
{
  options.${namespace}.security.auditd = {
    enable = mkEnableOption "default auditd configuration";
  };
  config = mkIf cfg.enable {
    security = {
      auditd.enable = true;
      audit = {
        enable = true;
        backloglimit = 8192;
        failureMode = "printk";
        rules = [ "-a exit,always -F arch=b64 =S execve" ];
      };
    };
    systemd = {
      timers."clean-audit-log" = {
        description = "Periodically clean audit log";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
        wantedBy = [ "timers.target" ];
      };
      services."clean-audit-log" = {
        script = # bash
          ''
            set -eu
            if [[ $(stat -c "%s" /var/log/audit/audit.log) -gt 524288000 ]]; then
            echo "Clearing Audit Log";
            rm -rvf /var/log/audit/audit.log;
            echo "Done!"
            fi
          '';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
        };
      };
    };
  };
}