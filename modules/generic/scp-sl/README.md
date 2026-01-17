SCP:SL Registry Documentation
=============================

Last updated: 2026/1/17

*An unofficial piece of documentation for the registry.txt file used to configure SCP:SL.*

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

* `13UserSettings_5E67_0000`

	Possible values: `string` (must be the name of a language folder in the `Translations` directory)

	Configures which language the game should use.

	Languages are defined in the `Translations` folder.

	On Linux, this folder is located at `/home/user/.local/share/Steam/steamapps/common/SCP Secret Laboratory/Translations`.

	Corresponds to **Settings / Interface / Interface Language**.
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

### Server Settings

The format for server settings is the following:

`07SrvSp_ID_1_SETTING::-%(|::value`

* `ID` is a numerical server ID. (This ID can be found in the `history.txt` file)
* `SETTING` is a number representing the server-specific setting.

#### Settings

Here is a list of settings on some servers:

##### Candy Cult

The ID of this server is `93013`.

* `07SrvSp_93013_1_12051`:

	Possible values: ASCII code

	Default value: `122` ("z")

	The keybind for opening a candy bag.

	Corresponds to **Settings / Server-specific / The key to Player open candy bag**.
* `07SrvSp_93013_1_12052`:

	Possible values: ASCII code

	Default value: `101` ("e")

	The keybind to interact (pick up candy bags and coins) as an SCP.

	Corresponds to **Settings / Server-specific / The key to SCP pick up candy & coin**.
* `07SrvSp_93013_1_12053`:

	Possible values: ASCII code

	Default value: `120` ("x")

	The keybind for equipping a coin.

	Corresponds to **Settings / Server-specific / The key to Player equip coin**.
* `07SrvSp_93013_1_12054`:

	Possible values: ASCII code

	Default value: `104` ("h")

	The keybind for equipping a random item as an SCP.

	Corresponds to **Settings / Server-specific / The key to SCP equip random item**.
