import app from "ags/gtk4/app";
import { Astal } from "ags/gtk4";
import { createPoll } from "ags/time";
import GLib from "gi://GLib?version=2.0";

type Props = { monitor?: number };

function shAsync(cmd: string) {
  try {
    GLib.spawn_command_line_async(cmd);
  } catch {
    // ignore
  }
}

function pad2(n: string) {
  return n.padStart(2, "0");
}

function sundialLabel(hourStr: string, minStr: string) {
  const h = Number(hourStr);
  const m = Number(minStr);

  if (h >= 2 && h <= 4) return "Early Morning";
  if (h <= 5) return "Dawn";
  if (h >= 6 && h <= 8) return "Morning";
  if (h >= 9 && h <= 11) return "Late Morning";
  if (h === 12 && m <= 29) return "Midday";
  if (h >= 12 && h <= 16) return "Afternoon";
  if (h > 16 && h <= 17) return "Late Afternoon";
  if ((h >= 17 && m <= 1) || (h <= 18 && m <= 20)) return "Early Evening";
  if (h >= 18 && h <= 19) return "Dusk";
  if (h > 19 && h <= 21) return "Late Evening";
  if (h > 21) return "Night";
  return "Midnight";
}

function networkIcon(sig: string) {
  // keep your original mapping
  const offline = "";
  const excellent = "";
  const good = "";
  const okay = "";
  const slow = "";

  if (!sig) return offline;
  const n = Number(sig);
  if (Number.isNaN(n)) return offline;
  if (n < 26) return slow;
  if (n < 51) return okay;
  if (n < 76) return good;
  return excellent;
}

function batteryIcon(status: string, capacityStr: string) {
  const charge = "";
  const empty = "";
  const low = "";
  const mid = "";
  const high = "";
  const full = "";

  const cap = Number(capacityStr);

  if (status === "Charging") return charge;
  if (cap < 15) return empty;
  if (cap < 25) return low;
  if (cap < 50) return mid;
  if (cap < 75) return high;
  return full;
}

export default function Powermenu({ monitor = 0 }: Props) {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

  // time: use Date() (polling only because you were polling)
  const hour = createPoll("00", 5000, () =>
    `${new Date().getHours()}`.padStart(2, "0"),
  );
  const min = createPoll("00", 5000, () =>
    `${new Date().getMinutes()}`.padStart(2, "0"),
  );

  // net: your nmcli poll
  const net = createPoll(
    "",
    100000,
    `bash -lc 'nmcli -t -f SIGNAL,ACTIVE device wifi | awk -F":" "{if(\\$2==\\"yes\\")print\\$1}"'`,
  );

  // battery: keep your BAT0 sysfs approach (portable and matches your old config)
  const batStatus = createPoll(
    "Unknown",
    15000,
    `bash -lc 'cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo Unknown'`,
  );
  const batCap = createPoll(
    "0",
    15000,
    `bash -lc 'cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 0'`,
  );

  const bg = `file://${GLib.get_home_dir()}/.dotfiles/wallpapers/Control/35.jpg`;

  return (
    <window
      // IMPORTANT: name must come before application to make toggling work
      name="powermenu"
      application={app}
      monitor={monitor}
      visible={false}
      layer={Astal.Layer.OVERLAY}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | LEFT | RIGHT | BOTTOM}
    >
      <box
        class="layout-box"
        vertical
        css={`
          background-image: url("${bg}");
          background-repeat: no-repeat;
          background-size: contain;
        `}
      >
        <box valign={0} spacing={25}>
          <label
            class="sundial-lbl"
            hexpand
            halign={2}
            label={hour((h) => sundialLabel(h, min()))}
          />

          <box class="bat-box" spacing={8}>
            <label label={batStatus((s) => batteryIcon(s, batCap()))} />
          </box>

          <box class="net-box" spacing={8}>
            <label label={net((n) => networkIcon(n))} />
          </box>

          <label class="sep" label="|" />

          <button
            class="close-btn"
            onClicked={() => {
              // CLI toggle is `ags toggle powermenu`; in-process you can just flip visibility too.
              const w = app.get_window("powermenu");
              if (w) w.visible = false;
            }}
          >
            
          </button>
        </box>

        <box hexpand vexpand>
          <box class="tm-box" spacing={15} valign={2} halign={0}>
            <label label="" />
            <label label={hour((h) => `${pad2(h)}:${pad2(min())}`)} />
          </box>

          <box
            class="btns-box"
            spacing={5}
            vexpand
            hexpand
            valign={2}
            halign={2}
          >
            <button onClicked={() => shAsync("poweroff")}></button>
            <button onClicked={() => shAsync("reboot")}></button>
            <button
              onClicked={() =>
                shAsync(`loginctl terminate-session "$XDG_SESSION_ID"`)
              }
            >
              
            </button>
            <button onClicked={() => shAsync("hyprlock")}></button>
          </box>
        </box>
      </box>
    </window>
  );
}
