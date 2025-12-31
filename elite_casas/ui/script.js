const minDistanceToStart = 5;
const units = [
  "px",
  "%",
  "rem",
  "em",
  "vh",
  "vw",
  "vmin",
  "vmax",
  "ex",
  "cm",
  "mm",
  "in",
  "pt",
  "pc",
  "ch",
];
const shiftKeyMultiple = 0.01;

var ResourceName;
let $input = 0;
let initialPosition = 0;
let initialValue = 0;
let initialUnit = "";
let initialShiftKey = 0;
var tic = new Audio("./tic.mp3");
var pop = new Audio("./pop.mp3");
var cli = new Audio("./cli.mp3");
tic.volume = 0.3;
pop.volume = 0.3;
cli.volume = 0.3;

// states
// 0 - none
// 1 - retrieving value
// 2 - change value
let dragState = 0;

function reset() {
  $input = 0;
  initialPosition = 0;
  initialValue = 0;
  initialUnit = "";
  initialShiftKey = 0;
  dragState = 0;
}

var DragUI = false;
var canDragUI = false;
var off = null;

$(document).on('mouseenter', '#move', function() {
  canDragUI = true;
  
});

$(document).on('mouseleave', '#move', function() {
  canDragUI = false;
});

$(document).mousedown(function(e) {
  if (canDragUI) {
    DragUI = true;
    var tp2 = $(".container").position();
    off = {
      x: e.pageX-tp2.left,
      y: e.pageY-tp2.top 
    }
  }
});

$(document).mouseup(function() {
  DragUI = false;
});

$(document).on("mousedown", ".draggable-input", function (e) {
  if (entityselected == false) {
    return;
  }
  if (canDragUI) {
    DragUI= true;
  }

  $input = $(this);
  initialPosition = {
    x: e.pageX,
    y: e.pageY,
  };
  initialValue = $input.val();

  const valueNum = parseFloat(initialValue);

  // check if value contains units and save it.
  if (initialValue !== `${valueNum}`) {
    const matchUnit = initialValue.match(
      new RegExp(`${valueNum}(${units.join("|")})`, "i")
    );

    if (matchUnit && matchUnit[1]) {
      initialUnit = matchUnit[1];
    }
  }

  if (e.shiftKey) {
    initialShiftKey = 1;
  }

  initialValue = valueNum;

  dragState = 1;
});

$(document).on("mouseup", function () {
  if (dragState > 0) {
    $.post("https://" + ResourceName + "/updatepos",
        JSON.stringify({
          pos:{
            x : round($("#px").val()),
            y : round($("#py").val()),
            z : round($("#pz").val())
          },
          rot:{
            x : round($("#rx").val()),
            y : round($("#ry").val()),
            z : round($("#rz").val())
          },
          refresh: true
        })
      );
  }
  reset();
  
});

$(document).on("mousemove", function (e) {
  if (DragUI) {
    var x= e.pageX-off.x, y = e.pageY-off.y;
    $(".container").css({top: y, left: x});
  }

  $.post("https://" + ResourceName + "/onmove");
  
  switch (dragState) {
    // check for drag position
    case 1:
      if (Math.abs(initialPosition.x - e.pageX) > minDistanceToStart) {
        reset();
      } else if (Math.abs(initialPosition.y - e.pageY) > minDistanceToStart) {
        dragState = 2;
      }
      break;
    // change input value.
    case 2:
      e.preventDefault();
      var increment = $input.attr("increment")
      $input.val(
        round(
          initialValue +
            (initialPosition.y - e.pageY) *
              (initialShiftKey ? increment*10 : increment) +
            initialUnit
        )
      );
        
      tic.play();
      $.post("https://" + ResourceName + "/updatepos",
        JSON.stringify({
          pos:{
            x : round($("#px").val()),
            y : round($("#py").val()),
            z : round($("#pz").val())
          },
          rot:{
            x : round($("#rx").val()),
            y : round($("#ry").val()),
            z : round($("#rz").val())
          },
        })
      );
      break;
    // no default
  }
});

function decimalAdjust(type, value, exp) {
  // Si el exp no está definido o es cero...
  if (typeof exp === "undefined" || +exp === 0) {
    return Math[type](value);
  }
  value = +value;
  exp = +exp;
  // Si el valor no es un número o el exp no es un entero...
  if (isNaN(value) || !(typeof exp === "number" && exp % 1 === 0)) {
    return NaN;
  }
  // Shift
  value = value.toString().split("e");
  value = Math[type](+(value[0] + "e" + (value[1] ? +value[1] - exp : -exp)));
  // Shift back
  value = value.toString().split("e");
  return +(value[0] + "e" + (value[1] ? +value[1] + exp : exp));
}

// Decimal round

round = function (value) {
  return decimalAdjust("round", value, -2);
};

// aca arranca lor ico



var bloqueaclick = 0;
var M = null;
var curcat = null;
var selindex = null;
var entityselected = false;
var haspack = false;

$(function () {
  window.addEventListener("message", function (event) {
    var d = event.data;
    if (d.target == "pop") {
      pop.play();
    } 

    if (d.target == "setdata") {
      ResourceName = event.data.name;

      var ar = {};
      $.each(event.data.data,function(k,v){
        ar[v.catname] = v.props;
        var thisid = 1;
        $.each(ar[v.catname],function(x,o){
          ar[v.catname][x].name = v.catname +" "+thisid;
          thisid++;
        });
      });

      M = ar;

      var f = true;
      $.each(M,function(k,v){
        if (f) {
          f = false;
          curcat = k;
          $(".select-list-cat").append('<div class="select-item" style="background-color: rgba(255, 255, 255, 0.967); color: rgb(0, 0, 0);" cat = '+k+' id = "catt" >'+k+'</div>')
        } else {
          $(".select-list-cat").append('<div class="select-item" cat = "'+k+'" id = "catt" >'+k+'</div>')
        }
        
      });

      $.each(M[curcat],function(k,v){
        $(".select-list-it").append('<div class="select-item" index = "'+k+'" id = "prop" >'+v.name+'</div>')
      });
    } 
    
    if (d.target == "open") {
      $("body").show(100);
      $(".select-list-it").html("");

      $.each(M[curcat],function(k,v){
        $(".select-list-it").append('<div class="select-item" index = "'+k+'" id = "prop" >'+v.name+'</div>')
      });
      $(".buy-options").fadeTo(0, 0.0);
      $(".container").css({"width":"40vh"});
      $("#cart").fadeTo(0, 0.0);
      $(".back-button").fadeTo(0, 0.0);
      $(".control").css({"filter":"blur(5px)"});
      haspack = d.pck;
    }

    if (d.target == "refresh") {
      $("#px").val(round(d.coords.x));
      $("#py").val(round(d.coords.y));
      $("#pz").val(round(d.coords.z));
      $("#rx").val(round(d.rotation.x));
      $("#ry").val(round(d.rotation.y));
      $("#rz").val(round(d.rotation.z));
    }

    if (d.target == "toggle") {
      $(".buy-options").fadeTo(100, 0.0);
      $(".container").css({"width":"40vh"});

      if (d.bol==0) {
        $(".control").hide();
        $(".place").hide();
        $(".container").css({"height": "4.5vh"});
        $(".edit-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
        $(".move-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
        $(".place-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
      } else if (d.bol==1) {
        $(".container").css({"height": "15vh"});
        $(".control").show(200);
        $(".place").hide();
        $(".edit-button").css({"color":"rgb(0, 0, 0)","background-color": "rgba(255, 255, 255, 0.897)"});
        $(".move-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
        $(".place-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
      } else if (d.bol==2) {
        $(".control").hide();
        $(".place").hide();
        $(".container").css({"height": "4.5vh"});
        $(".edit-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
        $(".move-button").css({"color":"rgb(0, 0, 0)","background-color": "rgba(255, 255, 255, 0.897)"});
        $(".place-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
      } else if (d.bol==3) {
        $(".container").css({"height": "20vh"});
        $(".control").hide();
        $(".place").show(200);
        $(".edit-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
        $(".move-button").css({"color":"rgb(160, 160, 160)","background-color": "rgba(17, 17, 17, 0.897)"});
        $(".place-button").css({"color":"rgb(0, 0, 0)","background-color": "rgba(255, 255, 255, 0.897)"});
        if (selindex != null) {
          $(".buy-options").fadeTo(200, 1.0);
          $(".container").css({"width":"55vh"});
        }
      }
    }

    if (d.target == "toggleselected") {
      entityselected = d.value
      if (d.value == true) {
        $(".control").css({"filter":"blur(0px)"});
        $(".back-button").fadeTo(100, 1.0);
      } else {
        $(".control").css({"filter":"blur(5px)"});
        $(".back-button").fadeTo(100, 0.0);
      }
    } 

    if (d.target == "close") {
      $("body").hide(100);
    }
    
  });

  document.onkeyup = function (data) {
    if (data.which == 27) {
      // Escape key
      $("body").hide(100);
      $.post("https://" + ResourceName + "/escape", JSON.stringify({}));
    }
  };
});

$(document).on('click', '.select-item', function(e){
  var thistype = $(this).attr("id");
  tic.play();
  if (thistype=="catt") {

    $(".select-list-it").fadeTo(0, 0.0);

    curcat = $(this).attr("cat");

    $(".select-list-cat").html("");

    $.each(M,function(k,v){

      if (k==curcat) {
        $(".select-list-cat").append('<div class="select-item" style="background-color: rgba(255, 255, 255, 0.967); color: rgb(0, 0, 0);" cat = '+k+' id = "catt" >'+k+'</div>')
      } else {
        $(".select-list-cat").append('<div class="select-item" cat = "'+k+'" id = "catt" >'+k+'</div>')
      }

    });
    $(".select-list-it").html("");

    $.each(M[curcat],function(k,v){
      $(".select-list-it").append('<div class="select-item" index = "'+k+'" id = "prop" >'+v.name+'</div>')
    });

    $(".select-list-it").fadeTo(200, 1.0);

  } else if (thistype=="prop") {
    var index = $(this).attr("index");

    var thisprop = M[curcat][index];
    selindex = index;
    
    $.post("https://" + ResourceName + "/place",JSON.stringify({obj: M[curcat][selindex]}),function(can){
      if (can) {
        $(".select-list-it").html("");

        $.each(M[curcat],function(k,v){
          if (k==index) {
            $(".select-list-it").append('<div class="select-item" style="background-color: rgba(255, 255, 255, 0.967); color: rgb(0, 0, 0);"  index = "'+k+'" id = "prop" >'+v.name+'</div>')
          } else {
            $(".select-list-it").append('<div class="select-item" index = "'+k+'" id = "prop" >'+v.name+'</div>')
          }
        });
    
        $(".container").css({"width":"55vh"});
    
        $(".buy-options").fadeTo(200, 1.0);
    
        var text = thisprop.name;
        if (haspack== true) {
          if (thisprop.fp == true) {
            text = text+"<br>Precio: $"+thisprop.price;
          } else {
            text = text + "<br>Precio: incluido";
          }          
        } else {
          text = text+"<br>Precio: $"+thisprop.price;
          
        }
        text = text+"<br>Prop: "+thisprop.m;
        //text = text+"<br>model: "+thisprop.m;
        if (thisprop.w) {
          text = text+"<br>Capacidad: "+thisprop.w+"kg";
        }

        $(".b-price").html(text);
        $("#cart").fadeTo(100, 1.0);
      }
    });
  }
});

$(document).on('click', '.b-button', function(e){
  e.preventDefault();
  var type = $(this).attr("typ");
  cli.play();
  $("#cart").fadeTo(100, 0.0);
  if (type == "buy") {

    selindex = null;

    $(".container").css({"width":"40vh"});

    $(".buy-options").fadeTo(100, 0.0);

    $(".select-list-it").html("");

    $.each(M[curcat],function(k,v){
      $(".select-list-it").append('<div class="select-item" index = "'+k+'" id = "prop" >'+v.name+'</div>')
    });
    
    $.post("https://" + ResourceName + "/PONERLA");
  } else if (type == "nobuy") {

    selindex = null;

    $(".container").css({"width":"40vh"});

    $(".buy-options").fadeTo(100, 0.0);

    $(".select-list-it").html("");

    $.each(M[curcat],function(k,v){
      $(".select-list-it").append('<div class="select-item" index = "'+k+'" id = "prop" >'+v.name+'</div>')
    });
    $.post("https://" + ResourceName + "/cancelpre");
  }
});

$(document).on('click', '.trash', function(e){
  e.preventDefault();
  cli.play();
  $.post("https://" + ResourceName + "/DeleteObj");
});


$(document).on('mouseenter', '.container', function() {
  bloqueaclick = 1;
});

$(document).on('mouseleave', '.container', function() {
  bloqueaclick = 0;
});

$(document).on("mousedown",function(e){ ///////////////////
  if (!bloqueaclick && e.which == 1) {
    $.post("https://" + ResourceName + "/OnClick");
  }
})

$(document).on('click', '.edit-button', function(e){
  e.preventDefault();
  cli.play();
  setTimeout(() => {
    $.post("https://" + ResourceName + "/ToggleSelect",JSON.stringify({v:1}));
  }, 50);
});

$(document).on('click', '.move-button', function(e){
  e.preventDefault();
  cli.play();
  setTimeout(() => {
    $.post("https://" + ResourceName + "/ToggleSelect",JSON.stringify({v:2}));
  }, 50);
});

$(document).on('click', '.place-button', function(e){
  e.preventDefault();
  cli.play();
  setTimeout(() => {
    $.post("https://" + ResourceName + "/ToggleSelect",JSON.stringify({v:3}));
  }, 50);
});

window.addEventListener("contextmenu",function(event){
  event.preventDefault();
  $.post("https://" + ResourceName + "/FocusOff");
});

window.addEventListener("wheel", event => {
  var delta = Math.sign(event.deltaY);
  $.post("https://" + ResourceName + "/onmove",JSON.stringify({val: delta}));
});