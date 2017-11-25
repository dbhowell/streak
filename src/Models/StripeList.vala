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
 
using Gee;

namespace Streak {
  public class StripeList : StripeObject {
    public bool has_more { get; set; }
    public string url { get; set; }
    public ArrayList<StripeObject> data { get; set; default=new Gee.ArrayList<StripeObject>(); }

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