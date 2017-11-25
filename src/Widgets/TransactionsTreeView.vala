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
  public class TransactionsTreeView : Gtk.TreeView {
    private Gtk.TreeIter iter;
    private Gtk.ListStore store;

    public TransactionsTreeView () {
      create_store ();

      set_model (store);
      create_columns ();
    }

    public void clear () {
      store.clear ();
    }

    public void append (StripeList history) {
      foreach (StripeObject item in history.data) {
        var t = (StripeTransaction)item;
        int64 net = t.amount - t.fee;
        store.append (out iter);
        store.set (iter, 0, get_row_type(t.transaction_type), 1, net, 2, t.amount, 3, t.fee, 4, t.description, 5, t.available_on.format("%Y/%m/%d"));
      }
    }

    private void create_store () {
      store = new Gtk.ListStore (6, typeof (string), typeof (int), typeof (int), typeof (int), typeof (string), typeof (string));
    }

    private void create_columns () {
      Gtk.CellRendererText cell = new Gtk.CellRendererText ();
      Gtk.CellRendererText amount = new Gtk.CellRendererText ();

      amount.align_set = true;
      amount.xalign = 1.0f;

      insert_column_with_attributes (-1, _("Type"), cell, "text", 0);
      insert_column_with_data_func (-1, _("Net"), amount, net_cell);
      insert_column_with_data_func (-1, _("Amount"), amount, amount_cell);
      insert_column_with_data_func (-1, _("Fee"), amount, fee_cell);
      insert_column_with_attributes (-1, _("Description"), cell, "text", 4);
      insert_column_with_attributes (-1, _("Available On"), cell, "text", 5);

      get_column (4).set_expand (true);
    }

    private void amount_cell (Gtk.TreeViewColumn tree_column, Gtk.CellRenderer cell, Gtk.TreeModel tree_model, Gtk.TreeIter iter) {
      Gtk.CellRendererText tcr = (Gtk.CellRendererText)cell;        
      GLib.Value v;
      tree_model.get_value (iter, 2, out v);
      int amount = v.get_int ();
      string text = "$" + ((float)(amount.abs () / 100.0)).to_string ("%.2f");
      if (amount < 0) {
        text = "(" + text + ")";
      }

      tcr.alignment = Pango.Alignment.RIGHT;
      tcr.text = text;
    }

    private void net_cell (Gtk.TreeViewColumn tree_column, Gtk.CellRenderer cell, Gtk.TreeModel tree_model, Gtk.TreeIter iter) {
      Gtk.CellRendererText tcr = (Gtk.CellRendererText)cell;        
      GLib.Value v;
      tree_model.get_value (iter, 1, out v);
      int amount = v.get_int ();
      string text = "$" + ((float)(amount.abs () / 100.0)).to_string ("%.2f");
      if (amount < 0) {
        text = "(" + text + ")";
      }

      tcr.alignment = Pango.Alignment.RIGHT;
      tcr.text = text;
    }

    private void fee_cell (Gtk.TreeViewColumn tree_column, Gtk.CellRenderer cell, Gtk.TreeModel tree_model, Gtk.TreeIter iter) {
      Gtk.CellRendererText tcr = (Gtk.CellRendererText)cell;        
      GLib.Value v;
      tree_model.get_value (iter, 3, out v);
      int amount = v.get_int ();

      if (amount == 0) {
        tcr.text = "";
        return;
      }

      string text = "$" + ((float)(amount.abs () / 100.0)).to_string ("%.2f");
      if (amount > 0) {
        text = "(" + text + ")";
      }

      tcr.alignment = Pango.Alignment.RIGHT;
      tcr.text = text;
    }

    private string get_row_type (string value) {
      switch (value) {
        case "charge":
          return _("Charge");
        case "refund":
          return _("Refund");
        case "transfer":
          return _("Payout");
        default:
          return value;
      }
    }
  }
}