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

    // All Time
    var totalCups;
    var totalGames;
    var totalWins;

    function initialize() {
        cups = Storage.getValue("cups");
        if(cups == null) { cups = 0.0; }
        games = Storage.getValue("games");
        if(games == null) { games = 0; }
        wins = Storage.getValue("wins");
        if(wins == null) { wins = 0; }
        season = Storage.getValue("season");
        if(season == null) { season = 1; }
        totalCups = Storage.getValue("totalCups");
        if(totalCups == null) { totalCups = 0.0; }
        totalGames = Storage.getValue("totalGames");
        if(totalGames == null) { totalGames = 0; }
        totalWins = Storage.getValue("totalWins");
        if(totalWins == null) { totalWins = 0; }
        currentCups = 0.0;
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
        games++;
        totalGames++;
        cups += currentCups;
        totalCups += currentCups;
        if(win) {
            wins++;
            totalWins++;
        }
    }

    function save() {
        Storage.setValue("cups", cups);
        Storage.setValue("games", games);
        Storage.setValue("wins", wins);
        Storage.setValue("season", season);
        Storage.setValue("totalCups", totalCups);
        Storage.setValue("totalGames", totalGames);
        Storage.setValue("totalWins", totalWins);
    }

    function newSeason() {
        season++;
        cups = 0.0;
        games = 0;
        wins = 0;
    }

    function getGames(total) {
        if(total) {
            return totalGames;
        } else {
            return games;
        }
    }

    function getCups(total) {
        if(total) {
            return totalCups;
        } else {
            return cups;
        }
    }

    function getWins(total) {
        if(total) {
            return totalWins;
        } else {
            return wins;
        }
    }

    function getCpg(total) {
        if(total) {
            if(totalGames == 0) {
                return 0.0;
            }
            return totalCups / totalGames;
        } else {
            if(games == 0) {
                return 0.0;
            }
            return cups / games;
        }
    }

    function getWpg(total) {
        if(total) {
            if(totalGames == 0) {
                return 0.0;
            }
            return totalWins.toDouble() / totalGames;
        } else {
            if(games == 0) {
                return 0.0;
            }
            return wins.toDouble() / games;
        }
    }

    function getSeason() {
        return season;
    }

    function getCurrentCpg() {
        return (cups + currentCups)/(games + 1);
    }

    function getCurrentCups() {
        return currentCups;
    }
}
