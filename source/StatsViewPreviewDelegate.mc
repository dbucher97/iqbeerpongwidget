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

class StatsViewPreviewDelegate extends WatchUi.BehaviorDelegate {

    var model;
    var season;


    function initialize(aModel, aSeason) {
        BehaviorDelegate.initialize();
        model = aModel;
        season = aSeason;
    }


    function onKey(evt) {
        if(evt.getKey() == KEY_UP) {
            var nSeason = season - 1;
            if(nSeason == 0) {
                nSeason = model.getSeason() - 1;
            }
            if(nSeason != season) {
                WatchUi.switchToView(new StatsView(null, model, nSeason), self, WatchUi.SLIDE_DOWN);
                season = nSeason;
            }
        } else if (evt.getKey() == KEY_DOWN) {
            var nSeason = season + 1;
            if(nSeason == model.getSeason()) {
                nSeason = 1;
            }
            if(nSeason != season) {
                WatchUi.switchToView(new StatsView(null, model, nSeason), self, WatchUi.SLIDE_UP);
                season = nSeason;
            }
        } else if(evt.getKey() == KEY_ENTER) {
            WatchUi.pushView(new ChangeValuesMenu(model, season), new ChangeValuesDelegate(model, season, 4), WatchUi.SLIDE_LEFT);
        } else if(evt.getKey() == KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
        return true;
    }
}
