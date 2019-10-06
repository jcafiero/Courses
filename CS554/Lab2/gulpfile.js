const gulp = require("gulp");
const concatenate = require("gulp-concat");
const cleanCSS = require("gulp-clean-css");
const autoPrefix = require("gulp-autoprefixer");
const sass = require("gulp-sass");
const rename = require("gulp-rename");

var config = {
    bootstrapDir: "./node_modules/bootstrap/",
    publicDir: "./public"
};

const sassFiles = [
    "./styles/_custom_variables.scss",
    "./styles/local.scss",
    "./node_modules/bootstrap/assets/scss/_variables.scss"    
];

const jsFiles = [
    "./node_modules/jquery/dist/jquery.min.js",
    "./node_modules/popper.js/dist/umd/popper.min.js",
    "./node_modules/bootstrap/dist/js/bootstrap.min.js"
  ];

gulp.task("css", function(done) {
    gulp.src("./styles/local.scss")
    .pipe(sass({
        includePaths: [config.bootstrapDir + "/assets/scss"]
    }))
    .pipe(gulp.dest(config.publicDir + "/css"))
    .pipe(cleanCSS())
    .pipe(rename("styles.min.css"))
    .pipe(gulp.dest("./public/css/"));
    done();
});

gulp.task("js", function(done) {
    gulp.src(jsFiles)
    .pipe(concatenate("vendor.min.js"))
    .pipe(gulp.dest("public/js"));
    done();
});

gulp.task("build", gulp.parallel(["css","js"]));

gulp.task("watch", function(done) {
    gulp.watch(sassFiles, gulp.series("css"));
    gulp.watch(jsFiles, gulp.series("js"));
    done();
});

gulp.task("default", gulp.series(["css", "js"]));
