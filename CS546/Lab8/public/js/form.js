/********
 * Name: Jennifer Cafiero
 * Date: November 9, 2017
 * CS546 Lab 8 - Palindromes
 * form.js
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
 ********/

(function () {
    let palindromeMethods = {};

    function isPalindrome(str) {
        if (typeof str !== "string") throw "Must provide a string";
        if (str === "") throw "Must enter a string";
        var lowerStr = str.replace(/[\W_]/g,'').toLowerCase();
        var reverseStr = lowerStr.split('').reverse().join('');
        return reverseStr === lowerStr;
    }

    var staticForm = document.getElementById("static-form");

    if (staticForm) {
        var stringElement = document.getElementById("term");
        var ispalindromeContainer = document.getElementById("palindrome-container");
        var notpalindromeContainer = document.getElementById("not-palindrome-container");
        var errorContainer = document.getElementById("error-container");
        var errorMsg = errorContainer.getElementsByClassName("error-msg")[0];


        staticForm.addEventListener("submit", (event) => {
            event.preventDefault();

            try {
                errorContainer.classList.add("toggle");
                var value = stringElement.value;
                var result = isPalindrome(value);
                if (result) {
                    var ul = document.getElementById("palindromes");
                    var li = document.createElement("li");
                    li.appendChild(document.createTextNode(value));
                    ul.appendChild(li);
                    ispalindromeContainer.classList.remove("toggle");
                } else {
                    var ul = document.getElementById("not-palindromes");
                    var li = document.createElement("li");
                    li.appendChild(document.createTextNode(value));
                    ul.appendChild(li);
                    notpalindromeContainer.classList.remove("toggle");
                }
            } catch (e) {
                var message = typeof e === "string" ? e : e.message;
                errorMsg.textContent = e;
                errorContainer.classList.remove("toggle");
            }
        });
    }
})();
