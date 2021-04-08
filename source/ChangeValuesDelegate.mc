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

class ChangeValuesMenu extends WatchUi.Menu2 {

    function initialize(model, season){
        Menu2.initialize({:title=>WatchUi.loadResource(Rez.Strings.MSet)});
        addItem(new MenuItem(WatchUi.loadResource(Rez.Strings.MSCups), model.getCups(season).format("%.1f"), "mscups", {}));
        addItem(new MenuItem(WatchUi.loadResource(Rez.Strings.MSGames), model.getGames(season).format("%d"), "msgames", {}));
        addItem(new MenuItem(WatchUi.loadResource(Rez.Strings.MSWins), model.getWins(season).format("%d"), "mswins", {}));
        addItem(new MenuItem(WatchUi.loadResource(Rez.Strings.MSDelete) + " " + season.format("%d"), null, "msdelete", {}));
    }
}

class ChangeValuesDelegate extends WatchUi.Menu2InputDelegate {

    var model;
    var season;
    var pops;

    function initialize(aModel, aSeason, aPops) {
        Menu2InputDelegate.initialize();
        model = aModel;
        season = aSeason;
        pops = aPops;
    }

    function onSelect(item) {
        if(item.getId().equals("msdelete")) {
            var menu = new Rez.Menus.ClearMenu();
            menu.setTitle(WatchUi.loadResource(Rez.Strings.MSDelete) + " " + season.format("%d") + "?");
            WatchUi.pushView(menu, self, WatchUi.SLIDE_LEFT);
        } else if(item.getId() == :clearConfirm) {
            model.deleteSeason(season);
            for(var i = 0; i < pops; i++) {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }
        } else if(item.getId() == :clearAbort) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        } else {
            var delegate = new NumberPickerDelegate(model, season, item);
            WatchUi.pushView(delegate.getView(), delegate, WatchUi.SLIDE_LEFT);
        }
    }
}
