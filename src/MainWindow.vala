using Streak.Services;

namespace Streak {
    public class MainWindow : Gtk.Window {
        private Streak.Settings settings;
        private StripeAccount account;
        private Streak.HeaderBar headerbar;
        private WelcomeView welcome;
        private TransactionsTreeView transactions;

        public MainWindow () {
            get_style_context ().add_class ("rounded");
            window_position = Gtk.WindowPosition.CENTER;
            
            set_default_size (800, 600);

            settings = Streak.Settings.get_instance ();
            account = new StripeAccount.with_api_key (settings.api_key);

            build_ui ();
        }

        private void build_ui () {
            headerbar = new Streak.HeaderBar ();
            set_titlebar (headerbar);
         
            if (settings.api_key != "") {
                transactions = new TransactionsTreeView ();

                account.response.connect ((obj) => {
                    if (obj.object_type == "list") {
                        transactions.append ((StripeList)obj);
                    }
                    headerbar.working = false;
                });

                add (transactions);
            } else {
                welcome = new WelcomeView ();
                add (welcome);
            }
    
            show_all ();
            headerbar.working = true;
            account.balance_history (null);
        }
    }
}
