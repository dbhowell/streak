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
