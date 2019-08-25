var express = require('express'),
        http = require('http');
var app = express();
var mysql = require('mysql');
var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({ extended: false });
//var port = 3000;

//app.listen(port);
//app.listen(port, function(){
//  console.log('Server Active on', port);
//});
//http.createServer(app).listen(port);


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use('/', express.static(__dirname + '/'));
app.set('view engine', 'html');

var connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root",
    database: "mywebsite"
});

connection.connect();

app.get('/',(req, res) => {
    connection.query("SELECT * FROM chat",(err, result) => {
        if(err) {
            console.log(err);
            res.json({"error":true});
        }
        else {
            console.log(result);
            res.json(result);
        }
    });
});

app.listen(3001, function () {
    console.log('Connected to port 3000');
});

module.exports = app;
