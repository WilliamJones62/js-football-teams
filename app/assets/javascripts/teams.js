$(document).ready(function (){
  loadPlayers()
  addPlayer()
  addGame()
});

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
    $.post(this.action, $(this).serialize()).success(function(response){
      $("#player_name").val("");
      var $ul = $("div.players ul")
      $ul.append(response)
      $(":submit").removeAttr("disabled");
    })
  })
}

function addGame() {
  $("#new_game").submit(function(e){
    debugger
    e.preventDefault();
    $.post(this.action, $(this).serialize()).success(function(response){
      $("#game_date").val("");
      $("#game_opponent").val("");
      $("#game_score_for").val("");
      $("#game_score_against").val("");
      $("#game_home_away").val("");
      var $ul = $("div.games ul")
      $ul.append(response)
      $(":submit").removeAttr("disabled");
    })
  })
}
