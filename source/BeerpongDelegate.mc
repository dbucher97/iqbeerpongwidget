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
using Toybox.Timer;
using Toybox.Application.Storage;


class BeerpongDelegate extends WatchUi.BehaviorDelegate {

    var model;

    var state = 0;

    var beerpongView;
    var statsView;
    var chooseView;

    var selectTimer;

    function initialize(aModel) {
        BehaviorDelegate.initialize();
        model = aModel;
        statsView = new StatsView(self, model, false);
    }

    function chooseStart() {
        state = 1;
        beerpongView = new BeerpongView(self, model);
        chooseView = new ChooseView(self, model);
        model.newGame();
        WatchUi.pushView(getView(), self, WatchUi.SLIDE_LEFT);
    }

    function chooseEnd() {
        state = 0;
        model.save();
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

    function chooseAbort() {
        chooseEnd();
    }

    function chooseResume() {
        state = 1;
        WatchUi.switchToView(getView(), self, WatchUi.SLIDE_DOWN);
    }

    function chooseMenu() {
        state = 2;
        WatchUi.switchToView(getView(), self, WatchUi.SLIDE_UP);
    }

    function onBack() {
        if(state != 0) {
            getView().onKey(KEY_ESC);
            return true;
        } else {
            return false;
        }
    }

    function onLongSelect() {
        selectTimer = null;
        if(state == 0) {
            state = 3;
        } else {
            state = 0;
        }
        WatchUi.switchToView(getView(), self, WatchUi.SLIDE_UP);
    }

    function onKey(evt) {
        if((state == 0 || state == 3) && evt.getKey() == KEY_ENTER) {
            selectTimer = new Timer.Timer();
            selectTimer.start(method(:onLongSelect), 1000, false);
        } else {
            getView().onKey(evt.getKey());
        }
        return true;
    }

    function onKeyReleased(evt) {
        if((state == 0 || state == 3) && evt.getKey() == KEY_ENTER && selectTimer != null) {
            selectTimer.stop();
            selectTimer = null;
            getView().onKey(KEY_ENTER);
        }
     }


    function getView() {
        if(state == 0) {
            return statsView;
        } else if(state == 1) {
            return beerpongView;
        } else if(state == 2){
            return chooseView;
        } else if(state == 3) {
            return new StatsView(self, model, true);
        }
    }

    function getModel() {
        return model;
    }
}
