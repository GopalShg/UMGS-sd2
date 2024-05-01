// Import express.js
const express = require("express");

// Create express app
var app = express();

// Add static files location
app.use(express.static("static"));

// Use the Pug templating engine
app.set('view engine', 'pug');
app.set('views', './app/views');


// Get the functions in the db.js file to use
const db = require('./services/db');

// Create a route for login page - /
app.get("/", function(req, res) {
    res.render("index");
});

// Create a route for Student Record - /
app.get('/Record', function(req, res) {
    var sql = 'SELECT s.id AS student_id, s.name AS student_name, s.email, s.Courselevel, s.Academic_year, GROUP_CONCAT(c.name) AS course_names FROM student s JOIN enrollments e ON s.id = e.student_id JOIN course c ON e.course_id = c.id GROUP BY s.id, s.name, s.email, s.Courselevel, s.Academic_year';
    db.query(sql).then(results => {
         res.render('Studentrec', {results: results});
    });
});

// Create a route for Performance page - /
app.get('/Performance', function(req, res) {
    var sql = 'SELECT s.name as `student_name`, c.id, c.name as `course_name`, r.grade, r.remarks FROM student as s, course as c, result as r WHERE r.student_id = s.id AND r.course_id = c.id;';
    
    db.query(sql).then(results => {
        res.render('Studentper', {results: results});
   });
});

// All Courses page /
app.get('/all-courses', function(req, res) {
    var sql = 'SELECT * from course';
    
    db.query(sql).then(results => {
        res.render('all-courses', {courses: results});
   });
});
// Create a route for Performance page - /
app.get('/course-detail/:id', function(req, res) {
    var c_id = req.params.id;
    var sql = 'SELECT s.id AS student_id, s.name AS student_name, s.Courselevel, s.Academic_year FROM student s JOIN enrollments e ON s.id = e.student_id WHERE e.course_id = ?';
    
    var sql2 = "SELECT name as course_name, description as course_description from course where id = ? "

    db.query(sql,[c_id]).then(results => {
        console.log(results);

        db.query(sql2,[c_id]).then(categoryData => {
            console.log(categoryData);
    
          //   res.render('course-details', {results: results, category_name: categoryData.category_name, category_description: categoryData.category_description });
      res.render('course-details', {results: results, categoryData: categoryData });
    });
    });
});
// Create a route for About page - /
app.get('/about', function(req, res) {
        res.render('about');
   });
app.listen(3000,function(){
    console.log(`Server running at http://127.0.0.1:3000/`);
});