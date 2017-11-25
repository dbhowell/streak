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
  public class Services.StripeAccount: GLib.Object {
    public signal void response (StripeObject history);
    public signal void error (StripeError error);

    private Soup.Session session;
    private string base_uri = "https://api.stripe.com/v1/";
    public string api_key { get; set; default = ""; }
    public bool working { get; set; default = false; }

    public StripeAccount () {
      setup_session ();
    }

    public StripeAccount.with_api_key (string api_key) {
      setup_session ();

      this.api_key = api_key;
    }

    private void setup_session () {
      session = new Soup.Session ();

      session.authenticate.connect ((message, auth, retrying) => {
        if (!retrying) {
          auth.authenticate (this.api_key, "");
        }
      });
    }

    public void balance_history (StripeObject? starting_after, int limit = 10) {
      working = true;
      string uri = @"$(base_uri)balance/history?limit=$(limit)";

      if (starting_after != null) {
        uri = uri + @"&starting_after=$(starting_after.id)";
      }

      Soup.Message msg = new Soup.Message ("GET", uri);
      session.queue_message (msg, message_response); 
    }

    private void message_response (Soup.Session sess, Soup.Message message) {
      Json.Parser parser = new Json.Parser ();
      string body = (string)message.response_body.flatten ().data;

      if ((message.status_code >= 200 && message.status_code < 300) ||
         (message.status_code >= 400 && message.status_code < 500)) {
        parser.load_from_data (body, -1);
      }

      working = false;
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
