(function () {
    function applySavedTheme() {
        var isDark = localStorage.getItem("theme") === "dark";
        document.documentElement.classList.toggle("dark-mode", isDark);
        if (document.body) {
            document.body.classList.toggle("dark-mode", isDark);
        }
        document.querySelectorAll("#darkModeToggle, [data-theme-toggle]").forEach(function (toggle) {
            toggle.textContent = isDark ? "☀️ 라이트모드" : "🌙 다크모드";
        });
    }

    applySavedTheme();
    document.addEventListener("DOMContentLoaded", applySavedTheme);
    window.addEventListener("storage", applySavedTheme);
})();
