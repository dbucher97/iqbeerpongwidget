using Toybox.Graphics;
using Toybox.System;
using Toybox.WatchUi;

class NumberPicker extends WatchUi.Picker {

    function initialize(id, model, season) {
        var factory;
        var initial;
        var titleStr = "";
        if(id.equals("mscups")) {
            factory = new NumberFactory(true);
            initial = model.getCups(season);
            titleStr = WatchUi.loadResource(Rez.Strings.MSCups);
        } else {
            factory = new NumberFactory(false);
            if(id.equals("msgames")) {
                initial = model.getGames(season);
                titleStr = WatchUi.loadResource(Rez.Strings.MSGames);
            } else {
                initial = model.getWins(season);
                titleStr = WatchUi.loadResource(Rez.Strings.MSWins);
            }
        }
        var title = new WatchUi.Text({:text=>titleStr, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_TOP, :color=>Graphics.COLOR_WHITE});
        var confirm = new WatchUi.Text({:text=>"OK", :locX=>WatchUi.LAYOUT_HALIGN_RIGHT, :locY=>WatchUi.LAYOUT_VALIGN_TOP, :color=>Graphics.COLOR_DK_GRAY, :font=>Graphics.FONT_TINY});
        Picker.initialize({:title=>title, :pattern=>[factory], :defaults=>[factory.getIndex(initial)], :confirm=>confirm});
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }

}

class NumberPickerDelegate extends WatchUi.PickerDelegate {

    var model;
    var season;
    var item;

    function initialize(aModel, aSeason, aItem) {
        PickerDelegate.initialize();
        model = aModel;
        season = aSeason;
        item = aItem;
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

    function onAccept(values) {
        var fs = "%d";
        if(item.getId().equals("mscups")) {
            model.changeCups(season, values[0]);
            fs = "%.1f";
        } else if (item.getId().equals("msgames")) {
            model.changeGames(season, values[0]);
        } else if (item.getId().equals("mswins")) {
            model.changeWins(season, values[0]);
        }
        item.setSubLabel(values[0].format(fs));
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

    function getView() {
        return new NumberPicker(item.getId(), model, season);
    }

}
