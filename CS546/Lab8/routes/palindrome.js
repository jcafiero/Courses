
const express = require('express');
const router = express.Router();

router.get("/static", (req, res) => {
    res.render("static", {});
});
module.exports = router;
