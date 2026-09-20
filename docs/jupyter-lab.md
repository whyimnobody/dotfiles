# JupyterLab on Asura

JupyterLab runs as a user service, bound to `127.0.0.1:8888`. Caddy serves it
on the tailnet as `http://jupyter.test` (same pattern as `email.test`). It is
not a public site.

The notebook root is `~/study` (override with `JUPYTER_LAB_ROOT`).

## Token (before starting the service)

Jupyter’s own login. Anyone who can open `http://jupyter.test` can run code as
this user, so the token is not optional in this setup.

1. Generate a long random password in 1Password.
2. On Asura:

```sh
mkdir -p ~/.local/state/jupyter
chmod 700 ~/.local/state/jupyter
printf '%s' 'PASTE_TOKEN_HERE' > ~/.local/state/jupyter/token
chmod 600 ~/.local/state/jupyter/token
```

The file is one line, no quotes, no trailing spaces. It is not in git.

3. Then start the service:

```sh
systemctl --user daemon-reload
systemctl --user enable --now jupyter-lab.service
```

Without that file the unit will not start (`ConditionPathExists`).

Open `http://jupyter.test` on Marceline (or `http://127.0.0.1:8888` on Asura)
and paste the same token when Jupyter asks.

`allow_remote_access` is on so Jupyter accepts `Host: jupyter.test` from Caddy.
The process still listens only on loopback.

To rotate: overwrite the file, then `systemctl --user restart jupyter-lab.service`.

## Study kernel and Typst

Notebooks live in `~/study`. That tree is the studying home (courses, Typst,
Google Calendar/Tasks via `gws`). Use the **Python — Study** kernel (the uv
venv), not system `Python 3`. That kernel auto-loads `%%typst`. The handbook
is `~/study/README.md`.
