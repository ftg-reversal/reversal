import Drop from "tether-drop";

$(document).on('ready turbolinks:load', () => {
    if (document.querySelector(".login")) {
      new Drop({
        target: document.querySelector(".login"),
        content: document.querySelector(".login-menu"),
        classes: "drop-theme-basic",
        position: "bottom right",
        openOn: "click"
      });
    }

    if (document.querySelector(".add-button-wrapper")) {
      new Drop({
        target: document.querySelector(".add-button-wrapper"),
        content: document.querySelector(".header-menu"),
        classes: "drop-theme-basic",
        position: "bottom right",
        openOn: "click"
      });
    }
  }
);
