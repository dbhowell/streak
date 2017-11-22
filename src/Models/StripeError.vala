namespace Streak {
  public class StripeError: StripeObject {
    public string error_type { get; set; }
    public string code { get; set; }
    public string message { get; set; }
    
    public StripeError () {

    }

    public StripeError.with_object (Json.Object obj) {
      error_type = obj.get_string_member ("type");
      message = obj.get_string_member ("message");

      if (obj.has_member ("code")) {
        code = obj.get_string_member ("code");
      }

      if (message == null) {
       message = "";
      }      
    }
  }
}