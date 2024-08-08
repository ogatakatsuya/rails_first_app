// メニュー操作

// トグルリスナーを追加してクリックをリッスンする
document.addEventListener("turbo:load", () => {
    const hamburger = document.querySelector("#hamburger");
    if (hamburger){
      hamburger.addEventListener("click", (event) => {
        event.preventDefault();
        const menu = document.querySelector("#navbar-menu");
        menu.classList.toggle("collapse");
      });
    }
    const account = document.querySelector("#account");
    if (account) {
      account.addEventListener("click", (event) => {
        event.preventDefault();
        const menu = document.querySelector("#dropdown-menu");
        menu.classList.toggle("active");
      });
    }
  });