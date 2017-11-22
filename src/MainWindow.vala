using Streak.Services;

namespace Streak {
    public class MainWindow : Gtk.Window {
        private Streak.HeaderBar headerbar;
        private StripeAccount account = new StripeAccount ();

        public MainWindow () {
            get_style_context ().add_class ("rounded");
            window_position = Gtk.WindowPosition.CENTER;
            
            set_default_size (800, 600);

            build_ui ();
        }

        private void build_ui () {
            headerbar = new Streak.HeaderBar ();
            set_titlebar (headerbar);
         
            show_all ();
        }
    }
}
