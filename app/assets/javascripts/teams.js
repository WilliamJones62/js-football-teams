$(document).ready(function (){
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
});
