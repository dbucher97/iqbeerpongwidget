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


class BeerpongView extends WatchUi.View {

    var delegate;
    var model;

    var cup;
    var hcup;

    const spx = 2;
    const spy = 2;

    function initialize(aDelegate, aModel) {
        View.initialize();
        delegate = aDelegate;
        model = aModel;
        cup = new WatchUi.Bitmap({:rezId=>Rez.Drawables.cup});
        hcup = new WatchUi.Bitmap({:rezId=>Rez.Drawables.hcup,:locX=>15,:locY=>100});
    }

    function onKey(kc) {
        if(kc == KEY_ENTER) {
            model.addCup();
        } else if(kc == KEY_DOWN) {
            model.removeCup();
        } else if(kc == KEY_UP) {
            model.addHalfCup();
        } else if(kc == KEY_ESC) {
            delegate.chooseMenu();
        }
        WatchUi.requestUpdate();
    }


    function onUpdate(dc) {
        var sd = (model.getCurrentCpg() * 10 + 0.5).toNumber()
                    - (model.getCpg(false) * 10 + 0.5).toNumber();
        if(sd.abs() > 0) {
            if(sd < 0) {
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
            } else {
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
            }
        } else {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        }
        dc.clear();

        var hits = model.getCurrentCups();
        dc.drawText(50, 50, Graphics.FONT_MEDIUM, model.getCurrentCpg().format("%.2f"), Graphics.TEXT_JUSTIFY_CENTER);

        var w = cup.getDimensions()[0];
        var h = cup.getDimensions()[1];
        var x = dc.getWidth() / 2 - w / 2;
        var y = dc.getHeight() / 2 - 2 * h - (3 * spy) / 2;
        var c = 0;
        var r = 0;
         for(var i = 0; i < hits.toNumber() && i < 10; i++) {
             cup.setLocation(x + ((spx + w) * (c - r / 2.0)), y + (spy + h) * r);
             cup.draw(dc);
             if(c == r) {
                 c = 0;
                 r++;
             } else {
                 c++;
             }
         }
         if((hits - hits.toNumber()) > 0.0) {
             hcup.draw(dc);
         }
         if(hits.toNumber() > 10) {
             c = hits.toNumber() - 10;
             for(var i = 0; i < c; i++) {
                 cup.setLocation(dc.getWidth() - 50, 100 - (c - i) * 5);
                 cup.draw(dc);
             }
         }
    }
}
