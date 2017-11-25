namespace Streak.Dialogs {
  public class Preferences : Gtk.Dialog {
    private Gtk.Entry api_key_entry = new Gtk.Entry ();
    private Streak.Settings settings = Streak.Settings.get_instance ();

    public Preferences (Gtk.Window parent) {
      set_title (_("Preferences"));
      set_size_request (640, -1);
      set_transient_for (parent);
      set_modal (true);

      get_content_area ().margin = 12;

      set_default_response(Gtk.ResponseType.OK);

      build_ui ();
    }

    private void build_ui () {
      Gtk.Label api_key_label = new Gtk.Label.with_mnemonic ("_API Key:");
      api_key_label.mnemonic_widget = this.api_key_entry;

      api_key_entry.set_text (settings.api_key);

      Gtk.Box hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 20);
      hbox.pack_start (api_key_label, false, true, 0);
      hbox.pack_start (this.api_key_entry, true, true, 0);

      Gtk.Box content = get_content_area () as Gtk.Box;
      content.pack_start (hbox, false, true, 0);
      content.spacing = 10;

      add_button(_("_Close"), Gtk.ResponseType.CLOSE);
      add_button(_("_OK"), Gtk.ResponseType.OK);

      this.response.connect (on_response);
      
      show_all ();
    }

    private void on_response (Gtk.Dialog source, int response_id) {
      switch (response_id) {
      case Gtk.ResponseType.OK:
        settings.api_key = api_key_entry.get_text ();
        destroy ();
        break;
      case Gtk.ResponseType.CLOSE:
        destroy ();
        break;
      }
    }
  }
}