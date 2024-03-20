const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const session = require('express-session');

const app = express();
app.use(express.static('public'));

app.set('view engine', 'pug');

app.use(bodyParser.urlencoded({ extended: true }));

app.use(session({
    secret: 'your-secret-key',
    resave: false,
    saveUninitialized: false
}));

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '200605',
    database: 'UNIVERSITY'
});

db.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('Connected to MySQL database');
});

function authenticate(req, res, next) {
    const { email, password } = req.body;
    const query = `SELECT * FROM Student WHERE email = ? AND password = ?`;
    db.query(query, [email, password], (err, results) => {
        if (err) {
            throw err;
        }
        if (results.length > 0) {
            req.session.user = results[0];
            next();
        } else {
            res.redirect('/login?message=Invalid email or password');
        }
    });
}

app.get('/login', (req, res) => {
    res.render('login');
});

app.post('/login', authenticate, (req, res) => {
    res.redirect('/record');
});

app.get('/record', (req, res) => {
    const student = req.session.user;
    if (student) {
        const studentId = student.id;
        const queryCourses = `SELECT Course.name FROM Course INNER JOIN Result ON Course.id = Result.course_id WHERE Result.student_id = ?`;
        db.query(queryCourses, [studentId], (err, courseResults) => {
            if (err) {
                throw err;
            }
            const courses = courseResults.map(course => ({ name: course.name }));
            res.render('record', { student, courses });
        });
    } else {
        res.redirect('/login?message=Invalid email or password');
    }
});


app.post('/result', (req, res) => {
    res.redirect('/result');
});

// Route for rendering result page
app.get('/result', (req, res) => {
    const studentId = req.session.user.id; // Get the student's ID from the session
    const queryResult = `SELECT Course.name AS course, Result.grade 
                         FROM Result 
                         INNER JOIN Course ON Result.course_id = Course.id 
                         WHERE Result.student_id = ?`; // Filter by student ID
    db.query(queryResult, [studentId], (err, results) => {
        if (err) {
            throw err;
        }
        res.render('result', { results });
    });
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
