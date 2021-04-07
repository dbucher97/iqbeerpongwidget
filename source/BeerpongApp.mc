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



using Toybox.Application;
using Toybox.WatchUi;

class BeerpongApp extends Application.AppBase {

    var model;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
        model = new BeerpongModel();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        model.save();
    }

    function getGlanceView() {
        return [new StatsGlance(model)];
    }

    // Return the initial view of your application here
    function getInitialView() {
        var delegate = new BeerpongDelegate(model);
        var view = delegate.getView();
        return [view, delegate];
    }

}
