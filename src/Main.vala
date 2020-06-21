/* main.vala
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


namespace Blobify {
    public class BlobifyApp : Gtk.Application {

        public BlobifyApp () {
            Object (
                application_id: "com.felixbrezo.Blobify",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        protected override void activate () {
            Window win = new Window(this);
            win.show_all();
        }

        public static int main (string[] args) {
            var app = new BlobifyApp ();
            return app.run (args);
        }
    }
}
