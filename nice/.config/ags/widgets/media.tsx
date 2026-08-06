import app from "ags/gtk4/app";
import { Astal } from "ags/gtk4";

type Props = { monitor?: number };

export default function Media({ monitor = 0 }: Props) {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

  return (
    <window
      name="media"
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
              const w = app.get_window("media");
              if (w) w.visible = false;
            }}
          >
            
          </button>
        </box>

        <box hexpand vexpand valign={1} halign={1}>
          <label class="panel-title" label="Media (MPRIS here)" />
        </box>
      </box>
    </window>
  );
}
