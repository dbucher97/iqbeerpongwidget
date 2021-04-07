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

using Toybox.Application.Storage;

class BeerpongModel {
    var currentCups;
    const maxCups = 15;

    // Season
    var cups;
    var games;
    var wins;
    var season;

    function initialize() {
        cups = Storage.getValue("cups");
        if(cups == null) { cups = [0.0, 0.0]; }
        games = Storage.getValue("games");
        if(games == null) { games = [0, 0]; }
        wins = Storage.getValue("wins");
        if(wins == null) { wins = [0, 0]; }
        season = Storage.getValue("season");
        if(season == null) { season = 1; }
    }

    function newGame() {
        currentCups = 0.0;
    }

    function addCup() {
        currentCups += 1;
        if(currentCups > maxCups) {
            currentCups = maxCups;
        }
    }
    function removeCup() {
        currentCups -= 1;
        if(currentCups < 0) {
            currentCups = 0.0;
        }
    }
    function addHalfCup() {
        currentCups += 0.5;
        if(currentCups > maxCups) {
            currentCups = maxCups;
        }
    }

    function endGame(win) {
        games[season]++;
        games[0]++;
        cups[season] += currentCups;
        cups[0] += currentCups;
        if(win) {
            wins[season]++;
            wins[0]++;
        }
    }

    function save() {
        Storage.setValue("cups", cups);
        Storage.setValue("games", games);
        Storage.setValue("wins", wins);
        Storage.setValue("season", season);
    }

    function newSeason() {
        season++;
        cups.add(0.0);
        games.add(0);
        wins.add(0);
    }

    function fixS(s) {
        if(s == -1 || s == null) {
            return season;
        } else {
            return s;
        }
    }

    function getGames(s) {
        s = fixS(s);
        return games[s];
    }

    function getCups(s) {
        s = fixS(s);
        return cups[s];
    }

    function getWins(s) {
        s = fixS(s);
        return wins[s];
    }

    function getCpg(s) {
        s = fixS(s);
        if(games[s] == 0) {
            return 0.0;
        } else {
            return cups[s] / games[s];
        }
    }

    function getWpg(s) {
        s = fixS(s);
        if(games[s] == 0) {
            return 0.0;
        } else {
            return wins[s].toDouble() / games[s];
        }
    }

    function getSeason() {
        return season;
    }

    function getCurrentCpg() {
        return (cups[season] + currentCups)/(games[season] + 1);
    }

    function getCurrentCups() {
        return currentCups;
    }

    function reset() {
        Storage.clearValues();
        cups = [0.0, 0.0];
        games = [0, 0];
        wins = [0, 0];
        season = 1;
    }

    function deleteSeason(s) {
        s = fixS(s);
        cups[0] -= cups[s];
        games[0] -= games[s];
        wins[0] -= wins[s];
        cups.remove(cups[s]);
        games.remove(games[s]);
        wins.remove(wins[s]);
        season -= 1;
        if(season == 0) {
            newSeason();
        }
    }

    function changeCups(s, n) {
        s = fixS(s);
        var d = n - cups[s];
        cups[0] += d;
        cups[s] += d;
    }

    function changeGames(s, n) {
        s = fixS(s);
        var d = n - games[s];
        games[0] += d;
        games[s] += d;
    }

    function changeWins(s, n) {
        s = fixS(s);
        var d = n - wins[s];
        wins[0] += d;
        wins[s] += d;
    }
}
