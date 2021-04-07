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

class MenuDelegate extends WatchUi.Menu2InputDelegate {

    var model;

    function initialize(aModel) {
        Menu2InputDelegate.initialize();
        model = aModel;
    }

    function onSelect(item) {
        if(item.getId() == :clearData) {
            WatchUi.pushView(new Rez.Menus.ClearMenu(), self, WatchUi.SLIDE_LEFT);
        }
        else if(item.getId() == :clearConfirm) {
            model.reset();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
        else if(item.getId() == :clearAbort) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
        else if(item.getId() == :newSeason) {
            model.newSeason();
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
        else if(item.getId() == :seasons) {
            WatchUi.pushView(new SeasonsMenu(model), self, WatchUi.SLIDE_LEFT);
        }
        else if(item.getId() == :setSeason) {
            WatchUi.pushView(new ChangeValuesMenu(model, model.getSeason()), new ChangeValuesDelegate(model, model.getSeason(), 3), WatchUi.SLIDE_LEFT);
        }
        else if(item.getId() instanceof String) {
            if(item.getId().substring(0, 7).equals("mseason")) {
                var s = item.getId().substring(7, item.getId().length()).toNumber();
                var delegate = new StatsViewPreviewDelegate(model, s);
                WatchUi.pushView(new StatsView(null, model, s), delegate, WatchUi.SLIDE_LEFT);
            }
        }
        return true;
    }
}


class SeasonsMenu extends WatchUi.Menu2 {
    function initialize(model){
        Menu2.initialize({:title=>WatchUi.loadResource(Rez.Strings.MSeasons)});
        var sStr = WatchUi.loadResource(Rez.Strings.MSeasonsLbl);
        for(var i = 1; i < model.getSeason(); i++) {
            addItem(new MenuItem(sStr + " " + i.format("%d"), 
                "Games: " + model.getGames(i).format("%d") + " CPG: " + model.getCpg(i).format("%.1f"), 
                "mseason" + i.format("%d"), {}));
        }
    }
}

