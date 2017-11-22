namespace Streak {
    public class MainWindow : Gtk.Window {

        public MainWindow () {
            get_style_context ().add_class ("rounded");
            window_position = Gtk.WindowPosition.CENTER;
            
            set_default_size (800, 600);

            build_ui ();
        }

        private void build_ui () {            
            show_all ();
        }
    }
}
