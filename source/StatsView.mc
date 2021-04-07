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


class StatsView extends WatchUi.View {

    var cup;
    var delegate;
    var model;

    var season;

    function initialize(aDelegate, aModel, aSeason) {
        View.initialize();
        delegate = aDelegate;
        model = aModel;
        season = aSeason;
        cup = new WatchUi.Bitmap({:rezId=>Rez.Drawables.cup});
    }

    function onKey(kc) {
        if(kc == KEY_ENTER) {
            season = null;
            delegate.chooseStart();
        }
    }

    function getTotalView() {
        var nSeason;
        if(season == null) {
            nSeason = 0;
        } else {
            nSeason = null;
        }
        return new StatsView(delegate, model, nSeason);
    }


    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 2;
        var cw = cup.getDimensions()[0];
        var ch = cup.getDimensions()[1];


        // WHITE STUFF
        var fhl = dc.getFontHeight(Graphics.FONT_LARGE) / 2;
        dc.drawText(1.2 * x, y/2 - fhl, Graphics.FONT_LARGE, model.getCups(season).format("%.1f"), Graphics.TEXT_JUSTIFY_CENTER);

        var fhh = dc.getFontHeight(Graphics.FONT_NUMBER_HOT) / 2;
        dc.drawText(x + 5, y - fhh, Graphics.FONT_NUMBER_HOT, (model.getCpg(season)).format("%.1f"), Graphics.TEXT_JUSTIFY_CENTER);

        dc.drawText(x - 10, y + 60 - fhl, Graphics.FONT_LARGE, model.getGames(season), Graphics.TEXT_JUSTIFY_RIGHT);
        dc.drawText(x + 10, y + 60 - fhl, Graphics.FONT_LARGE, model.getWins(season), Graphics.TEXT_JUSTIFY_LEFT);

        dc.drawText(x - 56, y - fhl, Graphics.FONT_LARGE, (model.getWpg(season)*100).format("%d") + "%", Graphics.TEXT_JUSTIFY_RIGHT);
        if(season == 0 || season == model.getSeason() || season == null || season == -1) {
            dc.drawText(2*x - 25, 50, Graphics.FONT_SMALL, "+", Graphics.TEXT_JUSTIFY_RIGHT);
        }


        // GRAY STUFF
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(x, y + 60 - fhl - 2, Graphics.FONT_LARGE, "|", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(x, y + 75, Graphics.FONT_XTINY, "|", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(x - 10, y + 75 , Graphics.FONT_XTINY, WatchUi.loadResource(Rez.Strings.Games), Graphics.TEXT_JUSTIFY_RIGHT);
        dc.drawText(x + 10, y + 75 , Graphics.FONT_XTINY, WatchUi.loadResource(Rez.Strings.Wins), Graphics.TEXT_JUSTIFY_LEFT);

        var fht = dc.getFontHeight(Graphics.FONT_TINY) / 2;
        dc.drawText(x + 55, y - 3 * fht + fhh, Graphics.FONT_TINY, WatchUi.loadResource(Rez.Strings.Cpg), Graphics.TEXT_JUSTIFY_LEFT);

        var txt = "";
        if(season == 0) {
            txt = WatchUi.loadResource(Rez.Strings.AllTime);
        } else {
            var nSeason = season;
            if(season == null || season == -1) {
                nSeason = model.getSeason();
            }
            txt = WatchUi.loadResource(Rez.Strings.Season) + " " + nSeason.format("%d");
        }
        dc.drawText(x, 10, Graphics.FONT_XTINY, txt, Graphics.TEXT_JUSTIFY_CENTER);

        dc.drawText(x - 56, y + 13, Graphics.FONT_XTINY, WatchUi.loadResource(Rez.Strings.Wpg), Graphics.TEXT_JUSTIFY_RIGHT);


        // DRAW CUP
        cup.setLocation(x * 0.65 - cw/2, y/2 - ch/2);
        cup.draw(dc);
    }
}
