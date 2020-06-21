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
    public class ResultsView : Gtk.Frame {
        private Gtk.Grid main_grid;
        private Gtk.Label title_label;
        public Gtk.Button copy_btn;
        private Gtk.TextView data_uri_view;

        public ResultsView () {
            // Objects
            this.title_label = new Gtk.Label ("Generated Data URI");
            this.title_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

            this.copy_btn = new Gtk.Button.with_label ("Copy to clipboard");
            this.copy_btn.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);

            this.data_uri_view = new Gtk.TextView ();
            this.data_uri_view.monospace = true;
            this.data_uri_view.editable = false;
            this.data_uri_view.wrap_mode = Gtk.WrapMode.CHAR;
            this.data_uri_view.pixels_below_lines = 3;
            this.data_uri_view.border_width = 12;
            this.data_uri_view.get_style_context ().add_class (Granite.STYLE_CLASS_TERMINAL);

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.set_size_request (600, 400);
            scrolled.add (this.data_uri_view);

            // Create the main_grid
            this.main_grid = new Gtk.Grid ();

            this.main_grid.margin_top = this.main_grid.margin_bottom = 12;
            this.main_grid.column_spacing = this.main_grid.row_spacing = 12;
            this.main_grid.halign = this.main_grid.valign = Gtk.Align.CENTER;

            this.main_grid.attach (this.title_label, 1, 0, 1);
            this.main_grid.attach (scrolled, 0, 1, 3);
            this.main_grid.attach (this.copy_btn, 1, 2, 1);

            this.add (this.main_grid);
            this.show_all ();
        }

        public void set_data_uri_view (string data_uri) {
            this.data_uri_view.buffer.text = data_uri;
        }

        public string get_data_uri_view () {
            return this.data_uri_view.buffer.text;
        }
    }
}

