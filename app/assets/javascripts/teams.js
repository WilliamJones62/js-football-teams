$(document).ready(function (){
  loadPlayers()
  addPlayer()
  addGame()
  nextPlayer()
  prevPlayer()
});

function Player(attributes){
  this.name = attributes.name;
  this.id = attributes.id;
}

Player.prototype.renderLI = function(){
    return Player.template(this)
}

function Game(attributes){
  this.date = attributes.date;
  this.id = attributes.id;
  this.opponent = attributes.opponent;
  this.score_for = attributes.score_for;
  this.score_against = attributes.score_against;
  this.home_away = attributes.home_away;
}

Game.prototype.renderLI = function(){
    return Game.template(this)
}

var players = [];

function loadPlayers() {
  $("a.load_players").click(function(e){
    e.preventDefault();
    $.get(this.href).success(function(json){
      var $ul = $("div.players ul")
      $ul.html("")
      json.forEach(function(player){
        $ul.append("<li><a href = '/teams/" + player.team_id + "/players/" + player.id + "'>" + player.name + "</a></li>");
      })
    })
  })
}

function addPlayer() {
  $("#new_player").submit(function(e){
    e.preventDefault();
    $.post(this.action, $(this).serialize()).success(function(json){
      Player.templateSource = $("#player-template").html()
      Player.template = Handlebars.compile(Player.templateSource);
      var player = new Player(json)
      var playerLi = player.renderLI()
      $("#player_name").val("");
      var $ul = $("div.players ul")
      $ul.append(playerLi)
      $(":submit").removeAttr("disabled");
    })
  })
}

function addGame() {
  $("#new_game").submit(function(e){
    e.preventDefault();
    $.post(this.action, $(this).serialize()).success(function(json){
      Game.templateSource = $("#game-template").html()
      Game.template = Handlebars.compile(Game.templateSource);
      var game = new Game(json)
      var gameLi = game.renderLI()
      $("#game_date").val("");
      $("#game_opponent").val("");
      $("#game_score_for").val("");
      $("#game_score_against").val("");
      $("#game_home_away").val("");
      var $ul = $("div.games ul")
      $ul.append(gameLi)
      $(":submit").removeAttr("disabled");
    })
  })
}

function prevPlayer() {
  $('.js-previous').click(function(e) {
    e.preventDefault()
    var teamId = parseInt($(".js-previous").attr("team-id"))
    var playerId = parseInt($(".js-previous").attr("player-id"))
    loadPlayer(teamId, playerId)
  })
}

function nextPlayer() {
  $('.js-next').click(function(e) {
    e.preventDefault()
    var teamId = parseInt($(".js-next").attr("team-id"))
    var playerId = parseInt($(".js-next").attr("player-id"))
    loadPlayer(teamId, playerId)
  })
}

function loadPlayer(teamId, playerId) {
  $.get("/teams/" + teamId + "/players/" + playerId + "/data", function(data) {
    $('#player-name').text("Player Name: " + data.name)
    $('#games').empty()
    data.games.forEach(function(game) {
      var formattedGame = ''
      formattedGame = "<li><a href='/teams/" + teamId + "/games/" + game.id + "'>" + game.date + '</a> Opponent: ' + game.opponent + '</li>'
    $('#games').append(formattedGame)
    })
    $('#played').text("Total games played = " + data.games.length)
  })
  if (players.length == 0) {
    $.get("/teams/" + teamId + "/players/")
       .success(function(json) {
         json.forEach(function(player){
           players.push(player.id)
         })
       })
       .error(function(jqXHR, textStatus, errorThrown) {
         console.log(textStatus)
         console.log(errorThrown)
       })
  }

  for (var i = 0, len = players.length; i < len; i++) {

    if (players[i] == playerId) {
      if (i > 0) {
        $('.js-previous').show();
        $('.js-previous').attr("team-id" ,teamId);
        $('.js-previous').attr("player-id" ,players[i-1]);
    } else {
        $('.js-previous').hide()
      }
      if (i < len - 1) {
        $('.js-next').show();
        $('.js-next').attr("team-id" ,teamId);
        $('.js-next').attr("player-id" ,players[i+1]);
      } else {
        $('.js-next').hide()
      }
      i = len + 1
    }

  }

}
