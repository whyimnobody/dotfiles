# OpenRGB — Corsair Dominator DRAM

Asura’s Dominator sticks are SMBus RGB, not USB. There is no Corsair HID
device. liquidctl already owns the NZXT Kraken and the board Aura headers;
OpenRGB should only drive the DIMMs.

SMBus `i2c-3` (`SMBus I801 adapter`) has SPD at `0x50`/`0x52` and likely RGB
controllers at `0x18`/`0x1a`. Do not `i2cdetect` that bus for fun — a full
probe can knock the SPD EEPROMs offline for a while.

## What the repo installs

- Package `openrgb` (Arch extra) plus existing `i2c-tools`
- `i2c-dev` at boot via `/etc/modules-load.d/i2c-dev.conf`
- Membership in group `i2c` (re-login after `arch.sh`)
- User unit `openrgb-dram.service`, which applies
  `~/.config/OpenRGB/profiles/dram.json` when that file exists and otherwise
  no-ops

OpenRGB’s own udev rules ship with the package. `i2c-i801` is already loaded
on this board.

## First-time profile (once, on Asura)

```sh
sudo pacman -S --needed openrgb
sudo gpasswd -a "$USER" i2c
```

Log out of the graphical session and back in (or reboot) so `i2c` group and
udev apply. Then:

```sh
openrgb
```

Confirm the Dominator modules appear. In **Settings → Supported Devices**,
disable **ASUS Aura** and **NZXT / Kraken** so OpenRGB does not fight
liquidctl. Set the RAM colours, save a profile named **dram**
(`~/.config/OpenRGB/profiles/dram.json`). OpenRGB 1.0 stores profiles in the
`profiles/` subdirectory as JSON.

```sh
systemctl --user enable --now openrgb-dram.service
systemctl --user start openrgb-dram.service
```

## If the DIMMs do not show up

`spd5118` claiming `0x50`/`0x52` (`UU` in `i2cdetect`) is a known OpenRGB
conflict for some DDR5 kits. RGB on this machine was at `0x18`/`0x1a`, so
leave `spd5118` loaded unless detection actually fails. Only then:

```sh
sudo rmmod spd5118
```

If that is required permanently, blacklist it; it only provides DIMM
temperature sensors.

Gigabyte `acpi_enforce_resources=lax` is not relevant on this ASUS board.

## Do not

- Run OpenRGB as root
- Point OpenRGB at the Kraken LCD (that is `kraken-lcd.service`)
- Add a suspend-on-idle path to make the lights “go to sleep”
