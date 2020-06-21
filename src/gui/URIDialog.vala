
using AppUtils;

namespace AppWidgets {
    public class URIDialog : Granite.MessageDialog {
        public Gtk.Entry uri_entry;

        public URIDialog (Gtk.Window parent) {
            Object (
                primary_text: "Create payload from a valid HTTP URI",
                secondary_text: "Note that data type will be automatically inferred from the file name",
                buttons: Gtk.ButtonsType.CANCEL,
                transient_for: parent
            );
        }

        construct {
            this.title = ("From an URI…");
            this.image_icon = GLib.Icon.new_for_string ("internet-web-browser");


            var suggested_button = new Gtk.Button.with_label ("Build");
            suggested_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            suggested_button.set_sensitive (false);
            this.add_action_widget (suggested_button, Gtk.ResponseType.ACCEPT);

            var dialog_grid = new Gtk.Grid ();

            // Define objects
            uri_entry = new Gtk.Entry ();
            uri_entry.set_placeholder_text ("https://example.com/icon.png");

            // Change events added
            uri_entry.changed.connect ( () => {
                if (uri_entry.get_text () != null) {
                    suggested_button.set_sensitive (true);
                } else {
                    suggested_button.set_sensitive (false);
                }
            });

            // Pack grid elements together together
            dialog_grid.column_spacing = dialog_grid.row_spacing = 12;
            dialog_grid.halign = dialog_grid.valign = Gtk.Align.CENTER;

            dialog_grid.attach (uri_entry, 0, 1);

            this.custom_bin.add (dialog_grid);
            this.show_all ();
        }
    }
}


