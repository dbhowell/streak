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

using Streak.Services;

namespace Streak {
    public class MainWindow : Gtk.Window {
        private Streak.Settings settings = Streak.Settings.get_instance ();
        private StripeAccount account;
        private Streak.HeaderBar headerbar = new Streak.HeaderBar ();
        private WelcomeView welcome = new WelcomeView ();
        private TransactionsTreeView transactions = new TransactionsTreeView ();

        public MainWindow () {
            get_style_context ().add_class ("rounded");
            window_position = Gtk.WindowPosition.CENTER;
            
            set_default_size (800, 600);

            build_services ();
            build_ui ();
            setup_signals ();

            show_all ();
        }

        private void build_services () {
            account = new StripeAccount.with_api_key (settings.api_key);
        }

        private void setup_signals () {
            headerbar.preferences.connect(on_preferences);

            settings.changed.connect (on_settings_changed);

            account.response.connect(stripe_response);
            account.error.connect(stripe_error);

            show.connect(window_show);
        }

        private void build_ui () {
            set_titlebar (headerbar);

            var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.expand = true;
    
            if (settings.api_key != "") {
                scrolled.add (transactions);
            } else {
                scrolled.add (welcome);
            }

            add (scrolled);
        }

        private void on_settings_changed () {
            account.api_key = settings.api_key;
            transactions.clear ();
            fetch_balance_history (null);
        }

        private void on_preferences () {
            var dialog = new Dialogs.Preferences (this);
            dialog.show_all ();
        }

        private void window_show () {
            fetch_balance_history (null);
        }

        private void stripe_error (StripeError err) {
            headerbar.working = false;
        }

        private void stripe_response (StripeObject obj) {
            if (obj.object_type == "list") {
                StripeList list = (StripeList)obj;
                transactions.append (list);

                if (list.has_more) {
                    fetch_balance_history (list.data.get(list.data.size - 1));
                } else {
                    headerbar.working = false;
                }
            } else {
                headerbar.working = false;
            }
        }

        private void fetch_balance_history (StripeObject? starting_after = null) {
            headerbar.working = true;
            account.balance_history (starting_after);
        }
    }
}
