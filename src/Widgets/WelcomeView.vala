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
  public class WelcomeView : Granite.Widgets.Welcome {
    public signal void preferences ();

    public class WelcomeView () {
      base (_("Streak"), _("Analytics for Stripe"));
    
      append ("emblem-web", _("Create a Stripe API key"), _("Create and copy an API key from the Stripe Dashboard."));
      append ("edit-copy", _("Paste API key into Streak"), _("Paste the API key into Streak."));

      activated.connect(on_activated);
    }

    private void on_activated (int index) {
      switch (index) {
        case 0:
          launch_api_url ();
          break;
        default:
          preferences();
          break;
      }
    }

    private void launch_api_url () {
      try {
          AppInfo.launch_default_for_uri ("https://dashboard.stripe.com/account/apikeys", null);
      } catch (Error e) {
          warning ("%s\n", e.message);
      }
    }
  }
}