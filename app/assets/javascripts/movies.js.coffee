$ ->
  $("#datepicker").datepicker dateFormat: "yy-mm-dd"

colors = [ "#ddd", "#E3CDCC", "#BED4C4", "#C9BED4", "#E8CDAE", "#C1DEDD", "#E2E3CA" ]
random_color = colors[Math.floor(Math.random() * colors.length)]
$ ->
  $(".top-bar").css "background-color", random_color
  $(".top-bar a").css "background-color", random_color
