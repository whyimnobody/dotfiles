import app from "ags/gtk4/app";

app.start({
  main() {
    return (
      <window visible>
        <label label="AGS is running" />
      </window>
    );
  },
});
