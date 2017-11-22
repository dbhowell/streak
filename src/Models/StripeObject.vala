namespace Streak {
  public class StripeObject : Object {
    public string object_type { get; set; }
  
    public StripeObject () {

    }

    public StripeObject.with_object (Json.Object obj) {
      object_type = obj.get_string_member ("object");
    }

    public static StripeObject parse (Json.Object obj) {
      string object_type = obj.get_string_member ("object");
      
      StripeObject item = null;

      switch (object_type) {
        case "list":
          item = new StripeList.with_object (obj);
          break;
        case "balance_transaction":
          item = new StripeTransaction.with_object (obj);
          break;
        default:
          item = null;
          break;
      }

      if (item != null) {
        item.object_type = object_type;
      }

      return item;
    }
  }
}