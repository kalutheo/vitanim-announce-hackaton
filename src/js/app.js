import { Elm } from "../Main.elm";

if (process.env.NODE_ENV === "development") {
  // Only runs in development and will be stripped from production build.
  // See https://parceljs.org/production.html

  const ElmDebugger = require("elm-debug-transformer");
  function hasFormatterSupport() {
    const originalFormatters = window.devtoolsFormatters;
    let supported = false;

    window.devtoolsFormatters = [
      {
        header: function(obj, config) {
          supported = true;
          return null;
        },
        hasBody: function(obj) {},
        body: function(obj, config) {}
      }
    ];
    console.log("elm-debug-transformer: checking for formatter support.", {});
    window.devtoolsFormatters = originalFormatters;
    return supported;
  }

  if (hasFormatterSupport()) {
    ElmDebugger.register();
  } else {
    ElmDebugger.register({ simple_mode: true });
  }
}

const app = Elm.Main.init({
  node: document.getElementById("app")
});

const debounce = fn => {
  let frame;

  return (...params) => {
    if (frame) {
      window.cancelAnimationFrame(frame);
    }

    frame = window.requestAnimationFrame(() => {
      fn(...params);
    });
  };
};

let lastScrollTop = 0;

function updateCustomTableScroll(e) {
  document.documentElement.dataset.customTableScroll = Math.max(
    Math.floor(e.scrollWidth - e.clientWidth - e.scrollLeft),
    80
  );
  if (lastScrollTop !== e.scrollTop) {
    lastScrollTop = e.scrollTop;
    app.ports.scrolledTo.send({
      height: e.clientHeight,
      scrollTop: parseInt(e.scrollTop, 10)
    });
  }
}

document.addEventListener(
  "scroll",
  debounce(e => {
    if (e.target.id === "customTable") updateCustomTableScroll(e.target);
  }),
  true
);

window.onresize = () => {
  const customTable = document.querySelector("#customTable");
  if (customTable) {
    updateCustomTableScroll(customTable);
  }
};

app.ports.updateCustomTable.subscribe(scrollIntoView => {
  setTimeout(() => {
    const customTable = document.querySelector("#customTable");
    if (customTable) updateCustomTableScroll(customTable);
    else return;

    const trs = document.querySelectorAll(".customTable_rowSelected");
    trs.forEach(tr => {
      tr.className = tr.className.replace(
        / customTable_lastInSelectedGroup/g,
        ""
      );
      if (
        tr.nextElementSibling &&
        tr.nextElementSibling.className.indexOf("customTable_rowSelected") ===
          -1
      ) {
        tr.className = tr.className + " customTable_lastInSelectedGroup";
      }
    });
  }, 150);
});
