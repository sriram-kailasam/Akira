/*
* Copyright (c) 2019-2020 Alecaddd (https://alecaddd.com)
*
* This file is part of Akira.
*
* Akira is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.

* Akira is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.

* You should have received a copy of the GNU General Public License
* along with Akira. If not, see <https://www.gnu.org/licenses/>.
*
* Authored by: Giacomo Alberini <giacomoalbe@gmail.com>
* Authored by: Alessandro "Alecaddd" Castellani <castellani.ale@gmail.com>
*/

public class Akira.Lib.Models.CanvasEllipse : Goo.CanvasEllipse, Models.CanvasItem {
    // Identifiers.
    public Models.CanvasItemType item_type { get; set; }
    public string id { get; set; }
    public string name { get; set; }

    // Transform Panel attributes.
    public double rotation { get; set; }
    public double opacity { get; set; }

    // Fill Panel attributes.
    public bool has_fill { get; set; default = true; }
    public int fill_alpha { get; set; }
    public Gdk.RGBA color { get; set; }
    public string color_string { get; set; }
    public bool hidden_fill { get; set; }

    // Border Panel attributes.
    public bool has_border { get; set; default = true; }
    public int border_size { get; set; }
    public Gdk.RGBA border_color { get; set; }
    public string border_color_string { get; set; }
    public int stroke_alpha { get; set; }
    public bool hidden_border { get; set; }

    // Style Panel attributes.
    public bool size_locked { get; set; }
    public double size_ratio { get; set; }
    public bool flipped_h { get; set; }
    public bool flipped_v { get; set; }
    public bool show_border_radius_panel { get; set; }
    public bool show_fill_panel { get; set; }
    public bool show_border_panel { get; set; }

    // Layers panel attributes.
    public bool selected { get; set; }
    public bool locked { get; set; }
    public string layer_icon { get; set; default = "shape-circle-symbolic"; }
    public int z_index { get; set; }

    public new Akira.Lib.Canvas canvas { get; set; }
    public Models.CanvasArtboard? artboard { get; set; }

    public double relative_x { get; set; }
    public double relative_y { get; set; }

    public double initial_relative_x { get; set; }
    public double initial_relative_y { get; set; }

    // Knows if an item was created or loaded for ordering purpose.
    public bool loaded { get; set; default = false; }

    public CanvasEllipse (
        double _center_x = 0,
        double _center_y = 0,
        double _radius_x = 0,
        double _radius_y = 0,
        int _border_size = 1,
        Gdk.RGBA _border_color,
        Gdk.RGBA _fill_color,
        Goo.CanvasItem? _parent = null,
        Models.CanvasArtboard? _artboard = null,
        bool _loaded = false
    ) {
        loaded = _loaded;
        artboard = _artboard;
        parent = _artboard != null ? _artboard : _parent;
        canvas = parent.get_canvas () as Akira.Lib.Canvas;

        item_type = Models.CanvasItemType.ELLIPSE;
        id = Models.CanvasItem.create_item_id (this);
        Models.CanvasItem.init_item (this);
        if (artboard != null) {
            connect_to_artboard ();
        }

        radius_x = _radius_x;
        radius_y = _radius_y;
        width = 1;
        height = 1;
        // The Ellipse has a weird 0.5 value always attached to it on creation.
        // We should get back to this and figure it out.
        center_x = - 0.5;
        center_y = - 0.5;
        show_fill_panel = true;
        show_border_panel = true;
        relative_x = 0;
        relative_y = 0;

        set_transform (Cairo.Matrix.identity ());

        position_item (_center_x, _center_y);

        color = _fill_color;
        has_border = settings.set_border;

        if (has_border) {
            border_color = _border_color;
            border_size = _border_size;
        }

        reset_colors ();
    }
}
