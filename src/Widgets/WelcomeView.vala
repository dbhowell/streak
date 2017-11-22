namespace Streak {
  public class WelcomeView : Granite.Widgets.Welcome {
    public class WelcomeView () {
      base (_("Streak"), _("Analytics for Stripe"));
    
      append ("emblem-web", _("Create a Stripe API key"), _("Create and copy an API key from the Stripe Dashboard."));
      append ("edit-copy", _("Paste API key into Streak"), _("Paste the API key into Streak."));
    }
  }
}