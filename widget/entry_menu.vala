using Gtk;
using Utils;

namespace Widgets {
    public class EntryMenu : Object {
        public Menu.Menu menu;
        
        public EntryMenu() {
            Intl.bindtextdomain(GETTEXT_PACKAGE, "/usr/share/locale");
        }

        public void create_entry_menu(Gtk.Entry entry, int x, int y) {
            var menu_content = new List<Menu.MenuItem>();
            if (is_selection(entry)) {
                menu_content.append(new Menu.MenuItem("cut", _("Cut")));
                menu_content.append(new Menu.MenuItem("copy", _("Copy")));
            }
            menu_content.append(new Menu.MenuItem("paste", _("Paste")));
            menu_content.append(new Menu.MenuItem("", ""));
            if (is_selection(entry)) {
                menu_content.append(new Menu.MenuItem("delete", _("Delete")));
                menu_content.append(new Menu.MenuItem("", ""));
            }
            menu_content.append(new Menu.MenuItem("select_all", _("Select all")));
                        
            menu = new Menu.Menu(x, y, menu_content);
            menu.click_item.connect((item_id) => {
                    handle_menu_item_click(entry, item_id);
                });
            menu.destroy.connect(handle_menu_destroy);
        }

        public void handle_menu_item_click(Gtk.Entry entry, string item_id) {
            switch(item_id) {
                case "cut":
                    entry.cut_clipboard();
                    break;
                case "copy":
                    entry.copy_clipboard();
                    break;
                case "paste":
                    entry.paste_clipboard();
                    break;
                case "delete":
                    entry.delete_selection();
                    break;
                case "select_all":
                    entry.select_region(0, -1);
                    break;
            }
        }        
            
        public bool is_selection(Gtk.Entry entry) {
            int start_pos, end_pos;
            entry.get_selection_bounds(out start_pos, out end_pos);
                
            return start_pos != end_pos;
        }
            
        public void handle_menu_destroy() {
            menu = null;
        }
    }
}