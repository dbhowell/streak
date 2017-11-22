namespace Streak {
  public class Settings : Granite.Services.Settings {
    private static Settings? instance = null;

    public string api_key { get; set; }

    public static Settings get_instance () {
      if (instance == null) {
        instance = new Settings ();
      }

      return instance;
    }

    private Settings () {
      base ("com.github.dbhowell.streak");
    }
  }
}