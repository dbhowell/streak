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
  public class StripeObject : Object {
    public string object_type { get; set; }
    public string id { get; set; }
    
    public StripeObject.with_object (Json.Object obj) {
      object_type = obj.get_string_member ("object");

      if (obj.has_member ("id")) {
        id = obj.get_string_member ("id");
      }
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

      return item;
    }
  }
}