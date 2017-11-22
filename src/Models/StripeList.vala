using Gee;

namespace Streak {
  public class StripeList : StripeObject {
    public bool has_more { get; set; }
    public string url { get; set; }
    public ArrayList<StripeObject> data { get; set; }
  
    public StripeList () {
      data = new Gee.ArrayList<StripeObject>();
    }

    public StripeList.with_object (Json.Object obj) {
      base.with_object (obj);

      has_more = obj.get_boolean_member ("has_more");
      url = obj.get_string_member ("url");

      var obj_data = obj.get_array_member ("data");

      foreach (unowned Json.Node item in obj_data.get_elements ()) {
        data.add (StripeObject.parse (item.get_object ()));
      }
    }
  }
}