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

using AppUtils;

namespace AppWidgets {
    public class TextDialog : Granite.MessageDialog {
        private Gtk.Entry category_entry;
        private Gtk.TextView payload_textview;

        public TextDialog (Gtk.Window parent) {

            Object (
                primary_text: "Create your own payload",
                secondary_text: "Select the application type and the text data to build the payload",
                buttons: Gtk.ButtonsType.CANCEL,
                transient_for: parent
            );
        }

        construct {
            this.title = ("From source…");
            this.image_icon = GLib.Icon.new_for_string ("text-x-source");

            var suggested_button = new Gtk.Button.with_label ("Build");
            suggested_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            suggested_button.set_sensitive (false);
            this.add_action_widget (suggested_button, Gtk.ResponseType.ACCEPT);

            var dialog_grid = new Gtk.Grid ();

            // Define objects
            var category_label = new Gtk.Label ("Category: ");
            category_label.halign = Gtk.Align.END;
            category_entry = new Gtk.Entry ();
            category_entry.set_placeholder_text ("text/plain");

            var payload_label = new Gtk.Label ("Text to encode: ");
            payload_label.halign = Gtk.Align.END;
            payload_textview = new Gtk.TextView ();
            payload_textview.monospace = true;
            payload_textview.editable = true;
            payload_textview.wrap_mode = Gtk.WrapMode.CHAR;
            payload_textview.pixels_below_lines = 3;
            payload_textview.border_width = 12;
            payload_textview.get_style_context ().add_class (Granite.STYLE_CLASS_TERMINAL);

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.set_size_request (300, 200);
            scrolled.add (payload_textview);

            // Change events added
            category_entry.changed.connect ( () => {
                category_entry.set_text (category_entry.get_text ().down ());
                if (category_entry.get_text () != null && payload_textview.get_buffer () != null) {
                    suggested_button.set_sensitive (true);
                } else {
                    suggested_button.set_sensitive (false);
                }
            });
            payload_textview.focus_out_event.connect ( () => {
                if (category_entry.get_text () != null && payload_textview.get_buffer () != null) {
                    suggested_button.set_sensitive (true);
                } else {
                    suggested_button.set_sensitive (false);
                }
            });

            // Pack grid elements together together
            dialog_grid.column_spacing = dialog_grid.row_spacing = 12;
            dialog_grid.margin_top = dialog_grid.margin_bottom = 12;
            dialog_grid.halign = dialog_grid.valign = Gtk.Align.CENTER;

            dialog_grid.attach (category_label, 0, 0);
            dialog_grid.attach (category_entry, 1, 0);
            dialog_grid.attach (payload_label, 0, 1);
            dialog_grid.attach (scrolled, 0, 2, 2);

            this.custom_bin.add (dialog_grid);
            this.show_all ();
        }

        public string? get_data_uri_from_text () {
            if (this.run () == Gtk.ResponseType.ACCEPT) {
                return URIGenerator.build_from_string (
                    this.payload_textview.get_buffer ().text,
                    this.category_entry.get_text()
                );
            }

            return null;
        }
    }
}


