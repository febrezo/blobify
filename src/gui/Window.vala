/* window.vala
 *
 * Copyright 2020 febrezo
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using AppUtils;
using AppWidgets;

namespace Blobify {
    public class Window : Gtk.ApplicationWindow {
        private Granite.Widgets.Toast toast;
        private HeaderBar header_bar;

        private WelcomeView welcome_view;
        private ResultsView results_view;
        private Gtk.Overlay overlay_panel;

        public Window (Gtk.Application app) {
            Object (application: app);
        }

        construct {
            this.toast = new Granite.Widgets.Toast ("Blobify");

            this.default_height = 480;
            this.default_width = 640;
            this.resizable = false;

            // Build the header bar
            this.header_bar = new HeaderBar ();
            this.header_bar.from_file_btn.clicked.connect (on_from_file_clicked);
            this.header_bar.from_uri_btn.clicked.connect (on_from_url_clicked);
            this.header_bar.from_source_btn.clicked.connect (on_from_source_clicked);
            this.header_bar.settings_menu_btn.clicked.connect (on_menu_clicked);
            this.set_titlebar (header_bar);


            this.results_view = new ResultsView ();
            this.results_view.copy_btn.clicked.connect (() => {
                this.set_clipboard_text (this.results_view.get_data_uri_view ());
            });

            // Create overlay
            /*this.overlay_panel = new Gtk.Overlay ();
            this.overlay_panel.add_overlay (this.results_view);
            this.overlay_panel.add_overlay (this.toast);*/

            this.welcome_view = new WelcomeView ();
            this.welcome_view.activated.connect ((index) => {
                switch (index) {
                    case 0:
                        this.on_from_file_clicked ();
                        break;
                    case 1:
                        this.on_from_url_clicked ();
                        break;
                    case 2:
                        this.on_from_source_clicked ();
                        break;
                }
            });
            this.add (welcome_view);
            this.show_all ();
        }

        private void on_from_file_clicked () {
            var dialog = new Gtk.FileChooserDialog (
                "Open local file", // Title
                this, // Parent Window
                Gtk.FileChooserAction.OPEN, // Action: OPEN, SAVE, CREATE_FOLDER, SELECT_FOLDER
                "Cancel",
                Gtk.ResponseType.CANCEL,
                "Open",
                Gtk.ResponseType.ACCEPT
            );

            var res = dialog.run ();

            if (res == Gtk.ResponseType.ACCEPT) {
                var path = dialog.get_filename ();

                // Process the file
                try {
                    var result = URIGenerator.build_from_file (path);
                    this.results_view.set_data_uri_view (result);
                    this.set_clipboard_text (result);
                    this.remove (this.welcome_view);
                    //this.add (this.overlay_panel);
                    this.add (this.results_view);
                    this.show_toast ("URI copied to the clipboard");
                } catch (Error e) {
                    this.show_toast ("Something happened when reading the file.");
                }
            }
            dialog.close ();
        }

        private void on_from_url_clicked () {
            var dialog = new URIDialog (this);

            var res = dialog.run ();

            if (res == Gtk.ResponseType.ACCEPT) {
                var path = dialog.uri_entry.get_text ();

                try {
                    var result = URIGenerator.build_from_uri (path);
                    this.results_view.set_data_uri_view (result);
                    this.set_clipboard_text (result);
                    this.remove (this.welcome_view);
                    //this.add (this.overlay_panel);
                    this.add (this.results_view);
                    this.show_toast ("URI copied to the clipboard");
                } catch (Error e) {
                    this.show_toast ("Something happened when reading the file.");
                }
            }
            dialog.close ();
        }

        private void on_from_source_clicked () {
            var dialog = new TextDialog (this);
            var result = dialog.get_data_uri_from_text ();

            if (result != null) {
                this.results_view.set_data_uri_view (result);
                this.set_clipboard_text (result);
                this.remove (this.welcome_view);
                //this.add (this.overlay_panel);
                this.add (this.results_view);
                this.show_toast ("URI copied to the clipboard");
            }
            dialog.destroy ();
        }

        private void on_menu_clicked (Gtk.Button sender) {
            this.header_bar.menu.set_relative_to (sender);
            this.header_bar.menu.show_all ();
        }

        private void show_toast (string message) {
            this.toast.title = message;
            this.toast.send_notification ();
        }

        public void set_clipboard_text (string text) {
            var clipboard = Gtk.Clipboard.get_for_display (
                Gdk.Display.get_default (),
                Gdk.SELECTION_CLIPBOARD
            );
            clipboard.set_text (text, text.length);
            this.show_toast ("URI copied to the clipboard!");
        }
    }
}
