namespace Streak {
   Streak.MainWindow window = null;

  public class StreakApp : Granite.Application {
    construct {
      application_id = "com.github.dbhowell.streak";
      flags = ApplicationFlags.FLAGS_NONE;

      Intl.setlocale (LocaleCategory.ALL, "");

      program_name = _("Streak");
      app_years = "2017";
      app_icon = "accessories-business";
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
