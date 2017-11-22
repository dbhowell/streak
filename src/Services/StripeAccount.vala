namespace Streak {
  public class Services.StripeAccount: GLib.Object {
    public signal void response (StripeObject history);
    public signal void error (StripeError error);

    private string base_uri = "https://api.stripe.com/v1/";
    private Soup.Session session;
    private string api_key { get; set; default = ""; }

    public StripeAccount () {
      session = new Soup.Session ();

      session.authenticate.connect ((message, auth, retrying) => {
        if (!retrying) {
          auth.authenticate (this.api_key, "");
        }
      });
    }

    public StripeAccount.with_api_key (string api_key) {
      this.api_key = api_key;
      base ();
    }

    public void balance_history (string? starting_after, int limit = 10) {
      string uri = @"$(base_uri)balance/history?limit=$(limit)";

      if (starting_after != null) {
        uri = uri + @"&starting_after=$(starting_after)";
      }

      Soup.Message msg = new Soup.Message ("GET", uri);
      session.queue_message (msg, message_response); 
    }

    private void message_response (Soup.Session session, Soup.Message message) {
      Json.Parser parser = new Json.Parser ();
      string body = (string)message.response_body.flatten ().data;

      if ((message.status_code >= 200 && message.status_code < 300) ||
         (message.status_code >= 400 && message.status_code < 500)) {
        parser.load_from_data (body, -1);
      }

      if (message.status_code >= 200 && message.status_code < 300) {
        StripeObject obj = StripeObject.parse (parser.get_root ().get_object ());
        
        response (obj);
        return;
      }

      if (message.status_code >= 400 && message.status_code < 500) {
        StripeError err = new StripeError.with_object (parser.get_root ().get_object ().get_object_member ("error"));

        error (err);
        return;
      }
    }
  }
}
