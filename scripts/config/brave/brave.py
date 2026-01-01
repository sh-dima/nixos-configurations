#!/usr/bin/env python3
import os
import json

path = "/home/dima/.config/BraveSoftware/Brave-Browser/Default/Preferences"
backup = "/home/dima/.config/BraveSoftware/Brave-Browser/Default/Preferences.bak"

if not os.path.exists(path):
	exit(0)

with open(path) as file:
	configuration = file.read()

with open(backup, "w") as file:
	file.write(configuration)

dictionary = json.loads(configuration)

dictionary["brave"]["ai_chat"]["show_toolbar_button"] = False

dictionary["brave"]["branded_wallpaper_notification_dismissed"] = True
dictionary["brave"]["brave_ads"]["should_allow_ads_subdivision_targeting"] = False

dictionary["brave"]["enable_window_closing_confirm"] = False
dictionary["brave"]["has_seen_brave_welcome_page"] = True

dictionary["brave"]["new_tab_page"]["show_brave_news"] = False
dictionary["brave"]["new_tab_page"]["show_branded_background_image"] = False
dictionary["brave"]["new_tab_page"]["show_rewards"] = False
dictionary["brave"]["new_tab_page"]["show_together"] = False

dictionary["brave"]["new_tab_page"]["background"]["random"] = False
dictionary["brave"]["new_tab_page"]["background"]["type"] = "color"
dictionary["brave"]["new_tab_page"]["background"]["selected_value"] = "#000000"

dictionary["brave"]["rewards"]["show_brave_rewards_button_in_location_bar"] = False
dictionary["brave"]["wallet"]["show_wallet_icon_on_toolbar"] = False

dictionary["brave"]["today"]["opted_in"] = False

serialized = json.dumps(
	dictionary,
	indent="\t",
	ensure_ascii=False,
	sort_keys=True,
)

with open(path, "w", encoding='utf-8') as file:
	file.write(serialized)
