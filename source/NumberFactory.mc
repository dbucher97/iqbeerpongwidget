// Copyright (C) 2021  David Bucher <d.bucher97@gmail.com>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

using Toybox.Graphics;
using Toybox.WatchUi;

class NumberFactory extends WatchUi.PickerFactory {
    var factor = 1;
    var formatStr = "%d";

    function getIndex(value) {
        return value * factor;
    }

    function initialize(halfInc) {
        PickerFactory.initialize();
        if(halfInc) {
            factor = 2;
            formatStr = "%.1f";
        }
    }

    function getDrawable(index, selected) {
        var font = Graphics.FONT_LARGE;
        if(factor > 1) {
            font = Graphics.FONT_MEDIUM;
        }
        return new WatchUi.Text( { :text=>getValue(index).format(formatStr), :color=>Graphics.COLOR_WHITE, :font=>font, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER } );
    }

    function getValue(index) {
        if(factor == 1) {
            return index;
        } else {
            return index.toDouble() / factor;
        }
    }

    function getSize() {
        if(factor == 1) {
            return 999;
        } else {
            return 1999;
        }
    }

}

