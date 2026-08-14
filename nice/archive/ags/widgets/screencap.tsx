import app from "ags/gtk4/app";
import { Astal } from "ags/gtk4";
import GLib from "gi://GLib?version=2.0";

type Props = { monitor?: number };

function shAsync(cmd: string) {
  try {
    GLib.spawn_command_line_async(cmd);
  } catch {}
}

function Action({ icon, cmd }: { icon: string; cmd: string }) {
  return (
    <button class="action-btn" onClicked={() => shAsync(cmd)}>
      {icon}
    </button>
  );
}

export default function Screencap({ monitor = 0 }: Props) {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

  return (
    <window
      name="screencap"
      application={app}
      monitor={monitor}
      visible={false}
      layer={Astal.Layer.OVERLAY}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | LEFT | RIGHT | BOTTOM}
    >
      <box class="overlay-root" vertical>
        <box halign={2}>
          <button
            class="close-btn"
            onClicked={() => {
              const w = app.get_window("screencap");
              if (w) w.visible = false;
            }}
          >
            
          </button>
        </box>

        <box hexpand vexpand valign={1} halign={1}>
          <box class="panel" spacing={8}>
            <Action
              icon="󰹑"
              cmd={`bash -lc 'grim -g "$(slurp)" /tmp/cap.png'`}
            />
            <Action icon="󰍹" cmd={`bash -lc 'grim /tmp/screen.png'`} />
            <Action
              icon="󰑋"
              cmd={`bash -lc 'wf-recorder -g "$(slurp)" -f /tmp/rec.mp4'`}
            />
            <Action icon="󰑊" cmd={`bash -lc 'pkill -INT wf-recorder'`} />
          </box>
        </box>
      </box>
    </window>
  );
}
