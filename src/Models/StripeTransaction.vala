
namespace Streak {
  public class StripeTransaction: StripeObject {
    public string id { get; set; }
    public int64 amount { get; set; }
    public string status { get; set; }
    public int64 fee { get; set; }
    public string description { get; set; }
    public string currency { get; set; }
    public string transaction_type { get; set; }
    public DateTime created { get; set; }
    public DateTime available_on { get; set; }
    public string source { get; set; }

    public StripeTransaction () {

    }

    public StripeTransaction.with_object (Json.Object obj) {
      base.with_object (obj);

      id = obj.get_string_member ("id");
      amount = obj.get_int_member ("amount");
      status = obj.get_string_member ("status");
      fee = obj.get_int_member ("fee");
      description = obj.get_string_member ("description");
      currency = obj.get_string_member ("currency");
      transaction_type = obj.get_string_member ("type");
      created = new DateTime.from_unix_utc (obj.get_int_member ("created"));
      available_on = new DateTime.from_unix_utc (obj.get_int_member ("available_on"));
      source = obj.get_string_member ("source");

      if (description == null) {
        if (source != null) {
          description = source;
        } else {
          description = "";
        }       
      }
    }
  }
}
