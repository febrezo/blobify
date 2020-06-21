/*
* Copyright (c) 2020 Félix Brezo (https://felixbrezo.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Félix Breo <felixbrezo@disroot.orgm>
*/


namespace AppWidgets {
    public class HeaderBar : Gtk.HeaderBar  {
        public Gtk.Button from_file_btn;
        public Gtk.Button from_uri_btn;
        public Gtk.Button from_source_btn;
        public Gtk.Button settings_menu_btn;
        public SettingsMenu menu;

        public HeaderBar () {
            this.show_close_button = true;
            this.title = "Blobify";
            this.subtitle = "Building 'data:' URIs in seconds";

            // Set Menu
            // --------
            this.menu = new SettingsMenu ();

            // Add menu buttons
            // ----------------

            // New button
            from_file_btn = new Gtk.Button.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR);
            from_file_btn.tooltip_text = "From a file…";
            this.pack_start (from_file_btn);

            // Open button
            from_uri_btn = new Gtk.Button.from_icon_name ("internet-web-browser", Gtk.IconSize.LARGE_TOOLBAR);
            from_uri_btn.tooltip_text = "From an URI…";
            this.pack_start (from_uri_btn);

            // Save button
            from_source_btn = new Gtk.Button.from_icon_name ("text-x-source", Gtk.IconSize.LARGE_TOOLBAR);
            from_source_btn.tooltip_text = "From text…";
            this.pack_start (from_source_btn);

            // Menu button
            settings_menu_btn = new Gtk.Button.from_icon_name ("open-menu-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
            settings_menu_btn.tooltip_text = "Preferences";

            this.pack_end (settings_menu_btn);
        }
    }
}


