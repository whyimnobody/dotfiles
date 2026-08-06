import app from "ags/gtk4/app";
import { Astal } from "ags/gtk4";

import Powermenu from "./widgets/powermenu";
import Screencap from "./widgets/screencap";
import Media from "./widgets/media";

app.start({
  // optional but recommended if you ever run multiple instances
  // instanceName: "ags",

  main() {
    // Instantiate windows inside main (recommended; avoids client-mode pitfalls)
    Powermenu({ monitor: 0 });
    Screencap({ monitor: 0 });
    Media({ monitor: 0 });
  },
});
