function appearMenu(){
  var showMenu = document.querySelector(".menu-mobile");
  showMenu.classList.toggle("active");
}

var menubtn = document.querySelector(".btn-menu-mobile");
 menubtn.addEventListener("click", appearMenu);
