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

class StatsGlance extends WatchUi.GlanceView {

    var model;

    function initialize(aModel) {
        GlanceView.initialize();
        model = aModel;
    }

    function onLayout(dc) {
        setLayout( Rez.Layouts.GlanceLayout(dc) );
    }

    function onUpdate(dc) {
        var cpg = View.findDrawableById("GlCpg");
        cpg.setText(model.getCpg(-1).format("%.1f"));

        var games = View.findDrawableById("GlGames");
        games.setText(model.getGames(-1).format("%d"));

        GlanceView.onUpdate(dc);
    }
}
