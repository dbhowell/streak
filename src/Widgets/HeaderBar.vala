/*-
 * Copyright (c) 2017 David Howell (https://github.com/dbhowell/streak)
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
 *
 * Authored by: David Howell <davidh@dynamicmethds.com.au>
 */
 
namespace Streak {
  public class HeaderBar : Gtk.HeaderBar {
    private Gtk.Spinner spinner;
    private Gtk.MenuItem preferences_menuitem;
    private Gtk.MenuItem refresh_menuitem;

    public signal void refresh ();
    public signal void preferences ();

    public bool working {
        set {
            if (value) {
                spinner.start ();
            } else {
                spinner.stop ();
            }
        }
    }

    public HeaderBar () {
      Object (
        title: _("Streak"),
        has_subtitle: false,
        show_close_button: true
      );
    }

    construct {
        preferences_menuitem = new Gtk.MenuItem.with_label (_("Preferences"));
        preferences_menuitem.activate.connect (() => {
            preferences ();
        });

        refresh_menuitem = new Gtk.MenuItem.with_label (_("Refresh"));
        refresh_menuitem.activate.connect (() => {
            refresh ();
        });

        var menu = new Gtk.Menu ();
        menu.add (refresh_menuitem);        
        menu.add (new Gtk.SeparatorMenuItem ());
        menu.add (preferences_menuitem);
        menu.show_all ();

        var app_menu = new Gtk.MenuButton ();
        app_menu.image = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
        app_menu.tooltip_text = _("Menu");
        app_menu.popup = menu;

        spinner = new Gtk.Spinner ();
        
        pack_end (app_menu);
        pack_end (spinner);

        show_all ();   
    }
  }
}
