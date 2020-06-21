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

namespace AppUtils {
    public class URIGenerator {
        public static string build_from_data (uint8[] data, string mime_type) {
            return "data:%s;base64,%s".printf (
                mime_type,
                Base64.encode (data)
            );
        }

        public static string build_from_file (string file_name) {
            uint8 [] contents;
            FileUtils.get_data (file_name, out contents);

            return build_from_data (
                contents,
                get_mime_type_from_file_name (file_name)
            );
        }

        public static string build_from_string (string text, string mime_type) {
            return build_from_data (text.data, mime_type);
        }

        public static string build_from_uri (string uri) {
            var session = new Soup.Session ();
            var msg = new Soup.Message ("GET", uri);
            session.send_message (msg);

            return build_from_data (
                msg.response_body.data,
                get_mime_type_from_file_name (uri)
            );
        }

        private static string get_mime_type_from_file_name (string file_name) {
            var structures = file_name.split ("/");
            var parts = structures[structures.length-1].split (".");

            switch (parts[parts.length-1].down ()) {
                case "abw":
                    return "application/x-abiword";

                case "avi":
                    return "video/x-msvideo";

                case "bin":
                    return "application/octet-stream";

                case "bmp":
                    return "image/bmp";

                case "bz":
                    return "application/x-bzip";

                case "bz2":
                    return "application/x-bzip2";

                case "css":
                    return "text/css";

                case "csv":
                    return "text/csv";

                case "doc":
                    return "application/msword";

                case "epub":
                    return "application/epub+zip";

                case "gif":
                    return "image/gif";

                case "htm":
                case "html":
                    return "text/html";

                case "icon":
                    return "image/x-icon";

                case "ics":
                    return "text/calendar";

                case "jar":
                    return "application/java-archive";

                case "jpg":
                case "jpeg":
                    return "image/jpeg";

                case "js":
                    return "application/javascript";

                case "json":
                    return "application/json";

                case "mid":
                case "midi":
                    return "audio/midi";

                case "mp3":
                    return "audio/mp3";

                case "mp4":
                    return "video/mp4";

                case "odp":
                    return "application/vnd.oasias.opendocumen.presentation";

                case "ods":
                    return "application/vnd.oasias.opendocumen.spreadsheet";

                case "odt":
                    return "application/vnd.oasias.opendocumen.text";

                case "mpeg":
                    return "video/mpeg";

                case "oga":
                    return "audio/ogg";

                case "ogv":
                    return "video/ogg";

                case "ogx":
                    return "application/ogg";

                case "pdf":
                    return "application/pdf";

                case "png":
                    return "image/png";

                case "ppt":
                    return "application/vnd.ms-powerpoint";

                case "rar":
                    return "application/x-rar-compressed";

                case "rtf":
                    return "application/rtf";

                case "sh":
                    return "application/x-sh";

                case "svg":
                    return "image/svg+xml";

                case "tar":
                    return "application/x-tar";

                case "tif":
                case "tiff":
                    return "image/tiff";

                case "ttf":
                    return "font/ttf";

                case "txt":
                case "text":
                    return "text/plain";

                case "vsd":
                    return "audio/vnd.visio";

                case "wav":
                    return "audio/x-wav";

                case "weba":
                    return "video/weba";

                case "webm":
                    return "video/webm";

                case "webp":
                    return "image/webp";

                case "xls":
                    return "application/vnd.ms-excel";

                case "xhtml":
                    return "application/xhtml+xml";

                case "xml":
                    return "application/xml";

                case "zip":
                    return "application/zip";

                case "7z":
                    return "application/x-7z-compressed";

                default:
                    return "application/octet-stream";
            }
        }
    }
}


