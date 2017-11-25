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
   Streak.MainWindow window = null;

  public class StreakApp : Granite.Application {
    construct {
      application_id = "com.github.dbhowell.streak";
      flags = ApplicationFlags.FLAGS_NONE;

      Intl.setlocale (LocaleCategory.ALL, "");

      program_name = _("Streak");
      app_launcher = "com.github.dbhowell.streak.desktop";

      SimpleAction quit_action = new SimpleAction ("quit", null);
      quit_action.activate.connect (() => {
        if (window != null) {
          window.destroy ();
        }
      });

      add_action (quit_action);
      add_accelerator ("<Control>q", "app.quit", null);
    }

    public override void activate () {
        window = new Streak.MainWindow ();
        this.add_window (window);
    }
  }

  public static int main (string[] args) {
      var application = new StreakApp ();
      return application.run (args);
  }
}
