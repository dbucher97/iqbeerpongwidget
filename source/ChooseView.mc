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

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;


class ChooseView extends WatchUi.View {

    var delegate;
    var model;

    function initialize(aDelegate, aModel) {
        View.initialize();
        delegate = aDelegate;
        model = aModel;
    }

    function onKey(kc) {
        if(kc == KEY_ENTER) {
            model.endGame(true);
            delegate.chooseEnd();
        } else if (kc == KEY_DOWN) {
            model.endGame(false);
            delegate.chooseEnd();
        } else if (kc == KEY_ESC) {
            delegate.chooseEnd();
        } else if (kc == KEY_UP) {
            delegate.chooseResume();
        }
    }


    function onLayout(dc) {
        setLayout(Rez.Layouts.ChooseLayout(dc));
    }


    function onUpdate(dc) {
        View.onUpdate(dc);
        var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 2;

        // dc.drawArc(0, 0, 1, Graphics.ARC_CLOCKWISE, 10, 20);
        dc.setPenWidth(10);
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        dc.drawArc(x, y, x - 5, Graphics.ARC_COUNTER_CLOCKWISE, 0, 150);

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        dc.drawArc(x, y, x - 5, Graphics.ARC_COUNTER_CLOCKWISE, 205, 300);

        dc.setPenWidth(6);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        dc.drawArc(x, y, x - 3, Graphics.ARC_COUNTER_CLOCKWISE, 155, 200);
        dc.drawArc(x, y, x - 3, Graphics.ARC_COUNTER_CLOCKWISE, 305, 355);
    }
}
