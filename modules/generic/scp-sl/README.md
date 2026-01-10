SCP:SL Registry Documentation
=============================

Last updated: 2026/1/10

*An unnoficial piece of documentation for the registry.txt file used to configure SCP:SL.*

Editing
-------

Make sure SCP:SL is closed if you want to edit these settings directly. Otherwise, your changes will be undone.

Location
--------

* On Linux: `/home/user/.local/share/Steam/steamapps/compatdata/700330/pfx/drive_c/users/steamuser/AppData/Roaming/SCP Secret Laboratory/registry.txt`

Structure
---------

The `registry.txt` contains key-value pairs. The format is:

```
key1::-%(|::value1
key2::-%(|::value2
key3::-%(|::value3
```

The separator is the string `::-%(|::`. Empty lines are ignored.

Keys/Values
-----------

Here is a list of key-value pairs and their meanings:

* `00UserSettings_5E67_3000`

	Possible values: boolean (`true` - fast or `false` - regular)

	Configures the duration of the role title and information when spawning in.

	Corresponds to **Settings / Interface / Role Intro Animation**.
* `00UserSettings_5E67_6000`

	Possible values: boolean (`true` - disabled or `false` - enabled)

	Whether to show a photosensitivity warning on game startup.

	Corresponds to **Settings / Interface / Photosensitivity Warning on Startup**.
* `00UserSettings_B226_3000`

	Possible values: boolean (`true` - hide or `false` - show)

	Whether players can view your Steam profile from the in-game player list.

	Corresponds to **Settings / Other / Profile on Player List**.

### Attachments

The attachments for your guns are also stored in `registry.txt`. The format is:

`0XYZ_AttachmentsSetupPreference_N::-%(|::number`

* `XYZ` is a three-digit number corresponding to the gun that the attachments belong to.
* `N` is a number 0-3 corresponding to the preset that the attachment data belongs to.
* The `number` at the end contains the data of the attachment setup.

### Attachment Presets

The format for attachment preset data is:

`07Preset_XY::-%(|::N`

* `XY` is a two-digit number corresponding to the gun that the preset belongs to.
* `N` is a number 0-3 corresponding to the preset that is currently selected. `N=0` means the preset is custom and not saved.
