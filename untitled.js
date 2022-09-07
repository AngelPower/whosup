
var mysql=require('mysql');

 var connection=mysql.createPool({
 
host: "sqlprive-rs51516-001.privatesql.ovh.net",
  user: "mainUser",
  password: "5ypizcvA",
  database: "preprod_dm"
 
});
 module.exports=connection;



 connectionLimit : 1000,
    connectTimeout  : 60 * 60 * 1000,
    aquireTimeout   : 60 * 60 * 1000,
    timeout         : 60 * 60 * 1000,